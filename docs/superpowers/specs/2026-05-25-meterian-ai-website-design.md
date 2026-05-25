# Design spec: Meterian AI — GitHub Pages website

**Date:** 2026-05-25  
**Repo:** `MeterianHQ/ai-skills`  
**URL:** `https://meterianhq.github.io/ai-skills/`

---

## Context

The `ai-skills` repo currently has no public website — just a README. It ships three related products:

1. **CLI** (`@meterian/cli`) — command-line dependency auditing, used directly by developers and invoked under the hood by the AI Skills
2. **AI Skills** (`meterian:security-audit`, `meterian:reachability-analysis`) — instruction-based integrations for 9 AI coding assistants
3. **MCP Server** (`@meterian/mcp`) — standalone npm package exposing real-time advisory data via the Model Context Protocol; required for GitHub Copilot Cloud agents and CLI-based AI tools (Claude, Gemini, Codex)

The goal is a professional documentation site that presents all three products coherently under the **"Meterian AI"** brand, consistent with the existing VS Code extension site at `https://meterianhq.github.io/vscode-extension-tracker/`.

---

## Technology

- **MkDocs** with the **Material for MkDocs** theme
- Deployed to GitHub Pages via the `docs/` folder on `main`
- Configuration: `mkdocs.yml` at repo root
- Settings to match VS Code extension site:
  - Palette: `indigo` primary, `indigo` accent
  - Font: `Roboto` (text), `Roboto Mono` (code)
  - Dark/light mode toggle enabled
  - Built-in search enabled
  - Back-to-top button enabled
  - Navigation tabs enabled (top-level tabs: CLI, AI Skills, MCP Server)

---

## Navigation structure

```
Home
Getting Started

CLI
  Overview
  Commands
    check
    advisories get
    nextsafe
  Supported Languages

AI Skills
  Overview
  Security Audit
  Reachability Analysis
  Installation
    Claude Code
    Cursor
    GitHub Copilot
    Windsurf
    Cline
    Aider
    Continue.dev
    Gemini CLI
    Codex CLI

MCP Server
  Overview
  Tools Reference
  Installation
  Supported Clients
  Prompts & Examples

FAQ
```

Sidebar labels are plain text — no emoji in navigation items. Product icons (⚡ CLI, 🧠 AI Skills, 🔌 MCP Server) appear only on the homepage cards.

---

## Pages

### Home (`docs/index.md`)

**Hero section** (light indigo tint `#f4f5fb`, bottom border `#dde0f0`):
- Eyebrow: *"Free · No account required"*
- H1: *"Security scanning for every developer workflow"*
- Subtext: one sentence covering all three integration modes and the 12+ ecosystem breadth
- Badges: `@meterian/cli`, `@meterian/mcp`, `9 AI tools`

**Three product cards** below the hero:
| Card | Icon | One-liner | Package badge |
|------|------|-----------|---------------|
| CLI | ⚡ | Direct audit from any terminal. Zero-install via npx. | `npx @meterian/cli check` |
| AI Skills | 🧠 | Your coding assistant scans dependencies inline, as you work. | `meterian:security-audit` |
| MCP Server | 🔌 | Real-time advisory data to any MCP-compatible client. | `@meterian/mcp` |

**"How they relate"** section: brief prose + simple architecture note showing CLI as the engine underneath both Skills and MCP Server.

**Supported ecosystems strip**: Node.js/npm, Python/pip, Java/Maven, Java/Gradle, Rust/Cargo, PHP/Composer, Ruby/Bundler, Go modules, .NET/NuGet, C++/Conan, Dart/pub, Clojure/Leiningen, Swift PM.

---

### Getting Started (`docs/getting-started.md`)

A decision guide: pick the right product based on your setup.

```
Are you using an AI coding assistant (Claude Code, Cursor, Copilot…)?
  → AI Skills

Are you using an MCP-compatible client (Claude Desktop, Gemini CLI, Codex…)?
  → MCP Server

Want direct command-line auditing without any AI tooling?
  → CLI
```

Each path ends with a direct link to the relevant installation page.

---

### CLI section (3 pages)

**Overview** (`docs/cli/index.md`): what the CLI does, zero-install vs global install, no account required.

**Commands** (`docs/cli/commands.md`): reference for all three commands with examples:
- `check` — reads JSON array of `{language, name, version}` from stdin, returns vulnerability summary
- `advisories get <language> <name> <version>` — full advisory list for one package
- `nextsafe <language> <name> <version>` — safe upgrade paths (latestPatch, latestMinor, latestMajor)

**Supported Languages** (`docs/cli/languages.md`): table of all 12+ ecosystems with their aliases.

---

### AI Skills section (4 pages + 9 per-tool install pages)

**Overview** (`docs/skills/index.md`): what AI Skills are (instruction files that teach your coding assistant to invoke the CLI), supported tools, auto-trigger behaviour.

**Security Audit** (`docs/skills/security-audit.md`): adapted from `skills/security-audit/SKILL.md` — the three modes (full audit, ad-hoc query, remediation), output format, supported manifest files.

**Reachability Analysis** (`docs/skills/reachability-analysis.md`): adapted from `skills/reachability-analysis/SKILL.md` — the 6-step workflow, the 5 classification categories, priority levels.

**Installation** (`docs/skills/installation/`): one page per tool. Content sourced from the existing `README.md` install instructions, expanded per tool:
- Claude Code (`claude-code.md`)
- Cursor (`cursor.md`)
- GitHub Copilot (`copilot.md`)
- Windsurf (`windsurf.md`)
- Cline (`cline.md`)
- Aider (`aider.md`)
- Continue.dev (`continue.md`)
- Gemini CLI (`gemini.md`)
- Codex CLI (`codex.md`)

---

### MCP Server section (5 pages)

Content adapted from `https://meterianhq.github.io/vscode-extension-tracker/mcp/` — VS Code–specific references removed, install instructions updated for the standalone `@meterian/mcp` npm package.

**Overview** (`docs/mcp/index.md`): why the MCP server exists (AI knowledge cutoff problem), what it enables, how it relates to the CLI.

**Tools Reference** (`docs/mcp/tools.md`): the two exposed tools:
- `advisories_get` — parameters: `language`, `name`, `version`; returns advisory array
- `advisories_getnextsafe` — same params; returns `latestPatch`, `latestMinor`, `latestMajor`

**Installation** (`docs/mcp/installation.md`): standalone npm install (`@meterian/mcp`), auto-detection of Claude / Gemini / Codex CLI clients; manual registration instructions for other clients.

**Supported Clients** (`docs/mcp/clients.md`): table of MCP-compatible clients (Claude Desktop, Gemini CLI, Codex CLI, VS Code Copilot via extension, Cursor, Windsurf) with notes on how each connects.

**Prompts & Examples** (`docs/mcp/prompts.md`): adapted from the VS Code extension site prompts page — example queries, expected outputs, typical workflows.

---

### FAQ (`docs/faq.md`)

Common questions: account requirements, data privacy (Kiwi database), supported versions, relationship between CLI / Skills / MCP.

---

## GitHub Pages setup

- `mkdocs.yml` at repo root
- GitHub Actions workflow (`.github/workflows/docs.yml`) to build and deploy on push to `main`
- `docs/` folder contains all Markdown source
- Add `docs/` and `mkdocs.yml` to the repo; existing skill files in `skills/` are not moved

---

## Out of scope

- Custom domain
- Analytics / tracking
- Versioned docs
- Changelog / releases page
