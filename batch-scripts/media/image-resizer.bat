@echo off
setlocal enabledelayedexpansion

:: Image Resizer Script
:: This script resizes images using ImageMagick

:: Check if ImageMagick is installed
where magick >nul 2>nul
if %errorlevel% neq 0 (
    echo ImageMagick is not installed or not in the system PATH.
    echo Please install ImageMagick and add it to your system PATH.
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

:: Ask for resize dimensions
set /p "width=Enter the desired width in pixels: "
set /p "height=Enter the desired height in pixels: "

:: Process all image files in the input directory
for %%F in ("%input_dir%\*.jpg" "%input_dir%\*.png" "%input_dir%\*.gif") do (
    set "input_file=%%F"
    set "output_file=%output_dir%\%%~nxF"
    
    echo Resizing: %%~nxF
    magick "!input_file!" -resize %width%x%height% "!output_file!"
    
    if !errorlevel! equ 0 (
        echo Resizing successful: !output_file!
    ) else (
        echo Error resizing: %%~nxF
    )
    echo.
)

echo Image resizing complete.
pause