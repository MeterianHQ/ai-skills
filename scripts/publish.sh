#!/usr/bin/env bash
# Publish meterian-security-audit to the official Anthropic Claude marketplace.
# Run from the repo root: ./scripts/publish.sh

set -euo pipefail

PLUGIN_DIR="$(cd "$(dirname "$0")/.." && pwd)/claude"
PLUGIN_JSON="$PLUGIN_DIR/.claude-plugin/plugin.json"

if [ ! -f "$PLUGIN_JSON" ]; then
  echo "ERROR: plugin.json not found at $PLUGIN_JSON"
  exit 1
fi

NAME=$(node -e "console.log(require('$PLUGIN_JSON').name)")
VERSION=$(node -e "console.log(require('$PLUGIN_JSON').version)")
DESCRIPTION=$(node -e "console.log(require('$PLUGIN_JSON').description)")
REPO=$(node -e "console.log(require('$PLUGIN_JSON').repository)")

echo ""
echo "Plugin ready for submission to the official Claude marketplace"
echo "=============================================================="
echo "  Name:        $NAME"
echo "  Version:     $VERSION"
echo "  Description: $DESCRIPTION"
echo "  Repository:  $REPO"
echo ""
echo "Submission forms:"
echo "  Claude.ai:   https://claude.ai/settings/plugins/submit"
echo "  Console:     https://platform.claude.com/plugins/submit"
echo ""
echo "To test the plugin locally before submitting:"
echo "  claude --plugin-dir $PLUGIN_DIR"
echo ""
echo "To let others install from this repo's marketplace directly:"
echo "  /plugin marketplace add github:MeterianHQ/ai-skills"
echo "  /plugin install meterian-security-audit@meterian-ai-skills"
echo ""

# Open the submission form if a browser is available
if command -v xdg-open &>/dev/null; then
  read -r -p "Open the submission form in your browser? [y/N] " answer
  if [[ "$answer" =~ ^[Yy]$ ]]; then
    xdg-open "https://claude.ai/settings/plugins/submit"
  fi
elif command -v open &>/dev/null; then
  read -r -p "Open the submission form in your browser? [y/N] " answer
  if [[ "$answer" =~ ^[Yy]$ ]]; then
    open "https://claude.ai/settings/plugins/submit"
  fi
fi
