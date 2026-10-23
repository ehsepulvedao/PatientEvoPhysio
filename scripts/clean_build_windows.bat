@echo off
setlocal EnableExtensions
cd /d "%~dp0\.."

echo Cleaning PatientEvoPhysio build artifacts...

if exist "build" (
  rmdir /s /q "build"
  echo [OK] Removed build\
)

rem Remove artifacts produced by the older v2.0.0 smoke script in the repository root.
for %%P in (neonate_healthy_smoke*) do (
  if exist "%%P" del /f /q "%%P" >nul 2>&1
)

echo [OK] Repository build artifacts cleaned.
echo Research results under data\generated are preserved.
endlocal
