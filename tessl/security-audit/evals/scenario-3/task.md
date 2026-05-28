# Full-Stack Application Security Audit

## Problem/Feature Description

A platform team manages a full-stack application with three independently developed components, all stored in the `inputs/` directory: a React frontend dashboard (`package.json`), a Rust analytics engine (`Cargo.toml`), and a Python ML pipeline (`requirements.txt`). Before the quarterly release, the CISO has mandated a dependency security audit across all three components in a single report.

The team currently has no automated scanning in place, so this will be the first comprehensive security check for the entire stack. The goal is to produce one unified vulnerability report covering every component.

## Output Specification

Audit all dependencies across all components and produce a single report saved to `security-report.md`. The report should cover packages from all three components, identify any vulnerabilities, and include a summary of findings.
