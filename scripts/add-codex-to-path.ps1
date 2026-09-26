<#
  add-codex-to-path.ps1 —— 把 Codex 的安装目录加入「用户 PATH」

  适用场景
    只装了 Codex 桌面版（没有用 npm 装 CLI）的机器上，终端里敲 codex
    会提示「'codex' 不是内部或外部命令」。

  特点
    · 只修改【用户级】PATH，不碰系统 PATH，不会覆盖或截断已有内容
    · 自动定位 Codex 安装目录（先读 ~/.codex/config.toml 的 CODEX_CLI_PATH，
      再在 %LOCALAPPDATA%\OpenAI\Codex\bin 下找）
    · 已存在则跳过，不会重复添加
    · 追加到 PATH 末尾：若已有 npm 装的 codex，仍然优先用 npm 那份
    · 不需要管理员权限

  用法
    powershell -ExecutionPolicy Bypass -File .\add-codex-to-path.ps1
    powershell -ExecutionPolicy Bypass -File .\add-codex-to-path.ps1 -DryRun
    powershell -ExecutionPolicy Bypass -File .\add-codex-to-path.ps1 -Path "C:\...\OpenAI\Codex\bin\<哈希>"

  也可以直接双击同目录下的 add-codex-to-path.cmd。
#>
param(
    [string]$Path,      # 手动指定要加入的目录（可选）
    [switch]$DryRun     # 只显示将要做什么，不实际修改
)

$ErrorActionPreference = 'Stop'

function Find-CodexDir {
    # 1) 优先从 ~/.codex/config.toml 的 CODEX_CLI_PATH 推断
    $cfg = Join-Path $env:USERPROFILE '.codex\config.toml'
    if (Test-Path -LiteralPath $cfg) {
        $txt = Get-Content -LiteralPath $cfg -Raw -Encoding utf8
        $m = [regex]::Match($txt, "CODEX_CLI_PATH\s*=\s*'([^']*codex\.exe)'")
        if ($m.Success) {
            $exe = $m.Groups[1].Value
            if (Test-Path -LiteralPath $exe) { return ([System.IO.Path]::GetDirectoryName($exe)) }
        }
    }
    # 2) 在 %LOCALAPPDATA%\OpenAI\Codex\bin\<哈希>\ 下找最新的 codex.exe
    $base = Join-Path $env:LOCALAPPDATA 'OpenAI\Codex\bin'
    if (Test-Path -LiteralPath $base) {
        $hit = Get-ChildItem -LiteralPath $base -Recurse -Filter 'codex.exe' -ErrorAction SilentlyContinue |
               Sort-Object LastWriteTime -Descending | Select-Object -First 1
        if ($hit) { return $hit.DirectoryName }
    }
    return $null
}

Write-Host ''
Write-Host '=== 把 Codex 加入用户 PATH ===' -ForegroundColor Cyan
Write-Host ''

$target = $Path
if (-not $target) { $target = Find-CodexDir }

if (-not $target) {
    Write-Host '✗ 没找到 Codex 安装目录。' -ForegroundColor Red
    Write-Host '  · 确认已安装 Codex 桌面版；或'
    Write-Host '  · 用 -Path 手动指定目录，例如：'
    Write-Host '      -Path "C:\Users\你\AppData\Local\OpenAI\Codex\bin\xxxxxxxx"'
    Write-Host '  · 目录怎么找：打开 %USERPROFILE%\.codex\config.toml，'
    Write-Host '    搜 CODEX_CLI_PATH，去掉末尾的 codex.exe 即是。'
    exit 1
}

try { $target = (Resolve-Path -LiteralPath $target).Path.TrimEnd('\') }
catch { Write-Host "✗ 目录不存在：$target" -ForegroundColor Red; exit 1 }

Write-Host "目标目录：$target"
if (-not (Test-Path -LiteralPath (Join-Path $target 'codex.exe'))) {
    Write-Host '⚠ 该目录下没有 codex.exe，请确认选对了目录。' -ForegroundColor Yellow
}

$userPathRaw = [Environment]::GetEnvironmentVariable('Path', 'User')
if (-not $userPathRaw) { $userPathRaw = '' }
$entries = @($userPathRaw -split ';' | Where-Object { $_ -ne '' })

$already = @($entries | Where-Object { $_.TrimEnd('\').Equals($target, [System.StringComparison]::OrdinalIgnoreCase) })
if ($already.Count -gt 0) {
    Write-Host '✓ 该目录已经在用户 PATH 里，无需修改。' -ForegroundColor Green
} else {
    if ($DryRun) {
        Write-Host '[DryRun] 将把该目录追加到用户 PATH 末尾（未实际修改）。' -ForegroundColor Yellow
    } else {
        $newPath = ($userPathRaw.TrimEnd(';') + ';' + $target).TrimStart(';')
        [Environment]::SetEnvironmentVariable('Path', $newPath, 'User')
        Write-Host '✓ 已追加到用户 PATH 末尾。' -ForegroundColor Green
    }
}

$npmDir = (Join-Path $env:APPDATA 'npm').TrimEnd('\')
$npmOnPath = @($entries | Where-Object { $_.TrimEnd('\').Equals($npmDir, [System.StringComparison]::OrdinalIgnoreCase) })
if ($npmOnPath.Count -gt 0) {
    Write-Host ''
    Write-Host "提示：用户 PATH 里已有 npm 目录（$npmDir），" -ForegroundColor DarkGray
    Write-Host '      codex 仍会优先用 npm 装的那份（本目录追加在末尾，不影响它）。' -ForegroundColor DarkGray
}

Write-Host ''
Write-Host '下一步：' -ForegroundColor Cyan
Write-Host '  1) 关闭所有已打开的终端窗口，重新开一个（必要时注销或重启一次）'
Write-Host '  2) 验证：codex --version'
Write-Host ''
Write-Host '若想撤销：环境变量窗口里把该目录从用户 Path 中删除即可。'
Write-Host ''
