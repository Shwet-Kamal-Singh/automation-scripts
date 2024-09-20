@echo off
setlocal enabledelayedexpansion

:: Firewall Configuration Script
echo Windows Firewall Configuration Utility

:menu
echo.
echo Select an option:
echo 1. Enable Firewall
echo 2. Disable Firewall
echo 3. Add a new inbound rule
echo 4. Remove an inbound rule
echo 5. List all inbound rules
echo 6. Exit
echo.

set /p "choice=Enter your choice (1-6): "

if "%choice%"=="1" goto enable_firewall
if "%choice%"=="2" goto disable_firewall
if "%choice%"=="3" goto add_rule
if "%choice%"=="4" goto remove_rule
if "%choice%"=="5" goto list_rules
if "%choice%"=="6" goto end

echo Invalid choice. Please try again.
goto menu

:enable_firewall
netsh advfirewall set allprofiles state on
echo Firewall has been enabled.
goto menu

:disable_firewall
netsh advfirewall set allprofiles state off
echo Firewall has been disabled.
goto menu

:add_rule
set /p "name=Enter rule name: "
set /p "port=Enter port number: "
set /p "protocol=Enter protocol (TCP/UDP): "
netsh advfirewall firewall add rule name="%name%" dir=in action=allow protocol=%protocol% localport=%port%
echo Rule "%name%" has been added.
goto menu

:remove_rule
set /p "name=Enter the name of the rule to remove: "
netsh advfirewall firewall delete rule name="%name%"
echo Rule "%name%" has been removed (if it existed).
goto menu

:list_rules
echo Listing all inbound rules:
netsh advfirewall firewall show rule name=all dir=in type=static
pause
goto menu

:end
echo Exiting Firewall Configuration Utility.
endlocal