---
name: ai-company-setup
description: One-shot setup for an OpenClaw-style AI company knowledge workspace. Use when the user wants to bootstrap AI社員 / AIカンパニーナレッジ from scattered files, run the construction prompt, set up MEMORY.md and departments, or says「セットアップ」「まとめてセットアップ」「AI社員の土台を作りたい」「PCを調べてセットアップ」.
disable-model-invocation: true
---

# AI Company Setup

grill-me 方式の対話セットアップ + 一括スクリプト実行。1ターン最大1〜2問。推測で埋めない。

## Canonical Design

**AGICAMP v2 テンプレ**（`Claude Code AI社員構築テンプレ v2`）が AI社員設計の正本です。

- ワークスペース内: `00-setup/ai-employee-template-v2.md`
- 原本: `05-raw-data/agicamp12/04_ai_template/template.md`
- 最初のAI社員: `content-brain`（発信脳）
- コピペ用: `00-setup/FIRST_EMPLOYEE_PROMPT.md`

## When To Use

- User bought Brain「AI社員の教科書」 and needs fast catch-up
- User says「まとめてセットアップ」「AI社員の土台を作りたい」「セットアップを一緒に」
- User has scattered Notion / ChatGPT / Drive / repo files and wants company knowledge
- User invokes `@ai-company-setup` or pastes `{destinationRoot}/00-setup/GRILL_SETUP_PROMPT.md`

**設定が既に揃っている場合のみ** Workflow Step 1 以降を直接実行。

## Workflow

### Step 0 — Grill Setup（デフォルト・必須）

スキル起動時、**最初のメッセージで必ず2択を提示**する:

1. **Interview Mode** — 質問に答えながら設定を確定
2. **PC Deep Research Mode** — 許可パスのみ自動調査 → 要確認項目を短く確認

ユーザーが未指定なら選ばせてから進む。両方混在可（Deep Research → 不足分を Interview）。

#### Interview Mode

- 詳細: [references/questions.md](references/questions.md)
- **Fast path**: 5問で `setup-config.json` 最小構成
- **Full path**: 全12問前後
- 1ターン **最大2問**。回答を受けてから次へ
- 既知（既存 `ai-company/USER.md` 等）は再質問しない

収集フィールド（`setup-config.schema.md` 準拠）:
`workspaceName`, `destinationRoot`, `companySlug`, `businessSlug`, `ownerName`, `ownerEmail`, `migrationMode`, `language`, `sourcePaths[]`

#### PC Deep Research Mode

- チェックリスト: [references/deep-research-checklist.md](references/deep-research-checklist.md)
- スクリプト実行:

```bash
.agents/skills/ai-company-setup/scripts/deep-research.sh \
  --repo-root /Users/kimurataiyou/taiyo-gyomu \
  --output /tmp/ai-company-deep-research.json
```

- 結果を **detected / not found / needs confirmation** で提示
- 推測値は `needs confirmation` と明記。ユーザー確認後に確定
- **`01-private/` は明示許可なしに読まない**（存在のみ報告可）

#### Step 0 出力

Interview または Deep Research 完了後、`setup-config.json` を書く:

- 推奨: `{repo-root}/.agents/skills/ai-company-setup/setup-config.json`
- または `/tmp/setup-config.json`（ユーザー指定時）

ユーザーに内容を要約提示 → **承認後** Step 1 へ。

### Step 1 — Collect facts（config 確定済みの場合）

`setup-config.json` から読み取る:

- `workspaceName` (e.g. `taiyo-ai-company`)
- `destinationRoot` (absolute path)
- `companySlug` (e.g. `kimura-taiyo`)
- optional `sourcePaths[]` for raw materials

### Step 2 — Init / Bootstrap

Run `scripts/init-ai-company.sh` with JSON config（新規）または `scripts/bootstrap-v2-template.sh --dest <path>`（既存へ v2 追記）。

生成先の `00-setup/claw-empire/` には、無料OSSのClaw-EmpireとAI COMPANY部署を同期する汎用セットアップを含む。Codex CLI / Claude Codeを選択でき、利用者固有設定は `.ai-company-local/` へ分離する。

### Step 3 — Stage raw data

If `sourcePaths` exist, run `scripts/stage-raw-data.sh`.
AGICAMP12 がある場合は `--agicamp-path` も。

### Step 4 — First employee

Open `FIRST_EMPLOYEE_PROMPT.md` → content-brain 実務テスト。

### Step 5 — Full construction

Open `BUILD_PROMPT.md` for full construction / knowledge migration.

### Step 6 — Verify

After AI migration, verify `MEMORY.md`, `02-company_knowledge/`, `03-AI_departments/content-brain/`.

### Step 7 — Smoke test

Run one smoke-test task against content-brain.

## Commands

From repo root:

```bash
# PC Deep Research（Step 0）
.agents/skills/ai-company-setup/scripts/deep-research.sh \
  --repo-root /Users/kimurataiyou/taiyo-gyomu \
  --output /tmp/ai-company-deep-research.json

# Init（Step 2）
.agents/skills/ai-company-setup/scripts/init-ai-company.sh \
  --config .agents/skills/ai-company-setup/setup-config.json

# Stage raw data（Step 3）
.agents/skills/ai-company-setup/scripts/stage-raw-data.sh \
  --dest ~/ai-company/05-raw-data \
  --paths /Users/kimurataiyou/taiyo-gyomu/.codex/brain-ichiaisyain

# AGI CAMP 12特典（固定サブディレクトリ agicamp12/ へステージ）
.agents/skills/ai-company-setup/scripts/stage-raw-data.sh \
  --dest ~/ai-company/05-raw-data \
  --agicamp-path ~/Downloads/AGICAMP12
```

## Resources

- `scripts/deep-research.sh`: PC metadata scan（Step 0 Deep Research）
- `scripts/init-ai-company.sh`: scaffold folders + starter docs + prompt bundle
- `scripts/bootstrap-v2-template.sh`: add v2 minimal structure to existing workspace
- `scripts/stage-raw-data.sh`: copy source folders into `05-raw-data/`
- `references/questions.md`: Interview Mode 質問リスト
- `references/deep-research-checklist.md`: Deep Research チェックリスト
- `references/setup-config.schema.md`: config fields
- `references/setup-config.example.json`: working sample
- `assets/templates/`: starter MEMORY / USER / SOUL stubs

## Handoff

セットアップ完了後:

1. `MEMORY.md` / `USER.md` が期待どおりか短く確認
2. **`{destinationRoot}/00-setup/FIRST_EMPLOYEE_PROMPT.md` を開くよう案内**
3. content-brain 実務テスト → 必要なら `BUILD_PROMPT.md`

## OSS×ローカルAI 業務自動化スターター（AGI CAMP v2）

業務自動化ツール選定用のExcelカタログと依頼文。

- Excel: `{destinationRoot}/04-resources/oss-local-ai-automation-starter.xlsx`
- 概要: `{destinationRoot}/00-setup/oss-automation-starter-v2.md`
- 依頼文: `{destinationRoot}/00-setup/OSS_AUTOMATION_REQUEST_PROMPT.md`
- 原本: `{destinationRoot}/05-raw-data/agicamp12/10_oss50/oss50.xlsx`

## AI部署7人（AGI CAMP v2）

構築後、7部署スキャフォールドは `03-AI_departments/` に配置済み。

- 正本: `{destinationRoot}/00-setup/seven-dept-prompt-v2.md`
- キックオフ: `00-setup/SEVEN_DEPT_KICKOFF.md`
- 実行順: `00-setup/SEVEN_DEPT_EXECUTION_ORDER.md`
- 引き継ぎ: `00-setup/SEVEN_DEPT_HANDOFF_TEMPLATE.md`

**最初は3人だけ**（CEO/PM → 制作/開発 → QA）。残り4部署は後から有効化。

## Rules

- Never rewrite source files during staging; copy only.
- Keep `ALLOW_CONTENT_REWRITE: false` in the construction prompt input.
- First goal is one working AI employee, not 30 departments.
- For multi-step work, use the 7-dept sequential flow; do not run all 7 at once.
- Long descriptions belong in notes/knowledge files, not invoice-style one-liners.
- 原本はコピーのみ（`migrationMode: COPY_ONLY` デフォルト）
- 秘密・APIキー・口座情報を config やログに書かない
- 日本語でユーザーと会話。コミットメッセージは英語

## Claw-Empire部署GUI

- 手順: `{destinationRoot}/00-setup/claw-empire/CLAW_EMPIRE_SETUP.md`
- 正本: `{destinationRoot}/03-AI_departments/company-routing.json`
- 初期状態は1部屋と `CEO・PM` / `制作・開発` / `品質確認` の3人
- Product / Growth / Shared Servicesは任意サンプルとして用意し、初期状態では使わない
- 高度な専門部署は共有版へ含めない
- 新しい機能部門は `watch` 中のGUIへ自動追加
- 正本から外れたキャラクターは削除せず `offline`

## Construction Prompt Source

Bundled from:

`.codex/brain-ichiaisyain/article/prompt.txt`

The init script copies it to `00-setup/construction-prompt.md` inside the destination root.

## Copy-paste Start

`{destinationRoot}/00-setup/GRILL_SETUP_PROMPT.md` — Cursor チャットに貼って `@ai-company-setup` で開始。
