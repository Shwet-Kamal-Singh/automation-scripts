@echo off
setlocal enabledelayedexpansion

:menu
cls
echo Scheduled Tasks Manager
echo =======================
echo 1. Create a new scheduled task
echo 2. List all scheduled tasks
echo 3. Delete a scheduled task
echo 0. Exit
echo.

set /p choice="Enter your choice (0-3): "

if "%choice%"=="1" goto create_task
if "%choice%"=="2" goto list_tasks
if "%choice%"=="3" goto delete_task
if "%choice%"=="0" exit /b

goto menu

:create_task
cls
echo Create a new scheduled task
echo ===========================
set /p task_name="Enter task name: "
set /p task_path="Enter full path to the script or program: "
set /p schedule_type="Enter schedule type (MINUTE, HOURLY, DAILY, WEEKLY, MONTHLY, ONCE, ONSTART, ONLOGON, ONIDLE): "
set /p start_time="Enter start time (HH:MM): "

schtasks /create /tn "%task_name%" /tr "%task_path%" /sc %schedule_type% /st %start_time%

if %errorlevel% equ 0 (
    echo Task created successfully.
) else (
    echo Failed to create task.
)
pause
goto menu

:list_tasks
cls
echo List of scheduled tasks
echo =======================
schtasks /query /fo list /v
pause
goto menu

:delete_task
cls
echo Delete a scheduled task
echo =======================
set /p task_name="Enter the name of the task to delete: "

schtasks /delete /tn "%task_name%" /f

if %errorlevel% equ 0 (
    echo Task deleted successfully.
) else (
    echo Failed to delete task.
)
pause
goto menu