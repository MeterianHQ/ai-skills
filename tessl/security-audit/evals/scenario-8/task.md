# Security Audit: .NET Payment API

## Problem/Feature Description

A .NET 5 web API (`inputs/PaymentApi.csproj`) is being assessed as part of a vendor security questionnaire. The client requires evidence that all NuGet package dependencies have been screened for known vulnerabilities. The project file contains all pinned package references.

The development team hasn't performed a formal dependency audit since the project was scaffolded. Given the sensitive nature of the data it handles, the security team wants a written vulnerability report before signing the vendor agreement.

## Output Specification

Audit all NuGet packages referenced in the project and save the findings to `security-report.md`. Include each package name and version checked, flag any vulnerabilities with severity and identifiers, and provide a summary.
