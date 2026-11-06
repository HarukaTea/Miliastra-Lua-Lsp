# Miliastra Lua LSP

[简体中文](README.md)

Type `game.` in VS Code to explore the APIs available to your Genshin Impact Miliastra scripts. The extension provides control and enum completions, Chinese hover documentation, argument type checking, and go-to-definition across `.lua` and `.luau` files.

## Install

Use VS Code 1.74 or later. Each package includes the Luau language server adapted for Miliastra. Choose the one that matches your VS Code platform.

1. Sign in to GitHub, open the [package builds](https://github.com/HarukaTea/Miliastra-Lua-Lsp/actions/workflows/native-vsix.yml?query=branch%3Amain), and select the most recent run with a green check mark.
2. Under **Artifacts** at the bottom of the run page, download the item for your platform and extract the `.vsix` file.
3. In the VS Code **Extensions** view, open the **⋯** menu, choose **Install from VSIX…**, and select the extracted file.

| Platform | Artifact |
| --- | --- |
| Windows x64 | `miliastra-win32-x64` |
| macOS on Apple silicon (ARM64) | `miliastra-darwin-arm64` |
| Linux x64 | `miliastra-linux-x64` |

## Try control completion

Open your script folder in VS Code and create `main.lua`. Enter the first line below. On the second line, type `panel:` and select `SetVisible` from the suggestions.

```lua
local panel = game.FindClientUIRoot("HUD")
panel:SetVisible(true)
```

Hover over `SetVisible` to see its boolean parameter and a Chinese note explaining that changing visibility lets the control's scripts keep running. You can try completion with the example as written. To run it in the game, replace `HUD` with the name of a UI root in your scene.

## Navigate modules and check types

- If your workspace contains `ui/panel.lua`, import it with `local panel = require("ui.panel")`. Press **F12** on an exported field where you use it to jump to its definition. If the module lives at `scripts/ui/panel.lua`, add `scripts/?.lua` to the `miliastraLsp.runtime.path` list in Settings.
- Put `--!strict` on the first line of a script to enable strict type checking. Try changing `true` in the example to the string `"true"` and look for the argument type error in the **Problems** view. To set type checking and lint rules for the workspace, use a `.luaurc` file at its root.
- The server also checks Miliastra bitwise operators such as `&`, `|`, `<<`, and `>>`. Search for `miliastraLsp` in VS Code Settings to adjust completions, diagnostics, or inlay hints.

## Common questions

**I already use Luau Language Server. Do I need both?** This extension works on its own. If you see duplicate suggestions or diagnostics in a Miliastra project, find JohnnyMorganz's **Luau Language Server** in the Extensions view and select **Disable (Workspace)** from its gear menu. It will still be available in other workspaces.

**Why did diagnostics change after upgrading from the older Lua-based version?** This version uses Luau's type checker and lint rules. If your scripts rely on EmmyLua annotations or your project configures diagnostics from the previous server, review the affected scripts after upgrading.

**How do I report a missing API or an incorrect diagnostic?** Include a short Lua snippet that reproduces the issue and the signature or diagnostic you expected. [Report an issue](https://github.com/HarukaTea/Miliastra-Lua-Lsp/issues) · [Contribution guide (Chinese)](CONTRIBUTING.md)

## License

The project is distributed under the [MIT License](LICENSE). See the [third-party notices](server/THIRD-PARTY-NOTICES.txt) for the bundled luau-lsp, Luau, and other native components.
