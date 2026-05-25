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
