#!/usr/bin/env bash
# Document Engineering — install pre-commit hook
# Run from repo root: bash Product/scripts/install-hook.sh
# Or from wherever the skill copied scripts/pre-commit.sh

HOOK_SRC="$(dirname "$0")/pre-commit.sh"
HOOK_DST=".git/hooks/pre-commit"

if [ ! -d ".git" ]; then
  echo "❌ Not a git repository. Run this from the repo root."
  exit 1
fi

cp "$HOOK_SRC" "$HOOK_DST"
chmod +x "$HOOK_DST"
echo "✅ pre-commit hook installed at $HOOK_DST"
echo "   It will warn (not block) when code changes lack doc updates."
