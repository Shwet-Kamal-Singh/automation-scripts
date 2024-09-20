@echo off
setlocal enabledelayedexpansion

:: Security Audit Script
echo Windows Security Audit Utility
echo =============================

:: Create a directory for audit results
set "AUDIT_DIR=%USERPROFILE%\Desktop\SecurityAudit_%date:~-4,4%%date:~-10,2%%date:~-7,2%"
mkdir "%AUDIT_DIR%"

:: Firewall status
echo Checking Firewall Status...
netsh advfirewall show allprofiles state > "%AUDIT_DIR%\firewall_status.txt"

:: Windows Update status
echo Checking Windows Update Status...
wuauclt /detectnow
wuauclt /reportnow
powershell "Get-WindowsUpdateLog" > "%AUDIT_DIR%\windows_update_log.txt"

:: List installed software
echo Listing Installed Software...
wmic product get name,version > "%AUDIT_DIR%\installed_software.txt"

:: Check for open ports
echo Checking Open Ports...
netstat -ano > "%AUDIT_DIR%\open_ports.txt"

:: List running services
echo Listing Running Services...
sc query state= all > "%AUDIT_DIR%\running_services.txt"

:: Check user account settings
echo Checking User Account Settings...
net user > "%AUDIT_DIR%\user_accounts.txt"
net localgroup administrators > "%AUDIT_DIR%\admin_accounts.txt"

:: Check system information
echo Gathering System Information...
systeminfo > "%AUDIT_DIR%\system_info.txt"

:: Check for pending reboots
echo Checking for Pending Reboots...
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" > nul 2>&1
if %errorlevel% equ 0 (
    echo Reboot Pending: Yes >> "%AUDIT_DIR%\reboot_status.txt"
) else (
    echo Reboot Pending: No >> "%AUDIT_DIR%\reboot_status.txt"
)

:: Generate summary
echo Generating Summary...
echo Security Audit Summary > "%AUDIT_DIR%\summary.txt"
echo Date: %date% >> "%AUDIT_DIR%\summary.txt"
echo Time: %time% >> "%AUDIT_DIR%\summary.txt"
echo. >> "%AUDIT_DIR%\summary.txt"
echo Please review the generated files for detailed information. >> "%AUDIT_DIR%\summary.txt"

echo Security audit completed. Results are saved in %AUDIT_DIR%
echo Please review the files for detailed information.

endlocal