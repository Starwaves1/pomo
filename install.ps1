# pomo installer for Windows.
# Downloads the script and makes `pomo` a command you can run from anywhere.
#
#   irm https://raw.githubusercontent.com/Starwaves1/pomo/main/install.ps1 | iex

$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = 'Tls12'   # GitHub needs TLS 1.2

$raw = 'https://raw.githubusercontent.com/Starwaves1/pomo/main/pomo'

# Python? The launcher `py` ships with the python.org build; `python` is the
# fallback. If neither is here, say so instead of installing a broken command.
$py = if (Get-Command py -EA SilentlyContinue) { 'py' }
      elseif (Get-Command python -EA SilentlyContinue) { 'python' }
      else { $null }
if (-not $py) {
    Write-Host "`n  Python isn't installed. Get it with:  winget install Python.Python.3.13`n" -ForegroundColor Yellow
    return
}

# The script lives here; a tiny launcher goes in WindowsApps, which is on PATH
# by default, so no PATH editing and it survives reboots.
$dir = Join-Path $env:LOCALAPPDATA 'pomo'
New-Item $dir -ItemType Directory -Force | Out-Null
$script = Join-Path $dir 'pomo'
Invoke-WebRequest $raw -OutFile $script

$shim = Join-Path $env:LOCALAPPDATA 'Microsoft\WindowsApps\pomo.cmd'
Set-Content $shim "@$py `"$script`" %*"

Write-Host "`n  pomo installed. Open a new terminal and run:  pomo`n" -ForegroundColor Green
