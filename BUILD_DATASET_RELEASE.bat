@echo off
setlocal
cd /d "%~dp0"
call scripts\detect_tools_windows.bat
if errorlevel 1 (pause & exit /b 1)
%PYTHON_CMD% scripts\report_all.py
if errorlevel 1 (echo [ERROR] Command failed. & pause & exit /b 1)
%PYTHON_CMD% scripts\dataset_quality_report.py
if errorlevel 1 (echo [ERROR] Command failed. & pause & exit /b 1)
%PYTHON_CMD% scripts\build_dataset_release.py --include-data --zip
if errorlevel 1 (echo [ERROR] Command failed. & pause & exit /b 1)
pause
