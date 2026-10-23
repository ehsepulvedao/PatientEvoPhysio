@echo off
setlocal
cd /d "%~dp0"
call scripts\detect_tools_windows.bat
if errorlevel 1 (pause & exit /b 1)
%PYTHON_CMD% scripts\run_experiment_plan.py oxygen_reference
if errorlevel 1 (echo [ERROR] Command failed. & pause & exit /b 1)
pause
