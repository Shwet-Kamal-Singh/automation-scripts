@echo off
setlocal enabledelayedexpansion

:: Media Scripts Launcher
:: This script allows users to select and run various media-related scripts

:menu
cls
echo Media Scripts Launcher
echo ======================
echo 1. Audio Extractor
echo 2. Image Resizer
echo 3. Media Info Display
echo 4. Playlist Generator
echo 5. Subtitle Downloader
echo 6. Video Converter
echo 7. Exit
echo.

set /p "choice=Enter your choice (1-7): "

if "%choice%"=="1" set "script=audio-extractor.bat"
if "%choice%"=="2" set "script=image-resizer.bat"
if "%choice%"=="3" set "script=media-info-display.bat"
if "%choice%"=="4" set "script=playlist-generator.bat"
if "%choice%"=="5" set "script=subtitle-downloader.bat"
if "%choice%"=="6" set "script=video-converter.bat"
if "%choice%"=="7" goto :eof

if not defined script (
    echo Invalid choice. Please try again.
    pause
    goto menu
)

:: Ask for the script location
set /p "script_path=Enter the full path to %script% (or press Enter if it's in the same directory): "

if "%script_path%"=="" (
    set "script_path=%~dp0%script%"
) else (
    set "script_path=%script_path%\%script%"
)

:: Check if the script exists
if not exist "%script_path%" (
    echo Script not found: %script_path%
    echo Please make sure the path is correct and the script exists.
    pause
    goto menu
)

:: Run the selected script
call "%script_path%"

:: Return to the menu after the script finishes
pause
goto menu