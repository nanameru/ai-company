#!/usr/bin/env bash
set -euo pipefail

COMPANY_ROOT=""
INSTALL_DIR="${HOME}/.local/share/claw-empire"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAW_EMPIRE_REV="${CLAW_EMPIRE_REV:-66a24ea7df2435ef897c48c147deb7ec572c01c2}"
DEFAULT_PROVIDER="codex"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --company-root) COMPANY_ROOT="$2"; shift 2 ;;
    --install-dir) INSTALL_DIR="$2"; shift 2 ;;
    --provider) DEFAULT_PROVIDER="$2"; shift 2 ;;
    -h|--help)
      echo "Usage: install-claw-empire.sh --company-root /path/to/ai-company [--install-dir /path]"
      exit 0
      ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

[[ -n "$COMPANY_ROOT" ]] || { echo "--company-root is required" >&2; exit 1; }
[[ "$DEFAULT_PROVIDER" == "codex" || "$DEFAULT_PROVIDER" == "claude" ]] || {
  echo "--provider must be codex or claude" >&2
  exit 1
}
COMPANY_ROOT="$(cd "$COMPANY_ROOT" && pwd)"
[[ -f "$COMPANY_ROOT/03-AI_departments/company-routing.json" ]] || {
  echo "company-routing.json was not found" >&2
  exit 1
}

command -v git >/dev/null || { echo "git is required" >&2; exit 1; }
command -v node >/dev/null || { echo "Node.js 22+ is required" >&2; exit 1; }
node -e 'const major=Number(process.versions.node.split(".")[0]); if (major < 22) process.exit(1)' || {
  echo "Node.js 22+ is required" >&2
  exit 1
}

mkdir -p "$(dirname "$INSTALL_DIR")"
if [[ ! -d "$INSTALL_DIR/.git" ]]; then
  git init "$INSTALL_DIR"
  git -C "$INSTALL_DIR" remote add origin https://github.com/GreenSheep01201/claw-empire.git
  git -C "$INSTALL_DIR" fetch --depth 1 origin "$CLAW_EMPIRE_REV"
  git -C "$INSTALL_DIR" checkout --detach FETCH_HEAD
else
  echo "Claw-Empire already exists: $INSTALL_DIR"
fi

(
  cd "$INSTALL_DIR"
  if command -v pnpm >/dev/null; then
    pnpm install --frozen-lockfile
    pnpm build
  else
    corepack pnpm install --frozen-lockfile
    corepack pnpm build
  fi
)

CONFIG_DIR="$COMPANY_ROOT/.ai-company-local"
CONFIG_PATH="$CONFIG_DIR/claw-empire.json"
mkdir -p "$CONFIG_DIR"
if [[ ! -f "$CONFIG_PATH" ]]; then
  node "$SCRIPT_DIR/sync-claw-empire.mjs" init \
    --config "$CONFIG_PATH" \
    --company-root "$COMPANY_ROOT" \
    --provider "$DEFAULT_PROVIDER"
fi

echo "Setup complete"
echo "Office: cd \"$INSTALL_DIR\" && HOST=127.0.0.1 PORT=8790 pnpm start"
echo "Sync: node \"$SCRIPT_DIR/sync-claw-empire.mjs\" watch --config \"$CONFIG_PATH\""
