# Install for Cline

Copy both the rules file and the skills directory into your project root:

```bash
cp .clinerules your-project/
cp -r skills your-project/
```

Cline reads `.clinerules` and follows `!include` directives to load skill content
from the `skills/` directory.

## Verify

Open a manifest file in VS Code with Cline active. The Security Audit skill
should trigger automatically.
