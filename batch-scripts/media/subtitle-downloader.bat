@echo off
setlocal enabledelayedexpansion

:: Subtitle Downloader Script
:: This script downloads subtitles for video files using OpenSubtitles-CLI

:: Check if OpenSubtitles-CLI is installed
where opensubs >nul 2>nul
if %errorlevel% neq 0 (
    echo OpenSubtitles-CLI is not installed or not in the system PATH.
    echo Please install OpenSubtitles-CLI using npm: npm install -g opensubtitles-cli
    exit /b 1
)

:: Ask for input directory
set /p "input_dir=Enter the path to the directory containing video files: "

:: Validate input directory
if not exist "%input_dir%" (
    echo Input directory does not exist.
    exit /b 1
)

:: Ask for language
set /p "lang=Enter the language code for subtitles (e.g., eng for English): "

:: Process all video files in the input directory
for %%F in ("%input_dir%\*.mp4" "%input_dir%\*.avi" "%input_dir%\*.mkv" "%input_dir%\*.mov") do (
    set "input_file=%%F"
    set "file_name=%%~nF"
    
    echo.
    echo Downloading subtitles for: %%~nxF
    opensubs --search "!file_name!" --lang !lang! --download "!input_dir!"
    
    if !errorlevel! equ 0 (
        echo Subtitle download successful for: %%~nxF
    ) else (
        echo Error downloading subtitles for: %%~nxF
    )
    echo.
)

echo Subtitle download process complete.
pause