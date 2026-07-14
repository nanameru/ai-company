#!/usr/bin/env bash
# PC Deep Research — read-only metadata scan for ai-company grill setup
# 秘密・ファイル中身は読まない。存在とメタデータのみ。
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: deep-research.sh --repo-root PATH [--home HOME] [--output FILE]

Scans allowed paths and writes JSON report (no secrets, no file contents).
EOF
}

REPO_ROOT=""
HOME_DIR="${HOME:-}"
OUTPUT=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --repo-root) REPO_ROOT="$2"; shift 2 ;;
    --home) HOME_DIR="$2"; shift 2 ;;
    --output) OUTPUT="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 1 ;;
  esac
done

[[ -n "$REPO_ROOT" ]] || { echo "Missing --repo-root" >&2; exit 1; }
REPO_ROOT="$(cd "$REPO_ROOT" && pwd)"
[[ -n "$HOME_DIR" ]] || HOME_DIR="$HOME"

# パス存在チェック（中身は読まない）
check_path() {
  local label="$1"
  local path="$2"
  local expanded
  expanded="$(eval echo "$path")"
  if [[ -e "$expanded" ]]; then
    local kind="file"
    [[ -d "$expanded" ]] && kind="directory"
    local count="0"
    if [[ -d "$expanded" ]]; then
      count="$(find "$expanded" -maxdepth 2 -type f 2>/dev/null | wc -l | tr -d ' ')"
    fi
    local modified=""
    if stat -f "%Sm" -t "%Y-%m-%d" "$expanded" >/dev/null 2>&1; then
      modified="$(stat -f "%Sm" -t "%Y-%m-%d" "$expanded")"
    elif stat -c "%y" "$expanded" >/dev/null 2>&1; then
      modified="$(stat -c "%y" "$expanded" | cut -d' ' -f1)"
    fi
    printf '{"label":"%s","path":"%s","status":"detected","kind":"%s","file_count_shallow":%s,"modified":"%s"}' \
      "$label" "$expanded" "$kind" "$count" "$modified"
  else
    printf '{"label":"%s","path":"%s","status":"not_found"}' "$label" "$expanded"
  fi
}

# 01-private は存在のみ（中身スキャン禁止）
check_private() {
  local label="$1"
  local path="$2"
  local expanded
  expanded="$(eval echo "$2")"
  if [[ -d "$expanded" ]]; then
    printf '{"label":"%s","path":"%s","status":"detected","note":"contents_not_scanned"}' "$label" "$expanded"
  else
    printf '{"label":"%s","path":"%s","status":"not_found"}' "$label" "$expanded"
  fi
}

# マーカーファイルの有無のみ
check_markers() {
  local base="$1"
  local expanded
  expanded="$(eval echo "$base")"
  local markers=""
  for f in MEMORY.md USER.md SOUL.md AGENTS.md; do
    [[ -f "$expanded/$f" ]] && markers="${markers}${f},"
  done
  markers="${markers%,}"
  if [[ -d "$expanded" ]]; then
    printf '{"label":"ai-company-markers","path":"%s","status":"detected","markers":"%s"}' "$expanded" "$markers"
  else
    printf '{"label":"ai-company-markers","path":"%s","status":"not_found"}' "$expanded"
  fi
}

entries=()
entries+=("$(check_path "repo-root" "$REPO_ROOT")")
entries+=("$(check_path "ai-company-in-repo" "$REPO_ROOT/ai-company")")
entries+=("$(check_markers "$REPO_ROOT/ai-company")")
entries+=("$(check_path "ai-company-home" "$HOME_DIR/ai-company")")
entries+=("$(check_private "01-private-repo" "$REPO_ROOT/ai-company/01-private")")
entries+=("$(check_private "01-private-home" "$HOME_DIR/ai-company/01-private")")
entries+=("$(check_path "05-raw-data" "$REPO_ROOT/ai-company/05-raw-data")")
entries+=("$(check_path "brain-ichiaisyain" "$REPO_ROOT/.codex/brain-ichiaisyain")")
entries+=("$(check_path "invoices" "$REPO_ROOT/invoices")")
entries+=("$(check_path "agicamp12-downloads" "$HOME_DIR/Downloads/AGICAMP12")")
entries+=("$(check_path "ai-company-setup-skill" "$REPO_ROOT/.agents/skills/ai-company-setup")")
entries+=("$(check_path "setup-config-example" "$REPO_ROOT/.agents/skills/ai-company-setup/references/setup-config.example.json")")

# Downloads 内の候補フォルダ（浅い一覧、中身は読まない）
downloads_candidates="[]"
if [[ -d "$HOME_DIR/Downloads" ]]; then
  downloads_candidates="$(find "$HOME_DIR/Downloads" -maxdepth 1 -type d 2>/dev/null \
    | grep -iE 'agicamp|notion|chatgpt|export|brain' \
    | head -10 \
    | python3 -c 'import json,sys; print(json.dumps([l.strip() for l in sys.stdin if l.strip()]))' 2>/dev/null || echo '[]')"
fi

items=""
for e in "${entries[@]}"; do
  [[ -n "$items" ]] && items+=","
  items+="$e"
done

report=$(cat <<EOF
{
  "scan_version": "1",
  "repo_root": "$REPO_ROOT",
  "home": "$HOME_DIR",
  "scanned_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "privacy": "no_secrets_no_private_contents",
  "entries": [$items],
  "downloads_candidates": $downloads_candidates,
  "suggested_needs_confirmation": [
    "destinationRoot: use ai-company-in-repo or ai-company-home?",
    "ownerName/ownerEmail: confirm from USER.md if detected",
    "sourcePaths: confirm brain-ichiaisyain, invoices, agicamp12",
    "01-private: do not read without explicit permission"
  ]
}
EOF
)

if [[ -n "$OUTPUT" ]]; then
  printf '%s\n' "$report" > "$OUTPUT"
  echo "Wrote: $OUTPUT"
else
  printf '%s\n' "$report"
fi
