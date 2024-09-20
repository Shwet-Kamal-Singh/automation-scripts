@echo off
setlocal enabledelayedexpansion

:menu
cls
echo Network Utilities Menu
echo ----------------------
echo 1. DNS Flush
echo 2. IP Configuration
echo 3. Network Share Configuration
echo 4. Ping Test
echo 5. Traceroute Utility
echo 6. WiFi Profile Manager
echo 7. Exit
echo.

set /p choice=Enter your choice (1-7): 

if "%choice%"=="1" call dns-flush.bat
if "%choice%"=="2" call ip-config.bat
if "%choice%"=="3" call network-share-config.bat
if "%choice%"=="4" call ping-test.bat
if "%choice%"=="5" call traceroute-util.bat
if "%choice%"=="6" call wifi-profile-manager.bat
if "%choice%"=="7" goto end

if %choice% geq 1 if %choice% leq 6 (
    echo.
    pause
    goto menu
)

echo Invalid choice. Please try again.
timeout /t 2 >nul
goto menu

:end
echo Goodbye!
exit /b 0