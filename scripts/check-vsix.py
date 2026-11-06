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
    module = workspace / "ui" / "panel.lua"
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
return control
"""
    script.write_text(source, encoding="utf-8")
    proc = subprocess.Popen([executable, "lsp", "--stdio", "--definitions=@miliastra=" + definitions,
                             "--documentation=" + docs], cwd=workspace, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    messages = queue.Queue()
    threading.Thread(target=read_messages, args=(proc.stdout, messages), daemon=True).start()

    def send(method, params, request_id=None):
        msg = dict(jsonrpc="2.0", method=method, params=params)
        if request_id is not None:
            msg["id"] = request_id
        body = json.dumps(msg).encode()
        proc.stdin.write(f"Content-Length: {len(body)}\r\n\r\n".encode() + body)
        proc.stdin.flush()

    def request(i, method, params):
        send(method, params, i)
        while True:
            message = messages.get(timeout=20)
            assert message is not None, "Server exited before " + method
            if message.get("id") == i:
                assert "error" not in message, message
                return message["result"]

    doc = {"uri": script.as_uri()}

    def cursor(line, token, offset):
        column = source.splitlines()[line].index(token) + offset
        return dict(textDocument=doc, position=dict(line=line, character=column))

    try:
        request(1, "initialize", dict(processId=os.getpid(), rootUri=workspace.as_uri(),
                                       capabilities={"textDocument": {"diagnostic": {}}}))
        send("initialized", {})
        send("textDocument/didOpen", {"textDocument": dict(doc, languageId="lua", version=1, text=source)})
        diagnostics = request(2, "textDocument/diagnostic", dict(textDocument=doc))
        assert not diagnostics["items"], diagnostics
        result = request(3, "textDocument/completion", cursor(5, "control:", len("control:")))
        items = result if isinstance(result, list) else result["items"]
        assert any(item["label"] == "SetVisible" for item in items)
        result = request(4, "textDocument/definition", cursor(3, "panel.id", 7))
        assert any(loc["uri"].endswith("/ui/panel.lua") and loc["range"]["start"] == {"line": 0, "character": 9}
                   for loc in result), result
        hover = request(5, "textDocument/hover", cursor(5, "SetVisible", 3))
        assert "仅设置可见性" in hover["contents"]["value"], hover
        send("textDocument/didChange", {"textDocument": dict(doc, version=2),
             "contentChanges": [{"text": source.replace("GetClientUIControl(mask)", 'GetClientUIControl("bad")')}]})
        errors = request(6, "textDocument/diagnostic", dict(textDocument=doc))["items"]
        assert any(e["range"]["start"]["line"] == 4 and "number" in e["message"] for e in errors), errors
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
