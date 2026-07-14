# TOOLS.md

使用ツール / MCP 一覧。構築後に更新。

## 運用の正本

| 用途 | パス |
|---|---|
| AI会社の回し方（日次・週次・自動化判断） | `02-company_knowledge/openclaw-seminar/operating-playbook.md` |
| セミナー出典索引 | `02-company_knowledge/openclaw-seminar/_INDEX.md` |
| X運用戦術（content-brain） | `03-AI_departments/Marketing Department/content-brain/knowledge/openclaw-x-playbook.md` |

## OSS×ローカルAI 業務自動化スターター

| 用途 | パス |
|---|---|
| Excelカタログ（日常利用） | `04-resources/oss-local-ai-automation-starter.xlsx` |
| スターター概要 v2 | `00-setup/oss-automation-starter-v2.md` |
| AI社員依頼文（コピペ） | `00-setup/OSS_AUTOMATION_REQUEST_PROMPT.md` |
| 原本 | `05-raw-data/agicamp12/10_oss50/oss50.xlsx` |

### 上位候補（30日導入順ベース）

1. **Ollama + Open WebUI** — ローカルAI入口。社内メモ要約の検証から始める（難易度: 低）
2. **n8n** — API/Slack/Webhook/AI処理をつなぐワークフロー自動化（194k+ stars）
3. **Dify** — RAG・チャットbot・社内AIアプリの土台（147k+ stars）

使い方: いきなり本番導入せず、1業務を入力→判断→出力に分解し、Excelの「最初の検証タスク」だけ実行する。
