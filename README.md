# devkit-cli

> A command-line developer toolkit that scaffolds new projects in **Node.js**, **Python**, and **Go** — complete with GitHub achievement unlocker scripts.

```
┌─────────────────────────────────────────────┐
│  devkit-cli v1.0.0                           │
│  Scaffold projects + unlock GitHub badges    │
└─────────────────────────────────────────────┘
```

## Quick Start

```bash
# Install dependencies
npm install

# Show help
node src/cli.js --help

# Scaffold a new Node.js API project
node src/cli.js new my-api --lang node --template api --git --install

# List all available templates
node src/cli.js list
```

## Features

- **Multi-language scaffolding** — Node.js, Python, and Go
- **4 template types** — Basic, CLI, API, and Library
- **Git initialization** — Optionally init a git repo on scaffold
- **Auto-install** — Optionally install dependencies after scaffold
- **GitHub Achievement Scripts** — Unlock Quickdraw, YOLO, Publicist, Pull Shark, and Pair Extraordinaire

## Templates

| Language | Basic | CLI | API | Library |
|----------|-------|-----|-----|---------|
| **Node.js** | package.json starter | CLI with argument parsing | Express REST API | Library with tests |
| **Python** | requirements.txt | argparse CLI | Flask API | Library with tests |
| **Go** | go.mod | flag CLI | net/http API | Library with tests |

## Installation

### Local
```bash
git clone https://github.com/YOUR_USERNAME/devkit-cli.git
cd devkit-cli
npm install
```

### Global (via npm link)
```bash
cd devkit-cli
npm link
devkit-cli --help
```

### npx (no install)
```bash
npx devkit-cli new my-project --lang go --template api
```

## Commands

| Command | Description | Example |
|---------|-------------|---------|
| `new <name>` | Scaffold a new project | `node src/cli.js new my-app --lang python --template api` |
| `list` | List available templates | `node src/cli.js list` |
| `info <template>` | Show template details | `node src/cli.js info node-api` |
| `--help` | Show help | `node src/cli.js --help` |
| `--version` | Show version | `node src/cli.js --version` |

## GitHub Achievement Badges

This repo includes bash scripts to unlock every scriptable GitHub achievement:

| Badge | Command | What It Does |
|-------|---------|--------------|
| ⚡ Quickdraw | `bash scripts/quickdraw.sh` | Opens & closes an issue |
| 🤠 YOLO | `bash scripts/yolo.sh` | Merges a PR without review |
| 📢 Publicist | `bash scripts/publicist.sh` | Publishes a v1.0.0 release |
| 🦈 Pull Shark | `bash scripts/pull-shark.sh 2` | Merges N PRs (2=Bronze, 16=Silver, 128=Gold) |
| 🤝 Pair Extraordinaire | `bash scripts/pair-extraordinaire.sh "Name" "email"` | Co-authors a merged PR |
| 🏆 All at once | `bash scripts/unlock-all.sh` | Interactive menu + full blast mode |

### Achievement Tracker

```bash
# Check your progress
node src/achievement-tracker.js

# View full roadmap
node src/achievement-tracker.js roadmap
```

## Project Structure

```
devkit-cli/
├── .devcontainer/
│   └── devcontainer.json          # Codespace auto-setup
├── .github/
│   ├── workflows/
│   │   ├── ci.yml                 # Runs on every push & PR
│   │   └── release.yml            # Auto-release on version tags
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md
│   │   └── feature_request.md
│   └── PULL_REQUEST_TEMPLATE.md
├── scripts/
│   ├── setup.sh                   # Environment setup
│   ├── quickdraw.sh               # ⚡ Quickdraw
│   ├── yolo.sh                    # 🤠 YOLO
│   ├── publicist.sh               # 📢 Publicist
│   ├── pull-shark.sh              # 🦈 Pull Shark (all tiers)
│   ├── pair-extraordinaire.sh     # 🤝 Pair Extraordinaire
│   └── unlock-all.sh              # 🏆 Interactive master menu
├── src/
│   ├── cli.js                     # Main scaffolding tool
│   └── achievement-tracker.js     # Badge progress tracker
├── docs/
│   └── instructions.md
├── package.json
├── CHANGELOG.md
├── CONTRIBUTING.md
├── LICENSE
└── README.md
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

[MIT](LICENSE)
# YOLO achievement commit
# Pull Shark PR 1
# Pull Shark PR 2
# Pull Shark PR 3
# Pair Extraordinaire — co-authored commit
# Pull Shark PR 1
# Pull Shark PR 2
# Pull Shark PR 3
# Pull Shark PR 4
# Pull Shark PR 5
# Pull Shark PR 6
# Pull Shark PR 7
# Pull Shark PR 8
# Pull Shark PR 9
# Pull Shark PR 10
# Pull Shark PR 11
