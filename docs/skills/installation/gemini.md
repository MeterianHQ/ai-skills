# Install for Gemini CLI

Copy the two Gemini skill delivery files into your project root:

```bash
cp gemini-extension.json GEMINI.md your-project/
```

`GEMINI.md` uses `@`-include directives to load the skill content into Gemini
CLI's context automatically on startup. It is not project documentation — do not
edit it.

## Verify

Start Gemini CLI from your project directory and ask:

```
Audit my dependencies for vulnerabilities.
```
