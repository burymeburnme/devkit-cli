#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# devkit-cli setup — validates environment & makes scripts executable
# ============================================================

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
echo -e "\033[1;36m========================================\033[0m"
echo -e "\033[1;36m  devkit-cli — Environment Setup\033[0m"
echo -e "\033[1;36m========================================\033[0m\n"

# —— 1. Node.js ——
echo -n "Checking Node.js... "
if command -v node &>/dev/null; then
  NODE_VER=$(node --version 2>/dev/null || echo "unknown")
  echo -e "\033[1;32mOK\033[0m ($NODE_VER)"
else
  echo -e "\033[1;31mMISSING\033[0m"
  echo "  Install: https://nodejs.org/ (v20+ recommended)"
  exit 1
fi

# —— 2. Git ——
echo -n "Checking Git... "
if command -v git &>/dev/null; then
  GIT_VER=$(git --version | awk '{print $3}')
  echo -e "\033[1;32mOK\033[0m (v$GIT_VER)"
else
  echo -e "\033[1;31mMISSING\033[0m"
  echo "  Install: https://git-scm.com/"
  exit 1
fi

# —— 3. GitHub CLI ——
echo -n "Checking GitHub CLI... "
if command -v gh &>/dev/null; then
  GH_VER=$(gh --version | head -n1 | awk '{print $3}')
  echo -e "\033[1;32mOK\033[0m (v$GH_VER)"
else
  echo -e "\033[1;33mMISSING\033[0m"
  echo "  Install: https://cli.github.com/"
fi

# —— 4. Make scripts executable ——
echo -n "Making scripts executable... "
chmod +x "$REPO_ROOT"/scripts/*.sh 2>/dev/null
echo -e "\033[1;32mDONE\033[0m"

# —— 5. npm install ——
echo -n "Installing npm dependencies... "
cd "$REPO_ROOT"
npm install --silent 2>/dev/null && echo -e "\033[1;32mDONE\033[0m" || echo -e "\033[1;33mSKIPPED\033[0m (no package.json)"

echo -e "\n\033[1;32mSetup complete!\033[0m Run \033[1m\`bash scripts/unlock-all.sh\`\033[0m to start unlocking badges.\n"
