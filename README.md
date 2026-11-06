# 千星奇域 Lua LSP

[English](README.en.md)

在 VS Code 中编辑千星奇域的 `.lua` 和 `.luau` 脚本。这个分支使用 Luau 的原生语言服务，内置 `game`、`script`、`Color`、控件和枚举的类型定义，以及中文 API 说明。

## 安装与使用

从仓库的 [Native VSIX 构建记录](https://github.com/HarukaTea/Miliastra-Lua-Lsp/actions/workflows/native-vsix.yml) 下载与你的平台匹配的构建产物，解压得到 VSIX，在 VS Code 的扩展面板选择“从 VSIX 安装”。目标平台为 Windows x64、Apple 芯片 macOS 和 Linux x64，编辑器版本要求为 VS Code 1.74 或更高。

打开脚本目录，在控件变量后输入冒号获取成员补全。悬停查看方法签名和中文说明，按 F12 跳转到定义。例如，当工作区有 `ui/panel.lua` 并返回带数值字段 `id` 的表时，可以直接写：

```lua
local panel = require("ui.panel")
local flags = 1 << 2
flags |= panel.id & 7
local control = game.GetClientUIControl(flags)
control:SetVisible((flags >> 1) ~= 0)
```

## 从旧版迁移

- 对于裸模块名，服务按 `miliastraLsp.runtime.path` 中的模板在调用脚本目录和工作区根目录查找。分散在其他目录的模块可通过 `scripts/?.lua` 这样的模板指定。显式相对路径与 `@alias` 使用 Luau 的解析规则。
- 当前分支沿用补全、签名、内联提示、诊断总开关和模块路径等设置。在设置面板搜索 `miliastraLsp` 可查看此版本实际支持的选项。类型检查模式与 lint 规则由 Luau 管理，可使用 `--!strict` 或工作区根目录的 `.luaurc`。旧 Lua 服务的逐条诊断名称和 EmmyLua 注解需要按项目复核。
- 位运算在语言分析期间按数值运算检查。游戏仍执行作者原本的脚本。

构建与维护说明见 [CONTRIBUTING.md](CONTRIBUTING.md)。上游语言服务见 [JohnnyMorganz/luau-lsp](https://github.com/JohnnyMorganz/luau-lsp)。
