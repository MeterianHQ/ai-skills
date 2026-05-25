# Install for Cursor

In Cursor's plugin manager, point to the repository:

```
https://github.com/MeterianHQ/ai-skills
```

Cursor will fetch the plugin manifest from `.cursor-plugin/plugin.json` and
install the skills automatically.

## Verify

Open any `package.json`, `pom.xml`, or other manifest file. Cursor should
invoke the `meterian:security-audit` skill and begin scanning.
