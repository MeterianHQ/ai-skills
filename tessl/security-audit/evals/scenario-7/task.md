# Security Audit: Java Payment Processing Service

## Problem/Feature Description

A Java Spring Boot service (`inputs/pom.xml`) handles payment processing and must pass a PCI-DSS compliance review. Part of the compliance checklist requires a documented security audit of all third-party Maven dependencies to confirm no known CVEs are present in the production classpath.

The service has been running in production for over a year and some of the library versions were pinned at project inception. The compliance officer needs a signed-off vulnerability report before the next audit window closes.

## Output Specification

Audit all Maven dependencies declared in the project and save the findings to `security-report.md`. The report should list each dependency, flag any known vulnerabilities with their severity and CVE identifiers, and include a summary count of vulnerable versus clean packages.

Also save the raw scan data to `scan-raw.json`.
