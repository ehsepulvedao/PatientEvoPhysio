@echo off
setlocal EnableExtensions
cd /d "%~dp0\.."
echo ============================================================
echo PatientEvoPhysio - Windows environment diagnosis
echo ============================================================
call scripts\detect_tools_windows.bat
if errorlevel 1 (
  echo.
  echo Diagnosis failed with code %errorlevel%.
  pause
  exit /b %errorlevel%
)
echo.
echo Repository root : %CD%
echo OpenModelica    : %OMC_EXE%
echo Python command  : %PYTHON_CMD%
echo.
"%OMC_EXE%" --version
%PYTHON_CMD% --version
echo.
echo Tool discovery completed successfully.
pause
exit /b 0
