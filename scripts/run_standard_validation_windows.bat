@echo off
setlocal EnableExtensions EnableDelayedExpansion
cd /d "%~dp0\.."
set "ROOT=%CD%"
set "LOGDIR=%ROOT%\data\logs"
if not exist "%LOGDIR%" mkdir "%LOGDIR%"
set "LOG=%LOGDIR%\standard_validation.log"

echo ============================================================ > "%LOG%"
echo PatientEvoPhysio v2.0.0 - Standard validation >> "%LOG%"
echo Started: %DATE% %TIME% >> "%LOG%"
echo Repository: %ROOT% >> "%LOG%"
echo ============================================================ >> "%LOG%"

echo.
echo ============================================================
echo PatientEvoPhysio v2.0.0 - STANDARD VALIDATION
echo ============================================================
echo Repository: %ROOT%
echo Log: %LOG%
echo.

call scripts\detect_tools_windows.bat
if errorlevel 1 (
  echo [ERROR] Required software could not be detected. >> "%LOG%"
  if not "%PEP_NO_PAUSE%"=="1" pause
  exit /b %errorlevel%
)
echo OpenModelica: %OMC_EXE% >> "%LOG%"
echo Python: %PYTHON_CMD% >> "%LOG%"

echo [1/5] Installing/checking Modelica dependencies...
call scripts\setup_windows.bat >> "%LOG%" 2>&1
if errorlevel 1 goto :failed

echo [2/5] Running Python/static repository tests...
%PYTHON_CMD% tests\static_audit.py >> "%LOG%" 2>&1
if errorlevel 1 goto :failed
%PYTHON_CMD% tests\test_generator_config.py >> "%LOG%" 2>&1
if errorlevel 1 goto :failed
%PYTHON_CMD% tests\test_output_pipeline.py >> "%LOG%" 2>&1
if errorlevel 1 goto :failed
%PYTHON_CMD% tests\compare_numeric_baseline.py >> "%LOG%" 2>&1
if errorlevel 1 goto :failed

echo [3/5] Diagnosing healthy-neonate initialization...
%PYTHON_CMD% scripts\diagnose_initialization.py --scenario neonate_healthy >> "%LOG%" 2>&1
if errorlevel 1 goto :failed

echo [4/5] Generating curated 5 s hemodynamic CSVs...
%PYTHON_CMD% scripts\generate_csv.py --profile hemodynamic_smoke >> "%LOG%" 2>&1
if errorlevel 1 goto :failed

echo [5/5] Validating generated curated CSV files...
set /a CSVCOUNT=0
set /a REVIEWCOUNT=0
for /r "%ROOT%\data\generated\profiles\hemodynamic_smoke" %%F in (*_res.csv) do (
  set /a CSVCOUNT+=1
  echo Validating %%F >> "%LOG%"
  %PYTHON_CMD% scripts\validate_results.py "%%F" >> "%LOG%" 2>&1
  if errorlevel 2 set /a REVIEWCOUNT+=1
)

if !CSVCOUNT! EQU 0 (
  echo [ERROR] No curated *_res.csv files were found for profile hemodynamic_smoke.
  echo [ERROR] No curated *_res.csv files were found for profile hemodynamic_smoke. >> "%LOG%"
  if not "%PEP_NO_PAUSE%"=="1" pause
  exit /b 1
)

echo.
echo ============================================================
echo STANDARD VALIDATION COMPLETED
echo Curated CSV files checked: !CSVCOUNT!
echo Files requiring review: !REVIEWCOUNT!
echo Initialization diagnostic: data\diagnostics\initialization\neonate_healthy\initialization_summary.json
echo Full log: %LOG%
echo ============================================================
echo.
echo NOTE: REVIEW does not automatically mean the physiology is wrong.
echo Inspect *.validation.json; full statistics are in *.validation.details.json.
echo.
if not "%PEP_NO_PAUSE%"=="1" pause
exit /b 0

:failed
echo.
echo ============================================================
echo [FAILED] A command returned an error.
echo See: %LOG%
echo ============================================================
echo.
if not "%PEP_NO_PAUSE%"=="1" pause
exit /b 1
