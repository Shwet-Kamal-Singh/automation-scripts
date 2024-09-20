@echo off
setlocal enabledelayedexpansion

:: Log Rotator Script
:: Rotates log files by moving them to an archive folder and compressing old logs

:: Configuration
set "LOG_DIR=C:\Logs"
set "ARCHIVE_DIR=C:\Logs\Archive"
set "MAX_AGE_DAYS=30"
set "COMPRESS_AGE_DAYS=7"

:: Create archive directory if it doesn't exist
if not exist "%ARCHIVE_DIR%" mkdir "%ARCHIVE_DIR%"

:: Move logs older than MAX_AGE_DAYS to archive
forfiles /p "%LOG_DIR%" /s /m *.log /d -%MAX_AGE_DAYS% /c "cmd /c move @path %ARCHIVE_DIR%"

:: Compress logs in archive older than COMPRESS_AGE_DAYS
forfiles /p "%ARCHIVE_DIR%" /m *.log /d -%COMPRESS_AGE_DAYS% /c "cmd /c 7z a -tzip @fname.zip @path && del @path"

:: Delete zip files older than MAX_AGE_DAYS
forfiles /p "%ARCHIVE_DIR%" /m *.zip /d -%MAX_AGE_DAYS% /c "cmd /c del @path"

echo Log rotation completed.