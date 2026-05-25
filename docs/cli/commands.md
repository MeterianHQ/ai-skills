# CLI — Commands

## check

Batch-audit a list of dependencies for known vulnerabilities.

**Input:** JSON array of `{"language", "name", "version"}` objects, read from stdin.

```bash
echo '[
  {"language":"nodejs","name":"lodash","version":"4.17.15"},
  {"language":"python","name":"requests","version":"2.25.0"}
]' | npx @meterian/cli check
```

**Output:** JSON object with:

- `vulnerable` — array of packages with known issues (empty if clean)
- `summary` — totals: `total`, `vulnerable`, `clean`

Each entry in `vulnerable` includes `safeVersions` ordered `[latestPatch, latestMinor, latestMajor]` (nulls excluded).

**Example output (vulnerable):**

```json
{
  "vulnerable": [
    {
      "language": "nodejs",
      "name": "lodash",
      "version": "4.17.15",
      "advisories": [
        {
          "id": "CVE-2021-23337",
          "severity": "HIGH",
          "title": "Command injection via template"
        }
      ],
      "safeVersions": ["4.17.21"]
    }
  ],
  "summary": { "total": 2, "vulnerable": 1, "clean": 1 }
}
```

---

## advisories get

Look up all known security advisories for a specific package version.

```bash
npx @meterian/cli advisories get <language> <name> <version>
```

**Example:**

```bash
npx @meterian/cli advisories get nodejs lodash 4.17.15
```

**Output:** JSON object with an `advisories` array. Each advisory includes id,
severity, title, description, and affected version range.

---

## nextsafe

Find the safest upgrade path for a vulnerable package.

```bash
npx @meterian/cli nextsafe <language> <name> <version>
```

**Example:**

```bash
npx @meterian/cli nextsafe nodejs lodash 4.17.15
```

**Output:**

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
| `latestPatch` | Earliest safe version at same `major.minor` |
| `latestMinor` | Earliest safe version at same `major` |
| `latestMajor` | Latest safe version overall |

A `null` value means no safe version exists at that semver level.

---

## Environment variables

| Variable | Default | Description |
|----------|---------|-------------|
| `KIWI_BASE_URL` | `https://kiwi.meterian.io` | Override the advisory database endpoint |
