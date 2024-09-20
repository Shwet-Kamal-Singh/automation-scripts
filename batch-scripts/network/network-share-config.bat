@echo off
setlocal enabledelayedexpansion

:menu
cls
echo Network Share Configuration
echo ===========================
echo 1. Create a new network share
echo 2. Remove an existing network share
echo 3. List all network shares
echo 4. Exit
echo.

set /p choice=Enter your choice (1-4): 

if "%choice%"=="1" goto create_share
if "%choice%"=="2" goto remove_share
if "%choice%"=="3" goto list_shares
if "%choice%"=="4" goto end

echo Invalid choice. Please try again.
timeout /t 2 >nul
goto menu

:create_share
set /p share_name=Enter share name: 
set /p share_path=Enter full path to share: 
set /p share_desc=Enter share description: 
net share %share_name%="%share_path%" /REMARK:"%share_desc%"
if %errorlevel% equ 0 (
    echo Share created successfully.
) else (
    echo Failed to create share.
)
pause
goto menu

:remove_share
set /p share_name=Enter share name to remove: 
net share %share_name% /delete
if %errorlevel% equ 0 (
    echo Share removed successfully.
) else (
    echo Failed to remove share.
)
pause
goto menu

:list_shares
echo Current network shares:
net share
pause
goto menu

:end
echo Exiting...
exit /b 0