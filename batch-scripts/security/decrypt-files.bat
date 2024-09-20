@echo off
setlocal enabledelayedexpansion

:: File Decryption Script
echo File Decryption Utility

:: Ask for the encrypted file
set /p "ENCRYPTED_FILE=Enter the full path of the encrypted file (.zip): "

:: Validate file
if not exist "%ENCRYPTED_FILE%" (
    echo Error: The specified file does not exist.
    goto :EOF
)

:: Ask for the output directory
set /p "OUTPUT_DIR=Enter the full path for the output directory: "

:: Create output directory if it doesn't exist
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

:: Ask for password
set /p "PASSWORD=Enter decryption password: "

:: Use 7-Zip for decryption (assuming it's installed and in PATH)
where 7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Error: 7-Zip is not installed or not in PATH.
    echo Please install 7-Zip and add it to your system PATH.
    goto :EOF
)

:: Perform decryption
echo Decrypting file %ENCRYPTED_FILE%...
7z x "%ENCRYPTED_FILE%" -o"%OUTPUT_DIR%" -p"%PASSWORD%" -y

if %ERRORLEVEL% equ 0 (
    echo Decryption completed successfully.
    echo Decrypted files are stored in: %OUTPUT_DIR%
) else (
    echo Error occurred during decryption.
    echo This may be due to an incorrect password or corrupted file.
)

endlocal