@echo off
setlocal enabledelayedexpansion

echo Temporary File Cleanup Utility
echo ==============================
echo.

:: List of temporary directories to clean
set "temp_dirs=%temp% %systemroot%\Temp %systemroot%\Prefetch"
set "browser_dirs=%localappdata%\Google\Chrome\User Data\Default\Cache %localappdata%\Mozilla\Firefox\Profiles\*.default\cache2"

:: Ask for confirmation
set /p "confirm=Are you sure you want to delete temporary files? (Y/N): "
if /i "%confirm%" neq "Y" goto :eof

:: Clean each directory
for %%d in (%temp_dirs% %browser_dirs%) do (
    if exist "%%d" (
        echo Cleaning %%d
        del /q /f /s "%%d\*.*" 2>nul
        for /d %%p in ("%%d\*.*") do rmdir "%%p" /s /q 2>nul
    )
)

echo.
echo Temporary file cleanup completed.
pause