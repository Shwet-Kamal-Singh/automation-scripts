@echo off
setlocal enabledelayedexpansion

echo Windows Event Log Clearing Utility
echo ==================================
echo.

:: List of common event logs
set "logs=Application System Security"

:: Ask for confirmation
set /p "confirm=Are you sure you want to clear Windows event logs? (Y/N): "
if /i "%confirm%" neq "Y" goto :eof

:: Clear each log
for %%l in (%logs%) do (
    echo Clearing %%l log...
    wevtutil cl %%l
    if !errorlevel! equ 0 (
        echo %%l log cleared successfully.
    ) else (
        echo Failed to clear %%l log. Error code: !errorlevel!
    )
    echo.
)

:: Optional: Clear additional logs
echo Clearing other event logs...
for /f "tokens=*" %%l in ('wevtutil el') do (
    if "%%l" neq "Application" if "%%l" neq "System" if "%%l" neq "Security" (
        echo Clearing %%l...
        wevtutil cl "%%l"
        if !errorlevel! equ 0 (
            echo %%l cleared successfully.
        ) else (
            echo Failed to clear %%l. Error code: !errorlevel!
        )
    )
)

echo.
echo Event log clearing process completed.
pause