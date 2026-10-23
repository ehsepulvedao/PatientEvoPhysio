@echo off
setlocal
cd /d "%~dp0"
call scripts\detect_tools_windows.bat
if errorlevel 1 (pause & exit /b 1)
%PYTHON_CMD% scripts\build_data_article_package.py --include-data
if errorlevel 1 (echo [ERROR] Command failed. & pause & exit /b 1)
pause
