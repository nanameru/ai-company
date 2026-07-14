# OSS自動化 — AI社員依頼文（コピペ用）

`04-resources/oss-local-ai-automation-starter.xlsx` の **50 OSS Catalog** を開いたうえで、以下をAI社員に貼る。

`{業務名}` を実際の業務名に置き換える。

```text
このExcelの50 OSS Catalogを見て、私の業務「{業務名}」を自動化する候補を3つ選んでください。

条件:
- いきなり本番導入しない
- 個人情報や顧客情報を外に出さない
- まず1週間の検証だけにする
- 導入難易度が低い順に提案する
- 何を入力し、何を出力するかを明確にする

出力:
1. おすすめ候補3つ
2. 選定理由
3. 最初の検証タスク
4. 失敗しそうな点
5. 人間が確認すべきこと
```

## 関連

- スターター概要: `00-setup/oss-automation-starter-v2.md`
- Excel原本: `05-raw-data/agicamp12/10_oss50/oss50.xlsx`
- Excel内の追加依頼文: シート「AI社員依頼文」
