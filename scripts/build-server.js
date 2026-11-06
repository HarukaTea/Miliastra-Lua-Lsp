const { execFileSync } = require('node:child_process');
const { createHash } = require('node:crypto');
const fs = require('node:fs');
const path = require('node:path');

const root = path.resolve(__dirname, '..');
const tag = '1.70.1';
const revision = '0382dc76ca9b73df3c8e7c9cd85a8dd493cbd0ae';
const patches = ['luau-lsp.patch', 'luau.patch'].map(name => path.join(root, 'server', 'patches', name));
const hash = createHash('sha256').update(revision);
for (const patch of patches) hash.update(fs.readFileSync(patch));
const build = path.join(root, '.build', hash.digest('hex').slice(0, 12));
const source = path.join(build, 'src');
const output = path.join(build, 'out');
const native = path.join(root, 'server', 'native', process.platform + '-' + process.arch);
const exe = process.platform === 'win32' ? 'luau-lsp.exe' : 'luau-lsp';

function run(command, args, cwd) {
    execFileSync(command, args, { cwd, stdio: 'inherit' });
}

fs.mkdirSync(build, { recursive: true });
if (!fs.existsSync(source)) {
    run('git', ['clone', '--depth', '1', '--branch', tag,
        'https://github.com/JohnnyMorganz/luau-lsp.git', source], build);
}
const head = execFileSync('git', ['rev-parse', 'HEAD'], { cwd: source, encoding: 'utf8' }).trim();
if (head !== revision) throw new Error('Unexpected upstream revision: ' + head);
run('git', ['submodule', 'update', '--init', '--depth', '1', 'luau'], source);
for (const [i, cwd] of [source, path.join(source, 'luau')].entries()) {
    // On a repeated build, skip a patch only when its entire reverse applies.
    try {
        execFileSync('git', ['apply', '--reverse', '--check', patches[i]], { cwd, stdio: 'ignore' });
    } catch {
        run('git', ['apply', '--whitespace=nowarn', patches[i]], cwd);
    }
}
const architecture = process.arch === 'arm64' ? 'arm64' : 'x86_64';
const platformOptions = process.platform === 'darwin' ? ['-DCMAKE_OSX_ARCHITECTURES=' + architecture] : [];
run('cmake', [...platformOptions, '-S', source, '-B', output, '-DCMAKE_BUILD_TYPE=Release',
    '-DLSP_STATIC_CRT=ON', '-DLSP_WERROR=OFF', '-DLUAU_BUILD_TESTS=OFF', '-DLUAU_BUILD_CLI=OFF'], root);
run('cmake', ['--build', output, '--config', 'Release', '--target', 'Luau.LanguageServer.CLI', '--parallel',
    process.env.CMAKE_BUILD_PARALLEL_LEVEL || '4'], root);

const binary = [path.join(output, 'Release', exe), path.join(output, exe)].find(file => fs.existsSync(file));
if (!binary) throw new Error('CMake did not produce ' + exe);
fs.mkdirSync(native, { recursive: true });
fs.copyFileSync(binary, path.join(native, exe));
fs.chmodSync(path.join(native, exe), 0o755);
console.log('Built ' + path.join(native, exe));
