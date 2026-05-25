# Getting Started

Not sure which integration to use? Pick based on your setup.

---

## I use an AI coding assistant

**Claude Code, Cursor, GitHub Copilot, Windsurf, Cline, Aider, Continue.dev, Gemini CLI, or Codex CLI?**

→ Use **[AI Skills](skills/index.md)**.

The skill is a set of instructions that teaches your coding assistant to invoke
the Meterian CLI automatically. Once installed, it runs when you open a manifest
file and surfaces vulnerabilities inline, without leaving your editor.

**Prerequisite:** Node.js 18+ must be available in the terminal where your AI tool runs
(the skill invokes `npx @meterian/cli` under the hood).

[Install AI Skills :octicons-arrow-right-24:](skills/installation/index.md){ .md-button .md-button--primary }

---

## I use an MCP-compatible client

**Claude Desktop, Gemini CLI, Codex CLI, or any other MCP client?**

→ Use the **[MCP Server](mcp/index.md)**.

The standalone `@meterian/mcp` package registers a Model Context Protocol server
with your AI client. Once registered, your AI can query live vulnerability data
for any library without you having to run any CLI commands yourself.

[Install MCP Server :octicons-arrow-right-24:](mcp/installation.md){ .md-button .md-button--primary }

---

## I want direct command-line auditing

**No AI tooling — just a fast CLI audit from the terminal?**

→ Use the **[CLI](cli/index.md)**.

`npx @meterian/cli check` reads a JSON list of dependencies from stdin and returns
a vulnerability report. No account, no global install, no configuration.

[CLI documentation :octicons-arrow-right-24:](cli/index.md){ .md-button .md-button--primary }

---

## Can I use more than one?

Yes. A common setup is to use AI Skills for day-to-day development and the CLI
in CI pipelines. The MCP Server adds live lookups on top of either.
