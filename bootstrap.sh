#!/usr/bin/env bash
# Bootstrap Claude Code config on macOS / Linux.
# Usage:  ./bootstrap.sh
# Installs the shared skills, global rulebook, and settings into ~/.claude,
# then installs the dev toolchain. It backs up anything it would overwrite.
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
echo "==> Bootstrapping Claude Code config into $CLAUDE_DIR"

mkdir -p "$CLAUDE_DIR/skills"

# 1) Skills (merge into ~/.claude/skills, overwriting same-named skills)
echo "==> Installing skills"
cp -R "$HERE/skills/." "$CLAUDE_DIR/skills/"

# 2) Global auto-activation rulebook
echo "==> Installing CLAUDE.md (skill routing rulebook)"
cp "$HERE/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

# 3) Settings (back up any existing file first; merge personal keys back by hand)
if [ -f "$CLAUDE_DIR/settings.json" ]; then
  cp "$CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json.bak"
  echo "==> Backed up existing settings.json -> settings.json.bak"
  echo "    (re-add any personal keys, e.g. a statusLine, into the new settings.json)"
fi
cp "$HERE/settings.json" "$CLAUDE_DIR/settings.json"

# 4) Dev toolchain
echo "==> Installing dev tools"
if command -v brew >/dev/null 2>&1; then
  brew install node python go openssl gitleaks || true
elif command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update && sudo apt-get install -y nodejs npm python3 golang openssl || true
  echo "    NOTE: install 'gitleaks' from https://github.com/gitleaks/gitleaks/releases"
else
  echo "    No supported package manager found. Install manually: node, python, go, openssl, gitleaks"
fi

echo ""
echo "==> Done."
echo "    1. Start Claude Code and run /login to authenticate (credentials are NOT in this repo)."
echo "    2. Restart Claude Code once so it begins watching ~/.claude/skills."
echo "    On macOS, teammateMode=tmux gives real split panes if tmux or iTerm2 is installed."
