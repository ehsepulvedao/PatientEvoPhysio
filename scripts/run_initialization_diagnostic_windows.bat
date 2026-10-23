@echo off
setlocal EnableExtensions
cd /d "%~dp0\.."
call scripts\detect_tools_windows.bat
if errorlevel 1 exit /b %errorlevel%
%PYTHON_CMD% scripts\diagnose_initialization.py --scenario neonate_healthy
set ERR=%errorlevel%
if not "%ERR%"=="0" (
  echo.
  echo [FAILED] Initialization diagnostic returned %ERR%.
) else (
  echo.
  echo [OK] Review data\diagnostics\initialization\neonate_healthy\initialization_summary.json
)
pause
exit /b %ERR%
