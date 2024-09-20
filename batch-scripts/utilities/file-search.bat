@echo off
setlocal enabledelayedexpansion

:search_location
echo Where do you want to search?
echo 1. Drive C:
echo 2. Drive D:
echo 3. Whole PC
set /p search_choice="Enter your choice (1, 2, or 3): "

if "%search_choice%"=="1" (
    set "search_path=C:\"
) else if "%search_choice%"=="2" (
    set "search_path=D:\"
) else if "%search_choice%"=="3" (
    set "search_path=C:\ D:\"
) else (
    echo Invalid choice. Please try again.
    goto search_location
)

:file_name
set /p "file_name=Enter the file name or pattern to search for (e.g., *.txt, document.pdf): "

echo.
echo Searching for %file_name% in %search_path%
echo This may take a while, please be patient...
echo.

set "result_file=%temp%\file_search_results.txt"
> "%result_file%" (
    for %%d in (%search_path%) do (
        if exist %%d (
            dir /s /b "%%d%file_name%" 2>nul
        )
    )
)

cls
echo Search results for "%file_name%":
echo.

for /f "delims=" %%a in ('type "%result_file%" ^| find /c /v ""') do set "count=%%a"
echo Found %count% file(s).
echo.

type "%result_file%"

echo.
echo Results are also saved in: %result_file%

del "%result_file%" >nul 2>&1

pause