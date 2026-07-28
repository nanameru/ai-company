#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: init-ai-company.sh --config setup.json

Creates OpenClaw-style AI company workspace, starter docs, and BUILD_PROMPT.md.
EOF
}

CONFIG=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --config) CONFIG="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 1 ;;
  esac
done

[[ -n "$CONFIG" && -f "$CONFIG" ]] || { echo "Config not found: $CONFIG" >&2; exit 1; }

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
REPO_ROOT="$(cd "$SKILL_DIR/../../.." && pwd)"
PROMPT_SRC="$REPO_ROOT/.codex/brain-ichiaisyain/article/prompt.txt"

python3 - "$CONFIG" "$SKILL_DIR" "$PROMPT_SRC" <<'PY'
import json, os, shutil, sys
from pathlib import Path

config_path, skill_dir, prompt_src = sys.argv[1:4]
cfg = json.loads(Path(config_path).read_text())
required = ["destinationRoot", "companySlug", "workspaceName", "ownerName", "ownerEmail"]
for key in required:
    if not cfg.get(key):
        raise SystemExit(f"Missing config field: {key}")

root = Path(cfg["destinationRoot"]).expanduser().resolve()
company = cfg["companySlug"]
business = cfg.get("businessSlug", "main")
workspace = cfg["workspaceName"]
owner_name = cfg["ownerName"]
owner_email = cfg["ownerEmail"]
migration_mode = cfg.get("migrationMode", "COPY_ONLY")
language = cfg.get("language", "ja")

def render_template(name: str) -> str:
    text = (Path(skill_dir) / "assets/templates" / name).read_text()
    return (
        text.replace("{{WORKSPACE_NAME}}", workspace)
        .replace("{{COMPANY_SLUG}}", company)
        .replace("{{OWNER_NAME}}", owner_name)
        .replace("{{OWNER_EMAIL}}", owner_email)
    )

folders = [
    "00-rules",
    "00-setup",
    "01-private",
    f"02-company_knowledge/{company}/00-Company Profile",
    f"02-company_knowledge/{company}/01-Business content/{business}",
    f"02-company_knowledge/{company}/02-People",
    f"02-company_knowledge/{company}/03-Project",
    f"02-company_knowledge/{company}/04-Partner company",
    f"02-company_knowledge/{company}/05-Meetings",
    "03-AI_departments/ceo",
    "03-AI_departments/Marketing Department/content-writer/skills/01-draft-writer/output/archive",
    "03-AI_departments/Marketing Department/content-writer/skills/01-draft-writer/output/reusable",
    "03-AI_departments/Sales Department",
    "03-AI_departments/Customer Support Department",
    "03-AI_departments/Finance Department",
    "03-AI_departments/Technology Department",
    "04-resources",
    "05-raw-data/inbox",
    "06-todo",
    "07-routines",
    "99-trash",
]

root.mkdir(parents=True, exist_ok=True)
for rel in folders:
    (root / rel).mkdir(parents=True, exist_ok=True)

for name in ["MEMORY.md", "USER.md", "SOUL.md"]:
    (root / name).write_text(render_template(name))

(root / "README.md").write_text(
    f"# {workspace}\n\n"
    f"OpenClaw-style AI company workspace.\n\n"
    f"- Owner: {owner_name}\n"
    f"- Company slug: {company}\n"
    f"- Next: open `00-setup/BUILD_PROMPT.md` and run in Claude Code / Cursor\n"
)

stubs = {
    "AGENTS.md": "# AGENTS.md\n\n稼働中のAI社員一覧。構築後に更新。\n",
    "IDENTITY.md": "# IDENTITY.md\n\nブランド・トーン。構築後に更新。\n",
    "TOOLS.md": "# TOOLS.md\n\n使用ツール / MCP 一覧。構築後に更新。\n",
    "BACKLOG.md": "# BACKLOG.md\n\n- [ ] 原材料を集める\n- [ ] 構築プロンプトを実行\n- [ ] 最初の実務テスト\n",
    "HEARTBEAT.md": "# HEARTBEAT.md\n\n定期タスクの稼働ログ。\n",
    f"02-company_knowledge/{company}/_RULE.md": "# _RULE.md\n\n会社ナレッジの読み方。構築後に更新。\n",
    f"02-company_knowledge/{company}/_INDEX.md": "# _INDEX.md\n\n会社ナレッジ索引。構築後に更新。\n",
    f"02-company_knowledge/{company}/01-Business content/{business}/overview.md": f"# {business} overview\n\n事業概要をここに集約。\n",
    "03-AI_departments/Marketing Department/content-writer/_RULE.md": "# content-writer RULE\n\nマーケ文書担当の共通ルール。\n",
    "03-AI_departments/Marketing Department/content-writer/skills/01-draft-writer/SKILL.md": "# SKILL: draft-writer\n\n## 目的\n短い下書きを作る最初のスキル。\n\n## 出力\n`output/draft.md`\n",
}
for rel, content in stubs.items():
    path = root / rel
    if not path.exists() or path.stat().st_size == 0:
        path.write_text(content)

setup_dir = root / "00-setup"
setup_dir.mkdir(exist_ok=True)
if Path(prompt_src).exists():
    shutil.copy2(prompt_src, setup_dir / "construction-prompt.md")
else:
    (setup_dir / "construction-prompt.md").write_text("# construction prompt missing\n")

manifest = {
    "workspaceName": workspace,
    "destinationRoot": str(root),
    "companySlug": company,
    "businessSlug": business,
    "migrationMode": migration_mode,
    "language": language,
    "sourcePaths": cfg.get("sourcePaths", []),
}
(setup_dir / "setup-manifest.json").write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n")

build_prompt = f"""# BUILD_PROMPT

次を Claude Code または Cursor にそのまま貼り付けて実行してください。

## 1. 構築プロンプト本体

`00-setup/construction-prompt.md` を最初に読み込む。

## 2. 入力ブロック

```text
SOURCE_PATH: {root / '05-raw-data'}
DESTINATION_ROOT: {root}
WORKSPACE_NAME: {workspace}
PRIMARY_COMPANY_PLACEHOLDER: {company}
SECONDARY_COMPANY_PLACEHOLDER:
MIGRATION_MODE: {migration_mode}
LANGUAGE: {language}
ANONYMIZE_OUTPUT: false
ALLOW_MARKDOWN_APPEND: true
ALLOW_CONTENT_REWRITE: false
GENERATE_DERIVED_KNOWLEDGE: true
BUILD_AI_DEPARTMENTS: true
```

## 3. 事前準備

1. 原材料を `05-raw-data/` にコピーする
2. 構築プロンプトを実行する
3. `MEMORY.md` と `02-company_knowledge/` を人間が確認する
4. `03-AI_departments/Marketing Department/content-writer/skills/01-draft-writer/` で1件テストする

## 4. 実務テスト例

> USER.md と SOUL.md を読んだうえで、{owner_name} の事業紹介を200字で書き、`03-AI_departments/Marketing Department/content-writer/skills/01-draft-writer/output/draft.md` に保存してください。
"""
(setup_dir / "BUILD_PROMPT.md").write_text(build_prompt)

claw_source = Path(skill_dir) / "assets" / "claw-empire"
claw_destination = setup_dir / "claw-empire"
if claw_source.is_dir():
    shutil.copytree(claw_source, claw_destination, dirs_exist_ok=True)
    for executable in ["install-claw-empire.sh", "sync-claw-empire.mjs"]:
        target = claw_destination / executable
        if target.exists():
            target.chmod(target.stat().st_mode | 0o111)
    routing_template = claw_source / "company-routing.template.json"
    routing_target = root / "03-AI_departments/company-routing.json"
    if routing_template.exists() and not routing_target.exists():
        shutil.copy2(routing_template, routing_target)

gitignore_path = root / ".gitignore"
gitignore_text = gitignore_path.read_text() if gitignore_path.exists() else ""
if ".ai-company-local/" not in gitignore_text.splitlines():
    separator = "" if not gitignore_text or gitignore_text.endswith("\n") else "\n"
    gitignore_path.write_text(f"{gitignore_text}{separator}.ai-company-local/\n")

print(str(root))
PY
