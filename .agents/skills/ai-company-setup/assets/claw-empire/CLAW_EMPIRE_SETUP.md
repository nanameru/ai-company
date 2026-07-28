# Claw-EmpireでAI COMPANYを可視化する

AI COMPANYの組織を、無料OSSのClaw-Empireへ同期します。

## 対応関係

- `company-routing.json` の事業部 → GUIの部署
- 事業部配下の機能部門 → ピクセルキャラクター
- 部門の `purpose` → キャラクターの説明

新しい部門を `company-routing.json` に追加すると、`watch` 実行中のGUIへ自動追加されます。正本から外れたキャラクターは自動削除せず `offline` にします。

## 1コマンドセットアップ

AI COMPANYのルートで実行します。

```bash
bash 00-setup/claw-empire/install-claw-empire.sh --company-root "$PWD"
```

Claude Codeを既定にする場合:

```bash
bash 00-setup/claw-empire/install-claw-empire.sh \
  --company-root "$PWD" \
  --provider claude
```

このスクリプトは公式Claw-Empire v2.0.4の検証済みrevisionをユーザー領域へcloneし、依存関係とローカル同期設定を準備します。既存の `AGENTS.md` は変更しません。

## 起動

ターミナル1:

```bash
cd "$HOME/.local/share/claw-empire"
HOST=127.0.0.1 PORT=8790 pnpm start
```

ターミナル2:

```bash
node 00-setup/claw-empire/sync-claw-empire.mjs watch \
  --config .ai-company-local/claw-empire.json
```

ブラウザで `http://127.0.0.1:8790` を開きます。同期時に日本語表示へ自動設定されます。

## 安全境界

- 接続先はloopback HTTPだけ
- private、請求、secret、案件本文は同期しない
- 個人の絶対パスは `.ai-company-local/` だけに保存
- 自動削除、公開、merge、deploy、送信は行わない
- Claw-Empire本体はApache-2.0
