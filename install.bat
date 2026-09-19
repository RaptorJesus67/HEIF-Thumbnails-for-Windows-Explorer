@echo off
title HEIC Thumbnail Provider Installer

:: Request Administrator privileges if not elevated
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"

if not exist "%~dp0HeicThumbnailProvider.dll" (
    echo [ERROR] HeicThumbnailProvider.dll not found in current folder.
    pause
    exit /b 1
)

set "INSTALL_DIR=%ProgramFiles%\HeicThumbnailProvider"
taskkill /f /im prevhost.exe >nul 2>&1

if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%" >nul 2>&1
copy /y "%~dp0*.dll" "%INSTALL_DIR%\" >nul

echo [*] Registering Shell Extension...
regsvr32.exe /s "%INSTALL_DIR%\HeicThumbnailProvider.dll"

echo [*] Refreshing Windows Explorer cache...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 1 /nobreak >nul
del /f /s /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
start explorer.exe

echo.
echo =========================================================================
echo   [SUCCESS] HEIC Thumbnail Provider Installed!
echo =========================================================================
echo Installed to: "%INSTALL_DIR%"
pause