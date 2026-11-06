# Miliastra Lua LSP

[简体中文](README.md)

Edit Miliastra Lua and Luau scripts in VS Code. This branch uses the native Luau language server and ships definitions for the game API, UI controls, enums, and Chinese hover documentation.

Download a matching artifact from [Native VSIX builds](https://github.com/HarukaTea/Miliastra-Lua-Lsp/actions/workflows/native-vsix.yml), extract the VSIX, and use **Extensions → Install from VSIX** in VS Code 1.74 or later. Build targets are Windows x64, Apple Silicon macOS, and Linux x64.

Open a script folder to use completion, hover, signature help and go-to-definition. For example, `require("ui.panel")` resolves to `ui/panel.lua` under the configured search paths. Bare module names use `miliastraLsp.runtime.path` against the script directory and workspace root. Relative paths and aliases use Luau resolution. The server analyzes bitwise and compound bitwise operators in game scripts.

Search for `miliastraLsp` in Settings for the options supported by this branch. Luau reads type and lint settings from `.luaurc` and script directives such as `--!strict`. Review legacy Lua diagnostic names and EmmyLua annotations when migrating.

See [CONTRIBUTING.md](CONTRIBUTING.md) for build instructions and [luau-lsp](https://github.com/JohnnyMorganz/luau-lsp) for the upstream implementation.
