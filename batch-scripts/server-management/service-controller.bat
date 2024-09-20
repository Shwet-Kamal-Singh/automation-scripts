@echo off
setlocal enabledelayedexpansion

echo Service Controller
echo ------------------

:menu
echo.
echo 1. List All Services
echo 2. Start a Service
echo 3. Stop a Service
echo 4. Restart a Service
echo 5. Query a Service Status
echo 6. Change Service Startup Type
echo 7. Exit
echo.
set /p choice=Enter your choice (1-7): 

if "%choice%"=="1" goto :list
if "%choice%"=="2" goto :start
if "%choice%"=="3" goto :stop
if "%choice%"=="4" goto :restart
if "%choice%"=="5" goto :query
if "%choice%"=="6" goto :change_startup
if "%choice%"=="7" goto :end

echo Invalid choice. Please try again.
goto :menu

:list
echo.
echo Listing All Services...
sc query state= all | findstr "SERVICE_NAME:"
goto :menu

:start
echo.
set /p service_name=Enter the service name to start: 
sc start %service_name%
goto :menu

:stop
echo.
set /p service_name=Enter the service name to stop: 
sc stop %service_name%
goto :menu

:restart
echo.
set /p service_name=Enter the service name to restart: 
sc stop %service_name%
timeout /t 5 /nobreak >nul
sc start %service_name%
goto :menu

:query
echo.
set /p service_name=Enter the service name to query: 
sc query %service_name%
goto :menu

:change_startup
echo.
set /p service_name=Enter the service name to modify: 
echo Startup types: auto, delayed-auto, demand, disabled
set /p startup_type=Enter the new startup type: 
sc config %service_name% start= %startup_type%
goto :menu

:end
echo Exiting Service Controller...
exit /b