@echo off
setlocal enabledelayedexpansion

:menu
cls
echo System Maintenance Menu
echo -----------------------
echo 1. Cleanup Temporary Files
echo 2. Clear Event Logs
echo 3. Defragment Disk
echo 4. Check Disk
echo 5. Generate System Info Report
echo 6. Run Windows Update
echo 7. Exit

set /p choice=Enter your choice (1-7): 

if "%choice%"=="1" call :run_script cleanup-temp.bat
if "%choice%"=="2" call :run_script clear-event-logs.bat
if "%choice%"=="3" call :run_script defrag-disk.bat
if "%choice%"=="4" call :run_script disk-check.bat
if "%choice%"=="5" call :run_script system-info-report.bat
if "%choice%"=="6" call :run_script windows-update.bat
if "%choice%"=="7" exit /b

goto menu

:run_script
echo Running %1...
call %1
echo.
pause
goto :eof