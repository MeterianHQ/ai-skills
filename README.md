# Meterian AI Skills

[![skills.sh](https://skills.sh/b/MeterianHQ/ai-skills)](https://skills.sh/MeterianHQ/ai-skills)

Security vulnerability scanning and reachability analysis skills for AI coding assistants.

## Skills

### `meterian-security-audit`
Audit open-source dependencies for vulnerabilities across all supported ecosystems (npm, pip, Maven, Gradle, Cargo, Composer, Bundler, Go modules, NuGet, Conan, pub/Flutter, Leiningen, Swift PM).

Triggers automatically when you open or modify a manifest file (`package.json`, `requirements.txt`, `pom.xml`, `Cargo.toml`, etc.)

### `meterian-reachability`
After an audit, determine which vulnerable dependencies are actually reachable and exploitable in your application source code. Uses a 6-step workflow: enrich via CLI, identify entry points, search usage patterns, trace call paths, classify findings, and assign priority.

**Classifications:** Reachable · Conditionally reachable · Loaded but not called · Present but not reachable · Unknown

## Installation

### Any agent (skills CLI)

```bash
npx skills add MeterianHQ/ai-skills
```

Installs both skills for all detected agents in the current project. Use `-g` for global install, `-a claude-code` to target a specific agent.

### Claude Code

```
/plugin marketplace add MeterianHQ/ai-skills
/plugin install meterian-security-audit@meterian-ai-skills
/reload-plugins
```

### Cursor

Install via Cursor's plugin manager pointing to `https://github.com/MeterianHQ/ai-skills`.

### Windsurf

Copy `.windsurf/rules/` from this repository into your project root:

```bash
cp -r .windsurf your-project/
```

Or clone the repository and symlink the rules directory.

### GitHub Copilot

Copy `.github/copilot-instructions.md` from this repository into your project root:

```bash
cp .github/copilot-instructions.md your-project/.github/
```

### Cline

Copy `.clinerules` from this repository into your project root. Cline will automatically pick up the `!include` directives and load the skill content from the `skills/` directory.

```bash
cp .clinerules your-project/
cp -r skills your-project/
```

### Aider

Copy `.aider.conf.yml` and the `skills/` directory from this repository into your project root:

```bash
cp .aider.conf.yml your-project/
cp -r skills your-project/
```

Aider will automatically read the skill files listed under `read:` on startup.

### Continue.dev

Copy `.continue/rules/` from this repository into your project root:

```bash
cp -r .continue your-project/
```

Continue will load the rules files and apply them based on the `globs` and `alwaysApply` frontmatter settings.

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
  .windsurf/
    rules/
      meterian-security-audit.md   # Windsurf rules
      meterian-reachability.md
  .github/
    copilot-instructions.md        # GitHub Copilot instructions
  .clinerules                      # Cline rules (uses !include)
  .aider.conf.yml                  # Aider config (read: skill files)
  .continue/
    rules/
      meterian-security-audit.md   # Continue.dev rules
      meterian-reachability.md
  GEMINI.md                        # Gemini CLI context
  gemini-extension.json            # Gemini extension config
  AGENTS.md                        # Codex CLI context
```

## License

MIT
