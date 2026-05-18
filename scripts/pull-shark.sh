#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# Pull Shark — merge N pull requests (default: 2 for Bronze)
# Usage: bash scripts/pull-shark.sh [COUNT]
#   COUNT=2   → Bronze
#   COUNT=16  → Silver
#   COUNT=128 → Gold
# ============================================================

REPO=$(git remote get-url origin 2>/dev/null | sed 's/.*github\.com[:\/]//' | sed 's/\.git$//' || true)
if [[ -z "$REPO" ]]; then
  read -rp "Enter your GitHub repo (format: OWNER/REPO): " REPO
fi

COUNT=${1:-2}
REMAINING=$COUNT

echo -e "\033[1;33m🦈 Pull Shark — Target: $COUNT PRs\033[0m\n"

while [ $REMAINING -gt 0 ]; do
  PR_NUM=$((COUNT - REMAINING + 1))
  BRANCH="pullshark-${PR_NUM}-$(date +%s)"

  echo -e "\033[1;36m[$PR_NUM/$COUNT]\033[0m Creating branch $BRANCH..."
  git checkout -b "$BRANCH" 2>/dev/null
  echo "# Pull Shark PR ${PR_NUM}" >> README.md
  git add README.md 2>/dev/null || true
  git commit -m "Pull Shark: PR ${PR_NUM} of ${COUNT}" 2>/dev/null || true
  git push -u origin "$BRANCH" 2>/dev/null

  echo -e "\033[1;36m[$PR_NUM/$COUNT]\033[0m Opening PR..."
  PR_URL=$(gh pr create --repo "$REPO" --base main --head "$BRANCH" \
    --title "Pull Shark PR ${PR_NUM}/${COUNT}" \
    --body "Part of the 🦈 Pull Shark achievement. (${PR_NUM}/${COUNT})" 2>/dev/null)

  PR_ID=$(echo "$PR_URL" | grep -oP '/pull/\K[0-9]+')

  echo -e "\033[1;36m[$PR_NUM/$COUNT]\033[0m Merging PR #${PR_ID}..."
  gh pr merge "$PR_ID" --repo "$REPO" --merge --delete-branch 2>/dev/null

  REMAINING=$((REMAINING - 1))
  echo -e "\033[1;32m[$PR_NUM/$COUNT] DONE\033[0m\n"
done

echo -e "\033[1;32m✅ Pull Shark complete!\033[0m Merged $COUNT PRs.\n"
