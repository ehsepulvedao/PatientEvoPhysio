@echo off
call "%~dp0scripts\clean_build_windows.bat"
if errorlevel 1 exit /b %errorlevel%
echo.
echo Build cleanup completed. Generated research data were not deleted.
pause
