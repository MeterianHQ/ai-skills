# Meterian AI Skills

Claude Code skills for security vulnerability scanning and reachability analysis.

## Skills included

### `meterian-security-audit`
Audit open-source dependencies for vulnerabilities across all supported ecosystems (npm, pip, Maven, Gradle, Cargo, Composer, Bundler, Go modules, NuGet, Conan, pub/Flutter, Leiningen, Swift PM).

**Triggers automatically** when you open or modify a manifest file (`package.json`, `requirements.txt`, `pom.xml`, `Cargo.toml`, etc.)

**Explicit invocation:**
```
#meterian-security-audit
```

### `meterian-reachability`
After an audit, determine which vulnerable dependencies are actually reachable and exploitable in your application source code. Uses a 6-step workflow: enrich via CLI, identify entry points, search usage patterns, trace call paths, classify findings, and assign priority.

**Classifications:** Reachable · Conditionally reachable · Loaded but not called · Present but not reachable · Unknown

## Installation

### From this marketplace

```
/plugin marketplace add github:MeterianHQ/ai-skills
/plugin install meterian-security-audit@meterian-ai-skills
```

### Direct plugin install

```
/plugin install github:MeterianHQ/ai-skills?path=claude
```

## Prerequisite

Node.js 18+ must be available in the terminal. The skills use `npx @meterian/cli` (fetched automatically — no global install required).

To install the CLI globally for faster invocation:

```bash
npm install -g @meterian/cli
```

## Publishing

To submit to the official Anthropic marketplace:

```bash
./scripts/publish.sh
```

## License

MIT
