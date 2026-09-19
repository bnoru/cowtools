@echo off
setlocal

title Install CorelDRAW Cow Macro

REM ------------------------------------------------------------
REM CorelDRAW 2022 - GMS macro installer
REM
REM Usage:
REM   1. Put this BAT file in the same folder as CowTools.gms
REM      and double-click it.
REM
REM   OR
REM
REM   2. Drag a .gms file onto this BAT file.
REM ------------------------------------------------------------

set "TARGET=%APPDATA%\Corel\CorelDRAW Graphics Suite 2022\Draw\GMS"

REM If a file was dragged onto the installer, use it.
if not "%~1"=="" (
    set "SOURCE=%~1"
) else (
    set "SOURCE=%~dp0CowTools.gms"
)

if not exist "%SOURCE%" (
    echo.
    echo ERROR: Macro file not found.
    echo.
    echo Expected:
    echo   "%~dp0CowTools.gms"
    echo.
    echo Put CowTools.gms in the same folder as this installer,
    echo or drag the .gms file onto the installer.
    echo.
    pause
    exit /b 1
)

if /I not "%~x1"=="" (
    if /I not "%~x1"==".gms" (
        echo.
        echo ERROR: The selected file is not a .gms file.
        echo.
        pause
        exit /b 1
    )
)

if not exist "%TARGET%" (
    mkdir "%TARGET%" >nul 2>&1
)

if not exist "%TARGET%" (
    echo.
    echo ERROR: Could not create the CorelDRAW GMS folder:
    echo   "%TARGET%"
    echo.
    pause
    exit /b 1
)

copy /Y "%SOURCE%" "%TARGET%\" >nul

if errorlevel 1 (
    echo.
    echo ERROR: The macro could not be copied.
    echo.
    pause
    exit /b 1
)

echo.
echo Macro installed successfully.
echo.
echo Installed to:
echo   "%TARGET%"
echo.
echo Close and reopen CorelDRAW if it is currently running.
echo You can then assign a keyboard shortcut to the macro in CorelDRAW.
echo.
pause
exit /b 0
