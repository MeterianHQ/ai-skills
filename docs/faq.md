# FAQ

## Do I need a Meterian account?

No. All three products — CLI, AI Skills, and MCP Server — work without an account
in Free mode, with full access to the vulnerability database.

## Is this free?

Yes. The CLI, AI Skills, and MCP Server are free and open source (MIT licence).
A Premium mode is available for organisations that need expanded advisory details
or SLA support — contact [support@meterian.io](mailto:support@meterian.io).

## What data is sent to Meterian?

The CLI and MCP Server send package names and versions to the Meterian Kiwi
advisory database to look up vulnerability information. No source code, no
file contents, and no personal data are transmitted.

## Which Node.js version is required?

Node.js 18 or later. This applies to both the CLI (`npx @meterian/cli`) and the
MCP Server (`@meterian/mcp`).

## Can I use AI Skills and the MCP Server together?

Yes. They serve different purposes. AI Skills teach your assistant to run full
project audits via the CLI (reading manifest files, batch-checking all
dependencies). The MCP Server gives your assistant a live lookup tool for
individual packages. Many users run both.

## The skill triggered but didn't find my manifest file

Make sure Node.js 18+ is available in the terminal where your AI tool runs.
Run `node --version` to check. If `npx` is not found, install Node.js from
[nodejs.org](https://nodejs.org).

## How do I report a bug or request a feature?

Open an issue on [GitHub](https://github.com/MeterianHQ/ai-skills/issues).
For security disclosures, email [security@meterian.io](mailto:security@meterian.io)
rather than opening a public issue.
