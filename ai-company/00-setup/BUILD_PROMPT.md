# BUILD_PROMPT

AI社員ワークスペースの構築手順。v2テンプレ準拠。

設計正本: `00-setup/ai-employee-template-v2.md`

## 推奨フロー

1. **ブートストラップ** — `CLAUDE_CODE_BOOTSTRAP_PROMPT.md`（初回のみ）
2. **最初のAI社員** — `FIRST_EMPLOYEE_PROMPT.md`（content-brain の実務テスト）
3. **本格構築** — 以下の構築プロンプト（ナレッジ移行・部署拡張）

## 1. 最初のAI社員プロンプト（先に実行）

`00-setup/FIRST_EMPLOYEE_PROMPT.md` を Claude Code に貼り、content-brain が動くことを確認する。

## 2. 構築プロンプト本体

`00-setup/construction-prompt.md` を読み込む。

## 3. 入力ブロック

```text
SOURCE_PATH: /Users/kimurataiyou/taiyo-gyomu/ai-company/05-raw-data
DESTINATION_ROOT: /Users/kimurataiyou/taiyo-gyomu/ai-company
WORKSPACE_NAME: taiyo-ai-company
PRIMARY_COMPANY_PLACEHOLDER: kimura-taiyo
SECONDARY_COMPANY_PLACEHOLDER:
MIGRATION_MODE: COPY_ONLY
LANGUAGE: ja
ANONYMIZE_OUTPUT: false
ALLOW_MARKDOWN_APPEND: true
ALLOW_CONTENT_REWRITE: false
GENERATE_DERIVED_KNOWLEDGE: true
BUILD_AI_DEPARTMENTS: true
```

## 4. 事前準備

1. 原材料を `05-raw-data/` にコピーする（AGICAMP12 は `05-raw-data/agicamp12/` にステージ済み）
2. `FIRST_EMPLOYEE_PROMPT.md` で content-brain をテストする
3. 構築プロンプトを実行する（ナレッジ移行・部署拡張）
4. AGICAMP12 優先参照:
   - `00-setup/ai-employee-template-v2.md` — ワークスペース設計正本（v2）
   - `00-setup/seven-dept-prompt-v2.md` — AI部署7人プロンプト（正本）
   - `00-setup/SEVEN_DEPT_EXECUTION_ORDER.md` — 実行順テンプレ
   - `05-raw-data/agicamp12/02_obsidian/prompts/workspace-memory-rules-audit-prompt.md` — 構築後監査
5. `MEMORY.md` と `02-company_knowledge/` を人間が確認する
6. AI部署7人: 最初は `ceo-pm` → `production-dev` → `qa` の3人で1件テスト（`SEVEN_DEPT_KICKOFF.md` から起動）

## 5. 実務テスト例

> content-brain として、USER.md と `02-company_knowledge/service.md` を読んだうえで、AI社員ワークスペース構築テーマのX投稿案を3本作り、`03-AI_departments/Marketing Department/content-brain/output/archive/` に保存してください。

または AI部署7人フロー:

> `00-setup/SEVEN_DEPT_KICKOFF.md` を埋め、Step 1（CEO/PM）→ Step 3（制作/開発）→ Step 5（QA）の順で1件テストする。

## 6. その他のコピペ用プロンプト

- `CLAUDE_CODE_BOOTSTRAP_PROMPT.md` — 初回ブートストラップ
- `WORK_REQUEST_TEMPLATE.md` — 日常の作業・修正依頼
- `SEVEN_DEPT_KICKOFF.md` — AI部署7人 案件起票
- `SEVEN_DEPT_HANDOFF_TEMPLATE.md` — 引き継ぎメモ
- `prompts/*.md` — 各担当初回プロンプト
- `OSS_AUTOMATION_REQUEST_PROMPT.md` — OSS×ローカルAI 業務自動化の候補選定依頼（`04-resources/oss-local-ai-automation-starter.xlsx` と併用）
