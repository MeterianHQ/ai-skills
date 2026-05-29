---
name: security-audit
description: Use when auditing project dependencies for vulnerabilities, answering "is [library] [version] safe?" questions, or remediating vulnerable libraries. Scans manifest files for known vulnerabilities, suggests safe version upgrades, and generates a vulnerability report. Also activates automatically when the user opens or modifies a manifest file (package.json, package-lock.json, yarn.lock, pnpm-lock.yaml, requirements.txt, pom.xml, Cargo.toml, go.mod, Gemfile, composer.json, build.gradle, *.csproj, pubspec.yaml, conanfile.txt, conanfile.py, project.clj, deps.edn, Package.swift, pubspec.lock, Package.resolved, Gemfile.lock, poetry.lock, uv.lock, Cargo.lock, composer.lock).
metadata:
  short-description: Audit dependencies for vulnerabilities and get remediation advice
  version: 1.0.0
---

# Meterian Security Audit

You have access to the Meterian CLI (`@meterian/cli`). Invoke it via `npx @meterian/cli` (zero-install) or `meterian` if globally installed.

## Language Parameter Reference

Always use the following mapping to determine the `language` parameter:

| Manifest file | language |
|---|---|
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

## Mode A — Full Dependency Audit

When asked to audit, scan, or check all dependencies:

1. Find all manifest files in the workspace using Glob (search for the filenames in the Language Parameter Reference table above)
2. Read each manifest file and extract all direct dependencies with their pinned versions. Prefer lock files over manifests with version ranges; if no lock file exists, use the minimum bound of the range.

3. Build a JSON array of `{language, name, version}` objects and pipe it to the CLI:

```bash
echo '<json-array>' | npx @meterian/cli check
```

4. The CLI returns a compact JSON report. Present it as a markdown table:

```
## Meterian Security Audit Report

| Package | Version | Severity | ID | Safe Versions |
|---------|---------|----------|----|---------------|
| lodash  | 4.17.15 | HIGH     | CVE-2021-23337 | 4.17.21 |
...

**Summary:** X vulnerabilities found across Y packages (Z clean).
```

If `vulnerable` is empty, output: "✅ No vulnerabilities detected across N packages."

5. If vulnerabilities are present, always include in the report or response: a note that reachability analysis is available to determine which vulnerabilities are actually exploitable, and an offer to run it. If yes, invoke `reachability-analysis` with vulnerable packages (name, version, CVE ID). Always offer remediation guidance (Mode C).

## Mode B — Ad-hoc Security Query

When asked "is [library] [version] safe?" or similar:

1. Identify the library name and version from the question
2. Determine the language from context (file open in editor, explicit mention, or ask the user)
3. Run:

```bash
npx @meterian/cli advisories get <language> <name> <version>
```

4. Report findings inline: list each advisory with its severity, id, and description

## Mode C — Remediation

For each vulnerable dependency:

1. The `check` output already contains `safeVersions` — an array ordered `[latestPatch, latestMinor, latestMajor]` (nulls excluded). Select the first (least-disruptive) entry.
2. Apply patch bumps automatically. For minor or major bumps, show the proposed change and ask for confirmation before applying.

Update the version in the manifest file and/or run the ecosystem's install command (e.g. `npm install lodash@4.17.21`, `cargo update -p <crate>`, `pip install <pkg>==<ver>`).

After applying all fixes, re-run the full audit (Mode A). If new vulnerabilities are found, repeat the remediation cycle. If all are clean, output: "✅ All packages are now clean."

After remediating, always remind the user to re-run their ecosystem's install/sync command if lock files may be out of date (e.g. `npm install`, `pip install -r requirements.txt`, `cargo update`, `go mod tidy`).
