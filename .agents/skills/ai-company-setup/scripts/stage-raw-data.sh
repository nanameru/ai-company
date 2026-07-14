#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: stage-raw-data.sh --dest <05-raw-data> --paths <dir1> [--paths <dir2> ...]
       stage-raw-data.sh --dest <05-raw-data> --agicamp-path <AGICAMP12-dir>

Copies source folders into 05-raw-data without modifying originals.
--agicamp-path stages AGI CAMP 12特典 into <dest>/agicamp12/ (fixed subdir name).
EOF
}

DEST=""
PATHS=()
AGICAMP_PATH=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dest) DEST="$2"; shift 2 ;;
    --paths) PATHS+=("$2"); shift 2 ;;
    --agicamp-path) AGICAMP_PATH="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 1 ;;
  esac
done

[[ -n "$DEST" ]] || { echo "--dest is required" >&2; exit 1; }
if [[ -n "$AGICAMP_PATH" ]]; then
  PATHS+=("$AGICAMP_PATH")
fi
[[ ${#PATHS[@]} -gt 0 ]] || { echo "At least one --paths or --agicamp-path is required" >&2; exit 1; }

mkdir -p "$DEST"

for src in "${PATHS[@]}"; do
  [[ -d "$src" ]] || { echo "Skip missing path: $src" >&2; continue; }
  if [[ -n "$AGICAMP_PATH" && "$src" == "$AGICAMP_PATH" ]]; then
    base="agicamp12"
  else
    base="$(basename "$src")"
  fi
  target="$DEST/$base"
  rsync -a --exclude 'node_modules' --exclude '.git' --exclude '.DS_Store' "$src/" "$target/"
  echo "staged: $src -> $target"
done

echo "done: $DEST"
