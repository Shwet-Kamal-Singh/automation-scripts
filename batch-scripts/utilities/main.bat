@echo off
setlocal enabledelayedexpansion

:menu
cls
echo Utilities Menu
echo --------------
echo 1. Bulk Rename Files
echo 2. File Compression
echo 3. File Search
echo 4. Quick Launcher
echo 5. Manage Scheduled Tasks
echo 6. Export System Information
echo 7. Exit

set /p choice=Enter your choice (1-7): 

if "%choice%"=="1" call :run_script bulk-rename.bat
if "%choice%"=="2" call :run_script file-compression.bat
if "%choice%"=="3" call :run_script file-search.bat
if "%choice%"=="4" call :run_script quick-launcher.bat
if "%choice%"=="5" call :run_script scheduled-tasks.bat
if "%choice%"=="6" call :run_script system-info-export.bat
if "%choice%"=="7" exit /b

goto menu

:run_script
echo Running %1...
call %1
echo.
pause
goto :eof