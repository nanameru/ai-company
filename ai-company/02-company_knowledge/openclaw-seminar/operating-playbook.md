# AI会社 運用プレイブック

> 出典: いち OpenClaw 5日間セミナー（`sKBf0LxcMHg`, `LNSj32yU-Aw`, `78BrwdpqoIQ`, `mCODugvZqPA`, `mK_bFEnliwQ`）
> 前提: OpenClawを必須としない。木村太陽の **ai-company** ワークスペースで再現する。

## この文書の目的

「優秀な新卒社員」止まりのAIを、「自分を知り尽くした分身」に育てるための運用設計。
プロンプトの巧みさより、**情報の一元管理**と**自律的な定期実行**が勝ち筋。

---

## OpenClaw 3強み → ai-company 相当

| いちの概念 | 意味 | ai-company での実装 |
|---|---|---|
| **自立性** | 頼まなくても動く。定期実行・分析・提案まで自律 | `HEARTBEAT.md` + content-brain の SKILL 起動。将来は n8n/cron で朝の投稿案生成 |
| **永続メモリー** | 会話が消えない。ローカルMarkdownに蓄積 | `MEMORY.md`, `02-company_knowledge/`, `knowledge/`, `output/archive/`。Obsidianで閲覧 |
| **ローカル実行** | API従量課金を抑え、自分のファイルを直接参照 | `taiyo-gyomu` リポジトリ内のローカルファイル。Cursor / Claude Code（任意） |

ChatGPT/Geminiとの差: 受動的Q&Aではなく、**決まった時間に決まった仕事を回す**設計が本質（出典: `LNSj32yU-Aw`, `78BrwdpqoIQ`）。

---

## 情報の一元管理（最重要）

メモ・タスク・議事録・発信素材がバラバラだと、どんなに優秀なAIも毎回初対面になる（出典: `LNSj32yU-Aw`）。

### 木村の一元化マップ

| 情報の種類 | 置き場 | ルール |
|---|---|---|
| 会社の方針・代表の思想 | `SOUL.md`, `USER.md`, `MEMORY.md` | 長期方針の正本 |
| 事業・オファー | `02-company_knowledge/` | 価格・契約はここだけ |
| 発信ナレッジ・バズ型 | `content-brain/knowledge/` | 要約して置く。生ログは入れない |
| 未整理の原材料 | `05-raw-data/` | 原本保持。要約してから正本へ |
| 成果物・作業ログ | `output/archive/YYYY-MM-DD_slug/` | 次の仕事の材料にする |
| 個人情報・認証 | `01-private/` | AIの無断参照禁止 |

### 階層ナレッジの考え方

いちは `people/arkl/school` のような階層で記憶を分けていた（出典: `78BrwdpqoIQ`）。
ai-company では次に相当する:

```
02-company_knowledge/kimura-taiyo/   … 本人・事業の正本
03-AI_departments/*/knowledge/      … 部署別の実務ナレッジ
05-raw-data/                        … 未加工の一次情報
```

**一次情報**（旅行メモ、相談ログ、試行錯誤のメモ）を溜めるほど、AIの出力に差別化が乗る。一般知識だけでは伸びない（出典: `78BrwdpqoIQ`）。

---

## AI社員 vs 自動化パイプライン

| 観点 | AI社員（今やる） | 自動化パイプライン（後でやる） |
|---|---|---|
| 単位 | 1部署1スキル（content-brain から） | n8n / cron / Webhook 連鎖 |
| 強み | 判断・文体・文脈理解 | 定時実行・定型処理・通知 |
| 例 | X投稿案10本を人間が選んで投稿 | 毎朝6時にトレンド調査→80件案生成→UI表示 |
| 状態 | **今はこちらを安定させる** | パターンが固まってから導入 |

いちの事例: 朝6時に投稿案60〜80件生成、Slackリマインド、請求書処理の自動開発（出典: `sKBf0LxcMHg`, `78BrwdpqoIQ`）。
木村はまず **手動起動の content-brain** で同じ品質を再現し、週次で「何を自動化するか」を1つだけ選ぶ。

### 増やす順序（SOUL.md と整合）

1. content-brain（発信脳）— 稼働中
2. ceo-pm → production-dev → qa（案件単位で3人）
3. 残り4部署は必要になってから
4. n8n 等の自動化は「同じ入力→同じ出力」が3回連続で成功してから

---

## X運用の公式（概要）

詳細は `content-brain/knowledge/openclaw-x-playbook.md` へ。

```
フォロワー伸長 = 投稿数 × バズる型 × 情報密度
```

- **Aグループ**（〜200人）: 投稿数が最優先。打席を増やす
- **Bグループ**（200人〜）: バズる型の量産が最優先
- **情報密度**: AIで補完しにくい。本人の体験・実績・解釈が差別化の核

---

## 日次・週次ワークフロー

### 毎日（15〜30分）

| 時間帯 | やること | 担当 |
|---|---|---|
| 朝 | Daily Note / 作業メモを `05-raw-data/` または Obsidian に1行でも残す | 木村 |
| 朝 | content-brain で X投稿案 5〜10本生成。`output/archive/` に保存 | AI社員 |
| 昼〜夕 | 1〜3本を選んで投稿（外部送信は人間のみ） | 木村 |
| 夜 | 反応が良かった投稿を `knowledge/` に要約で追記 | 木村 or AI |

### 毎週（土日 1時間）

| やること | 目的 |
|---|---|
| バズ投稿（10いいね以上）を10件集め、型を分析 | Bグループ向け。型の更新 |
| 週次で投稿案をまとめ生成（平日は少量、週末に補充） | いちのハイブリッド運用（出典: `78BrwdpqoIQ`） |
| `output/archive/` を見返し、次週のテーマ候補を3つ決める | 改善ループ |
| 自動化候補を1つだけメモ（まだ実装しない） | `BACKLOG.md` または inbox |

### 月次

- `02-company_knowledge/` の陳腐化チェック
- 新しい原材料を `05-raw-data/` に集約
- 安定した処理だけ n8n 化を検討

---

## 今は手動 / 後で自動化

### 今は手動で十分（安定優先）

- content-brain への依頼・プロンプト実行
- X投稿の最終選択・投稿
- バズ投稿の型分析（初回はスプレッドシートでも可）
- ナレッジの `knowledge/` への要約追記
- 請求書・顧客対応（人間判断必須）

### 後で自動化する候補（パターン確定後）

| 処理 | 候補ツール | 参照 |
|---|---|---|
| 毎朝のトレンド調査 + 投稿案生成 | n8n + Cursor Agent / cron | `78BrwdpqoIQ` |
| 投稿パフォーマンス集計（URL渡し→分析） | n8n + X API | `78BrwdpqoIQ` |
| Slack/LINE リマインド | n8n Webhook | `sKBf0LxcMHg` |
| 請求書ドラフト生成 | 既存 invoice スキル + n8n | `sKBf0LxcMHg` |
| 定期バックアップ・ログ整理 | cron | `mCODugvZqPA` |

導入順の参考: `TOOLS.md` の OSS スターター（Ollama → n8n → Dify）。

---

## ツールスタック（木村向け）

| ツール | 役割 | 必須度 |
|---|---|---|
| **Obsidian** | `ai-company/` の閲覧・Daily Note・グラフで文脈把握 | 推奨 |
| **Cursor** | AI社員の実行環境。SKILL / Agent で content-brain 起動 | 必須 |
| **Claude Code** | 外出先からの操作、コーディング寄りの自動化 | 任意 |
| **n8n** | ワークフロー自動化（30日目以降） | 将来 |
| **Git** | ナレッジの版管理・`output/archive/` の履歴 | 必須 |

セキュリティの考え方（出典: `sKBf0LxcMHg`, `mCODugvZqPA`）:
- 本番データと実験を分ける（専用マシン or VPS は将来検討）
- `01-private/` と認証情報はリポジトリ外 or gitignore
- 外部送信・公開は人間の最終確認後のみ（`00-rules/external-action-policy.md`）

---

## 失敗パターンと対処

| 症状 | 原因 | 対処 |
|---|---|---|
| 毎回同じような投稿になる | ナレッジ不足・一次情報がない | `05-raw-data/` に体験メモを増やす |
| AIが前の会話を覚えていない | 一元管理できていない | `MEMORY.md` と `knowledge/` を更新 |
| 自動化したが品質が落ちた | 早すぎる自動化 | 手動で3回成功してから n8n 化 |
| 投稿はするが伸びない | 段階と施策のミスマッチ | A→量、B→型。`openclaw-x-playbook.md` を参照 |

---

## 次のアクション（木村）

- [ ] 直近のバズ投稿10件を `content-brain/knowledge/` に要約で入れる
- [ ] 今週の content-brain テストを `FIRST_EMPLOYEE_PROMPT.md` で1回実行
- [ ] Daily Note の置き場を決める（Obsidian or `06-todo/inbox.md`）
- [ ] 自動化は1つだけ候補に書く（実装はまだしない）
