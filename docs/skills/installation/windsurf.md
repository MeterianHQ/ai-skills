# Install for Windsurf

Copy the Windsurf rules directory into your project root:

```bash
cp -r .windsurf your-project/
```

Or clone the repository and symlink:

```bash
git clone https://github.com/MeterianHQ/ai-skills /tmp/ai-skills
ln -s /tmp/ai-skills/.windsurf your-project/.windsurf
```

Windsurf picks up rules from `.windsurf/rules/` automatically on next reload.

## Verify

Open a manifest file in Windsurf. The Security Audit skill should trigger.
