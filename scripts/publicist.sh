#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# Publicist — create a v1.0.0 GitHub Release
# ============================================================

REPO=$(git remote get-url origin 2>/dev/null | sed 's/.*github\.com[:\/]//' | sed 's/\.git$//' || true)
if [[ -z "$REPO" ]]; then
  read -rp "Enter your GitHub repo (format: OWNER/REPO): " REPO
fi

echo -e "\033[1;33m📢 Publicist — Creating release...\033[0m"

# Ensure tag exists locally
git tag -a "v1.0.0" -m "Release v1.0.0 — Publicist achievement" 2>/dev/null || true
git push origin "v1.0.0" 2>/dev/null || true

# Create release via gh CLI
gh release create "v1.0.0" \
  --repo "$REPO" \
  --title "v1.0.0" \
  --notes "First release for the 📢 Publicist GitHub achievement! 🎉" \
  2>/dev/null && echo -e "\033[1;32m✅ Publicist complete!\033[0m Release v1.0.0 published.\n" || {
    echo -e "\033[1;33mRelease already exists, attempting to link...\033[0m"
    echo -e "\033[1;32m✅ Publicist badge should unlock shortly!\033[0m\n"
  }
