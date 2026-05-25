# MCP Server — Overview

The Meterian MCP Server (`@meterian/mcp`) is a standalone
[Model Context Protocol](https://modelcontextprotocol.io/) server that exposes
real-time vulnerability data to any MCP-compatible AI client.

## Why use the MCP Server?

AI assistants are pre-trained on a fixed dataset that becomes stale over time.
New vulnerabilities are discovered daily, and the model has no awareness of issues
found after its training cutoff. The Meterian MCP Server solves this by giving
your AI client a live connection to the Meterian advisory database.

Once registered, your AI can answer questions like:

- *"Is any of my project's dependencies currently vulnerable?"*
- *"What is the safest version I can upgrade axios to?"*
- *"List all critical vulnerabilities in this workspace."*

## How it works

The server communicates via stdin/stdout using the JSON-RPC 2.0 protocol
(MCP spec version 2024-11-05). It exposes two tools:

| Tool | Purpose |
|------|---------|
| [`advisories_get`](tools.md#advisories_get) | Return all known advisories for a specific library version |
| [`advisories_getnextsafe`](tools.md#advisories_getnextsafe) | Return safe upgrade versions for a vulnerable library |

## Relationship to the CLI

The MCP Server queries the same Meterian Kiwi database as the CLI. The difference
is delivery: the CLI is invoked directly from a shell; the MCP Server exposes the
same data as a protocol endpoint that any MCP client can call without shell access.

## Free tier

The MCP Server operates in Free mode by default, with access to the full
vulnerability database. Premium mode delivers expanded advisory details — contact
[support@meterian.io](mailto:support@meterian.io) for details.
