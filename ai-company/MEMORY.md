# MEMORY.md

> AIが最初に読む案内板。詳細は各フォルダへ誘導する。

## Workspace

- Name: taiyo-ai-company
- Owner: 木村 太陽
- Company slug: kimura-taiyo
- 設計正本: `00-setup/ai-employee-template-v2.md`

## Read First

1. `SOUL.md` — 代表の思想・トーン
2. `USER.md` — オーナープロフィール
3. `00-rules/` — 文体・QA・外部操作ポリシー
4. `02-company_knowledge/service.md` — 事業・サービス正本
5. `02-company_knowledge/kimura-taiyo/_INDEX.md` — 詳細ナレッジ索引
6. `02-company_knowledge/openclaw-seminar/operating-playbook.md` — AI会社の運用正本（日次・週次・自動化判断）
7. `03-AI_departments/` — AI部署とスキル

## 長期的に守る方針

- ナレッジ不足が失敗原因。プロンプト巧みさより資料室の設計。
- 原本は壊さない。コピーで再配置する。
- 成果物は `output/archive/` に残し、次の仕事の材料にする。
- 最初は1体のAI社員だけ。安定してから役割を分ける。

## Departments

- `03-AI_departments/Marketing Department/content-brain/` — 最初のAI社員（発信脳）
- `03-AI_departments/Marketing Department/content-writer/` — レガシー下書き担当
- `03-AI_departments/ceo/` — 未稼働
- その他部署 — 未稼働

## Resources

- `02-company_knowledge/openclaw-seminar/_INDEX.md` — OpenClawセミナー5本の索引（要約リンク付き）
- `02-company_knowledge/openclaw-seminar/operating-playbook.md` — 運用プレイブック正本
- `03-AI_departments/Marketing Department/content-brain/knowledge/openclaw-x-playbook.md` — X運用戦術（content-brain向け）

## Raw Materials

- `05-raw-data/` — 未整理の原材料（原本は保持）
- `05-raw-data/agicamp12/04_ai_template/template.md` — v2テンプレ原本
- `04-resources/oss-local-ai-automation-starter.xlsx` — OSS×ローカルAI 50選カタログ
- `00-setup/OSS_AUTOMATION_REQUEST_PROMPT.md` — 業務自動化のAI社員依頼文

## Outputs

- 各AI社員の `output/archive/YYYY-MM-DD_slug/` に成果物を保存する

## Setup Status

- [x] v2テンプレを `00-setup/` に保存した
- [x] 最小フォルダ構造を作成した
- [x] content-brain を初期構築した
- [x] OSS自動化スターターを `04-resources/` に配置した
- [ ] （任意）`00-setup/GRILL_SETUP_PROMPT.md` で `@ai-company-setup` 対話セットアップ
- [ ] 原材料を `05-raw-data/` に集めた
- [ ] `FIRST_EMPLOYEE_PROMPT.md` で実務テストした
- [ ] `02-company_knowledge/` を人間が確認した
