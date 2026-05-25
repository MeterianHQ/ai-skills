# AI Skills — Overview

Meterian AI Skills are instruction files that teach your AI coding assistant to
invoke the Meterian CLI directly — no extra tooling, no browser extension, no
account required.

## How they work

When you install a Meterian skill, your AI assistant gains two new capabilities:

1. **Automatic scanning** — the skill triggers when you open or modify a manifest
   file (`package.json`, `pom.xml`, `Cargo.toml`, etc.) and runs a full dependency
   audit in the background.

2. **On-demand queries** — you can ask your assistant questions like
   "Is lodash 4.17.15 safe?" or "Fix all my vulnerable dependencies."

Under the hood, the skill instructs the assistant to run `npx @meterian/cli`
commands and format the results as a readable report.

## Available skills

| Skill | Trigger |
|-------|---------|
| [Security Audit](security-audit.md) | Opens/modifies any manifest file, or ask "audit my dependencies" |
| [Reachability Analysis](reachability-analysis.md) | After a security audit finds vulnerabilities |

## Supported AI tools

| Tool | Install method |
|------|---------------|
| [Claude Code](installation/claude-code.md) | Plugin marketplace |
| [Cursor](installation/cursor.md) | Plugin manager |
| [GitHub Copilot](installation/copilot.md) | Copy instructions file |
| [Windsurf](installation/windsurf.md) | Copy rules directory |
| [Cline](installation/cline.md) | Copy `.clinerules` |
| [Aider](installation/aider.md) | Copy config file |
| [Continue.dev](installation/continue.md) | Copy rules directory |
| [Gemini CLI](installation/gemini.md) | Copy extension files |
| [Codex CLI](installation/codex.md) | Copy `AGENTS.md` |

## Prerequisite

Node.js 18 or later must be available in the terminal where your AI tool runs.
The skills invoke `npx @meterian/cli` — Node.js is required; the CLI itself is
fetched automatically and needs no separate installation.
