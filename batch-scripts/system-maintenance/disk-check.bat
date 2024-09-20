@echo off
setlocal enabledelayedexpansion

echo Disk Check Utility
echo ==================
echo.

:ask_drive
set /p "drive=Enter the drive letter to check (e.g., C): "
if "!drive!"=="" goto ask_drive
set "drive=!drive:~0,1!"

if not exist !drive!:\ (
    echo The drive !drive!: does not exist.
    goto ask_drive
)

echo.
echo You've selected drive !drive!:
echo.

set /p "confirm=Are you sure you want to check drive !drive!:? (Y/N): "
if /i "!confirm!" neq "Y" goto :eof

echo.
echo Checking drive !drive!:...
echo This may take some time. Please be patient.
echo.

:: Check if we need to schedule a check on next reboot
fsutil dirty query !drive!: >nul
if !errorlevel! equ 0 (
    echo Drive !drive!: is not marked as dirty. Proceeding with online check.
    echo.
    chkdsk !drive!: /scan
) else (
    echo Drive !drive!: is marked as dirty or is the system drive.
    echo A full check will be scheduled on the next system reboot.
    echo.
    chkdsk !drive!: /f /r
)

echo.
echo Disk check process completed.
echo If any issues were found, you may need to restart your computer to fix them.
pause