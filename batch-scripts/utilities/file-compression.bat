@echo off
setlocal enabledelayedexpansion

:: Check if 7-Zip is installed
where 7z >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: 7-Zip is not installed or not in PATH.
    echo Please install 7-Zip and add it to your system PATH.
    pause
    exit /b 1
)

:input
set /p "source=Enter the source file or directory (e.g., C:\Users\YourName\Documents\file.txt or C:\Users\YourName\Documents\folder): "
if not exist "!source!" (
    echo Error: The specified file or directory does not exist.
    goto input
)

set /p "destination=Enter the destination path for the compressed file (e.g., C:\Users\YourName\Desktop\compressed.7z): "

set /p "compression_level=Enter compression level (0-9, where 0 is no compression and 9 is maximum compression): "
if %compression_level% lss 0 set "compression_level=0"
if %compression_level% gtr 9 set "compression_level=9"

echo.
echo Compressing...
7z a -mx%compression_level% "!destination!" "!source!"

if %errorlevel% equ 0 (
    echo.
    echo Compression completed successfully.
) else (
    echo.
    echo An error occurred during compression.
)

pause