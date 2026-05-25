# Install for Continue.dev

Copy the rules directory into your project root:

```bash
cp -r .continue your-project/
```

Continue reads rule files from `.continue/rules/` and applies them based on the
`globs` and `alwaysApply` frontmatter settings in each file.

## Verify

Open a manifest file in VS Code or JetBrains with Continue active. The Security
Audit skill should trigger automatically.
