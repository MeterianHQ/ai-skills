# Meterian Reachability Analysis

Determine whether vulnerable dependencies found by a security audit are actually exploitable in the application.

## Input

Use the vulnerable package list from the most recent Meterian security audit result in the current conversation (language, name, version, CVE/advisory ID, safeVersions).

If no audit result is present in the conversation, run a full dependency audit first (see `security-audit` rules), then return here and proceed.
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

- HTTP routes
- API controllers
- GraphQL resolvers
- RPC handlers
- CLI commands
- serverless handlers
- background jobs
- queue consumers
- scheduled tasks
- startup hooks
- plugin loaders
- file upload handlers
- parsers
- deserializers
- template rendering paths
- auth, crypto, archive, XML, YAML, JSON, PDF, image, and document processing code

### Step 3: Search for package usage

For each vulnerable dependency, search for:

- direct imports and `require()` calls — use the patterns below
- dynamic imports
- dependency injection bindings
- service registration
- reflection
- framework auto-loading
- plugin declarations
- config references
- transitive use through direct dependencies
- vulnerable symbol names, function names, or class names

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

Exclude these directories from all searches: `node_modules`, `.git`, `dist`, `build`, `vendor`, `.venv`, `target`.

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

Use exactly one of:

#### Reachable

There is a clear call path from an application entry point to the vulnerable behavior, and attacker-controlled or untrusted input can plausibly reach it.

#### Conditionally reachable

A path exists, but exploitation depends on configuration, feature flags, optional modules, plugins, specific file types, authentication, roles, or deployment conditions.

#### Loaded but not called

The vulnerable package or module is imported, initialized, or autoloaded, but there is no evidence that the vulnerable behavior is invoked.

#### Present but not reachable

The vulnerable package exists in the dependency tree, but there is no evidence that it is loaded or that vulnerable behavior is invoked.

#### Unknown

There is not enough information to determine reachability. Use when source code, generated code, advisory detail, dependency paths, or runtime behaviour are incomplete.

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

- Language: <language>
- Package: <name>
- Installed version: <version>
- Meterian severity: <severity>
- Safe versions: <safeVersions>
- Recommended upgrade: <version or "none — see mitigation">
- Direct/transitive: <direct | transitive | unknown>
- Vulnerable behavior: <symbol, function, module, or behavior>

### Reachability Verdict

- Classification: <Reachable | Conditionally reachable | Loaded but not called | Present but not reachable | Unknown>
- Confidence: <High | Medium | Low>
- Priority: <Critical | High | Medium | Low | Investigate>

### Evidence

- Package presence:
- Imports/references:
- Vulnerable symbol references:
- Entry point:
- Call path:
- User-controlled input path:
- Relevant configuration:
- Runtime assumptions:

### Analysis

Explain why this is reachable, conditionally reachable, not reachable, or unknown.

### Recommended Action

- Upgrade:
- Mitigation:
- Validation test:
- Suppression/acceptance note, if justified:
```

After all findings, produce a summary table:

```markdown
## Summary

| Package | Version | CVE | Classification | Priority | Recommended Upgrade |
|---------|---------|-----|---------------|---------|---------------------|
| lodash  | 4.17.15 | CVE-2021-23337 | Reachable                 | Critical | 4.17.21 |
| axios   | 0.21.0  | CVE-2021-10190 | Loaded but not called     | Low      | 1.6.0   |
| moment  | 2.18.0  | CVE-2022-24785 | Present but not reachable | Low      | 2.29.4  |
```

If any finding is Reachable or Conditionally reachable, ask:

> "Would you like me to proceed with remediation for the reachable vulnerabilities?"

If yes, run the Meterian Security Audit remediation mode (Mode C) for those packages only.

## Rules

- Do not mark a dependency reachable just because Meterian reported it.
- Do not mark a dependency unreachable just because there is no direct import.
- Check framework auto-loading, plugins, reflection, dependency injection, serializers, parsers, template engines, file processors, generated code, and startup hooks.
- Distinguish package presence from vulnerable behavior reachability.
- Prefer source-code evidence over assumptions.
- State uncertainty clearly.
- Do not suppress or downgrade a finding without evidence.

## Error Handling

- **`advisories get` returns no data:** Fall back to web search for function-level detail. If web search also yields nothing, classify as Unknown with Evidence noting "No advisory detail available for <CVE-ID>".
- **Source file cannot be read (permissions):** Classify as Unknown; set Evidence to "Could not read source files — check file permissions".
- **No source files found in workspace:** Classify all findings as Unknown; output "⚠️ No source files found in workspace — reachability analysis requires readable application source code." before the findings.
