# Security Audit: .NET Payment API

## Problem/Feature Description

A .NET 5 solution needs a full dependency vulnerability audit before a vendor agreement can be finalised. The security team requires a scan of all NuGet packages across the entire solution for known CVEs, so they can assess risk and provide a remediation path if needed. The `inputs/` directory contains the project files for the solution.

The development team hasn't run a dependency audit since the project was scaffolded. Given the sensitive nature of the data it handles, produce a written vulnerability report before the security sign-off deadline.

## Output Specification

Audit all NuGet packages referenced across all project files in `inputs/` and save the findings to `security-report.md`. Include each package name and version checked, flag any vulnerabilities with severity and identifiers, and provide a summary.

Also save the raw scan data to `scan-raw.json`.
