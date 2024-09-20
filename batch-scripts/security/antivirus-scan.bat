@echo off
setlocal enabledelayedexpansion

:: Antivirus Scan Script
echo Starting Antivirus Scan...

:: Set the scan path (default to C: drive)
set "SCAN_PATH=C:\"
if not "%~1"=="" set "SCAN_PATH=%~1"

:: Check if Windows Defender is available
where /q mpcmdrun.exe
if %ERRORLEVEL% neq 0 (
    echo Windows Defender not found. Please ensure it's installed and try again.
    goto :EOF
)

:: Run a quick scan if no path specified, otherwise do a custom scan
if "%SCAN_PATH%"=="C:\" (
    echo Performing a quick scan...
    start /wait mpcmdrun.exe -Scan -ScanType 1
) else (
    echo Performing a custom scan on %SCAN_PATH%...
    start /wait mpcmdrun.exe -Scan -ScanType 3 -File "%SCAN_PATH%"
)

echo Antivirus scan completed.
echo Please check the Windows Security Center for detailed results.

endlocal