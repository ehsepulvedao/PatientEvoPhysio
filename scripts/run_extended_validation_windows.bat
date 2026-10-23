@echo off
setlocal EnableExtensions EnableDelayedExpansion
cd /d "%~dp0\.."
set "ROOT=%CD%"
set "LOGDIR=%ROOT%\data\logs"
if not exist "%LOGDIR%" mkdir "%LOGDIR%"
set "LOG=%LOGDIR%\extended_validation.log"

echo ============================================================ > "%LOG%"
echo PatientEvoPhysio v2.0.0 - Extended validation >> "%LOG%"
echo Started: %DATE% %TIME% >> "%LOG%"
echo Repository: %ROOT% >> "%LOG%"
echo ============================================================ >> "%LOG%"

call scripts\detect_tools_windows.bat
if errorlevel 1 (
  echo [ERROR] Required software could not be detected. >> "%LOG%"
  if not "%PEP_NO_PAUSE%"=="1" pause
  exit /b %errorlevel%
)
echo OpenModelica: %OMC_EXE% >> "%LOG%"
echo Python: %PYTHON_CMD% >> "%LOG%"

echo.
echo ============================================================
echo PatientEvoPhysio v2.0.0 - EXTENDED VALIDATION
echo ============================================================
echo Long runs use curated output by default to control dataset size.
echo.

echo [1/3] Healthy-neonate oxygen profile: 600 s...
%PYTHON_CMD% scripts\generate_csv.py --profile neonate_oxygen_10min >> "%LOG%" 2>&1
if errorlevel 1 goto :failed

echo [2/3] Fetal-to-neonatal transition profile: 720 s...
%PYTHON_CMD% scripts\generate_csv.py --profile transition_12min >> "%LOG%" 2>&1
if errorlevel 1 goto :failed

echo [3/3] Validating the two extended-profile curated CSV files...
set /a CSVCOUNT=0
set /a REVIEWCOUNT=0
for /r "%ROOT%\data\generated\profiles\neonate_oxygen_10min" %%F in (*_res.csv) do (
  set /a CSVCOUNT+=1
  %PYTHON_CMD% scripts\validate_results.py "%%F" >> "%LOG%" 2>&1
  if errorlevel 2 set /a REVIEWCOUNT+=1
)
for /r "%ROOT%\data\generated\profiles\transition_12min" %%F in (*_res.csv) do (
  set /a CSVCOUNT+=1
  %PYTHON_CMD% scripts\validate_results.py "%%F" >> "%LOG%" 2>&1
  if errorlevel 2 set /a REVIEWCOUNT+=1
)

echo.
echo ============================================================
echo EXTENDED VALIDATION COMPLETED
echo Curated CSV files checked: !CSVCOUNT!
echo Files requiring review: !REVIEWCOUNT!
echo Full log: %LOG%
echo ============================================================
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
