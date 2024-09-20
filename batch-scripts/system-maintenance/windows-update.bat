@echo off
setlocal enabledelayedexpansion

echo Windows Update Management Utility
echo =================================
echo.

:: Check for administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrative privileges.
    echo Please run as administrator.
    pause
    exit /b 1
)

:menu
echo Select an option:
echo 1. Check for updates
echo 2. Download updates
echo 3. Install updates
echo 4. View update history
echo 5. Exit
echo.

set /p "choice=Enter your choice (1-5): "

if "%choice%"=="1" goto check_updates
if "%choice%"=="2" goto download_updates
if "%choice%"=="3" goto install_updates
if "%choice%"=="4" goto view_history
if "%choice%"=="5" goto :eof

echo Invalid choice. Please try again.
echo.
goto menu

:check_updates
echo Checking for Windows updates...
powershell -Command "Get-WindowsUpdate"
pause
goto menu

:download_updates
echo Downloading Windows updates...
powershell -Command "Get-WindowsUpdate -Download"
pause
goto menu

:install_updates
echo.
set /p "confirm=Are you sure you want to install Windows updates? This may restart your computer. (Y/N): "
if /i "%confirm%" neq "Y" goto menu

echo Installing Windows updates...
powershell -Command "Get-WindowsUpdate -Install"
pause
goto menu

:view_history
echo Displaying Windows Update history...
powershell -Command "Get-WinEvent -LogName Microsoft-Windows-WindowsUpdateClient/Operational | Where-Object {$_.ID -eq 19} | Select-Object TimeCreated, Message | Format-Table -AutoSize -Wrap"
pause
goto menu