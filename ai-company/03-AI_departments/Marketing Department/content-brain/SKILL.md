# content-brain スキル

## いつ使うか

ユーザーが次のような依頼をした時に使う。

- 「発信の種を作って」
- 「X投稿案を作って」
- 「メルマガの種を整理して」
- 「記事の導入文を書いて」
- 「今日の学びを発信に変換して」

## 入力

人間からの依頼が曖昧な場合は、`00-setup/request-templates/UNIVERSAL_CLARIFY.md` で5項目（目的/入力/禁止/出力/完了条件）に整理してから着手する。依頼文の型は `00-setup/request-templates/` を参照（初回は `MASTER_FIRST_REQUEST.md`、長文は `02-longform-content.md`）。

- 目的: （例: X投稿3本、メルマガ種1件）
- 対象読者: 個人事業主、AI導入検討者
- 使ってよい素材:
  - `USER.md`, `SOUL.md`
  - `02-company_knowledge/service.md`, `offer.md`, `customer-faq.md`
  - `knowledge/` 配下
  - `05-raw-data/`（参照のみ、原本は変更しない）
  - ユーザーが指定したメモ・URL
- 触ってはいけないファイル:
  - `01-private/`
  - 他AI社員の `_RULE.md` / `SKILL.md`（改善提案はログに残す）
- 出力形式: Markdown（投稿案、種、導入文）
- 保存先: `output/archive/YYYY-MM-DD_slug/`

## 手順

1. 必読ファイルを読む（`_RULE.md` の「最初に読むもの」）
2. 目的を1文に要約する
3. 入力素材を一覧化する（source-map下書き）
4. 作業範囲を確定する（何を作るか、何を作らないか）
5. 成果物を作る
6. `00-rules/qa-checklist.md` でQAする
7. source-mapを書く
8. 完了報告する

## 出力

各アーカイブフォルダに最低限次を含める。

- `output.md` — 成果物本体
- `source-map.md` — 参照したファイル・判断根拠
- `qa.md` — QAチェック結果
- `improvement-notes.md` — 次回の改善メモ（任意）

## QA

- [ ] 指定された素材だけを使った
- [ ] 保存先が `output/archive/YYYY-MM-DD_slug/` である
- [ ] 未確認URLを断定していない
- [ ] 外部公開していない
- [ ] `writing-style.md` のNG表現を避けた
- [ ] 次回に使える改善メモを残した

## source-map

```markdown
## 参照したファイル
- path/to/file — 何に使ったか

## 判断したこと
- 

## 未確認・要人間確認
- 
```

## 完了報告

- 作成したファイルと保存先
- 各ファイルの役割
- QA結果
- 人間が確認すべきこと
- 次に入れると良いナレッジ
