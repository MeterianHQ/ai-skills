# Meterian AI Skills

Security vulnerability scanning and reachability analysis skills for AI coding assistants.

## Skills

### `meterian-security-audit`
Audit open-source dependencies for vulnerabilities across all supported ecosystems (npm, pip, Maven, Gradle, Cargo, Composer, Bundler, Go modules, NuGet, Conan, pub/Flutter, Leiningen, Swift PM).

Triggers automatically when you open or modify a manifest file (`package.json`, `requirements.txt`, `pom.xml`, `Cargo.toml`, etc.)

### `meterian-reachability`
After an audit, determine which vulnerable dependencies are actually reachable and exploitable in your application source code. Uses a 6-step workflow: enrich via CLI, identify entry points, search usage patterns, trace call paths, classify findings, and assign priority.

**Classifications:** Reachable · Conditionally reachable · Loaded but not called · Present but not reachable · Unknown

## Installation

### Claude Code

```
/plugin marketplace add github:MeterianHQ/ai-skills
/plugin install meterian-security-audit@meterian-ai-skills
```

Or directly:

```
/plugin install github:MeterianHQ/ai-skills
```

### Cursor

Install via Cursor's plugin manager pointing to `https://github.com/MeterianHQ/ai-skills`.

### Gemini CLI

Add `gemini-extension.json` and `GEMINI.md` to your project, or install the extension via Gemini CLI's extension manager.

### Codex CLI

Add `AGENTS.md` to your project root, or reference this repository in your Codex configuration.

## Prerequisite

Node.js 18+ must be available in the terminal. The skills invoke `npx @meterian/cli` (fetched automatically — no global install required).

To install the CLI globally for faster invocation:

```bash
npm install -g @meterian/cli
```

## Repository structure

```
ai-skills/
  skills/                          # shared skill content
    meterian-security-audit/SKILL.md
    meterian-reachability/SKILL.md
  .claude-plugin/
    plugin.json                    # Claude Code plugin
    marketplace.json               # Claude Code marketplace
  .cursor-plugin/
    plugin.json                    # Cursor plugin
  GEMINI.md                        # Gemini CLI context
  gemini-extension.json            # Gemini extension config
  AGENTS.md                        # Codex CLI context
```

## License

MIT
