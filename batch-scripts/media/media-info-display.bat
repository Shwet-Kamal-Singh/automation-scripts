@echo off
setlocal enabledelayedexpansion

:: Media Info Display Script
:: This script displays information about media files using MediaInfo

:: Check if MediaInfo is installed
where mediainfo >nul 2>nul
if %errorlevel% neq 0 (
    echo MediaInfo is not installed or not in the system PATH.
    echo Please install MediaInfo and add it to your system PATH.
    exit /b 1
)

:: Ask for input directory
set /p "input_dir=Enter the path to the directory containing media files: "

:: Validate input directory
if not exist "%input_dir%" (
    echo Input directory does not exist.
    exit /b 1
)

:: Ask for output format
echo Select output format:
echo 1. Summary
echo 2. Full details
set /p "format_choice=Enter your choice (1 or 2): "

if "%format_choice%"=="1" (
    set "format_option=--Output=Summary"
) else if "%format_choice%"=="2" (
    set "format_option=--Output=HTML"
) else (
    echo Invalid choice. Defaulting to Summary.
    set "format_option=--Output=Summary"
)

:: Process all media files in the input directory
for %%F in ("%input_dir%\*.*") do (
    set "input_file=%%F"
    
    echo.
    echo File: %%~nxF
    echo ------------------------
    mediainfo %format_option% "!input_file!"
    echo ------------------------
    echo.
)

echo Media info display complete.
pause