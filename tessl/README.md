# Tessl Skills

This directory contains the Meterian skills packaged for the [Tessl](https://tessl.io) package manager — a separate, independently maintained set of skill files tuned for the Tessl platform.

## Prerequisites

```bash
npm install -g tessl        # or: brew install tessl
tessl login
```

## Structure

```
tessl/
  security-audit/
    SKILL.md                # skill instructions for the agent
    LANGUAGES.md            # manifest-to-language mapping (referenced from SKILL.md)
    tile.json               # tessl tile manifest
    evals/                  # eval scenarios for automated testing
      scenario-N/
        task.md             # scenario description
        criteria.json       # scoring criteria
        inputs/             # fixture files the agent works with
  reachability-analysis/
    SKILL.md
    SEARCH_PATTERNS.md      # import search patterns (referenced from SKILL.md)
    tile.json
```

## Local development

### 1. Import (first time only)

If you're setting up a new skill from a `SKILL.md`:

```bash
tessl skill import ./tessl/security-audit
```

### 2. Edit → Pack → Install → Test

```bash
# Edit tessl/security-audit/SKILL.md, then:
tessl tile pack ./tessl/security-audit
tessl install ./local-security-audit-0.1.0.tgz

# In Claude Code, reload the skill:
/reload-plugins
```

Use `--watch-local` to auto-reinstall whenever the pack changes:

```bash
tessl install --watch-local ./local-security-audit-0.1.0.tgz
```

### 3. Review quality

```bash
tessl skill review ./tessl/security-audit   # full AI-judged review + score
tessl skill lint ./tessl/security-audit     # validation checks only (faster)
```

The review scores Description and Content separately and provides concrete suggestions. Aim for 90%+.

## Evals

Evals verify the skill actually works end-to-end with a real agent.

### Generate scenarios (once, or when skill changes significantly)

```bash
tessl scenario generate ./tessl/security-audit --count 10
tessl scenario list                          # check status
tessl scenario download <id> --output ./tessl/security-audit/evals/
```

Scenarios are generated from the skill content — tessl synthesises realistic user prompts and scoring criteria automatically.

### Run evals

```bash
tessl eval run ./tessl/security-audit --agent claude:claude-sonnet-4-6 --label "v1.0.0"
tessl eval view --last                       # check results
```

You can compare models or with/without skill context:

```bash
tessl eval run ./tessl/security-audit \
  --agent claude:claude-sonnet-4-6 \
  --agent claude:claude-opus-4-7 \
  --variant with-context \
  --variant without-context
```

Results are also viewable in the browser at `https://tessl.io/eval-runs/<id>`.

### Linking the project (first time only)

Evals require a Tessl project linked to this repository:

```bash
tessl project create ai-skills --workspace meterian
```

If the project already exists but isn't linked:

```bash
tessl project link --workspace meterian
```

## Publishing

Before publishing, ensure `tile.json` has the correct workspace name (e.g. `meterian/security-audit`), `"private": false`, and the version is correct.

```bash
tessl skill publish ./tessl/security-audit

# Future releases — let tessl bump the version:
tessl skill publish ./tessl/security-audit --bump patch   # 1.0.0 → 1.0.1
tessl skill publish ./tessl/security-audit --bump minor   # 1.0.0 → 1.1.0
```

Once published, users install with:

```bash
tessl install meterian/security-audit
```

## Versioning

Version is tracked in `tile.json` (`"version"` field) and mirrored in `SKILL.md` frontmatter (`metadata.version`). Keep them in sync. This is independent from the Claude Code plugin version in `/.claude-plugin/plugin.json`.

## Relationship to skills/

`skills/*/SKILL.md` is the single source of truth for all other agent integrations (Claude Code plugin, Windsurf, Copilot, etc.). The `tessl/` copies are independent — changes here do not propagate automatically. When tessl-side improvements are stable, sync them back to `skills/` manually.
