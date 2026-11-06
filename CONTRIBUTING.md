# 构建与维护

客户端入口在 `client/src/extension.ts`。它通过标准输入输出连接原生语言服务，按工作区传递扩展配置。千星奇域 API 签名、控件继承关系和枚举声明在 `server/definitions/miliastra.d.luau`，中文文档在同目录的 `zh-cn.json`。

## 本地构建

需要 Node.js 22、Git、CMake 3.19 或更高版本，以及支持 C++17 的平台编译器。Windows 可使用 Visual Studio 2022 的“使用 C++ 的桌面开发”工作负载。使用与目标 VS Code 架构匹配的 Node.js 和编译器。

```sh
npm ci
npm run build:server
npm run compile
```

原生构建脚本检出上游 1.70.1 的固定提交及其 Luau 子模块，应用 `server/patches/` 中的补丁后生成当前平台的可执行文件。构建缓存位于 `.build/`，最终可执行文件位于 `server/native/<platform>-<arch>/`。首次构建需要联网，编译并行度可用 `CMAKE_BUILD_PARALLEL_LEVEL` 设置。在开发主机上执行 `code --extensionDevelopmentPath=. <脚本目录>` 即可加载扩展。

## 安装包验证

以下命令以 Windows x64 为例。Apple 芯片 macOS 使用 `darwin-arm64`，Linux x64 使用 `linux-x64`。

```sh
npx --yes @vscode/vsce@3.6.2 package --target win32-x64 --out miliastra-win32-x64.vsix
python scripts/check-vsix.py miliastra-win32-x64.vsix
```

验证脚本从 VSIX 中提取服务和定义，用一个含点号模块路径、位运算与控件调用的工作区检查补全、跨文件跳转、中文悬停和参数诊断。CI 对每个平台分别构建、执行此验证并上传安装包。

## 上游适配

`luau.patch` 在表达式位置识别千星位运算，沿用操作数的源位置，并将其表示为用于静态分析的数值函数调用。`luau-lsp.patch` 接入模块路径模板及诊断开关。升级上游时，需要更新固定提交、重新生成补丁并重新验证三个平台。上游源码和依赖许可列在 `server/THIRD-PARTY-NOTICES.txt`。
