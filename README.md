# ai-company + Skills スリムバンドル

`taiyo-gyomu` から **AI 会社ワークスペース本体** と **セットアップ Skill** だけを切り出した軽量パッケージです。Brain 生データ・動画・文字起こしアーカイブは含みません。

**作成日**: 2026-07-14  
**元リポジトリ**: `taiyo-gyomu`  
**フル版との違い**: `exports/ai-company-google-drive-bundle/` は参照データ（Brain 記事・動画・YouTube 文字起こし）込みの約 240MB 版です。本バンドルは **テキスト＋Skill のみ（約 1MB）** です。

---

## このパッケージに入っているもの

| フォルダ | 内容 |
|---------|------|
| `ai-company/` | OpenClaw 型 AI 会社ワークスペース本体（ルール・部署・セットアッププロンプト・既存ナレッジ） |
| `skills/ai-company-setup/` | 対話式セットアップ Skill（Interview / Deep Research / テンプレ展開） |
| `ai-company/00-setup/claw-empire/` | 部署とキャラクターをピクセルオフィスへ同期する可視化 |

---

## フォルダマップ

```text
ai-company-only-bundle/
├── README.md                          ← このファイル
├── ai-company/
│   ├── AGENTS.md, SOUL.md, USER.md, MEMORY.md
│   ├── 00-rules/                      共通ルール
│   ├── 00-setup/                      セットアップ・7部署プロンプト
│   │   ├── GRILL_SETUP_PROMPT.md      ← 初回対話セットアップ
│   │   ├── FIRST_EMPLOYEE_PROMPT.md   ← 最初の AI 社員起動
│   │   └── construction-prompt.md     ← 構築プロンプト（Brain 由来・既に同梱）
│   ├── 02-company_knowledge/          公開ナレッジ（openclaw-seminar 要約等）
│   ├── 03-AI_departments/             AI 部署（content-brain 等）
│   ├── 05-raw-data/README.md          ※ 本体は含まず（ポインタのみ）
│   └── 01-private/README.md           ※ 秘密情報フォルダ（中身なし）
└── skills/
    └── ai-company-setup/              @ai-company-setup スキル一式
```

---

## 使い方

### 1. 別 PC / バックアップ先へ配置

```bash
# 例: 新しいマシンで taiyo-gyomu 相当の場所に展開
mkdir -p ~/taiyo-gyomu
cp -R ai-company-only-bundle/ai-company ~/taiyo-gyomu/
mkdir -p ~/taiyo-gyomu/.agents/skills
cp -R ai-company-only-bundle/skills/ai-company-setup ~/taiyo-gyomu/.agents/skills/
```

Cursor / Claude Code では `~/.agents/skills/` またはプロジェクト内 `.agents/skills/` のどちらかに置けば `@ai-company-setup` が使えます。

### 2. 初回セットアップの流れ

1. **（任意・初回）** `ai-company/00-setup/GRILL_SETUP_PROMPT.md` を貼り、`@ai-company-setup` で対話セットアップ
2. `ai-company/00-setup/FIRST_EMPLOYEE_PROMPT.md` で最初の AI 社員（content-brain）を起動
3. `00-setup/BUILD_PROMPT.md` で本格構築（ナレッジ移行）

### 3. バンドル再生成（元リポジトリ側）

```bash
./exports/build-ai-company-only-bundle.sh
```

---

## 含まれていないもの（理由付き）

| 除外対象 | 理由 | 取得方法 |
|---------|------|---------|
| `05-raw-data/` 本体（agicamp12 Zip、Brain 動画等） | サイズ大（約 241MB）・gitignore 対象 | `skills/ai-company-setup/scripts/stage-raw-data.sh` で再ステージ |
| `.codex/brain-ichiaisyain/` | 有料 Brain コンテンツ・個人利用 | 購入者ページから手動取得 |
| `reference/youtube-transcripts/` | セミナー全文文字起こし（大容量） | `youtube-transcript-fetch` スキルで再取得（フル版バンドル参照） |
| Brain 動画（webm/mkv/mp4） | サイズ大・配布対象外 | YouTube / Brain から個別 DL |
| `01-private/` の中身 | 秘密情報・個人情報 | 各マシンで個別管理 |
| `.obsidian/` | エディタキャッシュ | 不要 |
| `skills/youtube-transcript-fetch/` | ai-company-setup の直接依存ではない | フル版バンドルまたは `.agents/skills/` から別途コピー |
| API キー・`.env` | セキュリティ | 各マシンで個別設定 |

**フル版が必要な場合**: `./exports/build-ai-company-bundle.sh` で `ai-company-google-drive-bundle/`（参照データ・動画込み）を生成してください。

---

## 次のステップ

| 手順 | ファイル |
|------|---------|
| 対話セットアップ（Grill） | `ai-company/00-setup/GRILL_SETUP_PROMPT.md` |
| 最初の AI 社員起動 | `ai-company/00-setup/FIRST_EMPLOYEE_PROMPT.md` |
| 本格構築 | `ai-company/00-setup/BUILD_PROMPT.md` |
| 7 部署キックオフ | `ai-company/00-setup/SEVEN_DEPT_KICKOFF.md` |
| 部署GUIのセットアップ | `ai-company/00-setup/claw-empire/CLAW_EMPIRE_SETUP.md` |

## Claw-Empireによる部署可視化

`ai-company/` へ移動して実行します。

```bash
bash 00-setup/claw-empire/install-claw-empire.sh \
  --company-root "$PWD" \
  --provider codex
```

Claude Codeを使う場合は `--provider claude` に変更します。初期状態は1つの `AI COMPANY` ルームに、`CEO・PM` / `制作・開発` / `品質確認` の3人だけを表示します。

Product / Growth / Shared Servicesへ分けたい場合だけ、`ai-company/00-setup/claw-empire/company-routing.three-divisions.example.json` を参考にします。高度な専門部署は共有版へ含めません。

---

## サイズ目安

| 区分 | サイズ |
|------|--------|
| ai-company（05-raw-data 除く） | 約 500 KB |
| ai-company-setup スキル | 約 64 KB |
| **バンドル全体** | **約 1 MB** |
| Zip 版（`exports/ai-company-only-bundle.zip`） | 約 300 KB（圧縮後） |

Zip は git 非追跡（任意）。スクリプト再実行でローカルに再生成できます。
