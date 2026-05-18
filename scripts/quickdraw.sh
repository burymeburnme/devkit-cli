#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# Quickdraw — open an issue and close it in under 5 minutes
# ============================================================

REPO=$(git remote get-url origin 2>/dev/null | sed 's/.*github\.com[:\/]//' | sed 's/\.git$//' || true)
if [[ -z "$REPO" ]]; then
  read -rp "Enter your GitHub repo (format: OWNER/REPO): " REPO
fi

echo -e "\033[1;33m⚡ Quickdraw — Opening issue...\033[0m"

ISSUE_URL=$(gh issue create \
  --repo "$REPO" \
  --title "Quickdraw challenge — closing fast" \
  --body "This issue was created to unlock the ⚡ Quickdraw GitHub achievement. Closing it immediately!" \
  2>/dev/null) || { echo -e "\033[1;31mFailed to create issue.\033[0m"; exit 1; }

ISSUE_NUM=$(echo "$ISSUE_URL" | grep -oP '/issues/\K[0-9]+')

echo -e "Issue created: \033[1;34m$ISSUE_URL\033[0m"
echo -e "\033[1;33m⚡ Quickdraw — Closing issue #${ISSUE_NUM}...\033[0m"

gh issue close "$ISSUE_NUM" --repo "$REPO" --comment "Closed for Quickdraw achievement! ⚡" 2>/dev/null || {
  echo -e "\033[1;31mFailed to close issue.\033[0m"
  exit 1
}

echo -e "\033[1;32m✅ Quickdraw complete!\033[0m Issue opened and closed.\n"
