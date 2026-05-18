#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# YOLO — create a branch, push a commit, open a PR, merge without review
# ============================================================

REPO=$(git remote get-url origin 2>/dev/null | sed 's/.*github\.com[:\/]//' | sed 's/\.git$//' || true)
if [[ -z "$REPO" ]]; then
  read -rp "Enter your GitHub repo (format: OWNER/REPO): " REPO
fi

BRANCH="yolo-$(date +%s)"
echo -e "\033[1;33m🤠 YOLO — Creating branch: $BRANCH...\033[0m"

# Create branch locally with a small change
git checkout -b "$BRANCH" 2>/dev/null
echo "# YOLO achievement commit" >> README.md
git add README.md 2>/dev/null || true
git commit -m "YOLO: merge without review" 2>/dev/null || true
git push -u origin "$BRANCH" 2>/dev/null || {
  echo -e "\033[1;31mPush failed. Ensure you have push access.\033[0m"
  exit 1
}

# Open PR
echo -e "\033[1;33m🤠 YOLO — Opening PR...\033[0m"
PR_URL=$(gh pr create \
  --repo "$REPO" \
  --base main \
  --head "$BRANCH" \
  --title "YOLO achievement — merge without review" \
  --body "This PR is for unlocking the 🤠 YOLO GitHub achievement." \
  2>/dev/null) || { echo -e "\033[1;31mFailed to create PR.\033[0m"; exit 1; }

PR_NUM=$(echo "$PR_URL" | grep -oP '/pull/\K[0-9]+')
echo -e "PR created: \033[1;34m$PR_URL\033[0m"

# Merge PR without review
echo -e "\033[1;33m🤠 YOLO — Merging PR #${PR_NUM}...\033[0m"
gh pr merge "$PR_NUM" --repo "$REPO" --merge --delete-branch 2>/dev/null || {
  echo -e "\033[1;31mMerge failed.\033[0m"
  exit 1
}

echo -e "\033[1;32m✅ YOLO complete!\033[0m PR merged without review.\n"
