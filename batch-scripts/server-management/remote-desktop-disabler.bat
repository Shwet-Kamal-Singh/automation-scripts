@echo off
setlocal enabledelayedexpansion

echo Remote Desktop Disabler
echo ----------------------

:ask_confirmation
set /p confirm=Are you sure you want to disable Remote Desktop? (Y/N): 
if /i "%confirm%" equ "Y" goto :disable_rdp
if /i "%confirm%" equ "N" goto :abort
echo Invalid input. Please enter Y or N.
goto :ask_confirmation

:disable_rdp
echo.
echo Disabling Remote Desktop...

:: Disable Remote Desktop
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f

if %errorlevel% equ 0 (
    echo Remote Desktop has been successfully disabled.
) else (
    echo Failed to disable Remote Desktop. Please run this script as an administrator.
    goto :end
)

:: Stop the Remote Desktop Services
echo Stopping Remote Desktop Services...
net stop TermService
if %errorlevel% equ 0 (
    echo Remote Desktop Services stopped successfully.
) else (
    echo Failed to stop Remote Desktop Services.
)

:: Disable the Remote Desktop firewall rule
echo Disabling Remote Desktop firewall rule...
netsh advfirewall firewall set rule group="remote desktop" new enable=No
if %errorlevel% equ 0 (
    echo Remote Desktop firewall rule disabled successfully.
) else (
    echo Failed to disable Remote Desktop firewall rule.
)

goto :end

:abort
echo Operation aborted. Remote Desktop settings were not changed.

:end
echo.
pause