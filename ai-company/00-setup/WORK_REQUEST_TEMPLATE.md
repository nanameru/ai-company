# WORK_REQUEST_TEMPLATE

作業依頼・修正依頼のコピペ用テンプレ索引。

- **正本（全文）**: `00-setup/non-engineer-request-kit-v2.md` — AGI CAMP 非エンジニアAI社員依頼文キット v2
- **シナリオ別コピペ**: `00-setup/request-templates/` — 用途別に `{ }` を埋めて貼る
- **設計根拠**: `00-setup/ai-employee-template-v2.md` セクション6-7

非エンジニアが AI 社員へ渡すときは、必ず **目的 / 入力 / 禁止 / 出力 / 完了条件** の5項目を含める（`00-rules/request-handoff.md` 参照）。

---

## 迷ったらここから

| 状況 | ファイル |
|---|---|
| 初めて依頼する | [`request-templates/MASTER_FIRST_REQUEST.md`](request-templates/MASTER_FIRST_REQUEST.md) |
| 依頼が曖昧 | [`request-templates/UNIVERSAL_CLARIFY.md`](request-templates/UNIVERSAL_CLARIFY.md) |
| 出力が短すぎる | [`request-templates/FEEDBACK_TOO_SHORT.md`](request-templates/FEEDBACK_TOO_SHORT.md) |
| 最小の基本形 | [`request-templates/00-basic-form.md`](request-templates/00-basic-form.md) |

---

## シナリオ別テンプレ

| # | ファイル | 使う場面 |
|---|---|---|
| 00 | [`00-basic-form.md`](request-templates/00-basic-form.md) | まず覚える基本形 |
| 01 | [`01-outline-first.md`](request-templates/01-outline-first.md) | 構成案だけ先に |
| 02 | [`02-longform-content.md`](request-templates/02-longform-content.md) | 長文本文（note/Brain/LP） |
| 03 | [`03-slides.md`](request-templates/03-slides.md) | スライド |
| 04 | [`04-excel.md`](request-templates/04-excel.md) | Excel |
| 05 | [`05-html-review-page.md`](request-templates/05-html-review-page.md) | HTML確認ページ |
| 06 | [`06-research.md`](request-templates/06-research.md) | リサーチ |
| 07 | [`07-revision.md`](request-templates/07-revision.md) | 修正依頼 |
| 08 | [`08-qa.md`](request-templates/08-qa.md) | QA |
| 09 | [`09-line-reply.md`](request-templates/09-line-reply.md) | LINE返信文 |
| 10 | [`10-work-log.md`](request-templates/10-work-log.md) | 作業ログ |

---

## 作業依頼テンプレ（エンジニア向け・ファイル編集）

`ai-employee-template-v2.md` セクション6 と同一。ファイルパスを明示する作業向け。

```text
今回の作業は「{作業名}」です。

目的:
{なぜやるか}

読んでよい情報:
- {ファイル/URL}

読まなくてよい情報:
- {今回は不要なフォルダ}

触ってよい場所:
- {編集対象}

触ってはいけない場所:
- {禁止対象}

出力:
- {形式}
- {保存先}

完了条件:
- {確認1}
- {確認2}
- {確認3}

最後に報告してほしいこと:
- 変更したファイル
- 確認したこと
- 未確認のこと
- 次に人間が判断すべきこと
```

---

## 修正依頼テンプレ

詳細版: [`request-templates/07-revision.md`](request-templates/07-revision.md)

```text
修正対象:
{ファイル名、ページ、セクション}

今の問題:
{短すぎる、具体性がない、見づらい、リンクが違う、など}

期待する状態:
{どうなっていればOKか}

触ってよい範囲:
{修正してよいファイル/フォルダ}

触ってはいけない範囲:
{変えないファイル/公開済み導線など}

確認方法:
{HTMLで開く、Excelで開く、リンクをcurlで確認、など}

修正後に報告:
- 何を変えたか
- 何を変えていないか
- どこで確認できるか
```

---

## content-brain 向け記入例

依頼文の型: [`request-templates/02-longform-content.md`](request-templates/02-longform-content.md) または [`MASTER_FIRST_REQUEST.md`](request-templates/MASTER_FIRST_REQUEST.md)

```text
今回の作業は「AI社員テーマのX投稿案3本」です。

目的:
ワークスペース構築の学びを発信に変換し、反応を取る

読んでよい情報:
- USER.md
- SOUL.md
- 02-company_knowledge/service.md
- 03-AI_departments/Marketing Department/content-brain/knowledge/

読まなくてよい情報:
- 05-raw-data/invoices/
- 01-private/

触ってよい場所:
- 03-AI_departments/Marketing Department/content-brain/output/archive/

触ってはいけない場所:
- 02-company_knowledge/offer.md（今回は参照のみ）

出力:
- Markdown（投稿案3本 + source-map）
- output/archive/2026-07-13_x-post-ai-employee/

完了条件:
- 各投稿にフック・要点・CTAがある
- NG表現を避けている
- source-mapがある

最後に報告してほしいこと:
- 保存先パス
- 人間が確認すべき表現
```

---

## 生データ

AGICAMP12 原本: `05-raw-data/agicamp12/11_request_kit/request_kit.md`
