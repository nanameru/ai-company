# GRILL_SETUP_PROMPT

以下を Cursor のチャットに貼って、AIカンパニーの対話セットアップを始めてください。

---

```text
@ai-company-setup スキルで AIカンパニーのセットアップを手伝ってください。

## モード選択（どちらか選んでください）

A) **Interview Mode** — 質問に答えながら設定を決める（1ターン1〜2問）
B) **PC Deep Research Mode** — このPCの許可フォルダを自動調査してから、不足分だけ確認

## 私の前提

- オーナー: 木村 太陽
- リポジトリ: /Users/kimurataiyou/taiyo-gyomu
- 既存ワークスペース候補: ai-company/（あれば使う）

## ゴール

1. setup-config.json を確定
2. init / stage スクリプトを実行（承認後）
3. 完了したら FIRST_EMPLOYEE_PROMPT.md へ案内

01-private/ の中身は、明示許可があるまで読まないでください。
```

## 使い方

1. 上の ```text``` ブロックをコピー
2. Cursor で `@ai-company-setup` をメンションして貼り付け
3. **A** か **B** を返信
4. セットアップ完了後 → `FIRST_EMPLOYEE_PROMPT.md` で content-brain 実務テスト

## 関連

- スキル: `.agents/skills/ai-company-setup/SKILL.md`
- 質問リスト: `.agents/skills/ai-company-setup/references/questions.md`
- Deep Research: `.agents/skills/ai-company-setup/references/deep-research-checklist.md`
- 最初のAI社員: `FIRST_EMPLOYEE_PROMPT.md`
