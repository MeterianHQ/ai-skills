---
name: Meterian Security Audit
description: Audit open-source dependencies for vulnerabilities and offer remediation
globs: ["package.json", "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "requirements.txt", "Pipfile", "pyproject.toml", "poetry.lock", "uv.lock", "pom.xml", "Cargo.toml", "Cargo.lock", "go.mod", "go.sum", "Gemfile", "Gemfile.lock", "composer.json", "composer.lock", "build.gradle", "build.gradle.kts", "*.csproj", "pubspec.yaml", "pubspec.lock", "conanfile.txt", "conanfile.py", "project.clj", "deps.edn", "Package.swift", "Package.resolved"]
alwaysApply: false
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

1. Find all manifest files in the workspace (search for the filenames in the table above)
2. Read each manifest file and extract all direct dependencies with their pinned versions

   Note: If a manifest uses version ranges (e.g. `^4.17.0`, `>=2.0`) rather than pinned versions, prefer the corresponding lock file (e.g. `package-lock.json`, `yarn.lock`, `poetry.lock`) to resolve the exact installed version. If no lock file is available, use the minimum bound of the range as the version to check.

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

5. If any vulnerabilities were found, offer remediation (see Mode C below)

6. After offering remediation (step 5) but before applying any fixes, if any vulnerabilities were found, ask:
   > "Would you like me to also run a reachability analysis to determine which of these vulnerabilities are actually exploitable in your codebase?"
   - If yes → apply the `meterian-reachability` rules, including the list of vulnerable packages (name, version, CVE ID)
   - If no → end the audit flow

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
2. Determine the bump level from the selected version:
   - **Patch** (x.y.Z → x.y.Z'): apply automatically
   - **Minor** (x.Y.z → x.Y'.z) or **Major** (X.y.z → X'.y.z): show the proposed change and ask for confirmation before applying

Use the best remediation approach for the ecosystem — this may mean editing the manifest file directly, running a package manager command (e.g. `npm install lodash@4.17.21`), or both.

After applying all fixes, re-run the full audit (Mode A). If new vulnerabilities are found, repeat the remediation cycle. If all are clean, output: "✅ All packages are now clean."

After remediating, always remind the user to re-run their package manager if lock files may be out of date:
- npm: `npm install`
- yarn: `yarn install`
- pnpm: `pnpm install`
- pip: `pip install -r requirements.txt`
- cargo: `cargo update`
- go: `go mod tidy`
- maven: `mvn install`
- gradle: `gradle build`
- composer: `composer install`
- bundler: `bundle install`
- dotnet: `dotnet restore`
- conan: `conan install .`
- pub/flutter: `flutter pub get` or `dart pub get`
- leiningen: `lein deps`
- swift: `swift package resolve`
