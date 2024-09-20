@echo off
setlocal enabledelayedexpansion

:menu
cls
echo Server Management Menu
echo ----------------------
echo 1. Log Rotator
echo 2. Remote Desktop Enabler
echo 3. Remote Desktop Disabler
echo 4. Server Monitor
echo 5. Service Controller
echo 6. SSH Key Manager
echo 7. Web Server Config
echo 8. Exit

set /p choice=Enter your choice (1-8): 

if "%choice%"=="1" call :run_script log-rotator.bat
if "%choice%"=="2" call :run_script remote-desktop-enabler.bat
if "%choice%"=="3" call :run_script remote-desktop-disabler.bat
if "%choice%"=="4" call :run_script server-monitor.bat
if "%choice%"=="5" call :run_script service-controller.bat
if "%choice%"=="6" call :run_script ssh-key-manager.bat
if "%choice%"=="7" call :run_script web-server-config.bat
if "%choice%"=="8" exit /b

goto menu

:run_script
echo Running %1...
call %1
echo.
pause
goto :eof