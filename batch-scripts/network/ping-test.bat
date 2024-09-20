@echo off
setlocal enabledelayedexpansion

:: Ping Test Utility
echo Ping Test Utility
echo ================

:input
set /p "target=Enter IP address or hostname to ping (or 'exit' to quit): "
if /i "%target%"=="exit" goto :eof

:: Perform the ping test
ping -n 4 %target%

:: Check the error level
if %errorlevel% equ 0 (
    echo.
    echo Ping test successful. Host %target% is reachable.
) else (
    echo.
    echo Ping test failed. Host %target% is unreachable.
)

echo.
goto input