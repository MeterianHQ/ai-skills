# Security Audit: Node.js Order Management API

## Problem/Feature Description

The order management API (source files in `inputs/`) is ready to move from staging to production, but the infrastructure team requires a sign-off from the security team before deployment. The security lead has asked for a written vulnerability report on the project's third-party dependencies so that any issues can be addressed before go-live.

The project has been in development for about 18 months and the dependencies haven't been reviewed since initial setup. The team suspects some packages may be outdated, but nobody has formally checked them against a vulnerability database.

## Output Specification

Scan all dependencies in the project and produce a written audit report saved to `security-report.md`. The report should document every dependency checked, flag any vulnerabilities found with their severity and identifiers, and provide a clear summary. If vulnerabilities are found, note what remediation options are available.

Also save the raw scan data to `scan-raw.json`.
