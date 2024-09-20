@echo off
setlocal enabledelayedexpansion

echo Disk Defragmentation Utility
echo ============================
echo.

:: List available drives
echo Available drives:
wmic logicaldisk get deviceid, volumename, description

echo.
set /p "drive=Enter the drive letter to defragment (e.g., C): "

:: Validate drive input
if not exist %drive%:\ (
    echo Error: Drive %drive%: does not exist.
    goto :eof
)

:: Ask for confirmation
set /p "confirm=Are you sure you want to defragment drive %drive%:? (Y/N): "
if /i "%confirm%" neq "Y" goto :eof

:: Check if the drive needs defragmentation
echo Analyzing drive %drive%:...
defrag %drive%: /A

:: Ask if user wants to proceed with defragmentation
set /p "proceed=Do you want to proceed with defragmentation? (Y/N): "
if /i "%proceed%" neq "Y" goto :eof

:: Perform defragmentation
echo.
echo Starting defragmentation of drive %drive%:...
defrag %drive%: /V

echo.
echo Defragmentation process completed.
pause