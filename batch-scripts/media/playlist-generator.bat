@echo off
setlocal enabledelayedexpansion

:: Playlist Generator Script
:: This script generates a playlist file for media files in a specified directory

:: Ask for input directory
set /p "input_dir=Enter the path to the directory containing media files: "

:: Validate input directory
if not exist "%input_dir%" (
    echo Input directory does not exist.
    exit /b 1
)

:: Ask for playlist name
set /p "playlist_name=Enter the name for your playlist (without extension): "

:: Ask for playlist format
echo Select playlist format:
echo 1. M3U
echo 2. PLS
set /p "format_choice=Enter your choice (1 or 2): "

if "%format_choice%"=="1" (
    set "playlist_ext=.m3u"
    set "playlist_file=%input_dir%\%playlist_name%.m3u"
) else if "%format_choice%"=="2" (
    set "playlist_ext=.pls"
    set "playlist_file=%input_dir%\%playlist_name%.pls"
) else (
    echo Invalid choice. Defaulting to M3U format.
    set "playlist_ext=.m3u"
    set "playlist_file=%input_dir%\%playlist_name%.m3u"
)

:: Create playlist file
echo Creating playlist: %playlist_file%

if "%playlist_ext%"==".m3u" (
    echo #EXTM3U > "%playlist_file%"
) else (
    echo [playlist] > "%playlist_file%"
)

:: Add media files to playlist
set "file_count=0"
for %%F in ("%input_dir%\*.mp3" "%input_dir%\*.wav" "%input_dir%\*.flac" "%input_dir%\*.m4a" "%input_dir%\*.mp4" "%input_dir%\*.avi" "%input_dir%\*.mkv") do (
    set /a "file_count+=1"
    set "file_path=%%F"
    set "file_name=%%~nxF"
    
    if "%playlist_ext%"==".m3u" (
        echo #EXTINF:-1,%file_name% >> "%playlist_file%"
        echo !file_path! >> "%playlist_file%"
    ) else (
        echo File!file_count!=!file_path! >> "%playlist_file%"
        echo Title!file_count!=!file_name! >> "%playlist_file%"
    )
)

if "%playlist_ext%"==".pls" (
    echo NumberOfEntries=!file_count! >> "%playlist_file%"
    echo Version=2 >> "%playlist_file%"
)

echo Playlist generation complete.
echo Total files added: %file_count%
echo Playlist saved as: %playlist_file%

pause