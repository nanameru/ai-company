# 無料OSS×ローカルAI 業務自動化スターター v2

この特典は、短いチェックリストではなく、実際に開けるExcelワークブックとして作り直しました。

## 入っているもの

- GitHub高スターOSS/ローカルAI 50選
- GitHub URL
- Stars（GitHub API取得日: 2026-07-01）
- ライセンス
- 導入難易度
- 業務自動化での使いどころ
- 最初の検証タスク
- 30日導入順
- AI社員へそのまま貼れる依頼文

## Excelファイル

- **日常利用**: `04-resources/oss-local-ai-automation-starter.xlsx`
- **原本**: `05-raw-data/agicamp12/10_oss50/oss50.xlsx`

## まず見るべき上位候補

- n8n-io/n8n（194,739 stars）: API、Google Sheets、Slack、Webhook、AI処理をつないで業務フローを作る
- ollama/ollama（175,211 stars）: PCやサーバー上でローカルLLMを動かす入口
- langgenius/dify（147,216 stars）: RAG、チャットbot、ワークフロー、社内AIアプリの土台
- open-webui/open-webui（143,658 stars）: Ollama等をブラウザUIで使い、社内向けAI画面を作る
- firecrawl/firecrawl（142,447 stars）: WebページをAIが読みやすいMarkdown/構造化データへ変換する
- langchain-ai/langchain（140,631 stars）: ツール呼び出し、RAG、エージェントなどのAIアプリ構築基盤
- browser-use/browser-use（101,898 stars）: AIにブラウザ操作をさせ、Web作業を自動化する
- puppeteer/puppeteer（95,212 stars）: Chrome操作、スクレイピング、PDF/スクショ生成
- microsoft/playwright（92,013 stars）: Webサイトの表示確認、フォーム入力、スクショ取得、E2E確認
- louislam/uptime-kuma（88,620 stars）: Web/サービス/ジョブの死活監視と通知

## 使い方

1. いきなり本番導入しない
2. まず1業務だけ選ぶ
3. 入力、判断、出力に分解する
4. Excelのカテゴリで候補を絞る
5. 「最初の検証タスク」だけ実行する
6. 外部送信、個人情報、ライセンス、バックアップを確認する
7. 人間確認を残してから運用化する

## おすすめの最小構成

- ローカルAI入口: Ollama + Open WebUI
- 文書RAG: AnythingLLM or RAGFlow
- ワークフロー: n8n
- Web収集: Firecrawl or changedetection.io
- 表示/リンクQA: Playwright
- 監視: Uptime Kuma
- ログ/評価: Langfuse

## AI社員に頼む時の依頼文

コピペ用は `00-setup/OSS_AUTOMATION_REQUEST_PROMPT.md` を開く。
