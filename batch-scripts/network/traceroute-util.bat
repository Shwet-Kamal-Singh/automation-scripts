@echo off
setlocal enabledelayedexpansion

:menu
cls
echo Traceroute Utility
echo ------------------
echo 1. Run traceroute
echo 2. Run traceroute with options
echo 3. Exit
echo.

set /p choice=Enter your choice (1-3): 

if "%choice%"=="1" goto run_traceroute
if "%choice%"=="2" goto run_traceroute_options
if "%choice%"=="3" goto end

echo Invalid choice. Please try again.
timeout /t 2 >nul
goto menu

:run_traceroute
set /p target=Enter the target IP or hostname: 
echo.
echo Running traceroute to %target%...
tracert %target%
pause
goto menu

:run_traceroute_options
set /p target=Enter the target IP or hostname: 
set /p max_hops=Enter maximum number of hops (default is 30): 
set /p timeout=Enter timeout in milliseconds (default is 4000): 

if "%max_hops%"=="" set max_hops=30
if "%timeout%"=="" set timeout=4000

echo.
echo Running traceroute to %target% with max hops %max_hops% and timeout %timeout%ms...
tracert -h %max_hops% -w %timeout% %target%
pause
goto menu

:end
echo Goodbye!
exit /b 0