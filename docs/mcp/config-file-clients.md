# MCP Server — Config-File Clients

Some AI tools have no `mcp add` command and no VS Code integration, but still
support MCP servers through a JSON config file. This guide walks through such a
setup using **[Roo Code](https://roocode.com/)** as the example — an
open-source, model-agnostic AI coding assistant for VS Code.

The same approach applies to any tool that accepts a standard `mcpServers` JSON
config block.

---

## Step 1 — Install the package

```bash
npm install -g @meterian/mcp
```

You do **not** need to run `npx @meterian/mcp install` for these clients — that
step auto-registers Claude Code, Gemini CLI and Codex CLI, none of which apply
here. The global install alone is enough.

## Step 2 — Find the absolute entry-point path

Config files take a literal path, so resolve it once and copy the result:

```bash
echo "$(npm root -g)/@meterian/mcp/dist/index.js"
```

Typical output:

```
/usr/local/lib/node_modules/@meterian/mcp/dist/index.js
```

!!! warning "Use the full absolute path"
    Do not put `$(npm root -g)` or `~` in a JSON config — most tools neither
    run a shell nor expand `~`. Paste the resolved path instead.

Verify the server starts:

```bash
node "$(npm root -g)/@meterian/mcp/dist/index.js"
```

It boots and waits on stdin. Press `Ctrl+C` to stop it once confirmed.

---

## Step 3 — Configure your AI tool

### Roo Code

Roo Code is a VS Code extension with 1.4M+ installs. It supports MCP servers
via a JSON config file and requires no CLI commands.

**Open the MCP settings:**

1. Click the **Roo Code icon** in the activity bar to open the Roo Code panel
2. Click the **settings icon** (gear) at the top of the panel
3. Scroll to the bottom and click **"Edit Global MCP"**

This opens the global config file `mcp_settings.json` for editing.

!!! tip "Project-level config"
    Click **"Edit Project MCP"** instead to scope the server to a single
    project. This creates `.roo/mcp.json` in your project root and takes
    precedence over the global config.

**Add the Meterian MCP server entry:**

```json
{
  "mcpServers": {
    "meterian-mcp": {
      "command": "node",
      "args": ["/usr/local/lib/node_modules/@meterian/mcp/dist/index.js"]
    }
  }
}
```

Replace the path with the one you resolved in Step 2. Save the file — Roo Code
picks up the change automatically.

**Verify:**

Ask Roo Code:

> *"Are any of my project's dependencies currently vulnerable?"*

If the server is connected, Roo Code calls the `advisories_get` tool and
returns results.

---

## General pattern for other tools

Any tool that accepts a standard `mcpServers` JSON config block can be
connected the same way:

```json
{
  "mcpServers": {
    "meterian-mcp": {
      "command": "node",
      "args": ["<absolute-path>/@meterian/mcp/dist/index.js"]
    }
  }
}
```

Consult your tool's documentation for where its MCP config file lives. See
[Supported Clients](clients.md) for the config locations we already know about.
