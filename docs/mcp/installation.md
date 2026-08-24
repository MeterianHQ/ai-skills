# MCP Server — Installation

The standalone `@meterian/mcp` package installs and auto-registers the MCP
server with whichever supported AI CLI tools it finds on your machine.

## Quick install

```bash
npm install -g @meterian/mcp
```

After installation, run the registration script:

```bash
npx @meterian/mcp install
```

The installer detects Claude Code, Gemini CLI, and Codex CLI on your machine
and registers the server with each one automatically.

## Manual registration

If auto-registration does not work for your client, register manually:

=== "Claude Code"

    ```bash
    claude mcp add meterian-mcp -s user -- node $(npm root -g)/@meterian/mcp/dist/index.js
    ```

    If Claude Code does not reconnect automatically, open `/mcp` and select **Reconnect**.

=== "Gemini CLI"

    ```bash
    gemini mcp add meterian-mcp node $(npm root -g)/@meterian/mcp/dist/index.js --scope user
    ```

=== "Codex CLI"

    ```bash
    codex mcp add meterian-mcp -- node $(npm root -g)/@meterian/mcp/dist/index.js
    ```

=== "mcp-cli"

    Add to `~/.config/mcp/mcp_servers.json`:

    ```json
    {
      "meterian-mcp": {
        "command": "node",
        "args": ["<path-to-global-node-modules>/@meterian/mcp/dist/index.js"]
      }
    }
    ```

    Run `npm root -g` to resolve `<path-to-global-node-modules>` — JSON configs
    do not expand shell substitutions or `~`.

For clients with no `mcp add` command that are configured purely through a JSON
file (for example Roo Code), see [Config-File Clients](config-file-clients.md).

## VS Code users

If you use the [Meterian Security VS Code extension](https://marketplace.visualstudio.com/items?itemName=Meterian.meterian-security),
the MCP Server is bundled and registers automatically with VS Code Copilot,
Cursor, and Windsurf when the extension activates. The standalone package is
only needed for AI CLI tools or clients outside VS Code.

## Verify

Ask your AI client:

```
Are any of my project's dependencies currently vulnerable?
```

If the MCP Server is registered correctly, the client calls `advisories_get`
or initiates a full audit.

## Uninstall

Deregister the server from each client you registered it with:

=== "Claude Code"

    ```bash
    claude mcp remove meterian-mcp -s user
    ```

=== "Gemini CLI"

    ```bash
    gemini mcp remove meterian-mcp --scope user
    ```

=== "Codex CLI"

    ```bash
    codex mcp remove meterian-mcp
    ```

=== "Config-file clients"

    Delete the `meterian-mcp` entry from the client's MCP config file
    (for example `~/.config/mcp/mcp_servers.json` for mcp-cli).

Then remove the package:

```bash
npm uninstall -g @meterian/mcp
```
