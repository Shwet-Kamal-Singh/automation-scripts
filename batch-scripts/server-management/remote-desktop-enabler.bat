@echo off
setlocal enabledelayedexpansion

echo Remote Desktop Enabler
echo =====================

echo Enabling Remote Desktop...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
netsh advfirewall firewall set rule group="Remote Desktop" new enable=Yes
echo Remote Desktop has been enabled.

:configure_nla
set /p "enable_nla=Do you want to enable Network Level Authentication? (Y/N): "
if /i "%enable_nla%"=="Y" (
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 1 /f
    echo Network Level Authentication has been enabled.
) else if /i "%enable_nla%"=="N" (
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f
    echo Network Level Authentication has been disabled.
) else (
    echo Invalid input. NLA configuration skipped.
)

echo.
echo Configuration complete. Please restart your computer for changes to take effect.
pause