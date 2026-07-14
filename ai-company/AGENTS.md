# AGENTS.md

このワークスペースでは、AIは作業前に必ず次を確認する。

1. `SOUL.md` - どういう姿勢で働くか
2. `USER.md` - 誰を助けているか
3. `MEMORY.md` - 長期的に守る方針
4. 今日と昨日の `memory/YYYY-MM-DD.md` - 直近の文脈（あれば）
5. `00-rules/` - 文体・QA・外部操作・依頼文の共通ルール
6. 作業対象の部署 `_RULE.md`
7. 作業対象の `SKILL.md`

## 基本原則

- 勝手に外部送信しない
- 勝手に公開しない
- 勝手に削除しない
- 作業ログを残す
- 成果物は確認しやすい形式にする
- 迷ったら、目的、入力、禁止、出力、完了条件に分解する（`00-rules/request-handoff.md`）

## 稼働中のAI社員

| 部署 | AI社員 | 状態 |
|---|---|---|
| Marketing Department | content-brain（発信脳） | 初期構築済み・テスト待ち |
| Marketing Department | content-writer | レガシー・段階的に統合 |

## AI部署7人の使い方

AGI CAMP「AI部署7人 簡易構築プロンプト v2」に基づく。**7人を同時起動しない。** 必要な担当だけ順番に回す。

### 最初は3人だけ

| Step | 担当 | フォルダ |
|---|---|---|
| 1 | CEO/PM | `03-AI_departments/ceo-pm/` |
| 3 | 制作/開発 | `03-AI_departments/production-dev/` |
| 5 | QA | `03-AI_departments/qa/` |

残り4人（ナレッジ設計、レビュー、運用、CS/案内）はフォルダのみ用意済み。**後から有効化**する。

### 実行手順

1. `00-setup/SEVEN_DEPT_KICKOFF.md` で案件を起票する
2. `00-setup/SEVEN_DEPT_EXECUTION_ORDER.md` の Step 順に進める
3. 各 Step で `00-setup/prompts/{role}.md` を貼る
4. 引き継ぎは `00-setup/SEVEN_DEPT_HANDOFF_TEMPLATE.md` 形式で `output/archive/` に残す

### 必ず守ること

- 目的を先に確認する（CEO/PM が最初）
- 読む情報・触るファイルを限定する
- **外部送信・公開・削除はしない**
- 作業ログと QA 結果を残す
- 人間判断が必要な点を最後に分ける

正本: `00-setup/seven-dept-prompt-v2.md` / 一覧: `03-AI_departments/README.md`

## 完了条件

作業完了時は必ず次を報告する。

- 何を作ったか
- どこに保存したか
- 何を確認したか
- まだ人間が見るべきこと
