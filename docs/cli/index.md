# CLI — Overview

The Meterian CLI (`@meterian/cli`) is a command-line tool for auditing
open-source dependencies against the Meterian vulnerability database.

## Key features

- **Zero-install** — run via `npx @meterian/cli` without any global setup
- **No account required** — works out of the box
- **Batch auditing** — check all your dependencies in one call via `check`
- **Individual lookups** — query a single package with `advisories get`
- **Safe upgrade paths** — find the least-disruptive fix with `nextsafe`
- **12+ ecosystems** — Node.js, Python, Java, Rust, Go, and more

## Installation

=== "Zero-install (recommended)"

    ```bash
    npx @meterian/cli <command>
    ```

    No setup required. npx fetches the latest version on first use and caches it.

=== "Global install"

    ```bash
    npm install -g @meterian/cli
    ```

    After global install, use `meterian <command>` instead of `npx @meterian/cli <command>`.

## Quick example

```bash
echo '[{"language":"nodejs","name":"lodash","version":"4.17.15"}]' \
  | npx @meterian/cli check
```

## Next steps

- [Commands reference](commands.md)
- [Supported languages](languages.md)
