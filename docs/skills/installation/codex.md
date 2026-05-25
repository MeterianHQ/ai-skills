# Install for Codex CLI

Copy `AGENTS.md` to your project root:

```bash
cp AGENTS.md your-project/
```

Like `GEMINI.md`, this is a skill delivery file — it uses `@`-include directives
to load the skill content into Codex CLI's context. It is not project documentation.

## Verify

Start Codex CLI from your project directory and ask:

```
Audit my dependencies for vulnerabilities.
```
