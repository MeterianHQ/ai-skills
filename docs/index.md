---
hide:
  - toc
---

<div class="hero" markdown>
<span class="eyebrow">Free &nbsp;·&nbsp; No account required</span>

# Security scanning for every developer workflow

Audit open-source dependencies for known vulnerabilities — from the command line,
through your AI coding assistant, or via the Model Context Protocol.
Covers 12+ ecosystems.

<div class="hero-badges" markdown>
`@meterian/cli` &nbsp;&nbsp; `@meterian/mcp` &nbsp;&nbsp; `9 AI tools supported`
</div>
</div>

## Choose your integration

Three ways to add Meterian security to your workflow — pick the one that fits your setup.

<div class="grid cards products" markdown>

-   ⚡ **CLI**

    ---

    Audit any project from the command line. Batch-check all dependencies, look
    up individual packages, or find safe upgrade paths. Zero-install via npx — no
    global setup required.

    ```bash
    npx @meterian/cli check
    ```

    [:octicons-arrow-right-24: CLI documentation](cli/index.md)

-   🧠 **AI Skills**

    ---

    Your AI coding assistant automatically scans dependencies and suggests fixes —
    inline, as you work. Supports 9 tools including Claude Code, Cursor, and
    GitHub Copilot. Triggers automatically when you open a manifest file.

    ```
    meterian:security-audit
    ```

    [:octicons-arrow-right-24: AI Skills documentation](skills/index.md)

-   🔌 **MCP Server**

    ---

    Expose real-time vulnerability data to any MCP-compatible client. Ask your
    AI assistant about any library — it queries live advisory data, not a stale
    training set.

    ```bash
    npm install -g @meterian/mcp
    ```

    [:octicons-arrow-right-24: MCP Server documentation](mcp/index.md)

</div>

## How they relate

The CLI is the engine underneath everything. AI Skills teach your coding assistant
to invoke it directly. The MCP Server exposes the same vulnerability data as a
live protocol endpoint — without requiring any CLI installation on the client side.

<div class="arch-diagram" markdown>
<div class="arch-db">Meterian Kiwi database</div>
<div class="arch-arrow-down">↓</div>
<div class="arch-cli">@meterian/cli</div>
<div class="arch-branches">
  <div class="arch-branch">
    <div class="arch-arrow-down">↓</div>
    <div class="arch-box">
      <strong>AI Skills</strong><br>
      <span>npx @meterian/cli</span><br>
      <span>9 coding assistants</span>
    </div>
  </div>
  <div class="arch-branch">
    <div class="arch-arrow-down">↓</div>
    <div class="arch-box">
      <strong>MCP Server</strong><br>
      <span>JSON-RPC 2.0 / MCP</span><br>
      <span>Any MCP-compatible client</span>
    </div>
  </div>
</div>
</div>

## Supported ecosystems

All three products cover the same 12+ languages and package managers.

<div class="eco-strip">
<span class="eco-tag">Node.js / npm</span>
<span class="eco-tag">Python / pip</span>
<span class="eco-tag">Java / Maven</span>
<span class="eco-tag">Java / Gradle</span>
<span class="eco-tag">Rust / Cargo</span>
<span class="eco-tag">PHP / Composer</span>
<span class="eco-tag">Ruby / Bundler</span>
<span class="eco-tag">Go modules</span>
<span class="eco-tag">.NET / NuGet</span>
<span class="eco-tag">C++ / Conan</span>
<span class="eco-tag">Dart / pub</span>
<span class="eco-tag">Clojure / Leiningen</span>
<span class="eco-tag">Swift PM</span>
</div>
