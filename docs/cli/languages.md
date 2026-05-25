# CLI — Supported Languages

All three Meterian products use the same language identifiers. Use the primary
value in the `language` field; aliases are also accepted.

| Ecosystem | Primary value | Accepted aliases |
|-----------|--------------|-----------------|
| Node.js / npm | `nodejs` | `javascript`, `npm` |
| Python | `python` | `pypi`, `pip` |
| Java (Maven) | `java` | `maven` |
| Java (Gradle) | `java` | `gradle` |
| PHP | `php` | `packagist`, `composer` |
| Ruby | `ruby` | `gem`, `bundler` |
| .NET | `dotnet` | `nuget`, `csharp` |
| Go | `golang` | `go` |
| Rust | `rust` | `cargo` |
| C / C++ | `cpp` | `conan` |
| Dart / Flutter | `dart` | `flutter`, `pub` |
| Clojure | `clojure` | `leiningen`, `clojars` |
| Swift | `swift` | `spm` |

## Manifest file mapping

| Manifest file | Language value |
|--------------|----------------|
| `package.json`, `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml` | `nodejs` |
| `requirements.txt`, `Pipfile`, `pyproject.toml`, `poetry.lock`, `uv.lock` | `python` |
| `pom.xml` | `java` |
| `build.gradle`, `build.gradle.kts` | `java` |
| `Cargo.toml`, `Cargo.lock` | `rust` |
| `composer.json`, `composer.lock` | `php` |
| `Gemfile`, `Gemfile.lock` | `ruby` |
| `go.mod`, `go.sum` | `golang` |
| `*.csproj` | `dotnet` |
| `conanfile.txt`, `conanfile.py` | `cpp` |
| `pubspec.yaml`, `pubspec.lock` | `dart` |
| `project.clj`, `deps.edn` | `clojure` |
| `Package.swift`, `Package.resolved` | `swift` |
