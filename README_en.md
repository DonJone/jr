English | [中文](README.md)

# jr

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)
![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20macOS%20%7C%20BSD-lightgrey.svg)
![Version](https://img.shields.io/badge/version-2.0.0-green.svg)

A minimalist terminal journal for developers who think in the terminal.

jr doesn't try to be another note-taking app. It does one thing: let you quickly log entries from the terminal, then get out of the way. Your data, Markdown format, Git sync.

## Design Philosophy

**Do one thing, and do it well.**

- Type and record, zero friction
- Markdown as format, readable and portable
- Git as sync, with conflict self-healing
- Isolation as security, sensitive data never leaves local

## Installation

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/DonJone/jr/main/install.sh)"
```

The script auto-detects your environment, installs dependencies, and configures PATH. If you want cloud sync, it guides you through GitHub authorization.

### Dependencies

| Component | Required | Description |
|-----------|----------|-------------|
| `git` | ✓ | Version control |
| `curl` | ✓ | Download & install |
| `gh` | Optional | GitHub CLI for cloud sync |

## Quick Start

```bash
# Record a journal entry
jr "Refactored the auth module today"

# Open today's journal in editor
jr -c

# Record to local backup only (no cloud sync)
jr -l "Local debugging notes"

# Record to private zone (never uploaded)
jr -p "Server password: xxx"

# Read from pipe
echo "Script output" | jr

# Check status
jr --status
```

## Directory Structure

```
~/Documents/
├── Journal/              # Sync zone → GitHub
│   └── 2026/05/
│       └── 2026-05-04.md
├── Journal_local/        # Local backup (syncs when online)
│   └── 2026/05/
│       └── 2026-05-04_local.md
└── Journal_private/      # Private zone (never uploaded)
    └── 2026/05/
        └── 2026-05-04_private.md
```

## Usage

```
jr [options] [content]

Recording modes:
  "content"               Record to sync + local backup
  -l, --local "content"   Record to local backup only
  -p, --private "content" Record to private zone (never uploaded)

Editors:
  -c, --code              VS Code
  -g, --gnome             GNOME Text Editor
  -k, --kde               Kate
  -m, --macos             macOS TextEdit
  -e, --edit              $EDITOR or system default
  -x, --xdg               xdg-open (Linux)

Management:
  --login                 GitHub login
  --status                Show status
  -q, --quiet             Quiet mode
  -v, --verbose           Verbose mode
  -V, --version           Version info
  -h, --help              Help
```

## Configuration

Config file: `~/.config/jr/config`

```bash
# Custom directory paths
sync_dir="$HOME/Documents/Journal"
local_dir="$HOME/Documents/Journal_local"
private_dir="$HOME/Documents/Journal_private"
```

## Platform Support

| Platform | Status |
|----------|--------|
| Linux (Ubuntu/Debian/Fedora/Arch) | ✓ |
| macOS | ✓ |
| FreeBSD | ✓ |
| OpenBSD | ✓ |
| NetBSD | ✓ |
| DragonFlyBSD | ✓ |

## Design Decisions

**Why Markdown?**
Plain text, grep-able, Git-diff-able, opens in any editor. Your journal will be readable in ten years.

**Why Git sync?**
Conflict resolution is a solved problem. Don't reinvent the wheel—use Git's rebase strategy for multi-device sync.

**Why a private zone?**
Passwords, tokens, and personal notes shouldn't be in Git history. Physical isolation is the only real isolation.

**Why gh?**
GitHub CLI handles OAuth and repository operations. More secure than hand-written tokens, simpler than SSH config.

## Uninstall

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/DonJone/jr/main/uninstall.sh)"
```

Uninstalling does not delete your journal data.

## License

[AGPL-3.0](LICENSE)
