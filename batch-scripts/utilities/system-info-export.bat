@echo off
setlocal enabledelayedexpansion

:: Set the output file name
set "output_file=%USERPROFILE%\Desktop\system_info_%computername%_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"

:: Start collecting system information
echo Collecting system information...
echo System Information for %computername% > "%output_file%"
echo Generated on %date% at %time% >> "%output_file%"
echo. >> "%output_file%"

:: OS information
echo ===== Operating System Information ===== >> "%output_file%"
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Type" >> "%output_file%"
echo. >> "%output_file%"

:: CPU information
echo ===== CPU Information ===== >> "%output_file%"
wmic cpu get Name, NumberOfCores, NumberOfLogicalProcessors /format:list >> "%output_file%"
echo. >> "%output_file%"

:: Memory information
echo ===== Memory Information ===== >> "%output_file%"
wmic computersystem get TotalPhysicalMemory /format:list >> "%output_file%"
wmic OS get FreePhysicalMemory,TotalVirtualMemorySize,FreeVirtualMemory /format:list >> "%output_file%"
echo. >> "%output_file%"

:: Disk information
echo ===== Disk Information ===== >> "%output_file%"
wmic logicaldisk get Caption,Description,ProviderName,Size,FreeSpace /format:list >> "%output_file%"
echo. >> "%output_file%"

:: Network information
echo ===== Network Information ===== >> "%output_file%"
ipconfig /all >> "%output_file%"
echo. >> "%output_file%"

:: Installed software
echo ===== Installed Software ===== >> "%output_file%"
wmic product get Name,Version /format:list >> "%output_file%"
echo. >> "%output_file%"

:: Running processes
echo ===== Running Processes ===== >> "%output_file%"
tasklist /v >> "%output_file%"
echo. >> "%output_file%"

echo System information has been exported to:
echo %output_file%
echo.
pause