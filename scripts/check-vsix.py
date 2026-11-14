"""Exercise the packaged language server on one Miliastra script, on each release platform."""
import json
import os
from pathlib import Path
import queue
import subprocess
import sys
import tempfile
import threading
import zipfile


def read_messages(stream, messages):
    try:
        while True:
            headers = {}
            for line in iter(stream.readline, b""):
                if not line.strip():
                    break
                key, value = line.split(b":", 1)
                headers[key.lower()] = value.strip()
            if not headers:
                return
            messages.put(json.loads(stream.read(int(headers[b"content-length"]))))
    finally:
        messages.put(None)


def check(package, root):
    with zipfile.ZipFile(package) as archive:
        binaries = [n for n in archive.namelist() if n.startswith("extension/server/native/")
                    and Path(n).name in ("luau-lsp", "luau-lsp.exe")]
        assert len(binaries) == 1, binaries
        executable = Path(archive.extract(binaries[0], root))
        definitions = archive.extract("extension/server/definitions/miliastra.d.luau", root)
        docs = archive.extract("extension/server/definitions/zh-cn.json", root)
        manifest = json.loads(archive.read("extension/package.json"))
        assert "extension/" + manifest["main"].removeprefix("./") + ".js" in archive.namelist()
        assert "extension/node_modules/vscode-languageclient/package.json" in archive.namelist()
    executable.chmod(0o755)
    workspace = root / "game"
    module = workspace / "scripts" / "ui" / "panel.lua"
    module.parent.mkdir(parents=True)
    module.write_text("return { id = 7 }\n", encoding="utf-8")
    script = workspace / "main.lua"
    source = """--!strict
local panel = require("ui.panel")
local mask = 1 << 2
mask |= panel.id & 7
local control = game.GetClientUIControl(mask)
control:SetVisible((mask >> 1) ~= 0)
local easing: Enum.EaseType = Enum.EaseType.Linear
game.Tween(control, {}, 1):SetEase(easing)
function OnInit() end
function OnStart() end
function OnEnable() end
function OnDisable() end
function OnUpdate(dt: number) dt |= 1; control:SetVisible(dt > 0) end
function OnLevelUpdate(dt: number) end
function OnDestroy() end
local panelSlash = require("ui/panel")
assert(panelSlash.id == panel.id)
local signal = game.ServerSignal("check")
signal:AddIntList({1, 2})
signal:AddFloatList({1.5})
signal:AddStringList({"a", "b"})
signal:AddBoolList({true})
signal:AddGuidList({1})
signal:AddEntityList({1})
signal:AddPrefabIdList({1})
signal:AddConfigIdList({1})
signal:AddVector3List({{x = 1, y = 2, z = 3}})
script:RegisterServerSignalHandler("check", function(name: string, params: {any}) print(name, params) end)
script:RegisterCustomVariableChangedHandler(Enum.CustomVariableEntityType.Level, "check",
    function(entity: Enum.CustomVariableEntityType, name: string) print(entity, name) end)
local function onCursor(data: CursorEventData) print(data.dragging) end
local area = script.object :: ClientUICursorEventAreaControl
area:AddCursorEventListener(Enum.CursorEventType.CursorClick, onCursor)
area:RemoveCursorEventListener(Enum.CursorEventType.CursorClick, onCursor)
area:SimulateCursorClick()
local button = script.object :: ClientUIPresetButtonControl
button:AddCursorEventListener(Enum.CursorEventType.CursorClick, onCursor)
button:RemoveCursorEventListener(Enum.CursorEventType.CursorClick, onCursor)
print(control.id)
local actions = {run = function(value: number) return value end, ["run-task"] = function(value: number) return value end}
print("中文", actions.run)
local function identity<T>(value: T): T return value end
local typed = identity<<typeof({enabled = 1 < 2})>>({enabled = true})
assert(typed.enabled)
return control
"""
    script.write_text(source, encoding="utf-8")
    proc = subprocess.Popen([executable, "lsp", "--stdio", "--definitions=@miliastra=" + definitions,
                             "--documentation=" + docs], cwd=workspace, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    messages = queue.Queue()
    threading.Thread(target=read_messages, args=(proc.stdout, messages), daemon=True).start()

    settings = {"require": {"modulePaths": ["?.lua"]}, "inlayHints": {"parameterNames": "all"}}

    def write(msg):
        body = json.dumps(msg).encode()
        proc.stdin.write(f"Content-Length: {len(body)}\r\n\r\n".encode() + body)
        proc.stdin.flush()

    def send(method, params, request_id=None):
        msg = dict(jsonrpc="2.0", method=method, params=params)
        if request_id is not None:
            msg["id"] = request_id
        write(msg)

    def receive():
        message = messages.get(timeout=20)
        assert message is not None, "Server exited unexpectedly"
        if message.get("method") == "workspace/configuration":
            write(dict(jsonrpc="2.0", id=message["id"], result=[
                settings if item.get("scopeUri") else {"diagnostics": {"enabled": False}}
                for item in message["params"]["items"]]))
        return message

    def request(i, method, params):
        send(method, params, i)
        while True:
            message = receive()
            if message.get("id") == i and "method" not in message:
                assert "error" not in message, message
                return message["result"]

    doc = {"uri": script.as_uri()}

    def cursor(line, token, offset):
        column = source.splitlines()[line].index(token) + offset
        return dict(textDocument=doc, position=dict(line=line, character=column))

    try:
        request(1, "initialize", dict(processId=os.getpid(), rootUri=workspace.as_uri(),
                                       capabilities={"workspace": {"configuration": True}, "textDocument": {"diagnostic": {},
                                           "completion": {"completionItem": {"snippetSupport": True}}}}))
        send("initialized", {})
        while receive().get("method") != "workspace/configuration":
            pass
        send("textDocument/didOpen", {"textDocument": dict(doc, languageId="lua", version=1, text=source)})
        missing = request(20, "textDocument/diagnostic", dict(textDocument=doc))["items"]
        assert any("Unknown require" in e["message"] for e in missing), missing
        colon = cursor(5, "control:", len("control:"))
        dot = cursor(source.splitlines().index("print(control.id)"), "control.", len("control."))
        items = request(25, "textDocument/completion", colon)
        assert any(i["label"] == "SetVisible" and i.get("labelDetails") for i in items), items
        items = request(26, "textDocument/completion", dot)
        assert any(i["label"] == "id" for i in items) and not any(i["label"] == "SetVisible" for i in items), items
        settings["require"]["modulePaths"] = ["scripts/?.lua"]
        settings["completion"] = {"showParams": False, "alwaysShowMethods": True}
        send("workspace/didChangeConfiguration", {"settings": {}})
        while receive().get("method") != "workspace/configuration":
            pass
        diagnostics = request(2, "textDocument/diagnostic", dict(textDocument=doc))
        assert not diagnostics["items"], diagnostics
        module.unlink()
        send("workspace/didChangeWatchedFiles", {"changes": [{"uri": module.as_uri(), "type": 3}]})
        missing = request(30, "textDocument/diagnostic", dict(textDocument=doc))["items"]
        assert any("Unknown require" in e["message"] for e in missing), missing
        module.write_text("return { id = 7 }\n", encoding="utf-8")
        send("workspace/didChangeWatchedFiles", {"changes": [{"uri": module.as_uri(), "type": 1}]})
        restored = request(31, "textDocument/diagnostic", dict(textDocument=doc))
        assert not restored["items"], restored
        result = request(3, "textDocument/completion", cursor(5, "control:", len("control:")))
        items = result if isinstance(result, list) else result["items"]
        assert any(item["label"] == "SetVisible" for item in items)
        assert not any(i.get("labelDetails") or i["label"] == "id" for i in items), items
        items = request(27, "textDocument/completion", dot)
        method = next(i for i in items if i["label"] == "SetVisible")
        assert not method.get("labelDetails") and method["insertText"] == "SetVisible(${1:visible})$0", method
        assert method["additionalTextEdits"] == [{"newText": ":", "range": {
            "start": dict(dot["position"], character=dot["position"]["character"] - 1), "end": dot["position"]}}], method
        action_line = source.splitlines().index('print("中文", actions.run)')
        action_cursor = cursor(action_line, "actions.", len("actions."))
        items = request(29, "textDocument/completion", action_cursor)
        action = next(i for i in items if i["label"] == "run-task")
        assert action["textEdit"]["newText"] == '["run-task"](${1:value})$0', action
        assert action["additionalTextEdits"] == [{"newText": "", "range": {
            "start": dict(action_cursor["position"], character=action_cursor["position"]["character"] - 1),
            "end": action_cursor["position"]}}], action
        items = request(28, "textDocument/completion", cursor(4, "game.", len("game.")))
        assert any(i["label"] == "GetClientUIControl" for i in items), items
        result = request(4, "textDocument/definition", cursor(3, "panel.id", 7))
        assert any(loc["uri"].endswith("/ui/panel.lua") and loc["range"]["start"] == {"line": 0, "character": 9}
                   for loc in result), result
        hover = request(5, "textDocument/hover", cursor(5, "SetVisible", 3))
        assert "仅设置可见性" in hover["contents"]["value"], hover
        signature = request(21, "textDocument/signatureHelp", cursor(5, "mask", 2))
        assert signature and "SetVisible" in signature["signatures"][0]["label"], signature
        hints = request(22, "textDocument/inlayHint", dict(textDocument=doc,
                        range={"start": {"line": 5, "character": 0}, "end": {"line": 6, "character": 0}}))
        assert hints and not any("disp:" in json.dumps(h) or '"x:"' in json.dumps(h) for h in hints), hints
        tokens = request(23, "textDocument/semanticTokens/full", dict(textDocument=doc))["data"]
        line = column = 0
        previous_end = (0, 0)
        for i in range(0, len(tokens), 5):
            delta_line, delta_column, length = tokens[i:i + 3]
            line += delta_line
            column = delta_column if delta_line else column + delta_column
            assert (line, column) >= previous_end and length > 0, tokens
            previous_end = (line, column + length)
        send("textDocument/didChange", {"textDocument": dict(doc, version=2),
             "contentChanges": [{"text": source.replace("GetClientUIControl(mask)", 'GetClientUIControl("bad")')
                                .replace("function OnInit()", "local function OnInit()")
                                .replace("function OnStart()", "function OnCustom()")
                                .replace("control:SetVisible(dt > 0)", 'control:SetVisible("bad")')
                                .replace("AddIntList({1, 2})", "AddIntList(1)")
                                .replace("area:SimulateCursorClick()", "local event = area:SimulateCursorClick(); print(event.dragging)")}]})
        errors = request(6, "textDocument/diagnostic", dict(textDocument=doc))["items"]
        assert any(e["range"]["start"]["line"] == 4 and "number" in e["message"] for e in errors), errors
        unused = [e["message"] for e in errors if e["code"] == 8]
        assert len(unused) == 2 and any("'OnInit'" in m for m in unused) and any("'OnCustom'" in m for m in unused), errors
        assert any(e["range"]["start"]["line"] == 12 and "boolean" in e["message"] for e in errors), errors
        assert any("{number}" in e["message"] for e in errors), errors
        click_line = source.splitlines().index("area:SimulateCursorClick()")
        assert any(e["range"]["start"]["line"] == click_line and e["severity"] == 1 for e in errors), errors
        outside = {"uri": (root / "game-other" / "main.lua").as_uri()}
        send("textDocument/didOpen", {"textDocument": dict(outside, languageId="lua", version=1,
             text='--!strict\nlocal value: number = "bad"\nreturn value')})
        outside_errors = request(24, "textDocument/diagnostic", dict(textDocument=outside))["items"]
        assert not outside_errors, outside_errors  # A sibling folder must use the global configuration.
        request(7, "shutdown", None)
        send("exit", None)
        assert proc.wait(timeout=5) == 0
    finally:
        if proc.poll() is None:
            proc.kill()
            proc.wait()
        proc.stdin.close()
        proc.stdout.close()


if __name__ == "__main__":
    with tempfile.TemporaryDirectory() as directory:
        check(sys.argv[1], Path(directory))
    print("Packaged LSP passed: diagnostics, completion, cross-file definition and Chinese hover.")
