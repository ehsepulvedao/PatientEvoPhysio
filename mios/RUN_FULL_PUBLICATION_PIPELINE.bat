@echo off
setlocal EnableExtensions
set "PEP_NO_PAUSE=1"
cd /d "%~dp0"
call scripts\detect_tools_windows.bat
if errorlevel 1 (pause & exit /b 1)
echo [1/6] Standard validation...
call RUN_STANDARD_VALIDATION.bat
if errorlevel 1 exit /b 1
echo [2/6] Extended validation...
call RUN_EXTENDED_VALIDATION.bat
if errorlevel 1 exit /b 1
echo [3/6] Publication reference simulations...
%PYTHON_CMD% scripts\run_experiment_plan.py publication_reference_all
if errorlevel 1 exit /b 1
echo [4/6] Scientific and quality reports...
%PYTHON_CMD% scripts\report_all.py
%PYTHON_CMD% scripts\dataset_quality_report.py
%PYTHON_CMD% scripts\build_ml_index.py
%PYTHON_CMD% scripts\build_feature_table.py
echo [5/6] Dataset release package...
%PYTHON_CMD% scripts\build_dataset_release.py --include-data --zip
if errorlevel 1 exit /b 1
echo [6/6] Data-article support package...
%PYTHON_CMD% scripts\build_data_article_package.py --include-data
%PYTHON_CMD% scripts\check_placeholders.py
echo FULL PUBLICATION PIPELINE COMPLETED.
pause
