@echo off
setlocal enabledelayedexpansion

:: Audio Extractor Script
:: This script extracts audio from video files using FFmpeg

:: Check if FFmpeg is installed
where ffmpeg >nul 2>nul
if %errorlevel% neq 0 (
    echo FFmpeg is not installed or not in the system PATH.
    echo Please install FFmpeg and add it to your system PATH.
    exit /b 1
)

:: Ask for input and output directories
set /p "input_dir=Enter the path to the input directory: "
set /p "output_dir=Enter the path to the output directory: "

:: Validate input directory
if not exist "%input_dir%" (
    echo Input directory does not exist.
    exit /b 1
)

:: Create output directory if it doesn't exist
if not exist "%output_dir%" (
    mkdir "%output_dir%"
    if !errorlevel! neq 0 (
        echo Failed to create output directory.
        exit /b 1
    )
)

:: Process all video files in the input directory
for %%F in ("%input_dir%\*.*") do (
    set "input_file=%%F"
    set "output_file=%output_dir%\%%~nF.mp3"
    
    echo Extracting audio from: %%~nxF
    ffmpeg -i "!input_file!" -q:a 0 -map a "!output_file!"
    
    if !errorlevel! equ 0 (
        echo Extraction successful: !output_file!
    ) else (
        echo Error extracting audio from: %%~nxF
    )
    echo.
)

echo Audio extraction complete.
pause