# Security Audit: .NET Payment API

## Problem/Feature Description

A .NET 5 solution is being assessed as part of a vendor security questionnaire. The client requires evidence that all NuGet package dependencies across the entire solution have been screened for known vulnerabilities. The `inputs/` directory contains the project files for the solution.

The development team hasn't performed a formal dependency audit since the project was scaffolded. Given the sensitive nature of the data it handles, the security team wants a written vulnerability report before signing the vendor agreement.

## Output Specification

Audit all NuGet packages referenced across all project files in `inputs/` and save the findings to `security-report.md`. Include each package name and version checked, flag any vulnerabilities with severity and identifiers, and provide a summary.

Also save the raw scan data to `scan-raw.json`.
