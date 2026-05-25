# Install for Claude Code

Run these two commands in Claude Code:

```
/plugin marketplace add MeterianHQ/ai-skills
/plugin install meterian@meterian-ai-skills
/reload-plugins
```

That's it. The skills activate immediately. Open any manifest file to trigger
the Security Audit, or type `/meterian-security-audit` to run it manually.

## Verify

After `/reload-plugins`, type:

```
/skills
```

You should see `meterian:security-audit` and `meterian:reachability-analysis` in the list.
