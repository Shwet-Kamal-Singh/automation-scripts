@echo off
setlocal enabledelayedexpansion

echo Bulk File Renaming Utility
echo --------------------------

:input_folder
set /p "folder=Enter the folder path (e.g., C:\Users\YourName\Documents): "
if not exist "%folder%" (
    echo Folder does not exist. Please try again.
    goto input_folder
)

:input_pattern
set /p "pattern=Enter the file pattern to match (e.g., *.txt for all text files): "

:input_prefix
set /p "prefix=Enter the prefix to add (or press Enter for none): "

:input_suffix
set /p "suffix=Enter the suffix to add (or press Enter for none): "

:input_replace
set /p "replace=Enter text to replace (or press Enter to skip): "
if not "%replace%"=="" (
    set /p "replacement=Enter replacement text: "
)

set /p "confirm=Rename files in %folder% matching %pattern%? (Y/N): "
if /i "%confirm%" neq "Y" goto end

set count=0
for %%F in ("%folder%\%pattern%") do (
    set "filename=%%~nF"
    set "extension=%%~xF"
    
    if not "%replace%"=="" (
        set "filename=!filename:%replace%=%replacement%!"
    )
    
    set "newname=%prefix%!filename!%suffix%!extension!"
    
    if not "%%~nxF"=="!newname!" (
        ren "%%F" "!newname!"
        set /a count+=1
        echo Renamed: %%~nxF to !newname!
    )
)

echo.
echo Renaming complete. %count% file(s) renamed.

:end
endlocal
pause