@echo off
setlocal EnableExtensions
cd /d "%~dp0\.."
call scripts\detect_tools_windows.bat
if errorlevel 1 exit /b %errorlevel%

echo [1/2] Installing/checking dependencies...
"%OMC_EXE%" scripts\bootstrap.mos || exit /b 1
echo [2/2] Checking all scenarios...
"%OMC_EXE%" scripts\check_scenarios.mos || exit /b 1
echo.
echo PatientEvoPhysio dependency/check sequence completed.
echo Numerical smoke simulations are run by RUN_STANDARD_VALIDATION.bat
echo and are isolated from the repository root.
endlocal
