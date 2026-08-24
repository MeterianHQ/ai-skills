# MCP Server — Supported Clients

| Client | Registration | Notes |
|--------|-------------|-------|
| Claude Code | Auto via installer, or manual `claude mcp add` | May need Reconnect on first use |
| Gemini CLI | Auto via installer, or manual `gemini mcp add` | |
| Codex CLI | Auto via installer, or manual `codex mcp add` | |
| VS Code Copilot | Automatic via VS Code extension | No standalone package needed |
| Cursor | Automatic via VS Code extension | No standalone package needed |
| Windsurf | Automatic via VS Code extension | No standalone package needed |
| mcp-cli | Manual config in `~/.config/mcp/mcp_servers.json` | |
| Roo Code | Manual config in `mcp_settings.json` or `.roo/mcp.json` | See [Config-File Clients](config-file-clients.md) |

Any other MCP-compatible client that supports stdio transport (JSON-RPC 2.0 /
MCP spec 2024-11-05) can be registered manually by pointing to the
`@meterian/mcp` entry point — see [Config-File Clients](config-file-clients.md)
for a worked example.

## VS Code extension vs standalone package

| | VS Code extension | Standalone `@meterian/mcp` |
|---|---|---|
| VS Code Copilot | ✅ Auto-registered | ✗ |
| Cursor | ✅ Auto-registered | ✗ |
| Windsurf | ✅ Auto-registered | ✗ |
| Claude Code | Via VS Code command | ✅ Auto via installer |
| Gemini CLI | Via VS Code command | ✅ Auto via installer |
| Codex CLI | Via VS Code command | ✅ Auto via installer |
| GitHub Copilot Cloud agents | ✗ | ✅ Required |
