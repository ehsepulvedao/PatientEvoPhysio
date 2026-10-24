@echo off
setlocal EnableExtensions
cd /d "%~dp0\.."
call scripts\detect_tools_windows.bat
if errorlevel 1 exit /b %errorlevel%
%PYTHON_CMD% scripts\generate_population.py %*
endlocal
