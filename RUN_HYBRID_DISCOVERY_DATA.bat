@echo off
setlocal
cd /d "%~dp0"
call scripts\detect_tools_windows.bat
if errorlevel 1 (pause & exit /b 1)
%PYTHON_CMD% scripts\run_experiment_plan.py hybrid_discovery_reference
if errorlevel 1 (echo [ERROR] Command failed. & pause & exit /b 1)
for /r "%CD%\data\generated\profiles\hybrid_discovery_30s" %%F in (*_res.csv) do %PYTHON_CMD% scripts\derive_hybrid_labels.py "%%F"
pause
