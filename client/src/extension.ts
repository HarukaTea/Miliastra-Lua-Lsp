import * as fs from 'fs';
import * as path from 'path';
import * as vscode from 'vscode';
import { LanguageClient, LanguageClientOptions, SemanticTokensRegistrationType, State } from 'vscode-languageclient/node';

let client: LanguageClient | undefined;
let clientLifecycle: Promise<void> = Promise.resolve();

function serverSettings(uri?: vscode.Uri) {
    const config = vscode.workspace.getConfiguration('miliastraLsp', uri ?? null);
    const hints = config.get<boolean>('hint.enable');
    return {
        platform: { type: 'standard' },
        types: { roblox: false },
        sourcemap: { enabled: false },
        require: { modulePaths: config.get<string[]>('runtime.path') },
        ignoreGlobs: config.get<string[]>('workspace.ignoreDir'),
        index: { maxFiles: config.get<number>('workspace.maxPreload') },
        diagnostics: { enabled: config.get<boolean>('diagnostics.enable') },
        completion: {
            enabled: config.get<boolean>('completion.enable'),
            addParentheses: config.get<boolean>('completion.callParenthesess'),
            showParams: config.get<boolean>('completion.showParams'),
            autocompleteEnd: config.get<boolean>('completion.endAutocompletion'),
            alwaysShowMethods: config.get<boolean>('completion.alwaysShowMethods'),
            showDeprecatedItems: config.get<boolean>('completion.deprecatedMembers'),
        },
        signatureHelp: { enabled: config.get<boolean>('signatureHelp.enable') },
        inlayHints: {
            parameterNames: hints && config.get<boolean>('hint.paramName') ? 'all' : 'none',
            parameterTypes: hints && config.get<boolean>('hint.paramType'),
            variableTypes: hints && config.get<boolean>('hint.variableType'),
            functionReturnTypes: hints && config.get<boolean>('hint.returnType'),
        },
    };
}

function useSemanticColor(document: vscode.TextDocument) {
    return vscode.workspace.getConfiguration('miliastraLsp', document.uri).get('color.mode') === 'Semantic';
}

export async function activate(context: vscode.ExtensionContext) {
    const executable = process.platform === 'win32' ? 'luau-lsp.exe' : 'luau-lsp';
    const target = process.platform + '-' + process.arch;
    const command = context.asAbsolutePath(path.join('server', 'native', target, executable));
    if (!fs.existsSync(command)) {
        throw new Error('缺少千星奇域语言服务（' + target + '）。请安装对应平台的 VSIX，从源码运行请先执行 npm run build:server。');
    }
    const options: LanguageClientOptions = {
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
    const service = new LanguageClient('miliastraLsp', '千星奇域 Luau LSP', { command, args }, options);
    client = service;
    context.subscriptions.push(
        service.onNotification('$/command', (params) => {
            if (params.command === 'cursorMove') {
                return vscode.commands.executeCommand('cursorMove', params.data);
            }
        }),
        vscode.commands.registerCommand('miliastraLsp.rename', async (uri: string, position: { line: number; character: number }) => {
            const editor = vscode.window.activeTextEditor;
            if (editor && editor.document.uri.toString() === vscode.Uri.parse(uri).toString()) {
                const pos = new vscode.Position(position.line, position.character);
                editor.selection = new vscode.Selection(pos, pos);
                await vscode.commands.executeCommand('editor.action.rename');
            }
        }),
    );
    const status = vscode.window.createStatusBarItem();
    function updateStatus() {
        status.text = service.isRunning() ? '千星奇域 LSP' : '千星奇域 LSP（已停止）';
        status.tooltip = '千星奇域 Luau 语言服务';
        if (vscode.workspace.getConfiguration('miliastraLsp', vscode.window.activeTextEditor?.document.uri ?? null).get('window.statusBar')) {
            status.show();
        } else {
            status.hide();
        }
    }
    context.subscriptions.push(status, service.onDidChangeState(updateStatus),
        vscode.window.onDidChangeActiveTextEditor(updateStatus),
        vscode.workspace.onDidChangeWorkspaceFolders(() => {
            // The native server advertises changeNotifications=false; restart to resync folders and open buffers.
            clientLifecycle = clientLifecycle.then(async () => {
                await service.stop();
                await service.start();
            }).catch(error => service.error('更新千星奇域语言服务的工作区失败', error, 'force'));
        }),
        vscode.workspace.onDidChangeConfiguration(event => {
            if (event.affectsConfiguration('miliastraLsp')) {
                updateStatus();
                if (service.state === State.Running) {
                    if (event.affectsConfiguration('miliastraLsp.color.mode')) {
                        const feature = service.getFeature(SemanticTokensRegistrationType.method);
                        const providers = new Set(vscode.workspace.textDocuments.map(document => feature.getProvider(document)));
                        for (const provider of providers) {
                            provider?.onDidChangeSemanticTokensEmitter.fire();
                        }
                    }
                    void service.sendNotification('workspace/didChangeConfiguration', { settings: {} });
                }
            }
        }));
    clientLifecycle = service.start();
    await clientLifecycle;
    updateStatus();
}

export function deactivate() {
    return clientLifecycle.then(() => client?.stop());
}
