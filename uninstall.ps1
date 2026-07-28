# Removes everything install.ps1 put down. Config is left alone unless you
# add -All.
#
#   irm https://raw.githubusercontent.com/Starwaves1/pomo/main/uninstall.ps1 | iex

param([switch]$All)

Remove-Item (Join-Path $env:LOCALAPPDATA 'pomo') -Recurse -Force -EA SilentlyContinue
Remove-Item (Join-Path $env:LOCALAPPDATA 'Microsoft\WindowsApps\pomo.cmd') -Force -EA SilentlyContinue

if ($All) {
    Remove-Item (Join-Path $env:USERPROFILE '.config\pomo') -Recurse -Force -EA SilentlyContinue
}

Write-Host "`n  pomo removed.`n" -ForegroundColor Green
