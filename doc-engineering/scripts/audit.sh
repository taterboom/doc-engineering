#!/usr/bin/env bash
# Document Engineering — periodic doc drift audit
# Usage: bash scripts/audit.sh [--doc-root Product/Functions]
#
# For each function folder, compares:
#   - latest git commit timestamp touching any file whose path contains the function name (code proxy)
#   - latest git commit timestamp touching any file inside Product/Functions/<FunctionName>/ (doc proxy)
# Reports functions where docs lag behind code.

DOC_ROOT="${1:-Product/Functions}"

if [ ! -d "$DOC_ROOT" ]; then
  echo "❌ Doc root not found: $DOC_ROOT"
  echo "   Run from repo root or pass the correct path."
  exit 1
fi

echo ""
echo "📋 Document Engineering — Drift Audit"
echo "   Doc root: $DOC_ROOT"
echo "   $(date)"
echo ""

DRIFT_FOUND=0

# Collect results into array for sorting
declare -a RESULTS

for func_dir in "$DOC_ROOT"/*/; do
  func_name=$(basename "$func_dir")

  # Skip _deprecated
  if [[ "$func_name" == _* ]]; then
    continue
  fi

  # Latest commit touching docs for this function
  doc_ts=$(git log --diff-filter=M --format="%ct" -- "$func_dir" 2>/dev/null | head -1)

  # Latest commit touching any file whose path contains the function name (heuristic for code)
  # Excludes the doc root itself
  code_ts=$(git log --format="%ct" -- "*${func_name}*" 2>/dev/null \
    | grep -v "" \
    | head -50 \
    | while read ts; do echo "$ts"; done \
    | head -1)

  # Fallback: search for any file with the function name (case-insensitive) excluding docs
  if [ -z "$code_ts" ]; then
    code_ts=$(git log --format="%ct" -- "$(echo "$func_name" | tr '[:upper:]' '[:lower:]')*" 2>/dev/null | head -1)
  fi

  if [ -z "$doc_ts" ] && [ -z "$code_ts" ]; then
    continue
  fi

  # Convert to human-readable
  if [ -n "$doc_ts" ]; then
    doc_date=$(date -d "@$doc_ts" '+%Y-%m-%d %H:%M' 2>/dev/null || date -r "$doc_ts" '+%Y-%m-%d %H:%M' 2>/dev/null || echo "unknown")
  else
    doc_date="never"
    doc_ts=0
  fi

  if [ -n "$code_ts" ]; then
    code_date=$(date -d "@$code_ts" '+%Y-%m-%d %H:%M' 2>/dev/null || date -r "$code_ts" '+%Y-%m-%d %H:%M' 2>/dev/null || echo "unknown")
  else
    code_date="unknown"
    code_ts=0
  fi

  # Lag in seconds
  lag=$(( code_ts - doc_ts ))

  if [ "$lag" -gt 0 ]; then
    lag_days=$(( lag / 86400 ))
    lag_hours=$(( (lag % 86400) / 3600 ))
    RESULTS+=("$lag|$func_name|$code_date|$doc_date|${lag_days}d ${lag_hours}h")
    DRIFT_FOUND=1
  fi
done

if [ "$DRIFT_FOUND" -eq 0 ]; then
  echo "✅ All docs appear in sync with code."
  echo ""
  exit 0
fi

# Sort by lag descending (largest first)
IFS=$'\n' SORTED=($(printf '%s\n' "${RESULTS[@]}" | sort -t'|' -k1 -rn))
unset IFS

echo "⚠️  Functions with stale docs (code newer than docs):"
echo ""
printf "  %-30s %-20s %-20s %s\n" "Function" "Code last changed" "Docs last updated" "Lag"
printf "  %-30s %-20s %-20s %s\n" "--------" "-----------------" "-----------------" "---"

for entry in "${SORTED[@]}"; do
  IFS='|' read -r lag func_name code_date doc_date lag_label <<< "$entry"
  printf "  %-30s %-20s %-20s %s\n" "$func_name" "$code_date" "$doc_date" "$lag_label"
done

echo ""
echo "Run Claude and ask it to update the docs for the lagging functions above."
echo ""
