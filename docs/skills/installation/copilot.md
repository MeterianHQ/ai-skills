# Install for GitHub Copilot

Copy the instructions file into your project's `.github/` directory:

```bash
curl -o .github/copilot-instructions.md \
  https://raw.githubusercontent.com/MeterianHQ/ai-skills/main/.github/copilot-instructions.md
```

Or manually:

```bash
# from the ai-skills repo
cp .github/copilot-instructions.md your-project/.github/
```

GitHub Copilot reads `.github/copilot-instructions.md` automatically. No restart required.

## Verify

Open a manifest file in VS Code with Copilot active, or ask Copilot:

```
Audit my dependencies for vulnerabilities.
```

Copilot should invoke the Meterian CLI and return a vulnerability report.
