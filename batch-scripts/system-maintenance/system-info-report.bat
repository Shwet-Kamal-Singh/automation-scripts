@echo off
setlocal enabledelayedexpansion

echo System Information Report Generator
echo ===================================
echo.

:: Set the output file name
set "timestamp=%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "timestamp=%timestamp: =0%"
set "output_file=%userprofile%\Desktop\SystemInfo_%timestamp%.txt"

echo Generating system information report...
echo This may take a few moments.
echo.

:: Start the report
echo System Information Report > "%output_file%"
echo Generated on %date% at %time% >> "%output_file%"
echo. >> "%output_file%"

:: System information
echo ===== System Information ===== >> "%output_file%"
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Manufacturer" /C:"System Model" /C:"System Type" /C:"Total Physical Memory" >> "%output_file%"
echo. >> "%output_file%"

:: CPU information
echo ===== CPU Information ===== >> "%output_file%"
wmic cpu get Name, MaxClockSpeed, NumberOfCores, NumberOfLogicalProcessors /format:list >> "%output_file%"
echo. >> "%output_file%"

:: Disk information
echo ===== Disk Information ===== >> "%output_file%"
wmic logicaldisk get Caption, Description, FileSystem, Size, FreeSpace /format:list >> "%output_file%"
echo. >> "%output_file%"

:: Network information
echo ===== Network Information ===== >> "%output_file%"
ipconfig /all >> "%output_file%"
echo. >> "%output_file%"

:: Installed software
echo ===== Installed Software ===== >> "%output_file%"
wmic product get Name, Version /format:list >> "%output_file%"
echo. >> "%output_file%"

:: Running processes
echo ===== Running Processes ===== >> "%output_file%"
tasklist /v >> "%output_file%"
echo. >> "%output_file%"

:: Services
echo ===== Services ===== >> "%output_file%"
sc query state= all | findstr "SERVICE_NAME STATE" >> "%output_file%"
echo. >> "%output_file%"

echo System information report generated successfully.
echo The report has been saved to:
echo %output_file%
echo.

:: Ask if user wants to open the report
set /p "open_report=Do you want to open the report now? (Y/N): "
if /i "%open_report%"=="Y" start "" "%output_file%"

pause