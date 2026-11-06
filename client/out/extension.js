"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deactivate = exports.activate = void 0;
const fs = require("fs");
const path = require("path");
const vscode = require("vscode");
const node_1 = require("vscode-languageclient/node");
let client;
function serverSettings(uri) {
    const config = vscode.workspace.getConfiguration('miliastraLsp', uri);
    const hints = config.get('hint.enable');
    return {
        platform: { type: 'standard' },
        types: { roblox: false },
        sourcemap: { enabled: false },
        require: { modulePaths: config.get('runtime.path') },
        ignoreGlobs: config.get('workspace.ignoreDir'),
        index: { maxFiles: config.get('workspace.maxPreload') },
        diagnostics: { enabled: config.get('diagnostics.enable') },
        completion: {
            enabled: config.get('completion.enable'),
            addParentheses: config.get('completion.callParenthesess'),
            fillCallArguments: config.get('completion.showParams'),
            autocompleteEnd: config.get('completion.endAutocompletion'),
            showPropertiesOnMethodCall: config.get('completion.alwaysShowMethods'),
            showDeprecatedItems: config.get('completion.deprecatedMembers'),
        },
        signatureHelp: { enabled: config.get('signatureHelp.enable') },
        inlayHints: {
            parameterNames: hints && config.get('hint.paramName') ? 'all' : 'none',
            parameterTypes: hints && config.get('hint.paramType'),
            variableTypes: hints && config.get('hint.variableType'),
            functionReturnTypes: hints && config.get('hint.returnType'),
        },
    };
}
function useSemanticColor(document) {
    return vscode.workspace.getConfiguration('miliastraLsp', document.uri).get('color.mode') === 'Semantic';
}
function activate(context) {
    return __awaiter(this, void 0, void 0, function* () {
        const executable = process.platform === 'win32' ? 'luau-lsp.exe' : 'luau-lsp';
        const target = process.platform + '-' + process.arch;
        const command = context.asAbsolutePath(path.join('server', 'native', target, executable));
        if (!fs.existsSync(command)) {
            throw new Error('缺少千星奇域语言服务（' + target + '）。请安装对应平台的 VSIX，从源码运行请先执行 npm run build:server。');
        }
        const options = {
            documentSelector: [
                { language: 'lua', scheme: 'file' },
                { language: 'lua', scheme: 'untitled' },
            ],
            middleware: {
                workspace: {
                    configuration: (params) => params.items.map(item => {
                        const scope = item.scopeUri ? vscode.Uri.parse(item.scopeUri) : undefined;
                        return item.section === 'luau-lsp'
                            ? serverSettings(scope)
                            : vscode.workspace.getConfiguration(undefined, scope).get(item.section || '');
                    }),
                },
                provideDocumentSemanticTokens: (doc, token, next) => useSemanticColor(doc) ? next(doc, token) : null,
                provideDocumentSemanticTokensEdits: (doc, id, token, next) => useSemanticColor(doc) ? next(doc, id, token) : null,
                provideDocumentRangeSemanticTokens: (doc, range, token, next) => useSemanticColor(doc) ? next(doc, range, token) : null,
            },
        };
        const args = ['lsp', '--stdio',
            '--definitions=@miliastra=' + context.asAbsolutePath('server/definitions/miliastra.d.luau'),
            '--documentation=' + context.asAbsolutePath('server/definitions/zh-cn.json'),
        ];
        const service = new node_1.LanguageClient('miliastraLsp', '千星奇域 Luau LSP', { command, args }, options);
        client = service;
        const status = vscode.window.createStatusBarItem();
        function updateStatus() {
            status.text = service.isRunning() ? '千星奇域 LSP' : '千星奇域 LSP（已停止）';
            status.tooltip = '千星奇域 Luau 语言服务';
            if (vscode.workspace.getConfiguration('miliastraLsp').get('window.statusBar')) {
                status.show();
            }
            else {
                status.hide();
            }
        }
        context.subscriptions.push(status, service.onDidChangeState(updateStatus), vscode.workspace.onDidChangeConfiguration(event => {
            if (event.affectsConfiguration('miliastraLsp')) {
                updateStatus();
                if (service.state === node_1.State.Running) {
                    void service.sendNotification('workspace/didChangeConfiguration', { settings: {} });
                }
            }
        }));
        yield service.start();
        updateStatus();
    });
}
exports.activate = activate;
function deactivate() {
    return client === null || client === void 0 ? void 0 : client.stop();
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map