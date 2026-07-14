# Grill Setup — Question List

`setup-config.schema.md` フィールド + 事業コンテキスト。Interview Mode 用。

## Fast Path（5問）

| # | 質問 | マップ先 |
|---|------|----------|
| F1 | AIカンパニーの置き場（絶対パス）は？ 例: `~/taiyo-gyomu/ai-company` | `destinationRoot` |
| F2 | ワークスペース名（表示用）は？ 例: `taiyo-ai-company` | `workspaceName` |
| F3 | オーナー名とメールは？ | `ownerName`, `ownerEmail` |
| F4 | 会社スラッグ（`02-company_knowledge/` 下）と事業スラッグは？ 例: `kimura-taiyo` / `consulting` | `companySlug`, `businessSlug` |
| F5 | 原材料フォルダはある？ パスを列挙（なければ空） | `sourcePaths[]` |

Fast path 完了後、デフォルトで `migrationMode: COPY_ONLY`, `language: ja` を設定。

## Full Path（Fast + 追加7問）

### Workspace basics

| # | 質問 | マップ先 |
|---|------|----------|
| W1 | 新規作成 vs 既存 `ai-company/` への追記？ | init vs bootstrap |
| W2 | 移行モード: 計画のみ / コピーのみ / 確認後適用？ | `migrationMode` |

### Owner profile

| # | 質問 | 用途 |
|---|------|------|
| O1 | 屋号・肩書きは？ | `USER.md` 補足 |
| O2 | 文体の好み（具体例優先、誇大NG 等）既存 `SOUL.md` と合う？ | 確認のみ |

### Business context

| # | 質問 | 用途 |
|---|------|------|
| B1 | 主な事業・サービスを1〜2文で | `02-company_knowledge/` ヒント |
| B2 | 主な顧客・導線（X, note, Brain 等） | ナレッジ配置 |
| B3 | よくある依頼タイプ top3 | 最初のAI社員スコープ |

### Raw materials

| # | 質問 | マップ先 |
|---|------|----------|
| R1 | Brain「AI社員の教科書」素材（`.codex/brain-ichiaisyain`）は使う？ | `sourcePaths[]` |
| R2 | `~/Downloads/AGICAMP12` はある？ステージする？ | `--agicamp-path` |
| R3 | 請求書・案件フォルダ（`invoices/`）も原材料に含める？ | `sourcePaths[]` |
| R4 | Notion/Drive エクスポートのローカルパスは？ | `sourcePaths[]` |

### First AI employee

| # | 質問 | 用途 |
|---|------|------|
| E1 | 最初のAI社員は content-brain（発信脳）でよい？ 別役割なら指定 | ハンドオフ先 |
| E2 | 最初の実務テスト（X案 / note導入 / FAQ整理 等）は何にする？ | FIRST_EMPLOYEE 前の期待 |

### Preferences

| # | 質問 | 用途 |
|---|------|------|
| P1 | 外部公開・送信は人間確認必須でよい？ | ポリシー確認 |
| P2 | `01-private/` に触れてよいタイミング（今は不可がデフォルト） | プライバシー |

## 進め方

1. Fast か Full かユーザーに確認（未指定なら Fast 提案）
2. 1ターン最大2問。番号（F1, B2 等）を付けて聞く
3. 回答を内部メモに蓄積。推測で埋めない
4. 全問完了 → `setup-config.json` ドラフト提示 → 承認

## setup-config.json テンプレ

```json
{
  "workspaceName": "",
  "destinationRoot": "",
  "companySlug": "",
  "businessSlug": "consulting",
  "ownerName": "",
  "ownerEmail": "",
  "migrationMode": "COPY_ONLY",
  "language": "ja",
  "sourcePaths": []
}
```
