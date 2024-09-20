@echo off
setlocal enabledelayedexpansion

:menu
cls
echo IP Configuration Utility
echo ========================
echo 1. Display IP configuration
echo 2. Release IP address
echo 3. Renew IP address
echo 4. Flush DNS cache
echo 5. Exit
echo.

set /p choice=Enter your choice (1-5): 

if "%choice%"=="1" goto display
if "%choice%"=="2" goto release
if "%choice%"=="3" goto renew
if "%choice%"=="4" goto flushdns
if "%choice%"=="5" goto end

echo Invalid choice. Please try again.
timeout /t 2 >nul
goto menu

:display
ipconfig /all
pause
goto menu

:release
ipconfig /release
echo IP address released.
pause
goto menu

:renew
ipconfig /renew
echo IP address renewed.
pause
goto menu

:flushdns
ipconfig /flushdns
echo DNS cache flushed.
pause
goto menu

:end
echo Exiting IP Configuration Utility.
exit /b 0