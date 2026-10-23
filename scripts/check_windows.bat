@echo off
setlocal EnableExtensions
cd /d "%~dp0\.."
call scripts\detect_tools_windows.bat
if errorlevel 1 exit /b %errorlevel%
"%OMC_EXE%" scripts\check_scenarios.mos || exit /b 1
endlocal
