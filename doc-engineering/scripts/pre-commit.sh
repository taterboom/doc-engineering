#!/usr/bin/env bash
# Document Engineering — pre-commit hook
# Warns (does not block) when code is staged without any doc updates.
#
# Install: copy to .git/hooks/pre-commit and chmod +x

DOC_ROOT="Product/Functions"

# Get list of staged files
STAGED=$(git diff --cached --name-only)

if [ -z "$STAGED" ]; then
  exit 0
fi

# Check if any staged file is a doc file
DOC_STAGED=$(echo "$STAGED" | grep "^$DOC_ROOT/")

# Check if any staged file is NOT a doc file (i.e., code changed)
CODE_STAGED=$(echo "$STAGED" | grep -v "^$DOC_ROOT/" | grep -v "^CLAUDE.md" | grep -v "^\.git")

if [ -n "$CODE_STAGED" ] && [ -z "$DOC_STAGED" ]; then
  echo ""
  echo "⚠️  [Doc Engineering] Code changed, but no docs updated."
  echo ""
  echo "   Changed code files:"
  echo "$CODE_STAGED" | sed 's/^/     /'
  echo ""
  echo "   Consider updating the relevant files in $DOC_ROOT/"
  echo "   (This is a warning only — commit proceeds.)"
  echo ""
fi

exit 0
