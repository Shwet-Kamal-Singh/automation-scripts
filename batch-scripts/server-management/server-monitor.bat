@echo off
setlocal enabledelayedexpansion

echo Server Monitor
echo --------------

:menu
echo.
echo 1. Check CPU Usage
echo 2. Check Memory Usage
echo 3. Check Disk Space
echo 4. List Running Services
echo 5. Check Network Connections
echo 6. View Event Logs
echo 7. Exit
echo.
set /p choice=Enter your choice (1-7): 

if "%choice%"=="1" goto :cpu
if "%choice%"=="2" goto :memory
if "%choice%"=="3" goto :disk
if "%choice%"=="4" goto :services
if "%choice%"=="5" goto :network
if "%choice%"=="6" goto :eventlogs
if "%choice%"=="7" goto :end

echo Invalid choice. Please try again.
goto :menu

:cpu
echo.
echo Checking CPU Usage...
wmic cpu get loadpercentage
goto :menu

:memory
echo.
echo Checking Memory Usage...
systeminfo | findstr /C:"Total Physical Memory" /C:"Available Physical Memory"
goto :menu

:disk
echo.
echo Checking Disk Space...
wmic logicaldisk get deviceid,size,freespace
goto :menu

:services
echo.
echo Listing Running Services...
net start
goto :menu

:network
echo.
echo Checking Network Connections...
netstat -an
goto :menu

:eventlogs
echo.
echo Viewing Recent System Event Logs...
wevtutil qe System /c:5 /f:text
goto :menu

:end
echo Exiting Server Monitor...
exit /b