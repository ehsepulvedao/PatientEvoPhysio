@echo off
rem Centralized Windows tool discovery for PatientEvoPhysio.
rem This file intentionally does NOT use SETLOCAL so OMC_EXE/PYTHON_CMD
rem remain available to the calling batch script.

if defined OMC_EXE if not exist "%OMC_EXE%" set "OMC_EXE="
set "PYTHON_CMD="
set "PF86=%ProgramFiles(x86)%"

rem ---------------------------------------------------------------------------
rem OpenModelica (omc.exe)
rem ---------------------------------------------------------------------------
if defined OMC_EXE if exist "%OMC_EXE%" goto :omc_found

for /f "delims=" %%I in ('where omc.exe 2^>nul') do if not defined OMC_EXE set "OMC_EXE=%%~fI"
if defined OMC_EXE if exist "%OMC_EXE%" goto :omc_found

if defined OPENMODELICAHOME if exist "%OPENMODELICAHOME%\bin\omc.exe" set "OMC_EXE=%OPENMODELICAHOME%\bin\omc.exe"
if defined OMC_EXE goto :omc_found

rem Registry locations used by some OpenModelica Windows installers.
for %%K in (
  "HKLM\SOFTWARE\OpenModelica"
  "HKLM\SOFTWARE\WOW6432Node\OpenModelica"
  "HKCU\SOFTWARE\OpenModelica"
) do (
  for /f "tokens=2,*" %%A in ('reg query %%~K /v InstallLocation 2^>nul ^| findstr /i "InstallLocation"') do (
    if not defined OMC_EXE if exist "%%B\bin\omc.exe" set "OMC_EXE=%%B\bin\omc.exe"
  )
)
if defined OMC_EXE goto :omc_found

rem Standard OpenModelica installation folders, including versioned names such
rem as OpenModelica1.26.9-64bit.
if defined ProgramFiles (
  for /d %%D in ("%ProgramFiles%\OpenModelica*") do if exist "%%~fD\bin\omc.exe" set "OMC_EXE=%%~fD\bin\omc.exe"
)
if defined PF86 (
  for /d %%D in ("%PF86%\OpenModelica*") do if exist "%%~fD\bin\omc.exe" set "OMC_EXE=%%~fD\bin\omc.exe"
)
if defined LOCALAPPDATA (
  for /d %%D in ("%LOCALAPPDATA%\Programs\OpenModelica*") do if exist "%%~fD\bin\omc.exe" set "OMC_EXE=%%~fD\bin\omc.exe"
)
for /d %%D in ("C:\OpenModelica*") do if exist "%%~fD\bin\omc.exe" set "OMC_EXE=%%~fD\bin\omc.exe"

if not defined OMC_EXE goto :omc_missing

:omc_found
"%OMC_EXE%" --version >nul 2>&1
if errorlevel 1 goto :omc_missing
set "OPENMODELICAHOME=%OMC_EXE:\bin\omc.exe=%"
echo [OK] OpenModelica detected: %OMC_EXE%

rem ---------------------------------------------------------------------------
rem Python 3
rem ---------------------------------------------------------------------------
for /f "delims=" %%I in ('where python.exe 2^>nul') do (
  if not defined PYTHON_CMD (
    "%%~fI" --version >nul 2>&1
    if not errorlevel 1 set PYTHON_CMD="%%~fI"
  )
)
if defined PYTHON_CMD goto :python_found

for /f "delims=" %%I in ('where py.exe 2^>nul') do (
  if not defined PYTHON_CMD (
    "%%~fI" -3 --version >nul 2>&1
    if not errorlevel 1 set PYTHON_CMD="%%~fI" -3
  )
)
if not defined PYTHON_CMD goto :python_missing

:python_found
echo [OK] Python detected: %PYTHON_CMD%
exit /b 0

:omc_missing
echo [ERROR] OpenModelica compiler omc.exe could not be located automatically.
echo Install OpenModelica using its normal Windows installer and rerun this file.
echo No PatientEvoPhysio path configuration is required for a standard installation.
exit /b 10

:python_missing
echo [ERROR] Python 3 could not be located automatically.
echo Install Python 3 or enable the Windows Python launcher, then rerun this file.
exit /b 11
