# Meterian AI Website — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build and deploy a MkDocs documentation website at `https://meterianhq.github.io/ai-skills/` covering three products: CLI, AI Skills, and MCP Server.

**Architecture:** MkDocs with Material for MkDocs theme, matching the VS Code extension site's indigo colour scheme and Roboto font stack. All content lives in `docs/`. Deployed via GitHub Actions on every push to `main`. A custom CSS file adds the homepage hero styling.

**Tech Stack:** MkDocs ≥1.5, Material for MkDocs ≥9.5, GitHub Actions, GitHub Pages (`gh-pages` branch)

---

## File structure

```
mkdocs.yml                             # site config + nav
requirements-docs.txt                  # pip deps for CI
.github/workflows/docs.yml             # build + deploy
docs/
  index.md                             # homepage
  getting-started.md
  stylesheets/
    extra.css                          # hero + eco-tag styles
  cli/
    index.md
    commands.md
    languages.md
  skills/
    index.md
    security-audit.md
    reachability-analysis.md
    installation/
      index.md
      claude-code.md
      cursor.md
      copilot.md
      windsurf.md
      cline.md
      aider.md
      continue.md
      gemini.md
      codex.md
  mcp/
    index.md
    tools.md
    installation.md
    clients.md
    prompts.md
  faq.md
```

---

## Task 1: Foundation — mkdocs.yml, requirements, GitHub Actions, custom CSS

**Files:**
- Create: `mkdocs.yml`
- Create: `requirements-docs.txt`
- Create: `.github/workflows/docs.yml`
- Create: `docs/stylesheets/extra.css`
- Create: `docs/index.md` (stub — replaced in Task 2)

- [ ] **Step 1: Create `requirements-docs.txt`**

```
mkdocs-material>=9.5
```

- [ ] **Step 2: Create `mkdocs.yml`**

```yaml
site_name: Meterian AI
site_url: https://meterianhq.github.io/ai-skills/
site_description: >-
  Security scanning for every developer workflow —
  CLI, AI Skills, and MCP Server.
site_author: Meterian
repo_url: https://github.com/MeterianHQ/ai-skills
repo_name: MeterianHQ/ai-skills
edit_uri: ""

theme:
  name: material
  palette:
    - scheme: default
      primary: indigo
      accent: indigo
      toggle:
        icon: material/brightness-7
        name: Switch to dark mode
    - scheme: slate
      primary: indigo
      accent: indigo
      toggle:
        icon: material/brightness-4
        name: Switch to light mode
  font:
    text: Roboto
    code: Roboto Mono
  features:
    - navigation.tabs
    - navigation.top
    - search.suggest
    - search.highlight

extra_css:
  - stylesheets/extra.css

markdown_extensions:
  - admonition
  - attr_list
  - md_in_html
  - pymdownx.details
  - pymdownx.superfences
  - pymdownx.tabbed:
      alternate_style: true
  - tables
  - toc:
      permalink: true

nav:
  - Home: index.md
  - Getting Started: getting-started.md
  - CLI:
    - Overview: cli/index.md
    - Commands: cli/commands.md
    - Supported Languages: cli/languages.md
  - AI Skills:
    - Overview: skills/index.md
    - Security Audit: skills/security-audit.md
    - Reachability Analysis: skills/reachability-analysis.md
    - Installation:
      - Overview: skills/installation/index.md
      - Claude Code: skills/installation/claude-code.md
      - Cursor: skills/installation/cursor.md
      - GitHub Copilot: skills/installation/copilot.md
      - Windsurf: skills/installation/windsurf.md
      - Cline: skills/installation/cline.md
      - Aider: skills/installation/aider.md
      - Continue.dev: skills/installation/continue.md
      - Gemini CLI: skills/installation/gemini.md
      - Codex CLI: skills/installation/codex.md
  - MCP Server:
    - Overview: mcp/index.md
    - Tools Reference: mcp/tools.md
    - Installation: mcp/installation.md
    - Supported Clients: mcp/clients.md
    - Prompts & Examples: mcp/prompts.md
  - FAQ: faq.md
```

- [ ] **Step 3: Create `docs/stylesheets/extra.css`**

```css
/* ── Homepage hero ── */
.hero {
  background: #f4f5fb;
  border: 1px solid #dde0f0;
  border-radius: 4px;
  padding: 1.6rem 2rem;
  margin-bottom: 2rem;
}

.hero .eyebrow {
  display: block;
  font-size: 0.7rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.09em;
  color: var(--md-primary-fg-color);
  opacity: 0.65;
  margin-bottom: 0.6rem;
}

.hero h1 {
  font-size: 1.6rem !important;
  font-weight: 300 !important;
  margin: 0 0 0.75rem !important;
  padding: 0 !important;
  border: none !important;
  color: var(--md-default-fg-color);
}

.hero p {
  color: var(--md-default-fg-color--light);
  margin: 0 0 1rem;
  max-width: 600px;
}

.hero-badges {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  margin-top: 0.75rem;
}

.hero-badges code {
  background: white;
  border: 1px solid #c8cef5;
  border-radius: 3px;
  padding: 0.15rem 0.55rem;
  font-size: 0.78rem;
  color: var(--md-primary-fg-color);
}

/* ── Ecosystem tags ── */
.eco-strip {
  display: flex;
  flex-wrap: wrap;
  gap: 0.4rem;
  margin-top: 0.75rem;
}

.eco-tag {
  background: #f0f2ff;
  border: 1px solid #c8cef5;
  border-radius: 3px;
  padding: 0.15rem 0.55rem;
  font-size: 0.75rem;
  color: var(--md-primary-fg-color);
  white-space: nowrap;
}

/* dark mode adjustments */
[data-md-color-scheme="slate"] .hero {
  background: hsla(var(--md-hue),15%,16%,1);
  border-color: hsla(var(--md-hue),15%,25%,1);
}
[data-md-color-scheme="slate"] .hero-badges code {
  background: hsla(var(--md-hue),15%,20%,1);
  border-color: hsla(var(--md-hue),15%,30%,1);
}
[data-md-color-scheme="slate"] .eco-tag {
  background: hsla(var(--md-hue),15%,18%,1);
  border-color: hsla(var(--md-hue),15%,28%,1);
}
```

- [ ] **Step 4: Create stub `docs/index.md` so the build can run**

```markdown
# Meterian AI

Coming soon.
```

- [ ] **Step 5: Create `.github/workflows/docs.yml`**

```yaml
name: Deploy documentation

on:
  push:
    branches:
      - main
  workflow_dispatch:

permissions:
  contents: write

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: 3.x
          cache: pip
      - run: pip install -r requirements-docs.txt
      - run: mkdocs gh-deploy --force
```

- [ ] **Step 6: Install deps locally and verify stub builds**

```bash
pip install -r requirements-docs.txt
mkdocs build --strict 2>&1 | tail -20
```

Expected: `INFO - Documentation built in X.X seconds` (warnings about missing nav pages are OK at this stage — `--strict` will error on those, so first run without it).

```bash
mkdocs build 2>&1 | tail -5
```

Expected: `INFO - Documentation built in X.X seconds`

- [ ] **Step 7: Commit**

```bash
git add mkdocs.yml requirements-docs.txt .github/workflows/docs.yml docs/stylesheets/extra.css docs/index.md
git commit -m "feat(docs): add MkDocs foundation — config, CI, custom CSS"
```

---

## Task 2: Homepage (`docs/index.md`)

**Files:**
- Modify: `docs/index.md`

- [ ] **Step 1: Write `docs/index.md`**

```markdown
<div class="hero" markdown>
<span class="eyebrow">Free &nbsp;·&nbsp; No account required</span>

# Security scanning for every developer workflow

Audit open-source dependencies for known vulnerabilities — from the command line,
through your AI coding assistant, or via the Model Context Protocol.
Covers 12+ ecosystems.

<div class="hero-badges" markdown>
`@meterian/cli` &nbsp;&nbsp; `@meterian/mcp` &nbsp;&nbsp; `9 AI tools supported`
</div>
</div>

## Choose your integration

Three ways to add Meterian security to your workflow — pick the one that fits your setup.

<div class="grid cards" markdown>

-   ⚡ **CLI**

    ---

    Audit any project from the command line. Batch-check all dependencies, look
    up individual packages, or find safe upgrade paths. Zero-install via npx — no
    global setup required.

    ```bash
    npx @meterian/cli check
    ```

    [:octicons-arrow-right-24: CLI documentation](cli/index.md)

-   🧠 **AI Skills**

    ---

    Your AI coding assistant automatically scans dependencies and suggests fixes —
    inline, as you work. Supports 9 tools including Claude Code, Cursor, and
    GitHub Copilot. Triggers automatically when you open a manifest file.

    ```
    meterian:security-audit
    ```

    [:octicons-arrow-right-24: AI Skills documentation](skills/index.md)

-   🔌 **MCP Server**

    ---

    Expose real-time vulnerability data to any MCP-compatible client. Ask your
    AI assistant about any library — it queries live advisory data, not a stale
    training set.

    ```bash
    npm install -g @meterian/mcp
    ```

    [:octicons-arrow-right-24: MCP Server documentation](mcp/index.md)

</div>

## How they relate

The CLI is the engine underneath everything. AI Skills teach your coding assistant
to invoke it directly. The MCP Server exposes the same vulnerability data as a
live protocol endpoint — without requiring any CLI installation on the client side.

```
Meterian Kiwi database
        │
        ▼
  @meterian/cli  ──────────────────────────┐
        │                                  │
        ▼                                  ▼
  AI Skills                          MCP Server
  (npx @meterian/cli)            (JSON-RPC 2.0 / MCP)
  9 coding assistants            Any MCP-compatible client
```

## Supported ecosystems

All three products cover the same 12+ languages and package managers.

<div class="eco-strip">
<span class="eco-tag">Node.js / npm</span>
<span class="eco-tag">Python / pip</span>
<span class="eco-tag">Java / Maven</span>
<span class="eco-tag">Java / Gradle</span>
<span class="eco-tag">Rust / Cargo</span>
<span class="eco-tag">PHP / Composer</span>
<span class="eco-tag">Ruby / Bundler</span>
<span class="eco-tag">Go modules</span>
<span class="eco-tag">.NET / NuGet</span>
<span class="eco-tag">C++ / Conan</span>
<span class="eco-tag">Dart / pub</span>
<span class="eco-tag">Clojure / Leiningen</span>
<span class="eco-tag">Swift PM</span>
</div>
```

- [ ] **Step 2: Verify build**

```bash
mkdocs build 2>&1 | tail -5
```

Expected: `INFO - Documentation built in X.X seconds`

- [ ] **Step 3: Commit**

```bash
git add docs/index.md
git commit -m "feat(docs): add homepage with hero, product cards, and ecosystem strip"
```

---

## Task 3: Getting Started (`docs/getting-started.md`)

**Files:**
- Create: `docs/getting-started.md`

- [ ] **Step 1: Create `docs/getting-started.md`**

```markdown
# Getting Started

Not sure which integration to use? Pick based on your setup.

---

## I use an AI coding assistant

**Claude Code, Cursor, GitHub Copilot, Windsurf, Cline, Aider, Continue.dev, Gemini CLI, or Codex CLI?**

→ Use **[AI Skills](skills/index.md)**.

The skill is a set of instructions that teaches your coding assistant to invoke
the Meterian CLI automatically. Once installed, it runs when you open a manifest
file and surfaces vulnerabilities inline, without leaving your editor.

**Prerequisite:** Node.js 18+ must be available in your terminal (the skill invokes
`npx @meterian/cli` under the hood).

[Install AI Skills :octicons-arrow-right-24:](skills/installation/index.md){ .md-button .md-button--primary }

---

## I use an MCP-compatible client

**Claude Desktop, Gemini CLI, Codex CLI, or any other MCP client?**

→ Use the **[MCP Server](mcp/index.md)**.

The standalone `@meterian/mcp` package registers a Model Context Protocol server
with your AI client. Once registered, your AI can query live vulnerability data
for any library without you having to run any CLI commands yourself.

[Install MCP Server :octicons-arrow-right-24:](mcp/installation.md){ .md-button .md-button--primary }

---

## I want direct command-line auditing

**No AI tooling — just a fast CLI audit from the terminal?**

→ Use the **[CLI](cli/index.md)**.

`npx @meterian/cli check` reads a JSON list of dependencies from stdin and returns
a vulnerability report. No account, no global install, no configuration.

[CLI documentation :octicons-arrow-right-24:](cli/index.md){ .md-button .md-button--primary }

---

## Can I use more than one?

Yes. A common setup is to use AI Skills for day-to-day development and the CLI
in CI pipelines. The MCP Server adds live lookups on top of either.
```

- [ ] **Step 2: Verify build**

```bash
mkdocs build 2>&1 | tail -5
```

Expected: no errors.

- [ ] **Step 3: Commit**

```bash
git add docs/getting-started.md
git commit -m "feat(docs): add Getting Started routing page"
```

---

## Task 4: CLI section (3 pages)

**Files:**
- Create: `docs/cli/index.md`
- Create: `docs/cli/commands.md`
- Create: `docs/cli/languages.md`

- [ ] **Step 1: Create `docs/cli/index.md`**

```markdown
# CLI — Overview

The Meterian CLI (`@meterian/cli`) is a command-line tool for auditing
open-source dependencies against the Meterian vulnerability database.

## Key features

- **Zero-install** — run via `npx @meterian/cli` without any global setup
- **No account required** — works out of the box
- **Batch auditing** — check all your dependencies in one call via `check`
- **Individual lookups** — query a single package with `advisories get`
- **Safe upgrade paths** — find the least-disruptive fix with `nextsafe`
- **12+ ecosystems** — Node.js, Python, Java, Rust, Go, and more

## Installation

=== "Zero-install (recommended)"

    ```bash
    npx @meterian/cli <command>
    ```

    No setup required. npx fetches the latest version on first use and caches it.

=== "Global install"

    ```bash
    npm install -g @meterian/cli
    ```

    After global install, use `meterian <command>` instead of `npx @meterian/cli <command>`.

## Quick example

```bash
echo '[{"language":"nodejs","name":"lodash","version":"4.17.15"}]' \
  | npx @meterian/cli check
```

## Next steps

- [Commands reference](../../cli/commands.md)
- [Supported languages](../../cli/languages.md)
```

- [ ] **Step 2: Create `docs/cli/commands.md`**

````markdown
# CLI — Commands

## check

Batch-audit a list of dependencies for known vulnerabilities.

**Input:** JSON array of `{"language", "name", "version"}` objects, read from stdin.

```bash
echo '[
  {"language":"nodejs","name":"lodash","version":"4.17.15"},
  {"language":"python","name":"requests","version":"2.25.0"}
]' | npx @meterian/cli check
```

**Output:** JSON object with:

- `vulnerable` — array of packages with known issues (empty if clean)
- `summary` — totals: `total`, `vulnerable`, `clean`

Each entry in `vulnerable` includes `safeVersions` ordered `[latestPatch, latestMinor, latestMajor]` (nulls excluded).

**Example output (vulnerable):**

```json
{
  "vulnerable": [
    {
      "language": "nodejs",
      "name": "lodash",
      "version": "4.17.15",
      "advisories": [
        {
          "id": "CVE-2021-23337",
          "severity": "HIGH",
          "title": "Command injection via template"
        }
      ],
      "safeVersions": ["4.17.21"]
    }
  ],
  "summary": { "total": 2, "vulnerable": 1, "clean": 1 }
}
```

---

## advisories get

Look up all known security advisories for a specific package version.

```bash
npx @meterian/cli advisories get <language> <name> <version>
```

**Example:**

```bash
npx @meterian/cli advisories get nodejs lodash 4.17.15
```

**Output:** JSON object with an `advisories` array. Each advisory includes id,
severity, title, description, and affected version range.

---

## nextsafe

Find the safest upgrade path for a vulnerable package.

```bash
npx @meterian/cli nextsafe <language> <name> <version>
```

**Example:**

```bash
npx @meterian/cli nextsafe nodejs lodash 4.17.15
```

**Output:**

```json
{
  "safe_versions": {
    "latestPatch": "4.17.21",
    "latestMinor": null,
    "latestMajor": null
  }
}
```

| Field | Meaning |
|-------|---------|
| `latestPatch` | Earliest safe version at same `major.minor` |
| `latestMinor` | Earliest safe version at same `major` |
| `latestMajor` | Latest safe version overall |

A `null` value means no safe version exists at that semver level.

---

## Environment variables

| Variable | Default | Description |
|----------|---------|-------------|
| `KIWI_BASE_URL` | `https://kiwi.meterian.io` | Override the advisory database endpoint |
````

- [ ] **Step 3: Create `docs/cli/languages.md`**

```markdown
# CLI — Supported Languages

All three Meterian products use the same language identifiers. Use the primary
value in the `language` field; aliases are also accepted.

| Ecosystem | Primary value | Accepted aliases |
|-----------|--------------|-----------------|
| Node.js / npm | `nodejs` | `javascript`, `npm` |
| Python | `python` | `pypi`, `pip` |
| Java (Maven) | `java` | `maven` |
| Java (Gradle) | `java` | `gradle` |
| PHP | `php` | `packagist`, `composer` |
| Ruby | `ruby` | `gem`, `bundler` |
| .NET | `dotnet` | `nuget`, `csharp` |
| Go | `golang` | `go` |
| Rust | `rust` | `cargo` |
| C / C++ | `cpp` | `conan` |
| Dart / Flutter | `dart` | `flutter`, `pub` |
| Clojure | `clojure` | `leiningen`, `clojars` |
| Swift | `swift` | `spm` |

## Manifest file mapping

| Manifest file | Language value |
|--------------|----------------|
| `package.json`, `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml` | `nodejs` |
| `requirements.txt`, `Pipfile`, `pyproject.toml`, `poetry.lock`, `uv.lock` | `python` |
| `pom.xml` | `java` |
| `build.gradle`, `build.gradle.kts` | `java` |
| `Cargo.toml`, `Cargo.lock` | `rust` |
| `composer.json`, `composer.lock` | `php` |
| `Gemfile`, `Gemfile.lock` | `ruby` |
| `go.mod`, `go.sum` | `golang` |
| `*.csproj` | `dotnet` |
| `conanfile.txt`, `conanfile.py` | `cpp` |
| `pubspec.yaml`, `pubspec.lock` | `dart` |
| `project.clj`, `deps.edn` | `clojure` |
| `Package.swift`, `Package.resolved` | `swift` |
```

- [ ] **Step 4: Verify build**

```bash
mkdocs build 2>&1 | tail -5
```

Expected: no errors.

- [ ] **Step 5: Commit**

```bash
git add docs/cli/
git commit -m "feat(docs): add CLI section — overview, commands, languages"
```

---

## Task 5: AI Skills overview + skill pages (3 pages)

**Files:**
- Create: `docs/skills/index.md`
- Create: `docs/skills/security-audit.md`
- Create: `docs/skills/reachability-analysis.md`

- [ ] **Step 1: Create `docs/skills/index.md`**

```markdown
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
```

- [ ] **Step 2: Create `docs/skills/security-audit.md`**

````markdown
# Security Audit

The `meterian:security-audit` skill audits your project's open-source dependencies
for known vulnerabilities and offers to fix them.

## What it does

### Mode A — Full project audit

When you ask "audit my dependencies", "scan this project", or simply open a
manifest file, the skill:

1. Finds all manifest files in the workspace
2. Reads each file and resolves exact installed versions (using lock files where
   available)
3. Sends all dependencies to the Meterian CLI in one batch call
4. Presents results as a table with severity, CVE ID, and safe versions

```
## Meterian Security Audit Report

| Package | Version | Severity | ID             | Safe Versions |
|---------|---------|----------|----------------|---------------|
| lodash  | 4.17.15 | HIGH     | CVE-2021-23337 | 4.17.21       |

Summary: 1 vulnerability found across 42 packages (41 clean).
```

If no vulnerabilities are found: `✅ No vulnerabilities detected across N packages.`

### Mode B — Ad-hoc query

Ask "Is express 4.17.1 safe?" or "What CVEs affect log4j 2.14.1?" — the skill
looks up that specific package and reports inline.

### Mode C — Remediation

After an audit, the skill offers to fix vulnerable packages:

- **Patch-level upgrades** are applied automatically
- **Minor or major upgrades** are shown first and require your confirmation

After applying fixes, the skill re-runs the audit to confirm all packages are clean.

## Auto-trigger manifest files

The skill activates automatically when you open or modify any of these files:

`package.json` · `package-lock.json` · `yarn.lock` · `pnpm-lock.yaml` ·
`requirements.txt` · `Pipfile` · `pyproject.toml` · `poetry.lock` · `uv.lock` ·
`pom.xml` · `build.gradle` · `build.gradle.kts` · `Cargo.toml` · `Cargo.lock` ·
`composer.json` · `composer.lock` · `Gemfile` · `Gemfile.lock` ·
`go.mod` · `go.sum` · `*.csproj` · `conanfile.txt` · `conanfile.py` ·
`pubspec.yaml` · `pubspec.lock` · `project.clj` · `deps.edn` ·
`Package.swift` · `Package.resolved`

## Relationship to Reachability Analysis

After finding vulnerabilities, the skill offers to run a
[Reachability Analysis](reachability-analysis.md) to determine which of them are
actually exploitable in your codebase.
````

- [ ] **Step 3: Create `docs/skills/reachability-analysis.md`**

```markdown
# Reachability Analysis

The `meterian:reachability-analysis` skill determines whether vulnerable
dependencies found by a security audit are actually reachable and exploitable
in your application source code.

!!! info
    This skill runs after a Security Audit that has found vulnerabilities. If no
    vulnerabilities were found, reachability analysis is not needed.

## Why reachability matters

A dependency can be vulnerable without your application being exploitable.
The vulnerable code path might be:

- Present in the package but never imported by your code
- Imported but never called in practice
- Callable only under specific configurations that don't apply to your deployment

Reachability Analysis classifies each finding so you can prioritise what to fix first.

## Workflow

The skill follows a 6-step process:

**Step 1 — Enrich** each vulnerable package using `npx @meterian/cli advisories get`
to identify the specific vulnerable function, symbol, or behaviour.

**Step 2 — Identify entry points** in your application: HTTP routes, API controllers,
CLI commands, serverless handlers, background jobs, queue consumers, etc.

**Step 3 — Search for usage** of each vulnerable package — imports, `require()` calls,
dependency injection bindings, framework auto-loading, and dynamic imports.

**Step 4 — Trace call paths** from entry points to the vulnerable behaviour,
considering attacker-controlled input and exploit preconditions.

**Step 5 — Classify** each finding using exactly one classification (see below).

**Step 6 — Assign priority** based on classification and impact.

## Classifications

| Classification | Meaning |
|----------------|---------|
| **Reachable** | Clear call path from entry point to vulnerable behaviour; attacker-controlled input can reach it |
| **Conditionally reachable** | Path exists but depends on configuration, feature flags, authentication, roles, or deployment conditions |
| **Loaded but not called** | Package is imported or initialised, but vulnerable behaviour is never invoked |
| **Present but not reachable** | Package is in the dependency tree but not loaded by your code |
| **Unknown** | Insufficient information — source code incomplete, advisory detail missing, or runtime behaviour unclear |

## Priority levels

| Priority | Condition |
|----------|-----------|
| **Critical** | Reachable, remotely triggerable, high impact |
| **High** | Reachable with realistic preconditions |
| **Medium** | Conditionally reachable |
| **Low** | Present but not reachable, with strong evidence |
| **Investigate** | Unknown or low confidence |

## Output

The skill produces a finding report for each vulnerability, followed by a summary table:

```
| Package | Version | CVE            | Classification            | Priority | Recommended Upgrade |
|---------|---------|----------------|---------------------------|----------|---------------------|
| lodash  | 4.17.15 | CVE-2021-23337 | Reachable                 | Critical | 4.17.21             |
| axios   | 0.21.0  | CVE-2021-10190 | Loaded but not called     | Low      | 1.6.0               |
| moment  | 2.18.0  | CVE-2022-24785 | Present but not reachable | Low      | 2.29.4              |
```

For reachable or conditionally reachable findings, the skill offers to run
remediation via the Security Audit skill (Mode C).
```

- [ ] **Step 4: Verify build**

```bash
mkdocs build 2>&1 | tail -5
```

Expected: no errors.

- [ ] **Step 5: Commit**

```bash
git add docs/skills/index.md docs/skills/security-audit.md docs/skills/reachability-analysis.md
git commit -m "feat(docs): add AI Skills overview, Security Audit, and Reachability Analysis pages"
```

---

## Task 6: AI Skills installation — Overview + Claude Code + Cursor + Copilot

**Files:**
- Create: `docs/skills/installation/index.md`
- Create: `docs/skills/installation/claude-code.md`
- Create: `docs/skills/installation/cursor.md`
- Create: `docs/skills/installation/copilot.md`

- [ ] **Step 1: Create `docs/skills/installation/index.md`**

```markdown
# AI Skills — Installation

Choose your AI coding assistant:

| Tool | Type | Install method |
|------|------|---------------|
| [Claude Code](claude-code.md) | CLI / IDE extension | Plugin marketplace (two commands) |
| [Cursor](cursor.md) | IDE | Plugin manager URL |
| [GitHub Copilot](copilot.md) | VS Code / JetBrains / CLI | Copy one file |
| [Windsurf](windsurf.md) | IDE | Copy rules directory |
| [Cline](cline.md) | VS Code extension | Copy `.clinerules` + `skills/` |
| [Aider](aider.md) | CLI | Copy config + `skills/` |
| [Continue.dev](continue.md) | VS Code / JetBrains | Copy rules directory |
| [Gemini CLI](gemini.md) | CLI | Copy two files |
| [Codex CLI](codex.md) | CLI | Copy `AGENTS.md` |

**Prerequisite for all tools:** Node.js 18+ must be available in the terminal
where your AI tool runs.
```

- [ ] **Step 2: Create `docs/skills/installation/claude-code.md`**

```markdown
# Install for Claude Code

Run these two commands in Claude Code:

```
/plugin marketplace add MeterianHQ/ai-skills
/plugin install meterian@meterian-ai-skills
/reload-plugins
```

That's it. The skills activate immediately. Open any manifest file to trigger
the Security Audit, or type `/meterian-security-audit` to run it manually.

## Verify

After `/reload-plugins`, type:

```
/skills
```

You should see `meterian:security-audit` and `meterian:reachability-analysis` in the list.
```

- [ ] **Step 3: Create `docs/skills/installation/cursor.md`**

```markdown
# Install for Cursor

In Cursor's plugin manager, point to the repository:

```
https://github.com/MeterianHQ/ai-skills
```

Cursor will fetch the plugin manifest from `.cursor-plugin/plugin.json` and
install the skills automatically.

## Verify

Open any `package.json`, `pom.xml`, or other manifest file. Cursor should
invoke the `meterian:security-audit` skill and begin scanning.
```

- [ ] **Step 4: Create `docs/skills/installation/copilot.md`**

```markdown
# Install for GitHub Copilot

Copy the instructions file into your project's `.github/` directory:

```bash
curl -o .github/copilot-instructions.md \
  https://raw.githubusercontent.com/MeterianHQ/ai-skills/main/.github/copilot-instructions.md
```

Or manually:

```bash
# from the ai-skills repo
cp .github/copilot-instructions.md your-project/.github/
```

GitHub Copilot reads `.github/copilot-instructions.md` automatically. No restart required.

## Verify

Open a manifest file in VS Code with Copilot active, or ask Copilot:

```
Audit my dependencies for vulnerabilities.
```

Copilot should invoke the Meterian CLI and return a vulnerability report.
```

- [ ] **Step 5: Verify build**

```bash
mkdocs build 2>&1 | tail -5
```

- [ ] **Step 6: Commit**

```bash
git add docs/skills/installation/
git commit -m "feat(docs): add AI Skills installation pages — overview, Claude Code, Cursor, Copilot"
```

---

## Task 7: AI Skills installation — Windsurf + Cline + Aider

**Files:**
- Create: `docs/skills/installation/windsurf.md`
- Create: `docs/skills/installation/cline.md`
- Create: `docs/skills/installation/aider.md`

- [ ] **Step 1: Create `docs/skills/installation/windsurf.md`**

```markdown
# Install for Windsurf

Copy the Windsurf rules directory into your project root:

```bash
cp -r .windsurf your-project/
```

Or clone the repository and symlink:

```bash
git clone https://github.com/MeterianHQ/ai-skills /tmp/ai-skills
ln -s /tmp/ai-skills/.windsurf your-project/.windsurf
```

Windsurf picks up rules from `.windsurf/rules/` automatically on next reload.

## Verify

Open a manifest file in Windsurf. The Security Audit skill should trigger.
```

- [ ] **Step 2: Create `docs/skills/installation/cline.md`**

```markdown
# Install for Cline

Copy both the rules file and the skills directory into your project root:

```bash
cp .clinerules your-project/
cp -r skills your-project/
```

Cline reads `.clinerules` and follows `!include` directives to load skill content
from the `skills/` directory.

## Verify

Open a manifest file in VS Code with Cline active. The Security Audit skill
should trigger automatically.
```

- [ ] **Step 3: Create `docs/skills/installation/aider.md`**

```markdown
# Install for Aider

Copy the config file and skills directory into your project root:

```bash
cp .aider.conf.yml your-project/
cp -r skills your-project/
```

Aider reads the `read:` entries in `.aider.conf.yml` on startup and loads the
skill content automatically.

## Verify

Start Aider from your project directory and ask:

```
Audit my dependencies for vulnerabilities.
```

Aider should invoke the Meterian CLI and return a report.
```

- [ ] **Step 4: Verify build**

```bash
mkdocs build 2>&1 | tail -5
```

- [ ] **Step 5: Commit**

```bash
git add docs/skills/installation/windsurf.md docs/skills/installation/cline.md docs/skills/installation/aider.md
git commit -m "feat(docs): add AI Skills install pages — Windsurf, Cline, Aider"
```

---

## Task 8: AI Skills installation — Continue.dev + Gemini CLI + Codex CLI

**Files:**
- Create: `docs/skills/installation/continue.md`
- Create: `docs/skills/installation/gemini.md`
- Create: `docs/skills/installation/codex.md`

- [ ] **Step 1: Create `docs/skills/installation/continue.md`**

```markdown
# Install for Continue.dev

Copy the rules directory into your project root:

```bash
cp -r .continue your-project/
```

Continue reads rule files from `.continue/rules/` and applies them based on the
`globs` and `alwaysApply` frontmatter settings in each file.

## Verify

Open a manifest file in VS Code or JetBrains with Continue active. The Security
Audit skill should trigger automatically.
```

- [ ] **Step 2: Create `docs/skills/installation/gemini.md`**

```markdown
# Install for Gemini CLI

Copy the two Gemini skill delivery files into your project root:

```bash
cp gemini-extension.json GEMINI.md your-project/
```

`GEMINI.md` uses `@`-include directives to load the skill content into Gemini
CLI's context automatically on startup. It is not project documentation — do not
edit it.

## Verify

Start Gemini CLI from your project directory and ask:

```
Audit my dependencies for vulnerabilities.
```
```

- [ ] **Step 3: Create `docs/skills/installation/codex.md`**

```markdown
# Install for Codex CLI

Copy `AGENTS.md` to your project root:

```bash
cp AGENTS.md your-project/
```

Like `GEMINI.md`, this is a skill delivery file — it uses `@`-include directives
to load the skill content into Codex CLI's context. It is not project documentation.

## Verify

Start Codex CLI from your project directory and ask:

```
Audit my dependencies for vulnerabilities.
```
```

- [ ] **Step 4: Verify full build with strict mode**

```bash
mkdocs build --strict 2>&1 | tail -10
```

Expected: `INFO - Documentation built in X.X seconds` — no warnings or errors now that all nav pages exist.

- [ ] **Step 5: Commit**

```bash
git add docs/skills/installation/continue.md docs/skills/installation/gemini.md docs/skills/installation/codex.md
git commit -m "feat(docs): add AI Skills install pages — Continue.dev, Gemini CLI, Codex CLI"
```

---

## Task 9: MCP Server — Overview + Tools Reference

**Files:**
- Create: `docs/mcp/index.md`
- Create: `docs/mcp/tools.md`

- [ ] **Step 1: Create `docs/mcp/index.md`**

```markdown
# MCP Server — Overview

The Meterian MCP Server (`@meterian/mcp`) is a standalone
[Model Context Protocol](https://modelcontextprotocol.io/) server that exposes
real-time vulnerability data to any MCP-compatible AI client.

## Why use the MCP Server?

AI assistants are pre-trained on a fixed dataset that becomes stale over time.
New vulnerabilities are discovered daily, and the model has no awareness of issues
found after its training cutoff. The Meterian MCP Server solves this by giving
your AI client a live connection to the Meterian advisory database.

Once registered, your AI can answer questions like:

- *"Is any of my project's dependencies currently vulnerable?"*
- *"What is the safest version I can upgrade axios to?"*
- *"List all critical vulnerabilities in this workspace."*

## How it works

The server communicates via stdin/stdout using the JSON-RPC 2.0 protocol
(MCP spec version 2024-11-05). It exposes two tools:

| Tool | Purpose |
|------|---------|
| [`advisories_get`](tools.md#advisories_get) | Return all known advisories for a specific library version |
| [`advisories_getnextsafe`](tools.md#advisories_getnextsafe) | Return safe upgrade versions for a vulnerable library |

## Relationship to the CLI

The MCP Server queries the same Meterian Kiwi database as the CLI. The difference
is delivery: the CLI is invoked directly from a shell; the MCP Server exposes the
same data as a protocol endpoint that any MCP client can call without shell access.

## Free tier

The MCP Server operates in Free mode by default, with access to the full
vulnerability database. Premium mode delivers expanded advisory details — contact
[support@meterian.io](mailto:support@meterian.io) for details.
```

- [ ] **Step 2: Create `docs/mcp/tools.md`**

````markdown
# MCP Server — Tools Reference

The Meterian MCP Server exposes two tools.

---

## advisories_get

Returns all known security advisories and license issues for a specific library version.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `language` | string | yes | Package manager (see [Supported Languages](../cli/languages.md)) |
| `name` | string | yes | Package name as published |
| `version` | string | yes | Library version to check |

**Example call:**

```json
{
  "tool": "advisories_get",
  "parameters": {
    "language": "nodejs",
    "name": "lodash",
    "version": "4.17.15"
  }
}
```

**Response:** JSON object with an `advisories` array. Each entry contains the
advisory ID, severity, title, description, and affected version range.

---

## advisories_getnextsafe

Returns the recommended safe upgrade versions for a vulnerable library.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `language` | string | yes | Package manager (see [Supported Languages](../cli/languages.md)) |
| `name` | string | yes | Package name as published |
| `version` | string | yes | Current (vulnerable) version |

**Example call:**

```json
{
  "tool": "advisories_getnextsafe",
  "parameters": {
    "language": "nodejs",
    "name": "lodash",
    "version": "4.17.15"
  }
}
```

**Response:**

```json
{
  "safe_versions": {
    "latestPatch": "4.17.21",
    "latestMinor": null,
    "latestMajor": null
  }
}
```

| Field | Meaning |
|-------|---------|
| `latestPatch` | Earliest safe version at the same `major.minor` — least disruptive fix |
| `latestMinor` | Earliest safe version at the same `major` |
| `latestMajor` | Latest safe version overall — most up-to-date fix |

A `null` value means no safe version exists at that semver level (e.g. the
vulnerability affects all versions of that major line).
````

- [ ] **Step 3: Verify build**

```bash
mkdocs build 2>&1 | tail -5
```

- [ ] **Step 4: Commit**

```bash
git add docs/mcp/index.md docs/mcp/tools.md
git commit -m "feat(docs): add MCP Server overview and tools reference"
```

---

## Task 10: MCP Server — Installation + Supported Clients + Prompts

**Files:**
- Create: `docs/mcp/installation.md`
- Create: `docs/mcp/clients.md`
- Create: `docs/mcp/prompts.md`

- [ ] **Step 1: Create `docs/mcp/installation.md`**

```markdown
# MCP Server — Installation

The standalone `@meterian/mcp` package installs and auto-registers the MCP
server with whichever supported AI CLI tools it finds on your machine.

## Quick install

```bash
npm install -g @meterian/mcp
```

After installation, run the registration script:

```bash
npx @meterian/mcp install
```

The installer detects Claude Code, Gemini CLI, and Codex CLI on your machine
and registers the server with each one automatically.

## Manual registration

If auto-registration does not work for your client, register manually:

=== "Claude Code"

    ```bash
    claude mcp add meterian-mcp -s user -- node $(npm root -g)/@meterian/mcp/dist/index.js
    ```

    If Claude Code does not reconnect automatically, open `/mcp` and select **Reconnect**.

=== "Gemini CLI"

    ```bash
    gemini mcp add meterian-mcp node $(npm root -g)/@meterian/mcp/dist/index.js --scope user
    ```

=== "Codex CLI"

    ```bash
    codex mcp add meterian-mcp -- node $(npm root -g)/@meterian/mcp/dist/index.js
    ```

=== "mcp-cli"

    Add to `~/.config/mcp/mcp_servers.json`:

    ```json
    {
      "meterian-mcp": {
        "command": "node",
        "args": ["<path-to-global-node-modules>/@meterian/mcp/dist/index.js"]
      }
    }
    ```

## VS Code users

If you use the [Meterian Security VS Code extension](https://marketplace.visualstudio.com/items?itemName=Meterian.meterian-security),
the MCP Server is bundled and registers automatically with VS Code Copilot,
Cursor, and Windsurf when the extension activates. The standalone package is
only needed for AI CLI tools or clients outside VS Code.

## Verify

Ask your AI client:

```
Are any of my project's dependencies currently vulnerable?
```

If the MCP Server is registered correctly, the client calls `advisories_get`
or initiates a full audit.
```

- [ ] **Step 2: Create `docs/mcp/clients.md`**

```markdown
# MCP Server — Supported Clients

| Client | Registration | Notes |
|--------|-------------|-------|
| Claude Code | Auto via installer, or manual `claude mcp add` | May need Reconnect on first use |
| Gemini CLI | Auto via installer, or manual `gemini mcp add` | |
| Codex CLI | Auto via installer, or manual `codex mcp add` | |
| VS Code Copilot | Automatic via VS Code extension | No standalone package needed |
| Cursor | Automatic via VS Code extension | No standalone package needed |
| Windsurf | Automatic via VS Code extension | No standalone package needed |
| mcp-cli | Manual config in `~/.config/mcp/mcp_servers.json` | |

Any other MCP-compatible client that supports stdio transport (JSON-RPC 2.0 /
MCP spec 2024-11-05) can be registered manually by pointing to the
`@meterian/mcp` entry point.

## VS Code extension vs standalone package

| | VS Code extension | Standalone `@meterian/mcp` |
|---|---|---|
| VS Code Copilot | ✅ Auto-registered | ✗ |
| Cursor | ✅ Auto-registered | ✗ |
| Windsurf | ✅ Auto-registered | ✗ |
| Claude Code | Via VS Code command | ✅ Auto via installer |
| Gemini CLI | Via VS Code command | ✅ Auto via installer |
| Codex CLI | Via VS Code command | ✅ Auto via installer |
| GitHub Copilot Cloud agents | ✗ | ✅ Required |
```

- [ ] **Step 3: Create `docs/mcp/prompts.md`**

```markdown
# MCP Server — Prompts & Examples

Example prompts to use with any MCP-compatible AI client once the Meterian
MCP Server is registered.

## Check for vulnerabilities

```
Are any of my project's dependencies currently vulnerable?
```

```
Scan all manifest files in this workspace for known security vulnerabilities.
```

## Get a safe upgrade version

```
What is the safest version I can upgrade axios to?
```

```
What's the next safe patch version for log4j 2.14.1?
```

## Triage by severity

```
List all critical and high severity vulnerabilities in this project.
```

```
Which of my dependencies have a CVSS score above 7?
```

## Targeted lookups

```
Is express@4.17.1 affected by any known vulnerabilities?
```

```
What CVEs affect org.springframework:spring-web at version 5.3.18?
```

## Automated remediation

**Patch-level fixes only:**

```
Using the Meterian MCP server, check all dependencies in this project for known
vulnerabilities. For each vulnerable dependency, get the next safe version and
apply a fix — but only if the safe version is a patch-level upgrade (same major
and minor version). Update the manifest files accordingly.
```

**Full remediation with approval:**

```
Audit all dependencies using the Meterian MCP server. Apply patch-level fixes
automatically. For minor and major version upgrades, show me the changes and ask
for confirmation before applying.
```
```

- [ ] **Step 4: Verify strict build**

```bash
mkdocs build --strict 2>&1 | tail -10
```

Expected: clean build, no warnings.

- [ ] **Step 5: Commit**

```bash
git add docs/mcp/installation.md docs/mcp/clients.md docs/mcp/prompts.md
git commit -m "feat(docs): add MCP Server installation, clients, and prompts pages"
```

---

## Task 11: FAQ

**Files:**
- Create: `docs/faq.md`

- [ ] **Step 1: Create `docs/faq.md`**

```markdown
# FAQ

## Do I need a Meterian account?

No. All three products — CLI, AI Skills, and MCP Server — work without an account
in Free mode, with full access to the vulnerability database.

## Is this free?

Yes. The CLI, AI Skills, and MCP Server are free and open source (MIT licence).
A Premium mode is available for organisations that need expanded advisory details
or SLA support — contact [support@meterian.io](mailto:support@meterian.io).

## What data is sent to Meterian?

The CLI and MCP Server send package names and versions to the Meterian Kiwi
advisory database to look up vulnerability information. No source code, no
file contents, and no personal data are transmitted.

## Which Node.js version is required?

Node.js 18 or later. This applies to both the CLI (`npx @meterian/cli`) and the
MCP Server (`@meterian/mcp`).

## Can I use AI Skills and the MCP Server together?

Yes. They serve different purposes. AI Skills teach your assistant to run full
project audits via the CLI (reading manifest files, batch-checking all
dependencies). The MCP Server gives your assistant a live lookup tool for
individual packages. Many users run both.

## The skill triggered but didn't find my manifest file

Make sure Node.js 18+ is available in the terminal where your AI tool runs.
Run `node --version` to check. If `npx` is not found, install Node.js from
[nodejs.org](https://nodejs.org).

## How do I report a bug or request a feature?

Open an issue on [GitHub](https://github.com/MeterianHQ/ai-skills/issues).
For security disclosures, email [security@meterian.io](mailto:security@meterian.io)
rather than opening a public issue.
```

- [ ] **Step 2: Final strict build**

```bash
mkdocs build --strict 2>&1
```

Expected: `INFO - Documentation built in X.X seconds` with no warnings or errors.

- [ ] **Step 3: Commit**

```bash
git add docs/faq.md
git commit -m "feat(docs): add FAQ page"
```

---

## Task 12: Enable GitHub Pages and deploy

**Files:**
- No new files — deployment only.

- [ ] **Step 1: Enable GitHub Pages in the repository settings**

Go to `https://github.com/MeterianHQ/ai-skills/settings/pages` and set:

- **Source:** Deploy from a branch
- **Branch:** `gh-pages` / `/ (root)`

Save. GitHub will show the Pages URL: `https://meterianhq.github.io/ai-skills/`

- [ ] **Step 2: Deploy manually via mkdocs**

```bash
mkdocs gh-deploy --force
```

Expected output ends with:
```
INFO - Your documentation should shortly be available at:
       https://meterianhq.github.io/ai-skills/
```

- [ ] **Step 3: Verify the site is live**

Open `https://meterianhq.github.io/ai-skills/` in a browser. Confirm:

- Homepage loads with hero section and three product cards
- Navigation tabs show: Home · Getting Started · CLI · AI Skills · MCP Server · FAQ
- Dark mode toggle works
- Search works (try "lodash")
- All three product card links navigate correctly

- [ ] **Step 4: Push all commits to trigger GitHub Actions on future pushes**

```bash
git push origin main
```

Verify the Actions workflow runs at `https://github.com/MeterianHQ/ai-skills/actions`
and the `docs.yml` job completes successfully.

- [ ] **Step 5: Final commit (update README with site link)**

Edit `README.md` — add the docs URL near the top:

```markdown
**Documentation:** https://meterianhq.github.io/ai-skills/
```

```bash
git add README.md
git commit -m "docs: add GitHub Pages site link to README"
git push origin main
```

---

## Self-review

**Spec coverage check:**

| Spec requirement | Task |
|-----------------|------|
| MkDocs + Material, indigo palette, Roboto fonts | Task 1 |
| GitHub Pages via `docs/` on `main` | Task 1, 12 |
| GitHub Actions build + deploy | Task 1 |
| Homepage: hero (light tint, "Free · No account required"), 3 product cards, architecture, ecosystem strip | Task 2 |
| Getting Started routing page | Task 3 |
| CLI: Overview, Commands, Supported Languages | Task 4 |
| AI Skills: Overview, Security Audit, Reachability Analysis | Task 5 |
| AI Skills: 9 per-tool installation pages | Tasks 6–8 |
| MCP: Overview, Tools Reference, Installation, Supported Clients, Prompts | Tasks 9–10 |
| FAQ | Task 11 |
| Sidebar: plain text labels, no emoji | mkdocs.yml nav in Task 1 |
| Product icons (⚡🧠🔌) only in homepage cards | Task 2 |
| Content for MCP section adapted from VS Code extension site | Tasks 9–10 |

**No placeholders:** All pages contain complete content. ✓

**Type consistency:** No cross-task references to undefined functions or types (this is a docs-only project). ✓
