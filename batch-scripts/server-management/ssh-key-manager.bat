@echo off
setlocal enabledelayedexpansion

echo SSH Key Manager
echo ---------------

:: Set the default SSH directory
set "SSH_DIR=%USERPROFILE%\.ssh"

:menu
echo.
echo 1. Generate new SSH key
echo 2. List existing SSH keys
echo 3. Add SSH key to ssh-agent
echo 4. Remove SSH key from ssh-agent
echo 5. Copy public key to clipboard
echo 6. Exit
echo.
set /p choice=Enter your choice (1-6): 

if "%choice%"=="1" goto :generate
if "%choice%"=="2" goto :list
if "%choice%"=="3" goto :add
if "%choice%"=="4" goto :remove
if "%choice%"=="5" goto :copy
if "%choice%"=="6" goto :end

echo Invalid choice. Please try again.
goto :menu

:generate
echo.
set /p key_name=Enter a name for the new SSH key: 
set /p key_type=Enter key type (rsa, ed25519): 
set /p email=Enter your email: 
ssh-keygen -t %key_type% -C "%email%" -f "%SSH_DIR%\%key_name%"
echo SSH key generated: %SSH_DIR%\%key_name%
goto :menu

:list
echo.
echo Existing SSH keys:
dir /b "%SSH_DIR%\*.pub"
goto :menu

:add
echo.
set /p key_file=Enter the name of the key file to add: 
ssh-add "%SSH_DIR%\%key_file%"
goto :menu

:remove
echo.
set /p key_file=Enter the name of the key file to remove: 
ssh-add -d "%SSH_DIR%\%key_file%"
goto :menu

:copy
echo.
set /p key_file=Enter the name of the public key file to copy: 
type "%SSH_DIR%\%key_file%" | clip
echo Public key copied to clipboard.
goto :menu

:end
echo Exiting SSH Key Manager...
exit /b