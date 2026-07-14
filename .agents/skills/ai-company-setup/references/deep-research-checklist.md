# Deep Research Checklist

PC Deep Research Mode 用。メタデータのみ。ファイル内容・秘密は読まない。

## スキャン対象

| 項目 | 典型パス | 検出内容 |
|------|----------|----------|
| 既存 ai-company | `{repo}/ai-company`, `~/ai-company` | フォルダ構造、USER/MEMORY 有無 |
| USER.md | `{dest}/USER.md` | 存在、オーナー名の有無（中身は要確認） |
| 05-raw-data | `{dest}/05-raw-data` | サブフォルダ一覧、ファイル数 |
| brain-ichiaisyain | `{repo}/.codex/brain-ichiaisyain` | 存在、記事/スクリプト有無 |
| AGICAMP12 | `~/Downloads/AGICAMP12` | 存在、主要サブディレクトリ |
| invoices | `{repo}/invoices` | クライアントフォルダ数（中身は読まない） |
| ai-company-setup スキル | `{repo}/.agents/skills/ai-company-setup` | example config 参照可 |
| 01-private | `{dest}/01-private` | **存在のみ**。中身は禁止 |

## 追加のよくあるエクスポート

- `~/Downloads/` — AGICAMP, Notion export, ChatGPT export っぽいフォルダ名
- `~/Documents/` — 同上（浅いスキャンのみ）
- `{repo}/.codex/` — brain 系、作業ログ（パス一覧のみ）

## 提示フォーマット

各項目を3状態で報告:

- **detected** — パス存在。メタデータ（ファイル数、更新日）のみ
- **not found** — パスなし
- **needs confirmation** — 推測値（例: USER.md から ownerName）。ユーザー確認必須

### 例

```
detected: /Users/kimurataiyou/taiyo-gyomu/ai-company (MEMORY.md, USER.md あり)
detected: .codex/brain-ichiaisyain (article/, scripts/)
not found: ~/Downloads/AGICAMP12
needs confirmation: destinationRoot → 既存 ai-company を使う？
needs confirmation: ownerEmail → USER.md に記載あり。これを使う？
```

## setup-config へのマッピング

| 検出 | 提案フィールド |
|------|----------------|
| 既存 ai-company + USER.md | `destinationRoot`, `ownerName`, `ownerEmail`（要確認） |
| USER.md の company slug 痕跡 | `companySlug`（要確認） |
| brain-ichiaisyain | `sourcePaths[]` に追加 |
| invoices/ | `sourcePaths[]` に追加（要確認） |
| AGICAMP12 | stage-raw-data `--agicamp-path` 候補 |
| 未検出 destination | ユーザーに F1 相当を1問だけ |

## プライバシー

- **`01-private/` 配下のファイルを開かない**（ディレクトリ存在・README の有無のみ）
- APIキー、`.env`、口座、契約書の中身を読まない
- レポートにメール・電話・口座番号を含めない（「USER.md に email フィールドあり」程度）
- スクリプト出力は JSON。ユーザー共有前に要確認項目を強調

## スクリプト

```bash
.agents/skills/ai-company-setup/scripts/deep-research.sh \
  --repo-root /path/to/repo \
  --home "$HOME" \
  --output /tmp/ai-company-deep-research.json
```

エージェントは JSON を読み、上記フォーマットで要約 → needs confirmation を Interview で埋める。
