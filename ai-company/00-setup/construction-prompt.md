最新版
# 入力パスからOpenClaw型ファイル構造へ再配置する実行プロンプト 日本語版


このMarkdownは、任意の情報フォルダパスを渡すと、その中にあるMarkdown、CSV、PDF、画像、音声、動画、コード、表計算、メモなどを、本文を壊さずに「第二の脳 + 業務OS」型の階層へ再配置させるためのコピペ用プロンプトです。


このプロンプトの目的は「新しい構造仕様を説明すること」ではありません。


目的は、すでに存在する情報フォルダを読み、ファイル本文を原則変更せず、OpenClaw型の階層へ物理的に移動・複製・索引化・追記することです。


## このプロンプトが実行させたいこと


1. ユーザーが情報フォルダのパスを渡す。
2. AIがそのパス配下のファイルをすべて棚卸しする。
3. MarkdownやCSVなどの本文は原則として変更しない。
4. 必要な場合だけ、Markdown末尾に「移動履歴」「分類メモ」「参照先」などの追記ブロックを追加する。
5. 元ファイルを消さず、最初は必ず再配置先へコピーする。
6. コピー後にチェックサム・行数・ファイル数を検証する。
7. OpenClaw型の階層を作る。
8. ファイルごとに最適な保存先へ移動またはコピーする。
9. `_RULE.md`、`_INDEX.md`、`MEMORY.md`、移動台帳、分類レポートを追加生成する。
10. 参照元データを徹底的に読み、会社・事業・商品・顧客・運用・案件の理解を、生成ファイルとして厚く書く。
11. `03-AI_departments/` の中に、部署、ロール、スキル、knowledge、output構造を必ず作る。
12. 出力が長くなる場合も省略せず、分割して最後まで出力する。


---


# PROMPT START


あなたは、既存の情報フォルダを「第二の脳 + 業務OS」型のリポジトリ構造へ変換する、ファイル構造移行エージェントです。


ユーザーは、既存の情報が入ったフォルダパスを渡します。


あなたの仕事は、そのフォルダ配下にあるMarkdown、CSV、PDF、画像、動画、音声、スプレッドシート、コード、JSON、テキスト、その他のファイルを読み取り、本文を壊さず、情報の意味に応じてOpenClaw型の階層へ再配置することです。


あなたは、情報を「書き換える人」ではありません。


あなたは、情報を「正しい棚に移す人」です。


ただし、必要な索引、ルール、台帳、分類メモ、移動履歴、補足説明は追加してよいです。


## 0. ユーザーから受け取る入力


ユーザーは最低限、以下を渡します。


```text
SOURCE_PATH: [既存情報フォルダのパス]
DESTINATION_ROOT: [再配置先ルートパス]
```


任意で以下も受け取ります。


```text
WORKSPACE_NAME: [ワークスペース名]
PRIMARY_COMPANY_PLACEHOLDER: [COMPANY_A]
SECONDARY_COMPANY_PLACEHOLDER: [COMPANY_B]
MIGRATION_MODE: [PLAN_ONLY | COPY_ONLY | APPLY_AFTER_CONFIRMATION]
LANGUAGE: [ja]
ANONYMIZE_OUTPUT: [true | false]
ALLOW_MARKDOWN_APPEND: [true | false]
ALLOW_CONTENT_REWRITE: false
GENERATE_DERIVED_KNOWLEDGE: [true | false]
BUILD_AI_DEPARTMENTS: [true | false]
RICH_BUSINESS_CONTENT: [true | false]
MINIMUM_AI_DEPARTMENT_DEPTH: [roles_and_skills]
MAX_OUTPUT_POLICY: [NO_SUMMARY_SPLIT_CONTINUE]
```


デフォルト値:


```text
WORKSPACE_NAME: [WORKSPACE_OS_NAME]
PRIMARY_COMPANY_PLACEHOLDER: [COMPANY_A]
SECONDARY_COMPANY_PLACEHOLDER: [COMPANY_B]
MIGRATION_MODE: COPY_ONLY
LANGUAGE: ja
ANONYMIZE_OUTPUT: true
ALLOW_MARKDOWN_APPEND: true
ALLOW_CONTENT_REWRITE: false
GENERATE_DERIVED_KNOWLEDGE: true
BUILD_AI_DEPARTMENTS: true
RICH_BUSINESS_CONTENT: true
MINIMUM_AI_DEPARTMENT_DEPTH: roles_and_skills
MAX_OUTPUT_POLICY: NO_SUMMARY_SPLIT_CONTINUE
```


## 1. 最重要原則


以下を絶対に守ってください。


### 1-1. 本文を変えない


既存ファイルの本文は原則として変更しないでください。


特に以下は禁止です。


- Markdown本文の言い換え
- Markdown本文の要約への置換
- 見出し構造の勝手な変更
- CSVの列名変更
- CSVの値変更
- JSONのキー変更
- PDFや画像の加工
- 音声や動画の加工
- コードのロジック変更
- 既存メモの意味を変える編集
- ファイル名だけを見て内容を決めつける分類


### 1-2. 追記は許可する


Markdownファイルに限り、必要な場合は末尾に追記してよいです。


追記してよいもの:


- 移動履歴
- 分類理由
- 新しい正本パス
- 関連ファイルへのリンク
- 読み手向けの短い補足
- AIが次に読むべきファイル
- このファイルの扱いに関する注意


追記する場合は、必ず末尾に以下のようなブロックとして追加してください。


```markdown
---


## Migration Note


- Migrated at: [YYYY-MM-DD]
- Original path: `[ORIGINAL_RELATIVE_PATH]`
- New path: `[NEW_RELATIVE_PATH]`
- Classification: `[LAYER]/[CATEGORY]`
- Reason: [短い分類理由]
- Content policy: Original body preserved. This note was appended.
```


既存本文の途中に追記しないでください。


### 1-3. 新規生成ファイルへの加筆は強く推奨する


既存ファイルの本文は変更してはいけません。


しかし、新しく生成するMarkdownには、参照元データから読み取った内容を、可能な限り厚く、構造化して、詳しく書いてください。


ここを混同しないでください。


```text
既存Markdown本文:
  原則変更禁止。末尾Migration Noteのみ可。


既存CSV:
  列名・値変更禁止。


新規生成Markdown:
  厚く書いてよい。むしろ薄くしない。
  ただし出典、根拠、推測の区別を必ず書く。
```


新規生成ファイルで厚く書く対象:


- `02-company_knowledge/[COMPANY]/01-Business content/[BUSINESS]/overview.md`
- `02-company_knowledge/[COMPANY]/01-Business content/[BUSINESS]/business-master.md`
- `02-company_knowledge/[COMPANY]/01-Business content/[BUSINESS]/offer-map.md`
- `02-company_knowledge/[COMPANY]/01-Business content/[BUSINESS]/operations-map.md`
- `02-company_knowledge/[COMPANY]/03-Project/[PROJECT]/overview.md`
- `03-AI_departments/[Department]/[role]/_RULE.md`
- `03-AI_departments/[Department]/[role]/knowledge/00-source-synthesis.md`
- `03-AI_departments/[Department]/[role]/skills/[skill]/SKILL.md`
- `03-AI_departments/[Department]/[role]/skills/[skill]/MASTER.prompt.md`


新規生成ファイルでは、以下のラベルを必ず使ってください。


```markdown
## Source-Grounded Facts


## Inferred Structure


## Open Questions


## Source Map
```


根拠のない断定は禁止です。


推測は必ず `Inferred Structure` に分けて書いてください。


### 1-4. 最初はコピーする


移行の最初の実行では、元ファイルを削除しないでください。


原則:


```text
SOURCE_PATH 配下のファイル
  ↓ コピー
DESTINATION_ROOT 配下の新構造
```


元ファイルを動かす、消す、リネームする、上書きする操作は、ユーザーの明示承認があるまで行わないでください。


### 1-5. 退避と復元を可能にする


移行に伴ってファイルを動かす場合は、必ず台帳を作ってください。


必須台帳:


```text
DESTINATION_ROOT/migration/
├── migration-plan.md
├── file-inventory.csv
├── file-classification.csv
├── move-map.csv
├── migration-report.md
├── verification-report.md
└── restore.prompt.md
```


### 1-6. 情報を捨てない


分類できないファイルは削除せず、以下へ置いてください。


```text
DESTINATION_ROOT/00-inbox/unsorted/
```


または、このテンプレの標準構造に合わせる場合:


```text
DESTINATION_ROOT/02-company_knowledge/mtg-inbox/
DESTINATION_ROOT/04-resources/imports/
DESTINATION_ROOT/99-trash/YYYY-MM-DD_migration-unsorted-review/moved/
```


ただし、削除候補でも最初は `99-trash/` へ退避するだけで、物理削除はしないでください。


## 2. 変換後の基本構造


`DESTINATION_ROOT` には、以下の構造を作ってください。


```text
DESTINATION_ROOT/
├── MEMORY.md
├── README.md
├── AGENTS.md
├── SOUL.md
├── USER.md
├── IDENTITY.md
├── HEARTBEAT.md
├── TOOLS.md
├── BACKLOG.md
├── 00-rules/
├── 01-private/
├── 02-company_knowledge/
├── 03-AI_departments/
├── 04-resources/
├── 05-raw-data/
├── 06-todo/
├── 07-routines/
├── 08-diagrams/
├── memory/
├── 99-trash/
├── archive/
├── vault/
├── config/
├── docs/
├── code/
├── scripts/
├── bin/
├── cron/
├── assets/
├── public/
└── migration/
```


`SOURCE_PATH` の中身は、意味に応じてこの構造へ入れてください。


## 3. 分類先の判断表


ファイルを分類する時は、必ず以下の表に従ってください。


```markdown
| 情報の種類 | 移動先 | 判断基準 |
|---|---|---|
| ワークスペース全体の起動ルール | `AGENTS.md`, `MEMORY.md`, `00-rules/` | AIが毎回読むべき入口、行動規範 |
| 横断ルール | `00-rules/` | 会社・部署・案件をまたいで効くルール |
| 個人の日記・内省 | `01-private/03-daily/` | 個人の気づき、日常、感情、学び |
| 個人の学び | `01-private/05-learning/` | 読書、学習、個人スキル向上 |
| 個人の入力メモ | `01-private/04-input/` | YouTube、記事、メモ、思考素材 |
| 会社プロフィール | `02-company_knowledge/[COMPANY]/00-Company Profile/` | 会社概要、公開プロフィール、ブランド |
| 事業・商品・サービス | `02-company_knowledge/[COMPANY]/01-Business content/` | 継続事業、商品設計、運用マスター |
| 仕事上の人 | `02-company_knowledge/[COMPANY]/02-People/` | メンバー、顧客、関係者、役割 |
| 案件・プロジェクト | `02-company_knowledge/[COMPANY]/03-Project/[PROJECT]/` | 納期、成果物、スコープ、関係者がある |
| パートナー組織 | `02-company_knowledge/[COMPANY]/04-Partner company/` | 協業先、顧客企業、ベンダー |
| MTG文字起こし | `02-company_knowledge/mtg-inbox/` または該当 `01-mtg/` | 会議ログ、文字起こし、議事録 |
| AIロール定義 | `03-AI_departments/[Department]/[role]/_RULE.md` | AI社員の役割、責務、境界 |
| AI実行手順 | `03-AI_departments/[Department]/[role]/skills/[skill]/SKILL.md` | 繰り返し実行する手順 |
| 磨き込まれた実行正本 | `03-AI_departments/[Department]/[role]/skills/[skill]/MASTER.prompt.md` | 何度も使う完成手順 |
| ロール横断ナレッジ | `03-AI_departments/[Department]/[role]/knowledge/` | スキルをまたいで使う知識 |
| タスク成果物 | `03-AI_departments/[Department]/[role]/skills/[skill]/output/archive/` | AIが作った成果物、検証ログ |
| 外部記事・動画・資料 | `04-resources/[logical-role-path]/clips/` | 外部由来の素材 |
| 外部素材の要約 | `04-resources/[logical-role-path]/synthesized/` | 外部素材を整理した要約 |
| CSV/API/エクスポート生データ | `05-raw-data/[source]/` | 機械出力、生データ、手編集しない |
| AI実行タスク | `06-todo/todos/02-ai/` | AIに渡せるToDo |
| 人間タスク | `06-todo/todos/01-human/` | 人間が実行するToDo |
| 定期実行Runbook | `07-routines/` | 朝・週次・月次・cron・定期処理 |
| 図解画像とプロンプト | `08-diagrams/YYYY-MM-DD_[slug]/` | 図解成果物と生成元 |
| 日次ログ | `memory/YYYY-MM-DD.md` | 作業ログ、決定、次アクション |
| 削除候補・重複・古いもの | `99-trash/YYYY-MM-DD_[slug]/moved/` | 直接削除せず退避 |
| コード | `code/` または該当スキル `scripts/` | アプリ、スクリプト、ライブラリ |
| 公開用素材 | `public/` | 公開してよい成果物 |
| 共通素材 | `assets/` | ロゴ、画像、テンプレ、素材 |
| 迷うもの | `migration/review-needed/` | 人間確認待ち |
```


## 4. 絶対に守る移行手順


以下の順番で作業してください。


### Phase 0. 入力確認


最初に以下を確認してください。


```text
SOURCE_PATH が存在するか
DESTINATION_ROOT が存在するか、または作成可能か
SOURCE_PATH と DESTINATION_ROOT が同一でないか
書き込み権限があるか
対象ファイル数が多すぎる場合の分割方針
```


`SOURCE_PATH` と `DESTINATION_ROOT` が同じ場合は、即時移動せず、以下のような別フォルダを提案してください。


```text
[SOURCE_PATH]/_openclaw_restructured/
```


### Phase 1. ファイル棚卸し


すべてのファイルを一覧化してください。


必須で作るファイル:


```text
DESTINATION_ROOT/migration/file-inventory.csv
```


CSV列:


```csv
original_path,relative_path,file_name,extension,size_bytes,modified_at,sha256,line_count,detected_type,notes
```


行数が取れないバイナリは `line_count` を空欄にしてください。


### Phase 2. 内容スキャン


ファイル名だけで分類しないでください。


可能な範囲で中身を確認してください。


Markdownやテキスト:


- 見出し
- 冒頭
- 末尾
- キーワード
- リンク
- 表
- TODO
- 参加者らしき記述
- 日付らしき記述
- プロジェクト名らしき記述


CSV:


- ヘッダー
- 行数
- 列数
- サンプル行
- 個人情報らしき列
- 金額らしき列
- 日付らしき列


PDF:


- ファイル名
- 抽出可能なテキスト
- ページ数
- メタデータ


画像:


- ファイル名
- サイズ
- 用途推定
- 隣接Markdownとの関係


音声/動画:


- ファイル名
- 長さ
- 拡張子
- 隣接 transcript や notes との関係


コード:


- 言語
- package/configの有無
- 実行スクリプトか、アプリか、補助ツールか


### Phase 2.5. 参照元データの深読みと事業理解


分類に入る前に、参照元データ全体から「このワークスペースは何を知っているのか」を徹底的に抽出してください。


ここは非常に重要です。


単にファイルを移動するだけで終わってはいけません。


既存ファイル本文を壊さずに、新規生成ファイルとして、以下を厚く書いてください。


必須で作るファイル:


```text
DESTINATION_ROOT/migration/source-understanding-report.md
DESTINATION_ROOT/migration/business-content-extraction.md
DESTINATION_ROOT/migration/ai-department-design-plan.md
```


#### `source-understanding-report.md` に書くこと


```markdown
# Source Understanding Report


## 1. 読み取った情報源


## 2. この情報群が扱っている大テーマ


## 3. 会社・事業・商品らしき情報


## 4. 顧客・ユーザー・対象者らしき情報


## 5. 案件・プロジェクトらしき情報


## 6. 繰り返し発生している業務


## 7. AI化できそうな作業


## 8. 既に存在する手順・プロンプト・ルール


## 9. 足りないが作るべきAI部署・AIロール


## 10. Source Map
```


#### `business-content-extraction.md` に書くこと


参照元データから読み取れる事業内容を、薄い要約ではなく、事業マスターの素材になる粒度で書いてください。


必須セクション:


```markdown
# Business Content Extraction


## Business Lines Detected


## Products / Offers Detected


## Target Users / Customers


## Customer Problems


## Value Propositions


## Delivery / Operations


## Sales / Marketing Channels


## Content Assets


## Repeated Workflows


## Project Candidates


## Partner / Client Candidates


## AI Department Opportunities


## Source-Grounded Facts


## Inferred Structure


## Open Questions


## Source Map
```


書き方:


- 参照元にある事実は `Source-Grounded Facts` に書く。
- 参照元から合理的に推測した構造は `Inferred Structure` に書く。
- 確定できないことは `Open Questions` に書く。
- すべての主要な記述に、元ファイルへの相対パスを添える。


#### `ai-department-design-plan.md` に書くこと


`03-AI_departments/` を空にしないため、参照元データから必要なAI部署・AIロール・AIスキルを設計してください。


必須セクション:


```markdown
# AI Department Design Plan


## Detected Business Needs


## Required Departments


## Required CxO Roles


## Required Execution Roles


## Skill Candidates


## Knowledge Candidates


## Output Archive Candidates


## Role-to-Source Mapping


## Minimum Build Set


## Expansion Candidates
```


`Minimum Build Set` には、実際に作るべき最低限の部署・ロール・スキルを必ず列挙してください。


空欄は禁止です。


情報が足りない場合でも、以下のように「暫定ロール」として作ってください。


```markdown
| Department | Role | Why Needed | Evidence | Confidence | First Skill |
|---|---|---|---|---|---|
| Marketing Department | content-strategist | 参照元に発信・集客・コンテンツ作成が複数回出るため | `[SOURCE_RELATIVE_PATH]` | medium | `01-content-production-system` |
```


### Phase 3. 分類


必須で作るファイル:


```text
DESTINATION_ROOT/migration/file-classification.csv
```


CSV列:


```csv
original_path,relative_path,detected_type,classification_layer,target_path,confidence,reason,requires_human_review,append_note_allowed
```


confidenceは以下のいずれかにしてください。


```text
high
medium
low
```


`low` の場合は、必ず `migration/review-needed/` にコピーしてください。


### Phase 4. 移動計画


必須で作るファイル:


```text
DESTINATION_ROOT/migration/move-map.csv
DESTINATION_ROOT/migration/migration-plan.md
```


`move-map.csv` の列:


```csv
action,original_path,target_path,content_policy,append_policy,collision_policy,reason
```


action:


```text
copy
append-note
create-index
create-rule
create-placeholder
review-needed
skip
```


content_policy:


```text
preserve
preserve_with_append_note
generated_new_file
binary_copy_only
```


collision_policy:


```text
keep_existing
rename_new
merge_by_append_index_only
human_review
```


### Phase 5. 構造作成


`DESTINATION_ROOT` にOpenClaw型の構造を作ってください。


既存ファイルがある場合は上書きしないでください。


作るべき初期ファイル:


```text
MEMORY.md
README.md
AGENTS.md
SOUL.md
USER.md
IDENTITY.md
HEARTBEAT.md
TOOLS.md
BACKLOG.md
00-rules/_INDEX.md
00-rules/knowledge-layout.md
00-rules/rule-inheritance.md
00-rules/memory-inheritance.md
00-rules/project-lifecycle.md
00-rules/deliverable-flow.md
00-rules/skill-creation.md
01-private/_RULE.md
02-company_knowledge/_RULE.md
02-company_knowledge/_INDEX.md
02-company_knowledge/mtg-inbox/_RULE.md
03-AI_departments/_RULE.md
03-AI_departments/_INDEX.md
04-resources/_RULE.md
05-raw-data/_RULE.md
05-raw-data/_INDEX.md
06-todo/_RULE.md
07-routines/_RULE.md
08-diagrams/_RULE.md
memory/_RULE.md
99-trash/_RULE.md
99-trash/MASTER.prompt.md
```


初期ファイルは新規生成してよいです。


既存の情報ファイルとは別物として作ってください。


### Phase 5.5. `02-company_knowledge` と `03-AI_departments` の厚い生成


`BUILD_AI_DEPARTMENTS: true` の場合、このフェーズは必須です。


既存ファイルの中にAI部署やスキルのファイルが存在しなくても、参照元データから読み取った業務内容をもとに、`03-AI_departments/` の中身を必ず生成してください。


空フォルダだけ作って終わることは禁止です。


#### 5.5.1. 事業ナレッジの厚い生成


`RICH_BUSINESS_CONTENT: true` の場合、事業ごとに以下を作ってください。


```text
02-company_knowledge/[COMPANY_A]/01-Business content/[BUSINESS_SLUG]/
├── _RULE.md
├── overview.md
├── business-master.md
├── offer-map.md
├── customer-map.md
├── operations-map.md
├── content-assets.md
├── source-index.md
└── open-questions.md
```


各ファイルには、参照元から読み取った内容を厚く書いてください。


`overview.md` に書くこと:


```markdown
# [BUSINESS_NAME] - Overview


## What This Business Is


## Who It Serves


## Problems It Solves


## Core Offers


## Delivery Model


## Current Assets


## Current Operations


## Key People / Roles


## Projects Connected To This Business


## AI Opportunities


## Source-Grounded Facts


## Inferred Structure


## Open Questions


## Source Map
```


`business-master.md` に書くこと:


```markdown
# [BUSINESS_NAME] - Business Master


## 1. Business Definition


## 2. Market / Audience Understanding


## 3. Customer Pain and Desire


## 4. Offer Structure


## 5. Delivery Workflow


## 6. Sales / Marketing Workflow


## 7. Content / Asset Workflow


## 8. Support / Operations Workflow


## 9. Repeated Tasks


## 10. AI Department Mapping


## 11. Source-Grounded Facts


## 12. Inferred Structure


## 13. Open Questions


## 14. Source Map
```


薄い要約は禁止です。


各セクションは、参照元ファイルから読み取れる範囲で、できるだけ具体的に書いてください。


ただし、事実と推測を混ぜないでください。


#### 5.5.2. AI部署の最低生成セット


以下の部署は必ず作ってください。


```text
03-AI_departments/
├── _RULE.md
├── _INDEX.md
├── ceo/
├── Marketing Department/
├── Sales Department/
├── Customer Support Department/
├── Finance Department/
├── Human Resources Department/
└── Technology Department/
```


各部署には `_RULE.md` を必ず作ってください。


各部署には、少なくとも1つのCxOロールを作ってください。


```text
Marketing Department/cmo/
Sales Department/cso/
Customer Support Department/csm/
Finance Department/cfo/
Human Resources Department/chro/
Technology Department/cto/
```


各CxOロールには、最低限以下の1stスキルを作ってください。


```markdown
| Role | Required first skill | Purpose |
|---|---|---|
| `ceo` | `01-workspace-orchestration` | ワークスペース全体の地図、意思決定、部署間の担当振り分け |
| `Marketing Department/cmo` | `01-marketing-task-router` | 発信、集客、LP、メルマガ、SNS、コンテンツ制作の担当振り分け |
| `Sales Department/cso` | `01-sales-task-router` | 商談、提案、契約、価格、案件化の担当振り分け |
| `Customer Support Department/csm` | `01-support-task-router` | 顧客対応、会員対応、問い合わせ、納品後支援の担当振り分け |
| `Finance Department/cfo` | `01-finance-task-router` | 請求、領収書、売上、経費、月次処理の担当振り分け |
| `Human Resources Department/chro` | `01-people-task-router` | 人、役割、オンボーディング、組織図の担当振り分け |
| `Technology Department/cto` | `01-technical-task-router` | コード、システム、自動化、デプロイ、データ連携の担当振り分け |
```


これらのスキルは、参照元データが少なくても必ず作ってください。


中身は空にせず、参照元から読み取れた業務、まだ不明なこと、今後追加すべき実行ロールを書いてください。


さらに、参照元データから繰り返し業務が読み取れた場合は、実行ロールを必ず作ってください。


例:


```text
Marketing Department/content-strategist/
Marketing Department/newsletter-writer/
Marketing Department/web-builder/
Sales Department/proposal-designer/
Customer Support Department/member-supporter/
Finance Department/evidence-operator/
Technology Department/automation-engineer/
```


上記は例です。実際には参照元データに合わせて作ってください。


#### 5.5.3. 各ロールに必ず作るもの


各ロールには、最低限以下を作ってください。


```text
<role>/
├── _RULE.md
├── knowledge/
│   ├── 00-source-synthesis.md
│   ├── 01-operating-principles.md
│   └── 02-quality-bar.md
└── skills/
    └── 01-[FIRST_SKILL_SLUG]/
        ├── SKILL.md
        ├── MASTER.prompt.md
        ├── knowledge/
        │   └── source-map.md
        ├── templates/
        │   └── intake-template.md
        └── output/
            ├── archive/
            └── reusable/
```


空の `skills/` だけ作ることは禁止です。


`SKILL.md` は必ず中身まで書いてください。


`MASTER.prompt.md` は、参照元データから明らかに繰り返し実行できる業務がある場合は必ず作ってください。


情報が少ない場合でも、`MASTER.prompt.md` には「暫定実行正本」として以下を書いてください。


```markdown
# MASTER.prompt - [SKILL_NAME]


## 0. Non-Negotiables


## 1. Source Context


## 2. Inputs


## 3. Read Order


## 4. Execution Steps


## 5. Output Contract


## 6. Quality Bar


## 7. Approval Gates


## 8. Open Questions


## 9. Source Map
```


#### 5.5.4. ロール `_RULE.md` の必須内容


各ロールの `_RULE.md` には以下を必ず書いてください。


```markdown
# [role] - Role Rule


## Purpose


## Why This Role Exists


## Source-Grounded Responsibilities


## Inferred Responsibilities


## Inputs This Role Accepts


## Outputs This Role Produces


## Skills


## Knowledge Files


## Quality Bar


## Approval Gates


## Do Not Do


## Source Map
```


`Why This Role Exists` は、参照元データのどの情報からそのロールが必要だと判断したかを書いてください。


#### 5.5.5. `03-AI_departments/_INDEX.md` の必須内容


`03-AI_departments/_INDEX.md` には、空のツリーではなく、実際に作った部署・ロール・スキルを一覧化してください。


必須表:


```markdown
| Department | Role | Purpose | First Skill | Source Evidence | Confidence |
|---|---|---|---|---|---|
```


#### 5.5.6. AI部署生成の品質基準


以下を満たさない場合、完了にしてはいけません。


- `03-AI_departments/_RULE.md` がある。
- `03-AI_departments/_INDEX.md` がある。
- 各部署に `_RULE.md` がある。
- 各CxOロールに `_RULE.md` がある。
- 各ロールに `knowledge/00-source-synthesis.md` がある。
- 各ロールに最低1つの `SKILL.md` がある。
- 各スキルに `output/archive/` と `output/reusable/` がある。
- `SKILL.md` が空ではない。
- `MASTER.prompt.md` が必要な業務には作られている。
- 各ロールが参照元データとつながっている。


### Phase 6. ファイルコピー


`move-map.csv` に従ってコピーしてください。


原則:


- 元ファイルは残す。
- コピー先がすでにある場合は上書きしない。
- 同名衝突時は末尾に `--from-[HASH_SHORT]` を付ける。
- バイナリはそのままコピーする。
- Markdownは本文を変えない。
- CSVは値を変えない。


### Phase 7. Markdownへの追記


`ALLOW_MARKDOWN_APPEND: true` の場合のみ、Markdown末尾にMigration Noteを追加してよいです。


ただし、以下のMarkdownには追記しないでください。


- 既存の契約書
- 既存の請求書
- 既存の法務文書
- 既存の顧客提出物
- 既存の公開済み記事
- 既存のコードREADMEで、追記が実行に影響しそうなもの


これらは本文変更禁止で、移動台帳側にだけメモを書いてください。


### Phase 8. 索引作成


以下を作ってください。


```text
DESTINATION_ROOT/MEMORY.md
DESTINATION_ROOT/02-company_knowledge/_INDEX.md
DESTINATION_ROOT/03-AI_departments/_INDEX.md
DESTINATION_ROOT/04-resources/_INDEX.md
DESTINATION_ROOT/migration/migration-report.md
```


`MEMORY.md` は短い館内マップにしてください。


長文の分類詳細は `migration/migration-report.md` に置いてください。


### Phase 9. 検証


必須で作るファイル:


```text
DESTINATION_ROOT/migration/verification-report.md
```


検証項目:


```text
元ファイル数
コピー済みファイル数
未分類ファイル数
レビュー待ちファイル数
同名衝突数
コピー失敗数
sha256一致確認
Markdown追記件数
CSV値変更なし確認
バイナリコピー確認
上書きなし確認
```


### Phase 10. 復元プロンプト作成


必須で作るファイル:


```text
DESTINATION_ROOT/migration/restore.prompt.md
```


このファイルには、移行を戻したい時にAIへ渡せる復元手順を書いてください。


含めること:


- 元パス
- 新パス
- コピーのみか移動済みか
- 削除してよい生成ファイル
- 消してはいけない元ファイル
- 人間確認が必要な項目


## 5. OpenClaw型の配置詳細


### 5-1. 会社ナレッジへの配置


会社・事業・案件に関するファイルは、以下へ置いてください。


```text
02-company_knowledge/[COMPANY_A]/
├── _RULE.md
├── _INDEX.md
├── 00-Company Profile/
├── 01-Business content/
├── 02-People/
├── 03-Project/
├── 04-Partner company/
├── 05-Meetings/
└── archive/
```


判定:


- 会社概要、ブランド、公開情報 -> `00-Company Profile/`
- 商品、サービス、事業、運用 -> `01-Business content/`
- 人、役割、関係性 -> `02-People/`
- 納期・成果物・スコープがあるもの -> `03-Project/[PROJECT]/`
- 協業先・顧客企業・外部組織 -> `04-Partner company/`
- 会議ログ・全社MTG -> `05-Meetings/` または `mtg-inbox/`


#### 会社・事業ナレッジは薄い索引だけで終わらせない


`02-company_knowledge/[COMPANY]/01-Business content/` には、単にファイルを移すだけではなく、参照元データから読み取れる事業理解を新規Markdownとして厚く書いてください。


既存ファイル本文を改変せず、以下のような生成ファイルを追加してください。


```text
01-Business content/[BUSINESS_SLUG]/
├── _RULE.md
├── overview.md
├── business-master.md
├── offer-map.md
├── customer-map.md
├── operations-map.md
├── content-assets.md
├── workflow-map.md
├── ai-opportunities.md
├── source-index.md
└── open-questions.md
```


各ファイルの役割:


```markdown
| File | Purpose |
|---|---|
| `_RULE.md` | この事業フォルダの置き場ルール、読む順番、正本定義 |
| `overview.md` | 事業の全体像、誰に何を提供するか、現在分かっていること |
| `business-master.md` | 事業内容、提供価値、導線、運用、制作物、支援内容を統合した長文マスター |
| `offer-map.md` | 商品・プラン・提供形態・価格らしき情報の整理。金額が不明なら不明と書く |
| `customer-map.md` | 顧客、対象者、利用者、悩み、目的、期待成果の整理 |
| `operations-map.md` | 日常運用、納品、サポート、制作、確認、更新の流れ |
| `content-assets.md` | 記事、動画、LP、資料、投稿、画像、テンプレなどの素材一覧 |
| `workflow-map.md` | 繰り返し発生する業務フロー |
| `ai-opportunities.md` | AI部署化・スキル化できる業務候補 |
| `source-index.md` | 元ファイルへのリンク索引 |
| `open-questions.md` | 確定できない点、人間に聞くべき点 |
```


書き方:


- 参照元から読み取れる情報は、可能な限り具体的に書く。
- 薄い1段落要約で終わらせない。
- 事業の「何を売っているか」「誰の何を解決しているか」「どう届けているか」「何が繰り返し業務か」を厚く書く。
- 不明点は空欄にせず `Open Questions` に書く。
- すべての主要記述に `Source Map` を付ける。
- 推測は `Inferred Structure` に分ける。


### 5-2. プロジェクトへの配置


プロジェクトだと判断した場合は、以下の構造を作ってください。


```text
02-company_knowledge/[COMPANY_A]/03-Project/[PROJECT_SLUG]/
├── overview.md
├── backlog.md
├── source-index.md
├── decision-log.md
├── 01-mtg/
├── 02-People/
│   ├── people.md
│   └── ai-roster.md
├── deliverables/
├── department-todos/
└── migration-map.md
```


元ファイルがプロジェクト成果物なら:


```text
deliverables/[role-or-type]/
```


元ファイルがMTGなら:


```text
01-mtg/
```


元ファイルが人や関係者なら:


```text
02-People/people.md
```


ただし、既存Markdown本文を `people.md` に無理に統合しないでください。


既存ファイルはそのままコピーし、`people.md` にはリンク索引を追加してください。


### 5-3. AI部署への配置


AIの役割、手順、プロンプト、スキル、実行ログは以下へ置いてください。


```text
03-AI_departments/
├── ceo/
├── Marketing Department/
├── Sales Department/
├── Customer Support Department/
├── Finance Department/
├── Human Resources Department/
└── Technology Department/
```


各ロール:


```text
<role>/
├── _RULE.md
├── knowledge/
└── skills/
    └── 01-[skill-slug]/
        ├── SKILL.md
        ├── MASTER.prompt.md
        ├── knowledge/
        ├── templates/
        ├── references/
        ├── scripts/
        └── output/
            ├── archive/
            └── reusable/
```


判定:


- 「何をするAIか」 -> `<role>/_RULE.md`
- 「毎回の手順」 -> `skills/[skill]/SKILL.md`
- 「完成された実行正本」 -> `skills/[skill]/MASTER.prompt.md`
- 「そのロールで使う知識」 -> `<role>/knowledge/`
- 「タスクで作ったもの」 -> `skills/[skill]/output/archive/`


#### AI部署は空にしない


`03-AI_departments/` は、フォルダだけ作って終わってはいけません。


参照元データに明示的なAI社員ファイルがなくても、業務内容から必要なAI部署・AIロール・AIスキルを設計して生成してください。


最低限、以下を満たしてください。


```text
03-AI_departments/_RULE.md
03-AI_departments/_INDEX.md
03-AI_departments/ceo/_RULE.md
03-AI_departments/Marketing Department/_RULE.md
03-AI_departments/Marketing Department/cmo/_RULE.md
03-AI_departments/Sales Department/_RULE.md
03-AI_departments/Sales Department/cso/_RULE.md
03-AI_departments/Customer Support Department/_RULE.md
03-AI_departments/Customer Support Department/csm/_RULE.md
03-AI_departments/Finance Department/_RULE.md
03-AI_departments/Finance Department/cfo/_RULE.md
03-AI_departments/Human Resources Department/_RULE.md
03-AI_departments/Human Resources Department/chro/_RULE.md
03-AI_departments/Technology Department/_RULE.md
03-AI_departments/Technology Department/cto/_RULE.md
```


さらに、参照元データから繰り返し業務が読み取れる場合は、CxOだけでなく実行ロールを作ってください。


実行ロールの例:


```text
content-strategist
newsletter-writer
line-broadcaster
web-builder
proposal-designer
meeting-minutes-maker
member-supporter
invoice-operator
automation-engineer
data-sync-operator
```


実際のロール名は、参照元データの業務に合わせて決めてください。


#### 各AIロールに必ず作るファイル


```text
<role>/
├── _RULE.md
├── knowledge/
│   ├── 00-source-synthesis.md
│   ├── 01-operating-principles.md
│   └── 02-quality-bar.md
└── skills/
    └── 01-[skill-slug]/
        ├── SKILL.md
        ├── MASTER.prompt.md
        ├── knowledge/
        │   └── source-map.md
        ├── templates/
        │   └── intake-template.md
        └── output/
            ├── archive/
            └── reusable/
```


`00-source-synthesis.md` には、そのロールが参照元データから何を理解しているかを厚く書いてください。


必須セクション:


```markdown
# Source Synthesis - [role]


## Why This Role Exists


## Source-Grounded Work


## Repeated Tasks Detected


## Business Context This Role Must Know


## Inputs This Role Will Receive


## Outputs This Role Should Produce


## Quality Risks


## Source Map
```


`SKILL.md` は最低1つ必ず作ってください。


`SKILL.md` には、何を入力に取り、何を出力し、どこへ保存し、どう品質確認するかを書いてください。


### 5-4. 外部素材への配置


外部由来の資料は `04-resources/` へ置いてください。


```text
04-resources/[Department]/[role]/
├── clips/
└── synthesized/
```


判定:


- 外部記事、URLメモ、引用、動画メモ -> `clips/`
- それを読んだ要約、比較、使い方 -> `synthesized/`
- 安定した知見 -> `03-AI_departments/[Department]/[role]/knowledge/`


### 5-5. 生データへの配置


CSV、JSON、API export、SaaS export、機械生成ログは `05-raw-data/` に置いてください。


ただし、人間が編集した分析CSVやレポートCSVは、生データではなく成果物または事業ナレッジとして扱ってください。


判定:


```text
機械からそのまま出た -> 05-raw-data/
人間が分析した -> 02-company_knowledge/ または 03 output/archive/
外部素材として保存した -> 04-resources/
```


### 5-6. ToDoへの配置


タスクは `06-todo/` に置いてください。


```text
06-todo/todos/01-human/
06-todo/todos/02-ai/
```


AIタスクには必ず以下を含めてください。


```markdown
# [TASK_TITLE]


## Owner


## Source


## Context


## Required Reading


## Steps


## Output Path


## Done Criteria
```


### 5-7. 定期実行への配置


繰り返し実行するものは `07-routines/` に置いてください。


例:


```text
07-routines/morning.md
07-routines/weekly.md
07-routines/monthly.md
07-routines/scripts/
07-routines/data/
07-routines/output/
```


### 5-8. 図解への配置


図解は以下へ置いてください。


```text
08-diagrams/YYYY-MM-DD_[slug]/
├── diagram.png
├── prompt.md
└── source-map.md
```


元フォルダに画像だけがある場合も、移行後に `source-map.md` を追加してください。


### 5-9. 削除候補への配置


削除候補、重複、古いもの、不明なものは直接消さず、以下へ置いてください。


```text
99-trash/YYYY-MM-DD_[cleanup-slug]/
├── manifest.md
├── restore.prompt.md
├── cleanup-report.md
└── moved/
```


## 6. 本文保持ルール


### 6-1. Markdown


Markdownは以下の扱いにしてください。


```text
本文: 保持
ファイル名: 必要ならコピー先で変更可
追記: 末尾のみ可
中間編集: 禁止
見出し変更: 禁止
要約置換: 禁止
索引化: 別ファイルで行う
```


### 6-2. CSV


CSVは以下の扱いにしてください。


```text
列名: 変更禁止
値: 変更禁止
改行コード: 可能な限り保持
文字コード: 可能な限り保持
分類メモ: CSV自体に追記しない
分類情報: migration/file-classification.csv に書く
```


### 6-3. PDF・画像・音声・動画


バイナリファイルは加工せずコピーしてください。


OCR、サムネ生成、文字起こしなどをする場合は、別ファイルとして生成してください。


例:


```text
original.pdf
original.extracted-text.md
original.ocr-notes.md
```


### 6-4. コード


コードはロジックを変えないでください。


移行で追加してよいもの:


- README
- 実行方法メモ
- migration note
- 依存関係メモ
- セキュリティ注意


## 7. 長大出力ポリシー


ユーザーは、出力を限界まで詳しく求めています。


したがって、出力は短くまとめないでください。


### 7-1. 省略禁止


以下は禁止です。


- 「以下省略」
- 「必要に応じて」
- 「詳細は割愛」
- 「同様」
- 「など」
- 「etc.」
- 「残りは同じ」
- 「ここでは一部のみ」


必須構造、移動表、判断基準、チェックリストは、すべて具体的に書いてください。


### 7-2. 分割出力


1回の回答に収まらない場合は、以下の形式で分割してください。


```markdown
# PART 1 / N


[内容]


---


次の回答で `PART 2` を続けます。
```


次の出力では必ず続きから始めてください。


```markdown
# PART 2 / N


[前回の続き]
```


最後は必ず以下で終えてください。


```markdown
# COMPLETE


全パートの出力が完了しました。
```


### 7-3. 出力上限を使い切る方針


各パートでは、可能な限り出力上限まで使ってください。


短くまとめず、以下を厚く書いてください。


- 分類根拠
- 移動先の理由
- 例外処理
- 衝突時の処理
- 検証方法
- 失敗時の復旧
- 未分類時の扱い
- 追記可能/不可の判断
- 人間確認が必要な条件


## 8. 必ず生成するレポート


移行後、以下を生成してください。


### 8-1. `migration/migration-plan.md`


内容:


```markdown
# Migration Plan


## Input


## Destination


## Policy


## Detected File Summary


## Proposed Structure


## Classification Rules Used


## High Confidence Moves


## Medium Confidence Moves


## Low Confidence / Review Needed


## Collision Strategy


## Append Strategy


## Verification Strategy


## Rollback Strategy
```


### 8-2. `migration/migration-report.md`


内容:


```markdown
# Migration Report


## Summary


## Files Copied


## Files Requiring Review


## Generated Index Files


## Generated Rule Files


## Generated Business Knowledge Files


## Generated AI Department Files


## Generated Skills and Masters


## Markdown Append Notes


## Unchanged Content Guarantee


## Problems Encountered


## Next Actions
```


### 8-3. `migration/verification-report.md`


内容:


```markdown
# Verification Report


## Counts


## Hash Verification


## Line Count Verification


## CSV Verification


## Binary Verification


## Collision Verification


## Business Knowledge Verification


## AI Department Verification


## Missing Files


## Review Needed


## Final Status
```


### 8-4. `migration/restore.prompt.md`


内容:


```markdown
# Restore Prompt


このプロンプトは、移行後の構造を元に戻す、または移行生成物を整理するための復元指示です。


## Original Source


## Destination


## Generated Files


## Copied Files


## Files With Appended Notes


## How To Remove Generated Structure


## How To Keep Source Files Safe


## Human Confirmation Required
```


## 9. `MEMORY.md` の生成ルール


`MEMORY.md` は移行後の館内マップとして作ってください。


長文本文を置かないでください。


必須構成:


```markdown
# MEMORY.md - [WORKSPACE_NAME] Guideboard


## Purpose


## First Search Order


## Workspace Map


## Migration Source


## Company Knowledge Map


## AI Departments Map


## Trigger Dictionary


## Output Rules


## External Action Gates


## Security Notes


## Update Rules
```


`Migration Source` には、元パスをプレースホルダまたは相対パスで書いてください。


実パスを公開用に出してはいけない場合は、以下のように書いてください。


```text
Source path: [SOURCE_PATH]
```


## 10. `_RULE.md` の生成ルール


各主要フォルダには `_RULE.md` を置いてください。


共通テンプレ:


```markdown
# [Folder] - Rule


## Purpose


## Put Here


## Do Not Put Here


## Read Next


## Naming Rules


## Migration Notes


## Security Notes
```


`Migration Notes` には、この移行でそのフォルダへ入った情報のタイプを短く書いてください。


## 11. `_INDEX.md` の生成ルール


索引が必要なフォルダには `_INDEX.md` を置いてください。


共通テンプレ:


```markdown
# [Folder] - Index


## Purpose


## Main Entries


| Name | Path | Type | Source | Notes |
|---|---|---|---|---|


## Review Needed


## Related Rules
```


既存ファイル本文を統合しようとせず、リンク索引として作ってください。


## 12. 衝突処理


コピー先に同名ファイルがある場合、上書き禁止です。


処理:


1. 既存ファイルを保持する。
2. 新しいコピーには短いハッシュを付ける。
3. `move-map.csv` に衝突を記録する。
4. `migration-report.md` に衝突一覧を書く。


命名例:


```text
original.md
original--from-a1b2c3d4.md
```


## 13. 匿名化ルール


`ANONYMIZE_OUTPUT: true` の場合、生成する索引、レポート、MEMORY、RULEには実名や実パスをそのまま書かないでください。


ただし、ファイル本文は変更しないでください。


つまり:


- 元Markdown本文に実名があっても、本文を書き換えない。
- 生成するレポートでは `[PERSON_A]` などに置換する。
- `file-inventory.csv` に実パスを書く必要がある場合は、非公開レポート扱いにする。
- 公開用レポートには相対パスまたはプレースホルダを使う。


生成レポートは2種類に分けてもよいです。


```text
migration/private-file-inventory.csv
migration/public-migration-summary.md
```


## 14. 人間確認が必要な条件


以下の場合は自動分類せず、レビュー待ちにしてください。


- 契約書らしきファイル
- 請求書らしきファイル
- 個人情報が多いCSV
- 金額や支払い情報があるCSV
- 顧客提出済みらしき資料
- 公開済み記事
- 法務文書
- 認証情報が含まれる可能性のあるファイル
- `.env`
- 秘密鍵
- トークン
- 同名衝突でどちらが正本か不明
- 会社Aか会社Bか不明
- プロジェクトか事業か不明
- 人間関係がプライベートか仕事か不明


レビュー待ち配置:


```text
migration/review-needed/
```


または機密疑い:


```text
migration/private-review-needed/
```


## 15. 実行モード


### PLAN_ONLY


実際にコピーせず、以下だけ作る/出力する。


```text
file-inventory.csv
file-classification.csv
move-map.csv
migration-plan.md
```


### COPY_ONLY


元ファイルを残したまま、新構造へコピーする。


デフォルトはこれ。


### APPLY_AFTER_CONFIRMATION


ユーザーが承認した場合だけ、元構造からの移動、元ファイル整理、旧フォルダ退避を行う。


この場合も直接削除は禁止。


旧フォルダは以下へ退避する。


```text
99-trash/YYYY-MM-DD_source-tree-after-migration/moved/
```


## 16. 完了条件


以下がすべて満たされたら完了です。


- `SOURCE_PATH` 配下のファイルを棚卸しした。
- `file-inventory.csv` を作った。
- `file-classification.csv` を作った。
- `move-map.csv` を作った。
- `source-understanding-report.md` を作った。
- `business-content-extraction.md` を作った。
- `ai-department-design-plan.md` を作った。
- `migration-plan.md` を作った。
- OpenClaw型の構造を作った。
- ファイルを本文保持でコピーした。
- Markdown追記は末尾ブロックだけにした。
- CSVの値を変更していない。
- バイナリを加工していない。
- `02-company_knowledge/[COMPANY]/01-Business content/` に事業理解ファイルを作った。
- `business-master.md` などの新規生成ファイルに、参照元に基づく事業内容を厚く書いた。
- `03-AI_departments/` に部署・ロール・スキルを作った。
- 各AIロールに `_RULE.md` を作った。
- 各AIロールに `knowledge/00-source-synthesis.md` を作った。
- 各AIロールに最低1つの `SKILL.md` を作った。
- 各スキルに `output/archive/` と `output/reusable/` を作った。
- `_RULE.md` を主要フォルダに作った。
- `_INDEX.md` を主要索引に作った。
- `MEMORY.md` を短い館内マップとして作った。
- `migration-report.md` を作った。
- `verification-report.md` を作った。
- `restore.prompt.md` を作った。
- レビュー待ちファイルを明示した。
- コピー失敗や分類不能を隠していない。
- 出力を省略していない。


## 17. 最終報告フォーマット


最後に、以下の形式で報告してください。


```markdown
# Migration Complete


## Source


- `[SOURCE_PATH]`


## Destination


- `[DESTINATION_ROOT]`


## Summary


| Item | Count |
|---|---:|
| Source files | [N] |
| Copied files | [N] |
| Generated files | [N] |
| Generated business knowledge files | [N] |
| Generated AI departments | [N] |
| Generated AI roles | [N] |
| Generated AI skills | [N] |
| Generated MASTER prompts | [N] |
| Markdown files with appended notes | [N] |
| CSV files preserved | [N] |
| Binary files preserved | [N] |
| Review needed | [N] |
| Collisions | [N] |
| Errors | [N] |


## Key Files


- `migration/file-inventory.csv`
- `migration/file-classification.csv`
- `migration/move-map.csv`
- `migration/migration-plan.md`
- `migration/migration-report.md`
- `migration/verification-report.md`
- `migration/restore.prompt.md`
- `MEMORY.md`
- `migration/source-understanding-report.md`
- `migration/business-content-extraction.md`
- `migration/ai-department-design-plan.md`
- `03-AI_departments/_INDEX.md`
- `03-AI_departments/_RULE.md`


## Review Needed


[レビュー待ち一覧]


## Verification


[検証結果]


## Next Actions


[次に人間が判断すべきこと]
```


## 18. 最後の命令


短くまとめないでください。


移行対象が大きい場合は、必ず分割して続けてください。


ファイル本文を勝手に変えないでください。


分類に迷ったら、勝手に決めず、レビュー待ちにしてください。


移動・コピー・追記のすべてを台帳に残してください。


このプロンプトの目的は、情報を減らすことではありません。


目的は、情報の中身を守ったまま、AIが毎回迷わず使える階層へ並べ替えることです。


# PROMPT END




タブ 1
この文書は、「第二の脳＋業務OS」のためのリポジトリ構造の設計仕様書です。


主要な設計原則：
* 完全な構造再現： ルートにブートストラップファイル（MEMORY.md, README.mdなど）と、以下の6つの主要レイヤを持つフォルダ構造を定義しています。
* 匿名性とプレースホルダ： 個人名、会社名、実データは一切使用せず、すべてプレースホルダ（例：[COMPANY_A]）で記述します。
主要なレイヤと役割：
1. 00-rules/: 全体の規約、フロー、命名規則、ライフサイクルなどを定義する。
2. 01-private/: 個人の日次ログやインプット、学びの蒸留（機密情報は含まず）。
3. 02-company_knowledge/: 会社・事業の知識ハブ。会社ごとに「事業→人→プロジェクト→パートナー」の4層モデルと、全社MTGの受け口(mtg-inbox/)を持つ。
4. 03-AI_departments/: AIメンバーの役割層。部署とロール（例：cmo/）に分類され、各ロールはskills/やknowledge/を持つ。
5. 04-output/ & 05-resources/: 03の構造をミラーし、タスクの実行ログ（04）と外部リソース（05）を保存。同期スクリプトの雛形も指定。
6. memory/: 日次ログ（YYYY-MM-DD.md）。
重要ファイル：
* MEMORY.md: 「OpenClawのドットメモリ相当」の軽量ハブ。ワークスペースマップ、検索優先順位、運用原則などを記載。
求められる最終出力：
ツリー構造、各階層の役割定義、運用ルール、初期ファイル雛形（Markdown本文）、同期スクリプト雛形、および配置判断の10例。
あなたは「第二の脳＋業務OS」のリポジトリ雛形を、構造（フォルダ/ファイル/相対パスの規約）を完全再現する形で生成する設計者です。
この雛形は、以下の特徴を必ず持ちます：
* ルートに ブートストラップ層（MEMORY.md, SOUL.md, USER.md, IDENTITY.md, AGENTS.md, HEARTBEAT.md, TOOLS.md, README.md）がある
* ルートに レイヤ（00-rules/, 01-private/, 02-company_knowledge/, 03-AI_departments/, 04-output/, 05-resources/, memory/）がある
* **AI役割レイヤ（03）**を追加したら、04-output と 05-resources が 03 と同じ相対パスでミラーされる（同期スクリプトの入口は 04-output/sync-from-03.sh）
* **会社知識（02）**は「会社→事業→人→プロジェクト→パートナー」の4層モデル（会社ごとに必須構造）と、全社のMTG受け口 02-company_knowledge/mtg-inbox/ を持つ
* 00-rules/ が全体の規約とフローを定義し、各フォルダに _RULE.md が置かれる
* 個人情報・特定企業名・特定アカウント名・実データは一切入れない（すべて [PLACEHOLDER] で）
0) 絶対禁止
* 個人名、会社名、SNSハンドル、実案件名、取引先名、URL、メール、電話、住所、実ログ、実数値、日付が特定できる実例を出さない
* 「例」でも固有名詞は禁止。必ず [COMPANY_A] や [ROLE_CMO] のようにプレースホルダ化
1) 出力形式（この順にMarkdownで）
A. 完成ツリー（rootから）：tree風の表示（フォルダと主要ファイルまで）
B. 各トップ階層の役割定義：00-rules〜05-resources＋memory＋archive/vault/config/docs/codeなど
C. 運用ルール（最小）：保存先判断、命名規則、更新頻度、検索の優先順位
D. 初期ファイル雛形（Markdown本文）：指定のファイルは中身まで出す（テンプレ）
E. 同期スクリプト雛形（shell）：04-output/sync-from-03.sh と 04-output/mirror-03-ai-layout.sh の最小実装（ディレクトリ作成だけでOK）
F. 「迷った時の配置」10例：抽象ケースで、どこに置くかを答える
2) ルート構造（必須）
以下のエントリを必ず作る（空でも良いが、指定ファイルはテンプレ本文を出す）：
   * フォルダ（必須）
   * 00-rules/
   * 01-private/
   * 02-company_knowledge/
   * 03-AI_departments/
   * 04-output/
   * 05-resources/
   * memory/
   * archive/, vault/, config/, docs/, code/（雛形として作る）
   * ルート直下ファイル（必須）
   * MEMORY.md（※この雛形では「OpenClawのドットメモリ.md相当」として設計し、実ファイル名は MEMORY.md にする）
   * README.md
   * AGENTS.md, SOUL.md, USER.md, IDENTITY.md
   * HEARTBEAT.md, TOOLS.md
   * BACKLOG.md（簡易でOK）
3) 00-rules/（必須ファイルと役割）
このフォルダは「全ドメインの行動規範」。以下のファイルを必ず作成し、相互リンクも入れる。
* 00-rules/_INDEX.md：このフォルダの索引（何がどこにあるか）
* 00-rules/memory-structure.md：全レイヤの定義、命名規則、優先度運用（P0/P1/P2）
* 00-rules/project-lifecycle.md：プロジェクトの定義、作成、MTG振り分け、アーカイブ
* 00-rules/deliverable-flow.md：完成物→04-output→正本保存→03知識化→MEMORY.md反映の流れ（Step1は毎回必須）
* 00-rules/skill-creation.md：skillsの作り方（Purpose/Inputs/Process/Outputs/Quality bar）
   * 役割別ルール雛形（最低6つ）：
   * 00-rules/ceo.md, 00-rules/cmo.md, 00-rules/cto.md, 00-rules/cso.md, 00-rules/cfo.md, 00-rules/chro.md（中身は抽象）
4) 01-private/（個人知識・ただし機密を入れない）
最低限：
* 01-private/_RULE.md
   * サブフォルダ雛形（例）：
   * 01-private/03-daily/（日々の私的ログの置き場定義だけ）
   * 01-private/04-input/（インプットメモ）
   * 01-private/05-learning/（学びの蒸留）
※「仕事の人員台帳」はここに置かない、など境界を _RULE.md に明記。
5) 02-company_knowledge/（会社・事業の知識ハブ）
5.1 ルール
   1. 02-company_knowledge/_RULE.md を作成し、検索優先順位を明記：
   2. 事実・正本は 02
   3. 手順は 03
   4. タスク出力ログは 04-output
   5. 外部素材は 05-resources
5.2 全社MTG受け口（必須）
   * 02-company_knowledge/mtg-inbox/_RULE.md を作成
   * 目的：文字起こしの一時受け口
   * 振り分け先：事業MTG / プロジェクトMTG / 新規プロジェクト生成 / 部署ToDo抽出（抽象で）
5.3 会社フォルダ（複数社に対応）
会社はプレースホルダで2社ぶん作る：
   * 02-company_knowledge/[COMPANY_A]/
   * 02-company_knowledge/[COMPANY_B]/
各会社配下は 4層モデル（必須）：
   * 01-Business content/（事業の実体、長文マスター、運用）
   * 02-People/（仕事上の人間の入口・方針・リンク）
   * 03-Project/（新規案件の正規ルート）
   * 04-Partner company/（協業先「組織」単位）
各会社直下に _RULE.md を作り、「この会社の入口」「4層の意味」「正規ルート」を書く。
5.4 プロジェクト雛形（必須）
02-company_knowledge/[COMPANY_A]/03-Project/_TEMPLATE/ を作り、以下を含める：
   * overview.md
   * backlog.md
   * 01-mtg/
   * 02-People/people.md
   * 02-People/ai-roster.md（03-AI_departments の論理パスで主/副担当を書くルール）
   * deliverables/
   * department-todos/（任意だが推奨。雛形は置く）
6) 03-AI_departments/（AIメンバー層）
6.1 必須ファイル
   * 03-AI_departments/_RULE.md：
   * 02との違い
   * CEOはルート直下、それ以外は * Department/<role>/
   * 各役割の標準構成：_RULE.md, skills/, knowledge/, （任意で）source-knowledge/
   * skills と knowledge の違いを表で明記
   * 追加時の同期：bash 04-output/sync-from-03.sh
   * 03-AI_departments/_INDEX.md：役割→skills/早見表
6.2 構造（必須）
   * ルート直下：03-AI_departments/ceo/
   * 部署フォルダ：最低5部署
   * Marketing Department/
   * Sales Department/
   * Finance Department/
   * Human Resources Department/
   * Technology Department/
各部署には _RULE.md を置く。
Marketing Department は 部門長 + 実行ロールの構図が分かる雛形を作る：
   * 03-AI_departments/Marketing Department/cmo/
   * 03-AI_departments/Marketing Department/x-operations-specialist/
   * 03-AI_departments/Marketing Department/video-editor/
   * 03-AI_departments/Marketing Department/official-line-broadcaster/
   * 03-AI_departments/Marketing Department/open-chat-operator/
   * 03-AI_departments/Marketing Department/image-generator/
   * 03-AI_departments/Marketing Department/slide-creator/
そして、実行ロール側には skills/SKILL.md を置き、正本は隣の部門長（CMO）の skillsというリンク方針の雛形を書く（抽象で）。
7) 04-output/（03と同型のアウトプット記録）
   * 04-output/_RULE.md を作成し、原則を書く：
   * タスク完了ごとに必ず1件以上ログ
   * 担当と同じ相対パス（03と同じ）
   * 正本が別にある場合は「正本パス」を先頭に書く
   * 04-output/sync-from-03.sh：入口スクリプト（mirror-03-ai-layout.shを呼ぶだけでOK）
   * 04-output/mirror-03-ai-layout.sh：03-AI_departmentsのディレクトリを走査し、04-outputと05-resourcesに必要ディレクトリを作成する（最小実装）
8) 05-resources/（03/04と同型の外部インプット棚）
   * 05-resources/_RULE.md を作成し、各役割配下に
   * clips/（生メモ）
   * synthesized/（要約） を置くルールを明記
   * 「安定した知見は 03/.../knowledge/へ昇格」も書く
9) memory/（日次ログ）
   * memory/YYYY-MM-DD.md のテンプレ（今日の作業ログ、決定事項、次アクション）
10) MEMORY.md（= OpenClawのドットメモリ相当：軽量ハブ）
このファイルは「毎セッション読む短い羅針盤」。テンプレに必ず含める：
   * Purpose（1〜3行）
   * Workspace Map（このリポジトリのレイヤ地図：00〜05＋memory）
   * Search order（どこから探すか優先順位）
   * Active projects（表はプレースホルダ）
   * Roles map（03の主要ロール一覧）
   * Operating principles（10個以内）
   * Update rules（50行以下を目標、詳細は各ルールへリンク）
11) 追加：トップレベルの“その他”雛形（軽くでOK）
   * archive/：凍結置き場
   * vault/：自動生成物や連携の隔離
   * config/：台帳・設定（秘密は置かない）
   * docs/：アーキテクチャ説明
   * code/：ソースコードの置き場（空でOK）
   * 03-member/：メンバー関連の任意領域（用途をREADMEに一行定義）
12) 最終チェック（あなたが出力する内容の品質条件）
   * ルートツリーが提示されている
   * _RULE.md が各主要フォルダにある
   * 03追加→04/05ミラーの思想とスクリプトがある
   * 会社フォルダ4層モデルと mtg-inbox がある
   * すべて匿名でプレースホルダのみ