# AI部署7人

AGI CAMP「AI部署7人 簡易構築プロンプト v2」に基づく実行担当の配置。

## フォルダマップ

| Step | 部署 | フォルダ | 初期状態 |
|---|---|---|---|
| 1 | CEO/PM | `ceo-pm/` | **稼働** |
| 2 | ナレッジ設計 | `knowledge-design/` | 後から有効化 |
| 3 | 制作/開発 | `production-dev/` | **稼働** |
| 4 | レビュー | `review/` | 後から有効化 |
| 5 | QA | `qa/` | **稼働** |
| 6 | 運用 | `operations/` | 後から有効化 |
| 7 | CS/案内 | `cs-guide/` | 後から有効化 |

## 既存部署（Marketing）

| 部署 | フォルダ | 備考 |
|---|---|---|
| content-brain | `Marketing Department/content-brain/` | 発信脳（別系統・段階的統合） |
| content-writer | `Marketing Department/content-writer/` | レガシー |

## 使い方

1. `00-setup/SEVEN_DEPT_KICKOFF.md` で案件起票
2. `00-setup/SEVEN_DEPT_EXECUTION_ORDER.md` の Step 順に実行
3. 各 Step で `00-setup/prompts/{role}.md` を貼る
4. 引き継ぎは `00-setup/SEVEN_DEPT_HANDOFF_TEMPLATE.md` 形式

正本: `00-setup/seven-dept-prompt-v2.md`
