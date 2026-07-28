#!/usr/bin/env node

import { mkdir, readFile, writeFile } from "node:fs/promises";
import { realpathSync, unwatchFile, watchFile } from "node:fs";
import path from "node:path";
import process from "node:process";
import { pathToFileURL } from "node:url";

const LOOPBACK_HOSTS = new Set(["127.0.0.1", "localhost", "[::1]"]);
const MARKER = "AI_COMPANY_SYNC_ID=";
const DIVISION_JA = {
  "product-development": "プロダクト開発",
  "growth-marketing": "グロースマーケティング",
  "shared-services": "共通サービス",
};
const COLORS = ["#3b82f6", "#f59e0b", "#10b981", "#64748b"];

function titleFromSlug(slug) {
  return slug.split("-").filter(Boolean).map(
    (part) => part[0].toUpperCase() + part.slice(1),
  ).join(" ");
}

function spriteNumber(slug) {
  let hash = 0;
  for (const character of slug) hash = (hash * 31 + character.codePointAt(0)) >>> 0;
  return (hash % 14) + 1;
}

function safeText(value, length = 500) {
  const text = String(value ?? "").replace(/[\u0000-\u001f\u007f]/g, " ")
    .replace(/\s+/g, " ").trim();
  if (/(sk-[A-Za-z0-9_-]{16,}|password\s*=|PRIVATE KEY)/i.test(text)) return "[非表示]";
  return text.slice(0, length);
}

export function buildDirectory(routing, defaultProvider = "codex") {
  if (!routing?.divisions || typeof routing.divisions !== "object") {
    throw new Error("company routing must contain divisions");
  }
  const divisions = [];
  const characters = [];
  Object.entries(routing.divisions).forEach(([divisionId, division], index) => {
    if (!/^[a-z0-9][a-z0-9_-]{0,63}$/.test(divisionId)) {
      throw new Error(`invalid division id: ${divisionId}`);
    }
    const officeDepartmentId = `aic-${divisionId}`;
    divisions.push({
      id: officeDepartmentId,
      name: titleFromSlug(divisionId),
      name_ja:
        safeText(division?.nameJa, 80) ||
        DIVISION_JA[divisionId] ||
        titleFromSlug(divisionId),
      icon: "◆",
      color: COLORS[index % COLORS.length],
      description: safeText(division?.purpose, 300),
    });
    for (const [departmentId, department] of Object.entries(division?.departments ?? {})) {
      if (!/^[a-z0-9][a-z0-9_-]{0,63}$/.test(departmentId)) {
        throw new Error(`invalid department id: ${departmentId}`);
      }
      characters.push({
        id: `aic-agent-${departmentId}`,
        syncId: departmentId,
        name: titleFromSlug(departmentId),
        name_ja: safeText(department?.nameJa, 80) || titleFromSlug(departmentId),
        department_id: officeDepartmentId,
        role: departmentId === "product-management" ? "team_leader" : "senior",
        cli_provider: defaultProvider,
        avatar_emoji: "●",
        sprite_number: spriteNumber(departmentId),
        personality: `${MARKER}${departmentId}\n${safeText(department?.purpose)}`,
      });
    }
  });
  return {
    companyName: safeText(routing.company?.name, 100) || "AI Company",
    divisions,
    characters,
  };
}

function readSyncId(agent) {
  return String(agent?.personality ?? "").match(
    /(?:^|\n)AI_COMPANY_SYNC_ID=([a-z0-9][a-z0-9_-]{0,127})(?:\n|$)/,
  )?.[1] ?? null;
}

function validateConfig(input, configPath) {
  const base = path.dirname(path.resolve(configPath));
  const companyRoot = path.resolve(base, input.companyRoot ?? ".");
  const officeUrl = new URL(input.officeUrl ?? "http://127.0.0.1:8790/");
  if (officeUrl.protocol !== "http:" || !LOOPBACK_HOSTS.has(officeUrl.hostname)) {
    throw new Error("officeUrl must use loopback HTTP");
  }
  if (officeUrl.username || officeUrl.password) {
    throw new Error("officeUrl must not contain credentials");
  }
  const defaultProvider = input.defaultProvider ?? "codex";
  if (!["codex", "claude"].includes(defaultProvider)) {
    throw new Error("defaultProvider must be codex or claude");
  }
  return {
    companyRoot,
    routingPath: path.resolve(companyRoot, input.routingPath ?? "03-AI_departments/company-routing.json"),
    officeUrl: officeUrl.toString(),
    watchIntervalMs: Number(input.watchIntervalMs ?? 1500),
    defaultProvider,
    sessionCookie: "",
    csrfToken: "",
  };
}

async function bootstrapSession(config) {
  if (config.sessionCookie && config.csrfToken) return;
  const response = await fetch(new URL("/api/auth/session", config.officeUrl), {
    headers: { Accept: "application/json" },
    signal: AbortSignal.timeout(5000),
  });
  const value = await response.json().catch(() => ({}));
  if (!response.ok) {
    throw new Error(`Claw-Empire session HTTP ${response.status}`);
  }
  config.sessionCookie = String(response.headers.get("set-cookie") ?? "").split(";")[0];
  config.csrfToken = typeof value.csrf_token === "string" ? value.csrf_token : "";
  if (!config.sessionCookie || !config.csrfToken) {
    throw new Error("Claw-Empire session did not return cookie and csrf token");
  }
}

async function requestJson(config, pathname, options = {}) {
  if (pathname !== "/healthz") await bootstrapSession(config);
  const method = String(options.method ?? "GET").toUpperCase();
  const mutation = ["POST", "PUT", "PATCH", "DELETE"].includes(method);
  const response = await fetch(new URL(pathname, config.officeUrl), {
    ...options,
    headers: {
      Accept: "application/json",
      ...(options.body ? { "Content-Type": "application/json" } : {}),
      ...(config.sessionCookie ? { Cookie: config.sessionCookie } : {}),
      ...(mutation && config.csrfToken ? { "x-csrf-token": config.csrfToken } : {}),
    },
    signal: AbortSignal.timeout(5000),
  });
  const value = await response.json().catch(() => ({}));
  if (!response.ok) throw new Error(`Claw-Empire HTTP ${response.status}: ${safeText(value.error, 100)}`);
  return value;
}

async function sync(config) {
  const directory = buildDirectory(
    JSON.parse(await readFile(config.routingPath, "utf8")),
    config.defaultProvider,
  );
  const settings = (await requestJson(config, "/api/settings")).settings ?? {};
  const now = Date.now();
  const profile = {
    updated_at: now,
    departments: directory.divisions.map((division, index) => ({
      ...division,
      name_ko: division.name,
      name_zh: "",
      prompt: null,
      sort_order: index,
      created_at: now,
    })),
    agents: directory.characters.map((character) => {
      const { syncId, ...agent } = character;
      return {
        ...agent,
        name_ko: character.name,
        name_zh: "",
        acts_as_planning_leader: character.role === "team_leader" ? 1 : 0,
        cli_model: null,
        cli_reasoning_level: null,
        created_at: now,
      };
    }),
  };
  const hydrated = Array.isArray(settings.officePackHydratedPacks)
    ? settings.officePackHydratedPacks.filter((key) => key !== "roleplay")
    : [];
  await requestJson(config, "/api/settings", {
    method: "PUT",
    body: JSON.stringify({
      companyName: directory.companyName,
      language: "ja",
      defaultProvider: config.defaultProvider,
      officePackProfiles: {
        ...(settings.officePackProfiles ?? {}),
        roleplay: profile,
      },
      officePackHydratedPacks: hydrated,
      officeWorkflowPack: "roleplay",
    }),
  });

  const agents = (await requestJson(config, "/api/agents")).agents ?? [];
  const managed = new Map(
    agents
      .filter((agent) => agent.workflow_pack_key === "roleplay")
      .map((agent) => [readSyncId(agent), agent])
      .filter(([id]) => id),
  );
  const desired = new Set(directory.characters.map((character) => character.syncId));
  for (const [syncId, agent] of managed) {
    if (desired.has(syncId) && agent.status === "offline") {
      await requestJson(config, `/api/agents/${encodeURIComponent(agent.id)}`, {
        method: "PATCH",
        body: JSON.stringify({ status: "idle" }),
      });
    } else if (!desired.has(syncId) && agent.status !== "offline") {
      await requestJson(config, `/api/agents/${encodeURIComponent(agent.id)}`, {
        method: "PATCH",
        body: JSON.stringify({ status: "offline" }),
      });
    }
  }
  return {
    divisions: directory.divisions.length,
    characters: directory.characters.length,
    workflowPack: "roleplay",
  };
}

function parseArgs(args) {
  const command = args.shift() ?? "watch";
  let configPath = ".ai-company-local/claw-empire.json";
  let companyRoot = process.cwd();
  let defaultProvider = "codex";
  while (args.length) {
    const flag = args.shift();
    if (flag === "--config") configPath = path.resolve(args.shift());
    else if (flag === "--company-root") companyRoot = path.resolve(args.shift());
    else if (flag === "--provider") defaultProvider = args.shift();
    else throw new Error(`Unknown option: ${flag}`);
  }
  if (!["codex", "claude"].includes(defaultProvider)) {
    throw new Error("--provider must be codex or claude");
  }
  return { command, configPath, companyRoot, defaultProvider };
}

async function main() {
  const args = parseArgs(process.argv.slice(2));
  if (args.command === "init") {
    await mkdir(path.dirname(args.configPath), { recursive: true, mode: 0o700 });
    await writeFile(args.configPath, `${JSON.stringify({
      companyRoot: args.companyRoot,
      routingPath: "03-AI_departments/company-routing.json",
      officeUrl: "http://127.0.0.1:8790/",
      watchIntervalMs: 1500,
      defaultProvider: args.defaultProvider,
    }, null, 2)}\n`, { flag: "wx", mode: 0o600 });
    console.log(args.configPath);
    return;
  }
  const config = validateConfig(JSON.parse(await readFile(args.configPath, "utf8")), args.configPath);
  if (args.command === "directory") {
    const directory = buildDirectory(
      JSON.parse(await readFile(config.routingPath, "utf8")),
      config.defaultProvider,
    );
    console.log(JSON.stringify({
      divisions: directory.divisions.length,
      characters: directory.characters.length,
      provider: config.defaultProvider,
    }));
    return;
  }
  if (args.command === "check") {
    const health = await requestJson(config, "/healthz");
    console.log(JSON.stringify({ ok: health.ok === true, ...(await sync(config)) }));
    return;
  }
  if (args.command === "sync") {
    console.log(JSON.stringify(await sync(config)));
    return;
  }
  if (args.command !== "watch") throw new Error(`Unknown command: ${args.command}`);
  console.log(JSON.stringify(await sync(config)));
  watchFile(config.routingPath, { interval: config.watchIntervalMs }, async (current, previous) => {
    if (current.mtimeMs === previous.mtimeMs) return;
    try {
      console.log(JSON.stringify(await sync(config)));
    } catch (error) {
      console.error(safeText(error?.message, 180));
    }
  });
  const stop = () => unwatchFile(config.routingPath);
  process.once("SIGINT", stop);
  process.once("SIGTERM", stop);
}

if (process.argv[1] && import.meta.url === pathToFileURL(realpathSync(process.argv[1])).href) {
  main().catch((error) => {
    console.error(safeText(error?.message ?? "sync failed", 200));
    process.exitCode = 1;
  });
}
