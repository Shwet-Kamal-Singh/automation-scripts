@echo off
setlocal enabledelayedexpansion

:menu
cls
echo Security Scripts Menu
echo =====================
echo 1. Run Antivirus Scan
echo 2. Encrypt Files
echo 3. Decrypt Files
echo 4. Configure Firewall
echo 5. Run Security Audit
echo 6. Exit

set /p "choice=Enter your choice (1-6): "

if "%choice%"=="1" goto antivirus
if "%choice%"=="2" goto encrypt
if "%choice%"=="3" goto decrypt
if "%choice%"=="4" goto firewall
if "%choice%"=="5" goto audit
if "%choice%"=="6" goto end

echo Invalid choice. Please try again.
pause
goto menu

:antivirus
call antivirus-scan.bat
pause
goto menu

:encrypt
call encrypt-files.bat
pause
goto menu

:decrypt
call decrypt-files.bat
pause
goto menu

:firewall
call firewall-config.bat
goto menu

:audit
call security-audit.bat
pause
goto menu

:end
echo Exiting Security Scripts Menu.
endlocal