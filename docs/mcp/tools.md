# MCP Server — Tools Reference

The Meterian MCP Server exposes two tools.

---

## advisories_get

Returns all known security advisories and license issues for a specific library version.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `language` | string | yes | Package manager (see [Supported Languages](../cli/languages.md)) |
| `name` | string | yes | Package name as published |
| `version` | string | yes | Library version to check |

**Example call:**

```json
{
  "tool": "advisories_get",
  "parameters": {
    "language": "nodejs",
    "name": "lodash",
    "version": "4.17.15"
  }
}
```

**Response:** JSON object with an `advisories` array. Each entry contains the
advisory ID, severity, title, description, and affected version range.

---

## advisories_getnextsafe

Returns the recommended safe upgrade versions for a vulnerable library.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `language` | string | yes | Package manager (see [Supported Languages](../cli/languages.md)) |
| `name` | string | yes | Package name as published |
| `version` | string | yes | Current (vulnerable) version |

**Example call:**

```json
{
  "tool": "advisories_getnextsafe",
  "parameters": {
    "language": "nodejs",
    "name": "lodash",
    "version": "4.17.15"
  }
}
```

**Response:**

```json
{
  "safe_versions": {
    "latestPatch": "4.17.21",
    "latestMinor": null,
    "latestMajor": null
  }
}
```

| Field | Meaning |
|-------|---------|
| `latestPatch` | Earliest safe version at the same `major.minor` — least disruptive fix |
| `latestMinor` | Earliest safe version at the same `major` |
| `latestMajor` | Latest safe version overall — most up-to-date fix |

A `null` value means no safe version exists at that semver level (e.g. the
vulnerability affects all versions of that major line).
