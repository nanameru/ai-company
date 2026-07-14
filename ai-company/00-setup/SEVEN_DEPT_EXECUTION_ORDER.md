# AI部署 実行順テンプレ（Step 1–7）

7人を同時起動しない。前の担当の出力を次の担当が読む形で順番に回す。

## 使い方

1. `SEVEN_DEPT_KICKOFF.md` で案件を起票する
2. 下記 Step 1 から順に、該当担当の `00-setup/prompts/{role}.md` を貼る
3. 各 Step 完了後、`SEVEN_DEPT_HANDOFF_TEMPLATE.md` で引き継ぎメモを残す
4. **最初は Step 1 → Step 3 → Step 5 のみ**（CEO/PM → 制作/開発 → QA）

## 実行順プロンプト（貼り付け用）

```text
AI部署で進めますが、同時に全員を動かさないでください。
次の順番で、前の担当の出力を次の担当が読む形にしてください。

Step 1: CEO/PM
目的、対象者、完了条件、リスクを整理してください。

Step 2: ナレッジ設計
CEO/PMの整理を読んで、読む正本、読まない情報、未確定、source-mapを作ってください。

Step 3: 制作/開発
ナレッジ設計のsource-mapを読んで、成果物を作ってください。

Step 4: レビュー
成果物が目的、文体、ユーザー指示、禁止事項からズレていないか確認してください。

Step 5: QA
リンク、HTML、Excel、ZIP、画像、公開URLなど、目で確認できる項目を確認してください。

Step 6: 運用
保存先、更新日、期限、次回更新方法、削除/更新してはいけないものを整理してください。

Step 7: CS/案内
受け取る人に渡す短い文面、FAQ、迷いやすいポイントを作ってください。

最後に、7人分のログを1つに統合してください。
```

## 最小構成（最初の3人）

| Step | 担当 | フォルダ |
|---|---|---|
| 1 | CEO/PM | `03-AI_departments/ceo-pm/` |
| 3 | 制作/開発 | `03-AI_departments/production-dev/` |
| 5 | QA | `03-AI_departments/qa/` |

## 後から有効化する4人

| Step | 担当 | フォルダ |
|---|---|---|
| 2 | ナレッジ設計 | `03-AI_departments/knowledge-design/` |
| 4 | レビュー | `03-AI_departments/review/` |
| 6 | 運用 | `03-AI_departments/operations/` |
| 7 | CS/案内 | `03-AI_departments/cs-guide/` |

## 全体指示（毎回末尾に付ける）

```text
必ず守ること:
- 目的を先に確認
- 読む情報を限定
- 触るファイルを限定
- 外部送信/公開/削除はしない
- 作業ログを残す
- QA結果を残す
- 人間判断が必要な点を最後に分ける
```
