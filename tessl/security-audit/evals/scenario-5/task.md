# Security Audit: Go Authentication Microservice

## Problem/Feature Description

A Go microservice (`inputs/go.mod`) handles authentication and session management for the platform. Because it processes credentials and session tokens, the security team requires it to be scanned for vulnerable dependencies before any changes go to production.

The Go ecosystem relies on a module system and the service has several third-party dependencies that haven't been reviewed in over a year.

## Output Specification

Scan the Go module's dependencies for known vulnerabilities and produce a report saved to `security-report.md`. The report should list all packages audited, flag any CVEs or security advisories found, and include a summary.

Also save the raw scan data to `scan-raw.json`.
