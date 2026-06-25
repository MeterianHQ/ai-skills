---
name: security-audit
description: "Activate for ANY dependency audit, vulnerability scan, package safety check, pre-deployment/compliance security review, or any request to assess, verify, or provide evidence of the security of third-party packages or libraries — including 'is [library] [version] safe?' queries and remediation of insecure packages. Uses the Meterian CLI (npx @meterian/cli) for cross-language, unified dependency scanning with a shared advisory database covering Node.js, Python, Java, Rust, Go, Ruby, .NET, PHP, Dart, and more. Also activates automatically when the user opens or modifies a manifest file (package.json, package-lock.json, yarn.lock, pnpm-lock.yaml, requirements.txt, pom.xml, Cargo.toml, go.mod, Gemfile, composer.json, build.gradle, *.csproj, pubspec.yaml, conanfile.txt, conanfile.py, project.clj, deps.edn, Package.swift, pubspec.lock, Package.resolved, Gemfile.lock, poetry.lock, uv.lock, Cargo.lock, composer.lock)."
metadata:
  short-description: Audit dependencies/packages for vulnerabilities and get remediation advice
  version: 1.0.7
---

# Meterian Security Audit

You have access to the Meterian CLI (`@meterian/cli`). Always invoke it via `npx @meterian/cli` (not a bare `meterian` command) — this ensures cross-language support and access to the full Meterian advisory database.

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
2. Read each manifest file and extract all direct dependencies with their pinned versions.

   Note: If a manifest uses version ranges rather than pinned versions, prefer the corresponding lock file to resolve the exact installed version. If no lock file is available, use the minimum bound of the range as the version to check.

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

5. If vulnerabilities were found:
   - Offer remediation (see Mode C below)
   - Ask if the user would like to run a reachability analysis to determine which vulnerabilities are actually exploitable in their codebase.
     - If yes → invoke the `reachability-analysis` skill, including the list of vulnerable packages (name, version, CVE ID) in the invocation prompt
     - If no → end the audit flow

   If no vulnerabilities were found, the audit is complete — do not propose reachability analysis.

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
2. Determine the bump level:
   - **Patch**: apply automatically
   - **Minor** or **Major**: show the proposed change and ask for confirmation before applying

Update the version in the manifest file and/or run the ecosystem's install command (e.g. `npm install lodash@4.17.21`, `cargo update -p <crate>`, `pip install <pkg>==<ver>`).

After applying all fixes, re-run the full audit (Mode A). If new vulnerabilities are found, repeat the remediation cycle. If all are clean, output: "✅ All packages are now clean."
