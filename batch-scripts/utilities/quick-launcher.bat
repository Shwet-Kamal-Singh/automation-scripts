@echo off
setlocal enabledelayedexpansion

:menu
cls
echo Quick Launcher
echo ===============
echo 1. Notepad
echo 2. Calculator
echo 3. File Explorer
echo 4. Command Prompt
echo 5. Task Manager
echo 6. System Information
echo 7. Control Panel
echo 8. Custom Script 1
echo 9. Custom Script 2
echo 0. Exit
echo.

set /p choice="Enter your choice (0-9): "

if "%choice%"=="1" start notepad.exe
if "%choice%"=="2" start calc.exe
if "%choice%"=="3" start explorer.exe
if "%choice%"=="4" start cmd.exe
if "%choice%"=="5" start taskmgr.exe
if "%choice%"=="6" start msinfo32.exe
if "%choice%"=="7" start control.exe
if "%choice%"=="8" call :custom_script1
if "%choice%"=="9" call :custom_script2
if "%choice%"=="0" exit /b

goto menu

:custom_script1
echo Running Custom Script 1...
:: Add your custom script or command here
:: For example: call C:\path\to\your\script1.bat
pause
goto :eof

:custom_script2
echo Running Custom Script 2...
:: Add your custom script or command here
:: For example: call C:\path\to\your\script2.bat
pause
goto :eof