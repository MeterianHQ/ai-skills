# Upgrade Path Assessment: urllib3 2.0.0 (Python)

## Problem/Feature Description

A Python backend service is pinned to `urllib3` version `2.0.0`. The security team has flagged it as vulnerable and needs to know the safest, least-disruptive upgrade path before the next release.

The team follows a change-control policy that distinguishes between patch, minor, and major upgrades — each tier requires a different approval process. Your job is to determine:

1. Whether a patch-level fix exists within the current minor series
2. The minimum safe minor version, if no patch fix is available
3. Whether a major version upgrade is required

Produce a file named `upgrade-report.md` with a clear recommendation for each upgrade tier (patch / minor / major). Also save the raw safe-version data to `nextsafe-raw.json`.
