# 贡献指南

如果你发现某个千星奇域 API 缺少补全、中文说明有误，或一段能在游戏里运行的代码被标红，可以直接[提交 Issue](https://github.com/HarukaTea/Miliastra-Lua-Lsp/issues)。也欢迎直接提交 API 定义和文档修正。

## 报告一个可以复现的问题

请写明操作系统和架构、VS Code 版本、千星奇域 Lua LSP 扩展版本。贴出尽可能短的 Lua 代码，并说明光标放在哪里、实际看到了什么、预期是什么。例如，报告控件方法的签名错误时，请附上获取控件的那一行，以及游戏编辑器显示的签名或对应的文档出处。

如果问题与 `require` 有关，请附上调用脚本和模块的相对路径。若语言服务启动失败，请附上 VS Code「输出」面板中 **千星奇域 Luau LSP** 频道的相关日志。

## 找到要改的文件

| 想改什么 | 从哪里入手 |
| --- | --- |
| API 名称、参数、返回值、控件继承关系或枚举 | [千星奇域类型定义](server/definitions/miliastra.d.luau) |
| 鼠标悬停时显示的中文说明 | [中文 API 文档](server/definitions/zh-cn.json) |
| 扩展设置、语言服务启动方式或状态栏 | [扩展清单](package.json)和 [VS Code 客户端](client/src/extension.ts) |
| 模块查找、诊断或位运算解析 | [语言服务补丁](server/patches/luau-lsp.patch)和 [Luau 解析器补丁](server/patches/luau.patch) |

添加 API 时，请同时补上签名和中文说明。比如 `ClientUIBaseControl.SetVisible` 的签名在类型定义的控件声明里，其悬停说明对应 JSON 键 `@miliastra/globaltype/ClientUIBaseControl.SetVisible`。

## 在 VS Code 中试用改动

检出 `main` 分支，在仓库根目录运行以下命令。需要 Node.js 22、Git、CMake 3.19 或更高版本，以及支持 C++17 的编译器。Windows 可用 Visual Studio 2022 的「使用 C++ 的桌面开发」工作负载。Node.js 和编译器的目标架构应与 VS Code 一致。

```sh
npm ci
npm run build:server
npm run compile
```

首次构建会联网下载固定版本的 [luau-lsp](https://github.com/JohnnyMorganz/luau-lsp) 和 Luau，再应用仓库中的补丁。构建完成后，在仓库根目录执行下列命令，把引号内的路径换成自己的脚本目录。

```sh
code --new-window --extensionDevelopmentPath="$PWD" "/path/to/your/scripts"
```

在新窗口打开能复现问题的脚本，检查补全、悬停或错误提示是否符合预期。修改类型定义或中文说明后，在这个窗口运行 **Developer: Reload Window** 重新加载即可。修改客户端后先运行 `npm run compile`，修改原生补丁后先运行 `npm run build:server`。

## 验证安装包与提交 PR

如果改动涉及原生补丁或打包流程，可在本机生成 VSIX 并验证安装包里的服务。以下是 Windows x64 的命令，需要 Python 3.9 或更高版本。Apple 芯片的 macOS 和 Linux x64 请把两条命令中的 `win32-x64` 分别替换为 `darwin-arm64` 或 `linux-x64`。

```sh
npx --yes @vscode/vsce@3.6.2 package --target win32-x64 --out miliastra-win32-x64.vsix
python scripts/check-vsix.py miliastra-win32-x64.vsix
```

验证脚本会在临时工作区打开一个千星奇域脚本，检查控件补全、中文悬停、跨文件跳转和参数诊断。向 `main` 提交 PR 时，请说明修复了哪个用户可见的问题，并附上用于验证的示例或操作步骤。
