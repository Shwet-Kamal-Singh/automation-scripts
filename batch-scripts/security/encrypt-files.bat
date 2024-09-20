@echo off
setlocal enabledelayedexpansion

:: File Encryption Script
echo File Encryption Utility

:: Ask for the directory to encrypt
set /p "ENCRYPT_DIR=Enter the full path of the directory to encrypt: "

:: Validate directory
if not exist "%ENCRYPT_DIR%" (
    echo Error: The specified directory does not exist.
    goto :EOF
)

:: Ask for the output directory
set /p "OUTPUT_DIR=Enter the full path for the output directory (leave blank for same as input): "

:: If output directory is blank, use the input directory
if "%OUTPUT_DIR%"=="" set "OUTPUT_DIR=%ENCRYPT_DIR%"

:: Create output directory if it doesn't exist
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

:: Ask for password
set /p "PASSWORD=Enter encryption password: "

:: Confirm password
set /p "CONFIRM_PASSWORD=Confirm encryption password: "

:: Check if passwords match
if not "%PASSWORD%"=="%CONFIRM_PASSWORD%" (
    echo Error: Passwords do not match.
    goto :EOF
)

:: Use 7-Zip for encryption (assuming it's installed and in PATH)
where 7z >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Error: 7-Zip is not installed or not in PATH.
    echo Please install 7-Zip and add it to your system PATH.
    goto :EOF
)

:: Perform encryption
echo Encrypting files in %ENCRYPT_DIR%...
7z a -tzip "%OUTPUT_DIR%\encrypted_files.zip" "%ENCRYPT_DIR%\*" -p"%PASSWORD%" -mhe=on

if %ERRORLEVEL% equ 0 (
    echo Encryption completed successfully.
    echo Encrypted files are stored in: %OUTPUT_DIR%\encrypted_files.zip
) else (
    echo Error occurred during encryption.
)

endlocal