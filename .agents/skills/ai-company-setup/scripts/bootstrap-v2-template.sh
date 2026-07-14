#!/usr/bin/env bash
# v2最小構造を既存ワークスペースに追加する（既存ファイルは上書きしない）
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: bootstrap-v2-template.sh --dest /path/to/ai-company

Adds v2 minimal folder structure and placeholder files.
Does not overwrite existing non-empty files.
EOF
}

DEST=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dest) DEST="$2"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 1 ;;
  esac
done

[[ -n "$DEST" ]] || { echo "--dest is required" >&2; exit 1; }
ROOT="$(cd "$DEST" && pwd)"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE_SRC="$(cd "$SCRIPT_DIR/../../../ai-company/05-raw-data/agicamp12/04_ai_template" 2>/dev/null && pwd)/template.md" || true
if [[ -z "${TEMPLATE_SRC:-}" || ! -f "$TEMPLATE_SRC" ]]; then
  TEMPLATE_SRC="$(cd "$SCRIPT_DIR/../../.." && pwd)/ai-company/05-raw-data/agicamp12/04_ai_template/template.md"
fi

write_if_missing() {
  local path="$1"
  local content="$2"
  if [[ ! -f "$path" || ! -s "$path" ]]; then
    mkdir -p "$(dirname "$path")"
    printf '%s' "$content" > "$path"
    echo "created: $path"
  else
    echo "skip (exists): $path"
  fi
}

mkdir -p "$ROOT"/{00-rules,00-setup,01-private,06-todo}
mkdir -p "$ROOT/02-company_knowledge/source-assets"
mkdir -p "$ROOT/03-AI_departments/Marketing Department/content-brain"/{knowledge,output/archive}

# 正本テンプレ
if [[ -f "$TEMPLATE_SRC" ]]; then
  if [[ ! -f "$ROOT/00-setup/ai-employee-template-v2.md" ]]; then
    cp "$TEMPLATE_SRC" "$ROOT/00-setup/ai-employee-template-v2.md"
    echo "created: $ROOT/00-setup/ai-employee-template-v2.md"
  fi
fi

write_if_missing "$ROOT/00-rules/writing-style.md" "# writing-style.md\n\n（v2テンプレから追記）\n"
write_if_missing "$ROOT/00-rules/qa-checklist.md" "# qa-checklist.md\n\n（v2テンプレから追記）\n"
write_if_missing "$ROOT/00-rules/external-action-policy.md" "# external-action-policy.md\n\n（v2テンプレから追記）\n"
write_if_missing "$ROOT/01-private/README.md" "# 01-private\n\n個人情報・契約の置き場。\n"
write_if_missing "$ROOT/02-company_knowledge/service.md" "# service.md\n\n事業正本。\n"
write_if_missing "$ROOT/02-company_knowledge/offer.md" "# offer.md\n\nオファー正本。\n"
write_if_missing "$ROOT/02-company_knowledge/customer-faq.md" "# customer-faq.md\n\nFAQ正本。\n"
write_if_missing "$ROOT/06-todo/inbox.md" "# inbox\n\n"
write_if_missing "$ROOT/03-AI_departments/Marketing Department/content-brain/_RULE.md" "# content-brain\n\n"
write_if_missing "$ROOT/03-AI_departments/Marketing Department/content-brain/SKILL.md" "# content-brain skill\n\n"
write_if_missing "$ROOT/03-AI_departments/Marketing Department/content-brain/knowledge/README.md" "# knowledge\n\n"
touch "$ROOT/02-company_knowledge/source-assets/.gitkeep" 2>/dev/null || true
touch "$ROOT/03-AI_departments/Marketing Department/content-brain/output/archive/.gitkeep" 2>/dev/null || true

echo "bootstrap complete: $ROOT"
