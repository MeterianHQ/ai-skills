# Install for Aider

Copy the config file and skills directory into your project root:

```bash
cp .aider.conf.yml your-project/
cp -r skills your-project/
```

Aider reads the `read:` entries in `.aider.conf.yml` on startup and loads the
skill content automatically.

## Verify

Start Aider from your project directory and ask:

```
Audit my dependencies for vulnerabilities.
```

Aider should invoke the Meterian CLI and return a report.
