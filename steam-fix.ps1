#Requires -Version 5.1
# Abo Hassan - Steam + Millennium Fix
# Fixes Error 126

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    exit
}

Clear-Host
$steam = "C:\Program Files (x86)\Steam"

Write-Host ""
Write-Host "  Abo Hassan - Steam Fix" -ForegroundColor Cyan
Write-Host "  ======================" -ForegroundColor DarkGray
Write-Host ""

# Step 1: Kill Steam
Write-Host "  [1/4] Closing Steam..." -ForegroundColor Yellow
Get-Process -Name "steam*" -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 3
Get-Process -Name "steam*" -ErrorAction SilentlyContinue | Stop-Process -Force
Write-Host "        Done" -ForegroundColor Green

# Step 2: Remove ALL Millennium files
Write-Host "  [2/4] Removing Millennium..." -ForegroundColor Yellow
Remove-Item "$steam\millennium*.dll" -Force -ErrorAction SilentlyContinue
Remove-Item "$steam\user32.dll" -Force -ErrorAction SilentlyContinue
Remove-Item "$steam\user32.dll.bak" -Force -ErrorAction SilentlyContinue
Remove-Item "$steam\version.dll" -Force -ErrorAction SilentlyContinue
Remove-Item "$steam\version.dll.bak" -Force -ErrorAction SilentlyContinue
Remove-Item "$steam\python*.dll" -Force -ErrorAction SilentlyContinue
Remove-Item "$steam\SDL3*.dll" -Force -ErrorAction SilentlyContinue
Remove-Item "$steam\ext" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$steam\plugins" -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "        Done" -ForegroundColor Green

# Step 3: Clear cache
Write-Host "  [3/4] Clearing cache..." -ForegroundColor Yellow
Remove-Item "$steam\appcache" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$steam\config\htmlcache" -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "        Done" -ForegroundColor Green

# Step 4: Install fresh Millennium
Write-Host "  [4/4] Installing Millennium..." -ForegroundColor Yellow
Write-Host ""
& { Invoke-Expression (Invoke-WebRequest 'https://steambrew.app/install.ps1' -UseBasicParsing).Content }

Write-Host ""
Write-Host "  ======================" -ForegroundColor DarkGray
Write-Host "  Fixed!" -ForegroundColor Green
Write-Host ""
Write-Host "  Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey()
