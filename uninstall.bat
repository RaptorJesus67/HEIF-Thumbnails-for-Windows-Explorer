@echo off
title HEIC Thumbnail Provider Uninstaller

net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

set "INSTALL_DIR=%ProgramFiles%\HeicThumbnailProvider"
taskkill /f /im prevhost.exe >nul 2>&1

if exist "%INSTALL_DIR%\HeicThumbnailProvider.dll" (
    regsvr32.exe /u /s "%INSTALL_DIR%\HeicThumbnailProvider.dll"
)

taskkill /f /im explorer.exe >nul 2>&1
timeout /t 1 /nobreak >nul
del /f /s /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
start explorer.exe

if exist "%INSTALL_DIR%" rmdir /s /q "%INSTALL_DIR%" >nul 2>&1

echo [SUCCESS] HEIC Thumbnail Provider has been uninstalled.
pause
