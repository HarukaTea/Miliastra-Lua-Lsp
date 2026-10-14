# 参与开发

面向开发者的构建、调试与项目结构说明。用户使用说明请看 [README.md](README.md)。

## 环境要求

- Node.js（用于编译客户端 TypeScript）
- 与平台匹配的 `lua-language-server` 可执行文件（本仓库不提供，见下）

## 项目结构

```
MLSP/
├── client/                      # VS Code 扩展客户端（TypeScript）
│   ├── src/
│   │   ├── extension.ts         # 扩展入口，检测 sumneko.lua 冲突
│   │   └── languageserver.ts    # 语言客户端启动、状态栏、内联提示渲染
│   ├── out/                     # 编译产物（package.json 的 main 入口）
│   └── tsconfig.json            # 客户端编译配置
├── server/                      # 语言服务器（Lua）
│   ├── main.lua                 # 服务端入口
│   ├── platform.lua             # 平台初始化与 package.path 组装
│   ├── debugger.lua             # 调试器（develop.enable 时生效）
│   ├── def/
│   │   ├── env.luau             # 语言基础环境定义（按文件路径加载）
│   │   └── meta.luau            # 元表定义（按文件路径加载）
│   ├── locale/en-us/            # 文案（language.lua 运行时扫描目录加载）
│   ├── script/
│   │   ├── core/                # 补全、诊断、悬停、语义着色等核心能力
│   │   │   └── diagnostics/     # 30 条诊断规则，由 init.lua 动态 require
│   │   ├── library/             # 千星奇域 API 定义（api.lua / miliastra.lua）
│   │   ├── parser/              # Lua / Luau 词法、语法与文档注释解析
│   │   ├── provider/            # LSP 协议层（能力注册、请求分发）
│   │   ├── service/             # 服务主循环
│   │   ├── vm/                  # 类型推导与语义分析
│   │   ├── workspace/           # 工作区文件与模块解析
│   │   ├── brave/ + pub/        # 基于 bee.thread 的多线程任务分发
│   │   └── ...
│   └── bin/                     # 平台二进制 + 必需引导器 main.lua（被 .gitignore 忽略）
├── syntaxes/lua.tmLanguage.json # TextMate 语法高亮
├── language-configuration.json  # 括号、注释、缩进规则
├── images/logo.png              # 扩展图标
├── images/preview.png           # README 预览截图
├── package.json                 # 扩展清单与 54 项配置声明
└── package.nls.json             # 配置项文案（中文）
```

## 客户端：编译

客户端为 TypeScript 项目，依赖 `vscode-languageclient`：

```bash
cd client
npm install
npm run compile   # 编译一次
npm run watch     # 监听模式
```

编译产物输出到 `client/out/`，对应 `package.json` 中的 `main: ./client/out/extension`。

只改了 `client/src/` 之后，务必重新编译，让 `client/out/` 与源码保持同步。仓库会提交 `out/*.js`（便于直接按 F5 调试），但 `out/*.map` 已被忽略（`.vscodeignore` 也会把它们排除出扩展包）。

## 服务端：运行与调试

服务端为纯 Lua 实现，直接修改 `server/script/` 下的脚本后重启扩展即可生效。

运行时通过 `package.json` 指向的可执行文件启动，命令形如：

```
server/bin/{Windows,Linux,macOS}/lua-language-server -E server/main.lua
```

> 除 macOS arm64 以外，`server/bin` 下的平台目录仍由 `.gitignore` 忽略，需要自行准备匹配的可执行文件及其 `main.lua` 引导器。此 fork 提交了 `server/bin/macOS` 下的 arm64 运行时，来源为 LuaLS 3.13.6 官方发行包；Intel Mac 不包含在内。

macOS arm64 运行时来源：<https://github.com/LuaLS/lua-language-server/releases/tag/3.13.6>。归档 `lua-language-server-3.13.6-darwin-arm64.tar.gz` 的 SHA-256：`e2cbe217a155ceb952dbf7fed544be212a3ce8315dde317c617b5002d29fe596`。该运行时与当前服务端源码使用的 `bee` API 兼容；macOS 不提供 `subprocess.filemode`，所以协议层仅在 API 存在的平台调用它。

### ⚠️ `server/bin/<平台>/main.lua` 是必需的引导器，切勿删除

每个平台的 `bin` 目录下除了可执行文件本身，还必须有官方发行包自带的 `main.lua`：

```
server/bin/Windows/main.lua    # 引导器（Bootstrap）
server/bin/Windows/lua-language-server.exe
```

这个 exe 是 `--exe` 构建，**启动时会无条件加载与自己同目录的 `main.lua`**，再由它读取 `arg[0]` 加载我们真正指定的脚本。因此 `-E server/main.lua` 只是引导器的入参，并不代表引导器可以省略。

删掉它会立刻导致扩展无法启动，且**服务端一行 Lua 都不会执行**——因为进程在 C 引导阶段就退出了，`server/log/` 也不会生成。报错信息形如：

```
lua-language-server.exe: cannot open ...\server\bin\Windows\main.lua: No such file or directory
```

> 排查提示：这个文件不在任何 `require` 调用里，静态依赖分析会把它判成「无用文件」。判断服务端文件是否可删时，**不要只依赖 `require` 引用图**。另外整个 `server/bin` 都在 `.gitignore` 中，误删后 `git` 无法帮你恢复，只能从官方发行包或历史 `.vsix` 里取回。

### 附加调试器

1. 在用户设置中开启开发模式并确认调试端口：

```json
{
    "miliastraLsp.develop.enable": true,
    "miliastraLsp.develop.debuggerPort": 11413,
    "miliastraLsp.develop.debuggerWait": false
}
```

2. 在 VS Code 中打开 `server/` 目录，使用 `server/.vscode/launch.json` 中的 **附加** 配置连接调试器。默认地址为 `127.0.0.1:11413`，需要与上面的 `debuggerPort` 保持一致。

## 打包

```bash
npx vsce package
```

打包时 `.vscodeignore` 会排除源码、sourcemap、`server/log` 等开发文件。

## 改动时的注意事项

以下几点容易踩坑，改动相关代码时请留意：

- **配置项命名空间**：`package.json` 中声明的键是 `miliastraLsp.xxx.yyy`，客户端启动时以 `section = 'miliastraLsp'` 拉取配置，服务端 `server/script/config.lua` 里使用的键**不带前缀**（即 `xxx.yyy`）。新增配置需要两边同时改，并同步更新 `package.nls.json` 中的文案。

- **诊断规则是动态加载的**：`server/script/core/diagnostics/init.lua` 通过 `require('core.diagnostics.' .. name)` 加载规则，`name` 来自 `server/script/proto/define.lua` 的 `DiagnosticDefaultSeverity` 表。因此**新增一条诊断必须同时在该表（以及 `DiagnosticDefaultNeededFileStatus`）中登记**，否则规则不会被加载，`package.json` 里声明的默认值也会被忽略。

- **`def/*.luau` 与 `locale/*` 不走 `require`**：它们分别由 `server/script/library/defaultlibs.lua`、`server/script/library/api.lua` 和 `server/script/language.lua` 按文件路径读取。做「无用文件」清理之类的分析时，不要把它们误判成死代码。

- **服务端诊断默认值的唯一来源是 `proto/define.lua`**：`package.json` 中 `diagnostics.severity`、`diagnostics.neededFileStatus` 的 `default` 仅用于设置界面展示与实际行为保持一致，**修改默认级别请改 `define.lua`**，并同步 `package.json` 以免界面上显示的默认值与实际不符。

- **`package.nls.json` 用中文**：仓库不提供 `package.nls.en.json`，因此 VS Code 在任何语言下都会读取这份中文文案。新增配置项时记得补上对应条目（键名必须与 `package.json` 中的 `%占位符%` 完全一致）。

## 致谢

- [RobloxLsp](https://github.com/NightrainsRbx/RobloxLsp)：本项目的直接来源
- [sumneko/lua-language-server](https://github.com/sumneko/lua-language-server)：底层 Lua 语言服务器
