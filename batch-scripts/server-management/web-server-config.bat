@echo off
setlocal enabledelayedexpansion

echo Web Server Configuration Tool
echo -----------------------------

:: Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please run as administrator.
    pause
    exit /b 1
)

:menu
echo.
echo 1. Install IIS
echo 2. Create a new website
echo 3. List existing websites
echo 4. Start a website
echo 5. Stop a website
echo 6. Delete a website
echo 7. Exit
echo.
set /p choice=Enter your choice (1-7): 

if "%choice%"=="1" goto :install_iis
if "%choice%"=="2" goto :create_website
if "%choice%"=="3" goto :list_websites
if "%choice%"=="4" goto :start_website
if "%choice%"=="5" goto :stop_website
if "%choice%"=="6" goto :delete_website
if "%choice%"=="7" goto :end

echo Invalid choice. Please try again.
goto :menu

:install_iis
echo.
echo Installing IIS...
dism /online /enable-feature /featurename:IIS-WebServerRole /all
echo IIS installation complete.
goto :menu

:create_website
echo.
set /p site_name=Enter the name for the new website: 
set /p site_path=Enter the physical path for the website: 
set /p port=Enter the port number for the website: 
echo Creating website %site_name%...
%windir%\system32\inetsrv\appcmd add site /name:"%site_name%" /physicalPath:"%site_path%" /bindings:http/*:%port%:
echo Website created successfully.
goto :menu

:list_websites
echo.
echo Listing all websites:
%windir%\system32\inetsrv\appcmd list site
goto :menu

:start_website
echo.
set /p site_name=Enter the name of the website to start: 
echo Starting website %site_name%...
%windir%\system32\inetsrv\appcmd start site /site.name:"%site_name%"
goto :menu

:stop_website
echo.
set /p site_name=Enter the name of the website to stop: 
echo Stopping website %site_name%...
%windir%\system32\inetsrv\appcmd stop site /site.name:"%site_name%"
goto :menu

:delete_website
echo.
set /p site_name=Enter the name of the website to delete: 
echo Deleting website %site_name%...
%windir%\system32\inetsrv\appcmd delete site /site.name:"%site_name%"
goto :menu

:end
echo Exiting Web Server Configuration Tool...
exit /b