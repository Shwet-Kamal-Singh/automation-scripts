@echo off
setlocal enabledelayedexpansion

echo DNS Flush Utility
echo ================

:: Flush DNS cache
ipconfig /flushdns

if !errorlevel! equ 0 (
    echo DNS cache successfully flushed.
) else (
    echo Error: Failed to flush DNS cache.
    exit /b 1
)

:: Display DNS cache to confirm it's empty
echo.
echo Displaying current DNS cache:
ipconfig /displaydns | findstr "Record Name"

echo.
echo DNS flush operation completed.
pause