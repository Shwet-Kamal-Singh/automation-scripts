@echo off
setlocal enabledelayedexpansion

:: Video Converter Script
:: This script converts video files to a specified format using FFmpeg

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

:: Ask for output format
echo Select output format:
echo 1. MP4 (H.264)
echo 2. WebM (VP9)
echo 3. MKV (H.265/HEVC)
set /p "format_choice=Enter your choice (1, 2, or 3): "

if "%format_choice%"=="1" (
    set "output_format=mp4"
    set "codec_options=-c:v libx264 -crf 23 -preset medium -c:a aac -b:a 128k"
) else if "%format_choice%"=="2" (
    set "output_format=webm"
    set "codec_options=-c:v libvpx-vp9 -crf 30 -b:v 0 -b:a 128k -c:a libopus"
) else if "%format_choice%"=="3" (
    set "output_format=mkv"
    set "codec_options=-c:v libx265 -crf 28 -preset medium -c:a aac -b:a 128k"
) else (
    echo Invalid choice. Defaulting to MP4 (H.264).
    set "output_format=mp4"
    set "codec_options=-c:v libx264 -crf 23 -preset medium -c:a aac -b:a 128k"
)

:: Process all video files in the input directory
for %%F in ("%input_dir%\*.mp4" "%input_dir%\*.avi" "%input_dir%\*.mkv" "%input_dir%\*.mov") do (
    set "input_file=%%F"
    set "output_file=%output_dir%\%%~nF.%output_format%"
    
    echo Converting: %%~nxF
    ffmpeg -i "!input_file!" %codec_options% "!output_file!"
    
    if !errorlevel! equ 0 (
        echo Conversion successful: !output_file!
    ) else (
        echo Error converting: %%~nxF
    )
    echo.
)

echo Video conversion complete.
pause