#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# Interactive master menu — unlock all GitHub achievements
# ============================================================

clear
echo -e "\033[1;35m╔══════════════════════════════════════════╗\033[0m"
echo -e "\033[1;35m║     devkit-cli — Achievement Unlocker    ║\033[0m"
echo -e "\033[1;35m║                                          ║\033[0m"
echo -e "\033[1;35m║  Unlock every GitHub achievement badge   ║\033[0m"
echo -e "\033[1;35m╚══════════════════════════════════════════╝\033[0m\n"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

show_menu() {
  echo -e "\033[1;36mOptions:\033[0m"
  echo "  1) ⚡ Quickdraw        — open & close an issue"
  echo "  2) 🤠 YOLO             — merge a PR without review"
  echo "  3) 📢 Publicist        — publish a release"
  echo "  4) 🦈 Pull Shark       — merge multiple PRs"
  echo "  5) 🤝 Pair Extraordinaire — co-author a PR"
  echo "  6) 🏆 FULL BLAST       — run 1-5 all at once"
  echo "  0) Exit"
}

run_script() {
  local script=$1
  shift
  echo ""
  bash "$SCRIPT_DIR/$script" "$@" || echo -e "\033[1;31mScript exited with an error.\033[0m"
  echo ""
  read -rp "Press Enter to return to menu..."
  clear
}

while true; do
  show_menu
  read -rp "Choose [0-6]: " CHOICE

  case $CHOICE in
    1) run_script quickdraw.sh ;;
    2) run_script yolo.sh ;;
    3) run_script publicist.sh ;;
    4)
      read -rp "How many PRs? (2=Bronze, 16=Silver, 128=Gold): " NUM
      run_script pull-shark.sh "${NUM:-2}"
      ;;
    5)
      read -rp "Co-author name: " NAME
      read -rp "Co-author email: " EMAIL
      run_script pair-extraordinaire.sh "$NAME" "$EMAIL"
      ;;
    6)
      echo -e "\n\033[1;35m🏆 FULL BLAST — Running all achievements...\033[0m\n"
      bash "$SCRIPT_DIR/quickdraw.sh" || true
      bash "$SCRIPT_DIR/yolo.sh" || true
      bash "$SCRIPT_DIR/publicist.sh" || true
      read -rp "How many PRs for Pull Shark? (default 2): " NUM
      bash "$SCRIPT_DIR/pull-shark.sh" "${NUM:-2}" || true
      read -rp "Co-author name for Pair Extraordinaire: " NAME
      read -rp "Co-author email: " EMAIL
      bash "$SCRIPT_DIR/pair-extraordinaire.sh" "$NAME" "$EMAIL" || true
      echo -e "\n\033[1;32m🏆 FULL BLAST complete!\033[0m\n"
      read -rp "Press Enter to return to menu..."
      clear
      ;;
    0) echo -e "\nGood luck with the badges! 🚀\n"; exit 0 ;;
    *) echo -e "\033[1;31mInvalid option.\033[0m\n" ;;
  esac
done
