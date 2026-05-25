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

   Note: If a manifest uses version ranges (e.g. `^4.17.0`, `>=2.0`) rather than pinned versions, prefer the corresponding lock file to resolve the exact installed version. If no lock file is available, use the minimum bound of the range.

3. Build a JSON array of `{language, name, version}` objects and pipe it to the CLI:

```bash
echo '<json-array>' | npx @meterian/cli check
```

4. Present the JSON report as a markdown table with columns: Package, Version, Severity, ID, Safe Versions.

   If `vulnerable` is empty, output: "✅ No vulnerabilities detected across N packages."

5. If vulnerabilities were found:
   - Offer remediation (see Mode C below)
   - Before applying any fixes, ask:
     > "Would you like me to also run a reachability analysis to determine which of these vulnerabilities are actually exploitable in your codebase?"
     - If yes → apply the Meterian Reachability Analysis instructions below, including the list of vulnerable packages (name, version, CVE ID)
     - If no → end the audit flow

   If no vulnerabilities were found, the audit is complete — do not propose reachability analysis.

## Mode B — Ad-hoc Security Query

When asked "is [library] [version] safe?" or similar:

1. Identify the library name, version, and language
2. Run: `npx @meterian/cli advisories get <language> <name> <version>`
3. Report findings inline with severity, id, and description

## Mode C — Remediation

For each vulnerable dependency:

1. The `check` output contains `safeVersions` — an array ordered `[latestPatch, latestMinor, latestMajor]`. Select the first (least-disruptive) entry.
2. Patch bumps: apply automatically. Minor or Major bumps: show the proposed change and confirm before applying.

Use the best remediation approach for the ecosystem (edit manifest, run package manager command, or both). After all fixes, re-run Mode A. Repeat until clean.

After remediating, remind the user to re-run their package manager to update lock files.

---

# Meterian Reachability Analysis

Determine whether vulnerable dependencies found by the audit above are actually exploitable in the application.

## Input

Use the vulnerable package list from the most recent audit in the conversation. If no audit result exists, run Mode A first, then proceed.

## Workflow

### Step 1: Enrich each vulnerable package

Run `npx @meterian/cli advisories get <language> <name> <version>` for each package. Identify the vulnerable behavior, symbol, function, or affected feature.

If `advisories get` does not identify specific functions, supplement with a web search: `<CVE-ID> <package-name> affected function`.

### Step 2: Identify application entry points

Search for: HTTP routes, API controllers, GraphQL resolvers, RPC handlers, CLI commands, serverless handlers, background jobs, queue consumers, scheduled tasks, startup hooks, plugin loaders, file upload handlers, parsers, deserializers, template rendering, auth/crypto/archive/XML/YAML/JSON/PDF processing.

### Step 3: Search for package usage

For each vulnerable dependency, search for direct imports, `require()` calls, dynamic imports, DI bindings, service registration, reflection, framework auto-loading, plugin declarations, and vulnerable symbol/function/class names.

| Language | Search patterns |
|----------|----------------|
| nodejs | `require('NAME')`, `from 'NAME'`, `import NAME` |
| python | `import NAME`, `from NAME import` |
| java | `import NAME.`, `import com.NAME` |
| rust | `use NAME::`, `extern crate NAME` |
| php | `use NAME\`, `require 'NAME'` |
| ruby | `require 'NAME'` |
| golang | `"NAME"` (inside import block) — verify manually to avoid false positives |
| dotnet | `using NAME;` |

Exclude: `node_modules`, `.git`, `dist`, `build`, `vendor`, `.venv`, `target`.

### Step 4: Trace reachability

For each finding, answer: Is the package present? Direct or transitive? Imported/loaded? Vulnerable behavior called? Entry-point-to-behavior path exists? Attacker input reachable? Preconditions met? Enabled in production?

### Step 5: Classify

- **Reachable**: clear call path, attacker input can reach vulnerable behavior
- **Conditionally reachable**: path exists but depends on config, flags, auth, or deployment
- **Loaded but not called**: imported/initialized, vulnerable behavior not invoked
- **Present but not reachable**: in dependency tree, not loaded or called
- **Unknown**: insufficient information

### Step 6: Assign priority

`Critical` (reachable, remotely triggerable) · `High` (reachable with preconditions) · `Medium` (conditionally reachable) · `Low` (not reachable, strong evidence) · `Investigate` (unknown)

## Output Format

For each finding: advisory ID, package, version, severity, safe versions, classification, confidence, priority, evidence (package presence, imports, symbol references, entry point, call path, input path, config, runtime assumptions), analysis, and recommended action (upgrade, mitigation, validation test).

After all findings, produce a summary table: Package | Version | CVE | Classification | Priority | Recommended Upgrade.

If any finding is Reachable or Conditionally reachable, ask whether to proceed with remediation for those packages.

## Rules

- Do not mark reachable just because Meterian reported it; do not mark unreachable just because there is no direct import.
- Check auto-loading, plugins, reflection, DI, serializers, parsers, template engines, generated code, startup hooks.
- Prefer source-code evidence. State uncertainty clearly. Never suppress without evidence.
