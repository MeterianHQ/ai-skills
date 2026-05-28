# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A multi-agent AI skills plugin that wraps the Meterian CLI (`npx @meterian/cli`) for security vulnerability scanning and reachability analysis. It ships two skills — `meterian:security-audit` and `meterian:reachability-analysis` — and adapts them for every major AI coding assistant.

There is no build step, no test suite, and no runtime code. All content is markdown and JSON configuration.

## Skill naming convention

Skill identifiers follow the format `plugin-name:skill-name`:

- The **plugin prefix** comes from the `name` field in `.claude-plugin/plugin.json`
- The **skill name** comes from the `name:` frontmatter field in `skills/*/SKILL.md`
- Never repeat the plugin name inside the skill name (`meterian:security-audit`, not `meterian:meterian-security-audit`)

## Content architecture

`skills/*/SKILL.md` is the **single source of truth** for skill content. All other tool integrations are adapted versions of the same instructions:

| Tool | Location | Notes |
|------|----------|-------|
| Claude Code | `skills/*/SKILL.md` | Loaded via `.claude-plugin/plugin.json` |
| Windsurf | `.windsurf/rules/*.md` | No frontmatter `name:` field |
| Continue.dev | `.continue/rules/*.md` | Has frontmatter with `name`, `globs`, `alwaysApply` |
| GitHub Copilot | `.github/copilot-instructions.md` | Single file, both skills combined |
| Cline | `.clinerules` | `!include` directives pointing to `skills/` |
| Aider | `.aider.conf.yml` | `read:` directives pointing to `skills/` |
| Gemini CLI | `GEMINI.md` + `gemini-extension.json` | `@` includes pointing to `skills/` |
| Codex CLI | `AGENTS.md` | `@` includes pointing to `skills/` |
| Cursor | `.cursor-plugin/plugin.json` | Plugin manifest only; skill content from `skills/` |
| Tessl | `tessl/*/SKILL.md` + `tessl/*/tile.json` | Independent copies, tessl-optimised; see `tessl/CLAUDE.md` |

When editing skill content, **propagate changes to all tool-specific files** — particularly `.windsurf/rules/`, `.continue/rules/`, and `.github/copilot-instructions.md`, which contain adapted copies rather than includes.

The `tessl/` directory holds independent copies of skill content tuned for the Tessl package manager (different metadata, bundled reference files). Changes there do not automatically propagate to `skills/` — sync manually when stable.

## Versioning

Version is tracked at the plugin level (not per-skill) using SemVer. Update it in all three places together:

- `.claude-plugin/plugin.json`
- `.cursor-plugin/plugin.json`
- `gemini-extension.json`

Bump guide: patch = wording fixes; minor = new skills or behaviour changes; major = breaking changes (renamed/removed skills).

## Testing changes locally

After editing skill files, apply changes to the installed plugin cache and reload:

```bash
# The cache lives at:
~/.claude/plugins/cache/meterian-ai-skills/meterian-security-audit/<version>/

# Edit the cached SKILL.md files and plugin.json directly, then:
/reload-plugins
```

The cache directory name (`meterian-security-audit`) is the marketplace install identifier and does not change when `plugin.json` `name` is updated.

## Install command (Claude Code)

```
/plugin marketplace add MeterianHQ/ai-skills
/plugin install meterian@meterian-ai-skills
/reload-plugins
```
