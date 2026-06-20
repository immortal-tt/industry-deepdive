#!/bin/bash
# ─────────────────────────────────────────────────────────────
#  Industry Deep Dive — GitHub Push
#  Safe to run any time after adding/updating a deep dive HTML file.
# ─────────────────────────────────────────────────────────────

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -z "$GH_TOKEN" ] && [ -f "$SCRIPT_DIR/.env" ]; then
  source "$SCRIPT_DIR/.env"
fi

if [ -z "$GH_TOKEN" ]; then
  echo "✗ GH_TOKEN not set. Add it to $SCRIPT_DIR/.env"
  exit 1
fi
GH_USER="immortal-tt"
REPO="industry-deepdive"
DIR="$SCRIPT_DIR"

cd "$DIR"

git remote remove origin 2>/dev/null || true
git remote add origin "https://$GH_TOKEN@github.com/$GH_USER/$REPO.git"

git add -A
git diff --cached --quiet && echo "Nothing new to push" && exit 0

git commit -m "🔬 Industry deep dive: $(date +'%Y-%m-%d')"
git push origin main

echo "✓ Pushed to https://$(echo "$GH_USER" | tr A-Z a-z).github.io/$REPO"
