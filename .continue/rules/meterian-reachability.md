---
name: Meterian Reachability Analysis
description: Classify vulnerable dependencies by reachability after a security audit
alwaysApply: false
---

# Meterian Reachability Analysis

Determine whether vulnerable dependencies found by a security audit are actually exploitable in the application.

## Input

Use the vulnerable package list from the most recent Meterian security audit result in the current conversation (language, name, version, CVE/advisory ID, safeVersions).

If no audit result is present in the conversation, run a full dependency audit first (see `meterian-security-audit` rules), then return here and proceed.
If the audit finds no vulnerabilities, report that reachability analysis is not needed and stop.

## Workflow

### Step 1: Enrich each vulnerable package

For each vulnerable package from the audit, run:

```bash
npx @meterian/cli advisories get <language> <name> <version>
```

Use the advisory output to identify the vulnerable behavior, symbol, function, class, parser, serializer, protocol handler, or affected feature.

If `advisories get` does not identify specific functions or symbols, supplement with a web search: `<CVE-ID> <package-name> affected function`. If the advisory ID is not a CVE (e.g. a GHSA or internal ID), use: `<package-name> <version> security vulnerability affected function`.

For safe version recommendations, use the `safeVersions` array from the audit output. Prefer in order:
1. `latestPatch`
2. `latestMinor`
3. `latestMajor`
4. If no safe version exists, recommend mitigation or replacement.

### Step 2: Identify application entry points

Search for execution entry points, including:

- HTTP routes, API controllers, GraphQL resolvers, RPC handlers
- CLI commands, serverless handlers, background jobs, queue consumers
- Scheduled tasks, startup hooks, plugin loaders
- File upload handlers, parsers, deserializers, template rendering paths
- Auth, crypto, archive, XML, YAML, JSON, PDF, image, and document processing code

### Step 3: Search for package usage

For each vulnerable dependency, search for direct imports and `require()` calls, dynamic imports, dependency injection bindings, service registration, reflection, framework auto-loading, plugin declarations, config references, transitive use through direct dependencies, and vulnerable symbol/function/class names.

**Language-specific import patterns** (replace `NAME` with the package name):

| Language | Search patterns |
|----------|----------------|
| nodejs | `require('NAME')`, `require("NAME")`, `from 'NAME'`, `from "NAME"`, `import NAME` |
| python | `import NAME`, `from NAME import` |
| java | `import NAME.`, `import com.NAME` |
| rust | `use NAME::`, `extern crate NAME` |
| php | `use NAME\`, `require 'NAME'`, `require "NAME"` |
| ruby | `require 'NAME'`, `require "NAME"` |
| golang | `"NAME"` (inside an import block) ¹ |
| dotnet | `using NAME;` |

¹ golang: string matching inside import blocks may produce false positives — verify matches manually.

Exclude: `node_modules`, `.git`, `dist`, `build`, `vendor`, `.venv`, `target`.

### Step 4: Trace reachability

For each finding, answer:

1. Is the package present in the resolved dependency set?
2. Is it direct or transitive?
3. Is it imported, loaded, autoloaded, or initialized?
4. Is the vulnerable behavior actually called?
5. Is there a path from an application entry point to the vulnerable behavior?
6. Can attacker-controlled or untrusted input reach that path?
7. Are exploit preconditions met?
8. Is the feature enabled in production?

### Step 5: Classify each finding

- **Reachable**: clear call path from entry point to vulnerable behavior, attacker input can reach it
- **Conditionally reachable**: path exists but exploitation depends on config, flags, auth, or deployment conditions
- **Loaded but not called**: package is imported/initialized but vulnerable behavior is not invoked
- **Present but not reachable**: package exists in dependency tree but is not loaded or called
- **Unknown**: insufficient information — source code, advisory detail, or runtime behavior incomplete

### Step 6: Assign priority

- `Critical`: reachable, remotely triggerable, high impact
- `High`: reachable with realistic preconditions
- `Medium`: conditionally reachable
- `Low`: present but not reachable, with strong evidence
- `Investigate`: unknown or low confidence

## Output Format

For each finding, produce:

```markdown
## Finding: <advisory-id> — <package>

- Language / Package / Installed version / Meterian severity / Safe versions
- Recommended upgrade / Direct or transitive / Vulnerable behavior

### Reachability Verdict
- Classification: <one of the five above>
- Confidence: High | Medium | Low
- Priority: Critical | High | Medium | Low | Investigate

### Evidence
- Package presence / Imports / Vulnerable symbol references
- Entry point / Call path / User-controlled input path
- Relevant configuration / Runtime assumptions

### Analysis
Explain why this is reachable, conditionally reachable, not reachable, or unknown.

### Recommended Action
- Upgrade / Mitigation / Validation test / Suppression note if justified
```

After all findings, produce a summary table:

| Package | Version | CVE | Classification | Priority | Recommended Upgrade |

If any finding is Reachable or Conditionally reachable, ask whether to proceed with remediation for those packages.

## Rules

- Do not mark a dependency reachable just because Meterian reported it.
- Do not mark a dependency unreachable just because there is no direct import.
- Check framework auto-loading, plugins, reflection, DI, serializers, parsers, template engines, file processors, generated code, and startup hooks.
- Prefer source-code evidence over assumptions. State uncertainty clearly.
- Do not suppress or downgrade a finding without evidence.

## Error Handling

- **`advisories get` returns no data:** Fall back to web search. If nothing found, classify as Unknown.
- **Source file cannot be read:** Classify as Unknown; note "Could not read source files — check file permissions".
- **No source files found:** Classify all findings as Unknown; output warning before findings.
