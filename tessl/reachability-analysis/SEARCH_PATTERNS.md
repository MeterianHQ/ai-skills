# Language-Specific Import Search Patterns

Replace `NAME` with the package name when searching.

| Language | Search patterns |
|----------|----------------|
| nodejs | `require('NAME')`, `require("NAME")`, `from 'NAME'`, `from "NAME"`, `import NAME` |
| python | `import NAME`, `from NAME import` |
| java | `import NAME.`, `import com.NAME` |
| rust | `use NAME::`, `extern crate NAME` |
| php | `use NAME\`, `require 'NAME'`, `require "NAME"` |
| ruby | `require 'NAME'`, `require "NAME"` |
| golang | `"NAME"` (inside an import block) ¹ |
| dotnet | `using NAME;` |

¹ golang: string matching inside import blocks may produce false positives — verify matches manually.

Exclude from all searches: `node_modules`, `.git`, `dist`, `build`, `vendor`, `.venv`, `target`.
