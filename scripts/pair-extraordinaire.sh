#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# Pair Extraordinaire — co-author a merged PR
# Usage: bash scripts/pair-extraordinaire.sh "Name" "email@example.com"
# ============================================================

REPO=$(git remote get-url origin 2>/dev/null | sed 's/.*github\.com[:\/]//' | sed 's/\.git$//' || true)
if [[ -z "$REPO" ]]; then
  read -rp "Enter your GitHub repo (format: OWNER/REPO): " REPO
fi

COAUTHOR_NAME=${1:-}
COAUTHOR_EMAIL=${2:-}

if [[ -z "$COAUTHOR_NAME" ]]; then
  read -rp "Co-author full name: " COAUTHOR_NAME
fi
if [[ -z "$COAUTHOR_EMAIL" ]]; then
  read -rp "Co-author email (linked to their GitHub): " COAUTHOR_EMAIL
fi

BRANCH="pair-$(date +%s)"
echo -e "\033[1;33m🤝 Pair Extraordinaire — Creating branch: $BRANCH...\033[0m"

git checkout -b "$BRANCH" 2>/dev/null
echo "# Pair Extraordinaire — co-authored commit" >> README.md
git add README.md 2>/dev/null || true
git commit -m "feat: pair extraordinaire achievement

Co-authored-by: ${COAUTHOR_NAME} <${COAUTHOR_EMAIL}>" 2>/dev/null || true
git push -u origin "$BRANCH" 2>/dev/null || {
  echo -e "\033[1;31mPush failed.\033[0m"
  exit 1
}

echo -e "\033[1;33m🤝 Pair Extraordinaire — Opening PR...\033[0m"
PR_URL=$(gh pr create \
  --repo "$REPO" \
  --base main \
  --head "$BRANCH" \
  --title "Pair Extraordinaire — co-authored PR" \
  --body "Unlocking the 🤝 Pair Extraordinaire GitHub achievement.\n\nCo-authored-by: ${COAUTHOR_NAME} <${COAUTHOR_EMAIL}>" \
  2>/dev/null) || { echo -e "\033[1;31mFailed to create PR.\033[0m"; exit 1; }

PR_NUM=$(echo "$PR_URL" | grep -oP '/pull/\K[0-9]+')
echo -e "PR created: \033[1;34m$PR_URL\033[0m"

echo -e "\033[1;33m🤝 Pair Extraordinaire — Merging PR #${PR_NUM}...\033[0m"
gh pr merge "$PR_NUM" --repo "$REPO" --merge --delete-branch 2>/dev/null || {
  echo -e "\033[1;31mMerge failed.\033[0m"
  exit 1
}

echo -e "\033[1;32m✅ Pair Extraordinaire complete!\033[0m Co-authored PR merged.\n"
