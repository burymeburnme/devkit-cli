#!/usr/bin/env node
// ============================================================
// achievement-tracker — Track your GitHub badge progress
// Usage: node src/achievement-tracker.js [roadmap]
// ============================================================

const DATA_FILE = '.achievement-progress.json';
const fs = require('fs');
const path = require('path');

const BADGES = {
  quickdraw: { icon: '⚡', name: 'Quickdraw', tier: 'Bronze', unlock: 'Close an issue within 5 minutes of opening' },
  yolo: { icon: '🤠', name: 'YOLO', tier: 'Bronze', unlock: 'Merge a PR without code review' },
  publicist: { icon: '📢', name: 'Publicist', tier: 'Bronze', unlock: 'Publish a release on a public repo' },
  'pull-shark': { icon: '🦈', name: 'Pull Shark', tier: 'Bronze/Silver/Gold', unlock: 'Merge 2/16/128 PRs' },
  'pair-extraordinaire': { icon: '🤝', name: 'Pair Extraordinaire', tier: 'Bronze/Silver/Gold', unlock: 'Co-author 1/10/50 merged PRs' },
};

const MANUAL_BADGES = {
  'heart-on-your-sleeve': { icon: '❤️', name: 'Heart On Your Sleeve', tier: 'Bronze', unlock: 'React with ❤️ to any GitHub content' },
  'galaxy-brain': { icon: '🌌', name: 'Galaxy Brain', tier: 'Bronze', unlock: 'Have an answer marked as accepted' },
  starstruck: { icon: '🌟', name: 'Starstruck', tier: 'Bronze/Silver/Gold', unlock: 'Get 16/128/4096 stars on a repo' },
};

function loadProgress() {
  try {
    const data = fs.readFileSync(DATA_FILE, 'utf-8');
    return JSON.parse(data);
  } catch {
    return {};
  }
}

function saveProgress(progress) {
  fs.writeFileSync(DATA_FILE, JSON.stringify(progress, null, 2));
}

function showProgress() {
  const progress = loadProgress();
  console.log('\n┌─────────────────────────────────────────────┐');
  console.log('│      🏆 GitHub Achievement Progress         │');
  console.log('└─────────────────────────────────────────────┘\n');

  console.log('Script-Unlocked Badges:');
  for (const [key, badge] of Object.entries(BADGES)) {
    const done = progress[key] ? '✅' : '⬜';
    console.log(`  ${done} ${badge.icon} ${badge.name} — ${badge.tier}`);
    console.log(`     └─ ${badge.unlock}`);
  }

  console.log('\nManual Badges:');
  for (const [key, badge] of Object.entries(MANUAL_BADGES)) {
    const done = progress[key] ? '✅' : '⬜';
    console.log(`  ${done} ${badge.icon} ${badge.name} — ${badge.tier}`);
    console.log(`     └─ ${badge.unlock}`);
  }

  const scriptTotal = Object.keys(BADGES).length;
  const scriptDone = Object.keys(BADGES).filter(k => progress[k]).length;
  const manualTotal = Object.keys(MANUAL_BADGES).length;
  const manualDone = Object.keys(MANUAL_BADGES).filter(k => progress[k]).length;

  console.log(`\n📊 Summary: ${scriptDone}/${scriptTotal} script badges, ${manualDone}/${manualTotal} manual badges`);
  console.log(`   Run \`bash scripts/unlock-all.sh\` to unlock the rest!\n`);
}

function showRoadmap() {
  console.log(`
┌─────────────────────────────────────────────────────┐
│         🗺️  GitHub Achievement Roadmap               │
└─────────────────────────────────────────────────────┘

Day 1 — Script Unlocks
  ⚡ Quickdraw           bash scripts/quickdraw.sh
  🤠 YOLO               bash scripts/yolo.sh
  📢 Publicist          bash scripts/publicist.sh
  🦈 Pull Shark         bash scripts/pull-shark.sh 2
  🤝 Pair Extraordinaire  bash scripts/pair-extraordinaire.sh "Name" "email"

  Or run all at once:
  bash scripts/unlock-all.sh

Day 2 — Stacking
  🦈 Pull Shark (Silver)   bash scripts/pull-shark.sh 16
  🤝 Pair Extraordinaire   (use the same script across repos)

Day 3 — Gold Tier
  🦈 Pull Shark (Gold)     bash scripts/pull-shark.sh 128

Week 1 — Manual Badges
  ❤️ Heart On Your Sleeve  — React with heart on any issue/PR/comment
  🌌 Galaxy Brain          — Answer a Discussion question helpfully
  🌟 Starstruck            — Share your repo, get 16+ stars

Month 1 — Maximize
  Keep using devkit-cli across repos
  Run achievement scripts on every new project
  Contribute to discussions on popular repos
  Share projects on Reddit, Twitter, Hacker News

Tips:
  • Run scripts in Codespace (pre-configured environment)
  • Use multiple repos for Pull Shark & Pair Extraordinaire
  • Badge processing takes 2–24 hours — be patient!
  • GitHub profile: https://github.com/YOUR_USERNAME
`);
}

// ─── Main ─────────────────────────────────────────────────

const cmd = process.argv[2];
if (cmd === 'roadmap') {
  showRoadmap();
} else {
  showProgress();
}
