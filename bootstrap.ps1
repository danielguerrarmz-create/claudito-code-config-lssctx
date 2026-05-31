# Bootstrap Claude Code config on Windows (PowerShell).
# Usage:  powershell -ExecutionPolicy Bypass -File .\bootstrap.ps1
# Installs the shared skills, global rulebook, and settings into %USERPROFILE%\.claude,
# then installs the dev toolchain via winget. Backs up anything it would overwrite.
$ErrorActionPreference = 'Stop'
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path
$ClaudeDir = Join-Path $env:USERPROFILE '.claude'
Write-Host "==> Bootstrapping Claude Code config into $ClaudeDir"

New-Item -ItemType Directory -Force (Join-Path $ClaudeDir 'skills') | Out-Null

# 1) Skills
Write-Host "==> Installing skills"
Copy-Item -Recurse -Force (Join-Path $Here 'skills\*') (Join-Path $ClaudeDir 'skills')

# 2) Global auto-activation rulebook
Write-Host "==> Installing CLAUDE.md (skill routing rulebook)"
Copy-Item -Force (Join-Path $Here 'CLAUDE.md') (Join-Path $ClaudeDir 'CLAUDE.md')

# 3) Settings (back up existing first)
$settings = Join-Path $ClaudeDir 'settings.json'
if (Test-Path $settings) {
  Copy-Item -Force $settings "$settings.bak"
  Write-Host "==> Backed up existing settings.json -> settings.json.bak (re-add personal keys like statusLine)"
}
Copy-Item -Force (Join-Path $Here 'settings.json') $settings

# 4) Dev toolchain via winget
Write-Host "==> Installing dev tools (winget)"
$ids = @('OpenJS.NodeJS.LTS','Python.Python.3.13','GoLang.Go','ShiningLight.OpenSSL.Light','Gitleaks.Gitleaks')
foreach ($id in $ids) {
  try { winget install -e --id $id --silent --accept-package-agreements --accept-source-agreements } catch { Write-Host "   (skipped $id)" }
}

Write-Host ""
Write-Host "==> Done."
Write-Host "    1. Start Claude Code and run /login (credentials are NOT in this repo)."
Write-Host "    2. Restart Claude Code once so it begins watching ~\.claude\skills."
Write-Host "    NOTE: split-pane teammates need WSL+tmux; on native Windows they run in-process."
