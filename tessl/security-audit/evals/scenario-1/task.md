# Security Audit: Python Data Processing Service

## Problem/Feature Description

A Python-based data processing service handles sensitive customer records and is being evaluated before it can be granted access to production data. The compliance team requires a security audit of the service's third-party dependencies as part of the data-handling approval process.

The project directory (`inputs/`) contains the Python dependency specifications. The team needs a formal vulnerability report they can attach to the compliance ticket.

## Output Specification

Audit all dependencies in the project and produce a vulnerability report saved to `security-report.md`. The report should clearly identify any vulnerable packages, their severity, and which versions are considered safe.

Also save the raw scan data to `scan-raw.json`.
