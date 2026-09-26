@echo off
chcp 65001 >nul
setlocal
echo.
echo === Add Codex to user PATH (double-click to run) ===
echo.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0add-codex-to-path.ps1" %*
echo.
echo Press any key to close...
pause >nul