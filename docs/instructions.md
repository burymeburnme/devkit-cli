# devkit-cli — Documentation

## Overview

devkit-cli is a command-line toolkit for scaffolding new projects in Node.js, Python, and Go. It includes built-in scripts to unlock GitHub achievement badges.

## Commands

### `new <name> [options]`
Scaffold a new project.

Options:
- `--lang, -l <lang>` — Language: `node` | `python` | `go` (default: `node`)
- `--template, -t <name>` — Template: `basic` | `cli` | `api` | `lib` (default: `basic`)
- `--git, -g` — Initialize a git repository
- `--install, -i` — Install dependencies after scaffold

### `list`
Show all available templates.

### `info <template>`
Show details about a specific template (e.g., `node-api`).

## GitHub Achievement Scripts

All scripts are in the `scripts/` directory:

| Script | Badge | Description |
|--------|-------|-------------|
| `setup.sh` | — | Validate environment, install deps, make scripts executable |
| `quickdraw.sh` | ⚡ Quickdraw | Open and close an issue |
| `yolo.sh` | 🤠 YOLO | Merge a PR without review |
| `publicist.sh` | 📢 Publicist | Publish a v1.0.0 release |
| `pull-shark.sh` | 🦈 Pull Shark | Merge N PRs (2=Bronze, 16=Silver, 128=Gold) |
| `pair-extraordinaire.sh` | 🤝 Pair Extraordinaire | Co-author a merged PR |
| `unlock-all.sh` | 🏆 All | Interactive menu to run all scripts |

## Template Reference

### Node.js
| Template | Files Created |
|----------|--------------|
| `basic` | package.json, index.js, .gitignore, README.md |
| `cli` | package.json (with bin), bin/cli.js, index.js, .gitignore, README.md |
| `api` | package.json (Express), server.js, .env.example, .gitignore, README.md |
| `lib` | package.json, lib/index.js, test/index.test.js, .gitignore, README.md |

### Python
| Template | Files Created |
|----------|--------------|
| `basic` | main.py, requirements.txt, .gitignore, README.md |
| `cli` | main.py (argparse), requirements.txt, .gitignore, README.md |
| `api` | app.py (Flask), requirements.txt, .env.example, .gitignore, README.md |
| `lib` | {name}/__init__.py, tests/test_greet.py, setup.py, .gitignore, README.md |

### Go
| Template | Files Created |
|----------|--------------|
| `basic` | main.go, go.mod, .gitignore, README.md |
| `cli` | main.go (flags), go.mod, .gitignore, README.md |
| `api` | main.go (net/http), go.mod, .env.example, .gitignore, README.md |
| `lib` | {name}.go, {name}_test.go, go.mod, .gitignore, README.md |

## Troubleshooting

| Problem | Cause | Fix |
|---------|-------|-----|
| `Authentication failed` | Codespace token is read-only | `unset GITHUB_TOKEN` -> `gh auth login` -> `gh auth setup-git` |
| `No anonymous write access` | Same as above | Same fix as above |
| `gh: command not found` | GitHub CLI not installed | Run `bash scripts/setup.sh` |
| `node: command not found` | Node.js not available | Use the devcontainer or install Node 20+ |
| Template not found | Wrong lang/template combo | Run `node src/cli.js list` to see options |
