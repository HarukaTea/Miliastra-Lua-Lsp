# 千星奇域 Lua LSP

[简体中文](README.md) | [English](README.en.md)

为原神千星奇域Lua脚本开发打造的 Visual Studio Code 扩展，提供补全、悬停提示、跳转、诊断等完整的代码智能功能，并内置千星奇域运行时 API。

![预览](images/preview.png)

## 功能

| 功能 | 说明 |
| --- | --- |
| 智能补全 | 全局对象、库函数、字段、方法与关键词语法片段补全 |
| 悬停提示 | 显示类型、参数说明、字段预览与枚举列表 |
| 参数提示 | 输入函数参数时显示参数列表与文档 |
| 跳转与查找 | 转到定义、转到类型定义、查找引用、工作区符号 |
| 重命名 | 基于语义分析的符号重命名（`F2`） |
| 语义着色 | 语义高亮，可切换为语法着色 |
| 内联提示 | 参数名、参数类型、变量类型、赋值类型、返回类型提示 |
| 诊断检查 | 语法错误检查 + 30 条代码诊断规则，每条均可单独配置开关与等级 |
| 代码操作 | 快速修复建议（灯泡菜单） |
| 其他 | 文档符号、代码折叠、颜色选择器、模块跳转链接 |

## 安装

在 VS Code 中打开扩展面板，点击右上角 `...` → **从 VSIX 安装...**，选择 `miliastraLsp-0.0.3.vsix`。

也可以使用命令行：

```bash
code --install-extension miliastraLsp-0.0.3.vsix
```

### 环境要求

- VS Code `1.60.0` 或更高版本
- 扩展 **Lua（`sumneko.lua`）** 必须处于禁用状态，两者同时启用会弹出冲突提示

## 快速上手

1. 用 VS Code 打开你的《千星奇域》脚本目录（不要只打开单个文件）。
2. 打开任意 `.lua` / `.luau` 文件，扩展会自动为每个工作区启动一个语言服务。
3. 状态栏左下角会出现扩展状态，鼠标悬停可以看到已解析文件数、内存占用等信息。

常见的几个操作：

- `Ctrl + 空格`：手动触发补全
- `F2`：重命名符号
- `F12`：转到定义
- `Shift + F12`：查找引用

## 配置

所有配置项均以 `miliastraLsp.` 为前缀，在 VS Code 设置界面搜索 `miliastraLsp` 即可逐项调整，也可以直接写进 `settings.json`：

```json
{
    "miliastraLsp.color.mode": "Semantic",
    "miliastraLsp.completion.enable": true,
    "miliastraLsp.diagnostics.enable": true,
    "miliastraLsp.hint.enable": true,
    "miliastraLsp.workspace.ignoreDir": [
        ".vscode",
        "**/_Index/**"
    ]
}
```

### 常用配置项

| 配置项 | 默认值 | 说明 |
| --- | --- | --- |
| `miliastraLsp.color.mode` | `Semantic` | 着色模式：`Grammar`（语法）/ `Semantic`（语义） |
| `miliastraLsp.completion.enable` | `true` | 启用自动补全 |
| `miliastraLsp.completion.callParenthesess` | `false` | 补全函数时自动添加括号 |
| `miliastraLsp.completion.keywordSnippet` | `Replace` | 关键字片段显示方式：`Disable` / `Both` / `Replace` |
| `miliastraLsp.completion.workspaceWord` | `true` | 补全是否包含工作区中其他文件出现过的单词 |
| `miliastraLsp.diagnostics.enable` | `true` | 启用诊断和语法错误检查 |
| `miliastraLsp.diagnostics.globals` | — | 声明额外的全局变量，避免 `undefined-global` 误报 |
| `miliastraLsp.diagnostics.disable` | — | 按诊断代码禁用指定诊断 |
| `miliastraLsp.diagnostics.severity` | — | 逐条设置诊断等级：`Error` / `Warning` / `Information` / `Hint` |
| `miliastraLsp.diagnostics.neededFileStatus` | — | 逐条设置检查范围：`Any` / `Opened` / `None` |
| `miliastraLsp.hint.enable` | `false` | 启用内联提示 |
| `miliastraLsp.hint.paramType` | `true` | 在参数位置提示类型 |
| `miliastraLsp.hover.previewFields` | `100` | 悬停查看表时最多预览的字段数 |
| `miliastraLsp.typeChecking.mode` | `Disabled` | 类型检查模式：`Disabled` / `Non Strict` / `Strict` |
| `miliastraLsp.workspace.library` | — | 额外加载的外部代码库目录 |
| `miliastraLsp.workspace.ignoreDir` | `.vscode`、`**/_Index/**` | 忽略的文件与目录（`.gitignore` 语法） |
| `miliastraLsp.workspace.useGitIgnore` | `true` | 遵循 `.gitignore` 中的忽略规则 |
| `miliastraLsp.runtime.path` | 见 `settings.json` 默认值 | `require` 时的文件名搜索模板 |
| `miliastraLsp.runtime.fileEncoding` | `utf8` | 文件编码，`ansi` 仅在 Windows 下可用 |

> 全部 54 项配置的说明都可以在 VS Code 设置界面中直接看到。

### 诊断规则

内置 30 条诊断规则，可以逐条设置等级或关闭。按用途大致分为：

- **文档注释相关**：`undefined-doc-class`、`undefined-doc-name`、`undefined-doc-param`、`undefined-doc-module`、`doc-field-no-class`、`circle-doc-class`、`duplicate-doc-class`、`duplicate-doc-field`、`duplicate-doc-param`
- **类型与赋值相关**：`no-implicit-any`、`unbalanced-assignments`、`redundant-value`、`duplicate-index`、`duplicate-set-field`
- **作用域与引用相关**：`undefined-global`、`undefined-env-child`、`global-in-nil-env`、`redefined-local`、`unused-local`、`unused-function`、`unused-vararg`、`deprecated`
- **代码规范相关**：`empty-block`、`trailing-space`、`newfield-call`、`newline-call`、`redundant-parameter`、`unknown-diag-code`

另外当 `miliastraLsp.typeChecking.mode` 不为 `Disabled` 时，会额外交互式地给出类型检查诊断，以及 `undefined-type`、`redefined-type` 两条类型相关诊断。

想要忽略某些规则，把它的等级设为 `None`（关闭检查），或写进 `miliastraLsp.diagnostics.disable`：

```json
{
    "miliastraLsp.diagnostics.disable": [
        "undefined-global",
        "trailing-space"
    ],
    "miliastraLsp.diagnostics.severity": {
        "unused-local": "Information"
    }
}
```

## 千星奇域 API 支持

扩展内置了《千星奇域》运行时的类型定义，开箱即可补全，无需任何额外配置：

- **全局对象**：`script`（当前脚本实例）、`game`（客户端运行时全局表）、`Color`（颜色构造与转换）
- **类型**：`Script`、`Game`、`ColorValue`、`Tween`、`TweenSequence`、`ServerSignal`、`EnumItem` 等
- **控件**：`ClientUIBaseControl` 及派生控件（`ClientUIImageControl`、`ClientUITextBoxControl`、`ClientUITextWindowControl`、`ClientUIPresetButtonControl`、`ClientUICursorEventAreaControl`、`ClientUIGridScrollerControl`、`ClientUIKeyHintControl`、`ClientUIAnimationControl`、`ClientUIFullscreenAnimationControl`、`ClientUIContainerControl`、`ClientUIReferenceControl`），子类会自动继承父类成员
- **枚举**：`EaseType`、`Device`、`StageMode`、`LanguageType`、`ParamType`、`CustomVariableEntityType` 等

同时内置了 Lua 语言基础环境（`string`、`table`、`math`、`utf8`、`debug` 等标准库）与元表信息。

## 常见问题

**扩展没有任何反应，补全和诊断都不工作**

先确认 **Lua（`sumneko.lua`）** 已禁用。两者注册了同一个语言 ID，同时启用会冲突。

**`undefined-global` 报错，但那个变量确实存在**

这是本扩展不认识的自定义全局变量，把它加进配置即可：

```json
{
    "miliastraLsp.diagnostics.globals": [
        "MyGlobal",
        "MyOtherGlobal"
    ]
}
```

**状态栏一直显示加载中**

首次打开较大的项目时需要建立索引，稍等片刻即可。如果长时间不结束，检查 `server/log/service.log` 中的日志。

**扩展完全启动不起来，且 `server/log/` 是空的**

说明语言服务还没执行到 Lua 代码就退出了。最常见的原因是缺少 `server/bin/<平台>/main.lua` 引导器——可执行文件启动时会无条件加载它。详见 [CONTRIBUTING.md](CONTRIBUTING.md)。如果是通过 VSIX 安装的，重新安装扩展即可恢复。

**只想让诊断检查当前打开的文件**

把对应规则的 `miliastraLsp.diagnostics.neededFileStatus` 设为 `Opened`，可以减少后台开销：

```json
{
    "miliastraLsp.diagnostics.neededFileStatus": {
        "unused-local": "Opened",
        "unused-function": "Opened"
    }
}
```

## 参与开发

构建、调试与项目结构说明请见 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 致谢

- [RobloxLsp](https://github.com/NightrainsRbx/RobloxLsp)：本项目的直接来源
- [sumneko/lua-language-server](https://github.com/sumneko/lua-language-server)：底层 Lua 语言服务器
