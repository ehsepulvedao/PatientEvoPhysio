@echo off
setlocal EnableExtensions
cd /d "%~dp0"

echo ============================================================
echo PatientEvoPhysio 2.0.0 - OpenModelica dependency installer
echo ============================================================
echo.

set "OMC_EXE="
set "PF86=%ProgramFiles(x86)%"

for /f "delims=" %%I in ('where omc.exe 2^>nul') do if not defined OMC_EXE set "OMC_EXE=%%~fI"
if defined OMC_EXE if exist "%OMC_EXE%" goto :omc_found

if defined OPENMODELICAHOME if exist "%OPENMODELICAHOME%\bin\omc.exe" set "OMC_EXE=%OPENMODELICAHOME%\bin\omc.exe"
if defined OMC_EXE goto :omc_found

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
"%OMC_EXE%" --version
if errorlevel 1 goto :omc_missing
echo.
echo Running canonical dependency bootstrap...
"%OMC_EXE%" InstallPatientEvoPhysioDependencies.mos
if errorlevel 1 goto :install_failed

echo.
echo [SUCCESS] Dependencies are installed and PatientEvoPhysio.mo was loaded successfully.
echo Close and restart OMEdit before opening PatientEvoPhysio.mo.
echo If OMEdit forces Modelica 4.x at startup, disable that option under:
echo Tools ^> Options ^> Libraries, then restart OMEdit.
echo.
pause
exit /b 0

:omc_missing
echo.
echo [ERROR] omc.exe could not be found.
echo Install OpenModelica normally, then run this file again.
echo.
pause
exit /b 10

:install_failed
echo.
echo [ERROR] Dependency installation or verification failed.
echo Review the messages above. An Internet connection may be required on a fresh installation.
echo.
pause
exit /b 20
