# FIRST_EMPLOYEE_PROMPT

以下をそのまま Claude Code に貼ってください。

設計正本: `00-setup/ai-employee-template-v2.md` セクション16

---

```text
これから、私のワークスペースに最初のAI社員を1体作ります。

重要な前提:
AI社員とは、人格設定をしたチャットbotではありません。
ナレッジを読み、ルールに従い、スキルで同じ作業を再現し、成果物を残す実行担当です。

作りたいAI社員:
content-brain（発信脳）

役割:
- Daily Noteを読む
- 私の学び、事業メモ、顧客の声を整理する
- X投稿案を作る
- メルマガの種を作る
- Brain記事の導入文を作る
- セミナーやLPに使える訴求を抽出する
- 次回同じ失敗をしないように改善メモを残す

まず確認してほしいこと:
1. ワークスペース直下に AGENTS.md / MEMORY.md / USER.md / SOUL.md があるか
2. 00-rules / 01-private / 02-company_knowledge / 03-AI_departments / 06-todo があるか
3. 既存の文章、商品情報、過去投稿、顧客FAQの置き場があるか
4. 個人情報や外部公開NG情報がどこにあるか
5. 最初に読むべき正本がどれか

なければ作ってほしいもの:
- 03-AI_departments/Marketing Department/content-brain/_RULE.md
- 03-AI_departments/Marketing Department/content-brain/SKILL.md
- 03-AI_departments/Marketing Department/content-brain/knowledge/README.md
- 03-AI_departments/Marketing Department/content-brain/output/archive/.gitkeep

_RULE.mdに入れてほしいこと:
- 役割
- やること
- やらないこと
- 最初に読むもの
- 出力先
- 品質基準
- 外部送信や公開の禁止

SKILL.mdに入れてほしいこと:
- 起動条件
- 入力
- 手順
- 出力
- QA
- source-map
- 完了報告

注意:
- 既存ファイルを勝手に削除しないでください。
- 外部送信や公開はしないでください。
- 変更前に、どのファイルを作る/編集するか説明してください。
- 作った後は、どこを見ればよいかパスで教えてください。

完了報告:
- 作成/編集したファイル
- 各ファイルの役割
- 次に私が入れるべきナレッジ
- 最初に試す依頼文
- 残っているリスク
```

## 最初に試す依頼文（例）

```text
content-brainとして、USER.md と service.md を読んだうえで、
「AI社員ワークスペース構築」テーマのX投稿案を3本作ってください。
保存先: output/archive/今日の日付_x-post-ai-employee/
```
