# Investigating Security Advisories for a Specific Library

## Problem/Feature Description

A backend engineer wants to adopt `urllib3` version `1.24.1` in a new Python HTTP client integration. Before adding it as a dependency, the team wants to know if this specific version has any documented security advisories — the organisation has a policy of zero known vulnerabilities in newly introduced packages.

Your job is to look up the security record for this exact library and version and write up your findings so the engineer can make an informed decision.

## Output Specification

Produce a file named `advisory-report.md` documenting what you find. For each advisory, include its severity level, identifier, and a brief description of what the issue is.
