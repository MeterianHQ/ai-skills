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
