# Security Audit: Ruby E-Commerce Application

## Problem/Feature Description

A Ruby on Rails e-commerce platform (files in `inputs/`) is undergoing its quarterly security review mandated by the company's security policy. The platform handles customer payments and personal data, so the security team is particularly concerned about unpatched vulnerabilities in gem dependencies.

The project's gem dependency files are in the `inputs/` directory. The audit should capture the exact versions currently deployed so the report accurately reflects the production state of the application.

## Output Specification

Scan the Ruby application's gem dependencies for known vulnerabilities and save the findings to `security-report.md`. The report must list all gems checked, highlight any vulnerabilities with severity and identifiers, and summarise the findings.

Also save the raw scan data to `scan-raw.json`.
