@echo off
setlocal
cd /d "%~dp0"

set "BUNDLED_PYTHON=%USERPROFILE%\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe"
if exist "%BUNDLED_PYTHON%" (
    set "PYTHON_CMD="%BUNDLED_PYTHON%""
    goto have_python
)

where py.exe >nul 2>nul
if not errorlevel 1 (
    set "PYTHON_CMD=py -3"
    goto have_python
)

where python.exe >nul 2>nul
if not errorlevel 1 (
    set "PYTHON_CMD=python"
    goto have_python
)

echo Python not found.
echo Install Python 3.12 or run this file from the Codex computer.
pause
exit /b 1

:have_python
if not exist ".venv\Scripts\python.exe" (
    echo Creating virtual environment...
    %PYTHON_CMD% -m venv .venv
    if errorlevel 1 goto failed
)

echo Installing dependencies...
".venv\Scripts\python.exe" -m pip install --upgrade pip
if errorlevel 1 goto failed
".venv\Scripts\python.exe" -m pip install -r requirements.txt
if errorlevel 1 goto failed

if not exist ".env" copy ".env.example" ".env" >nul

echo.
echo Installation completed.
echo 1. Open .env and insert the NEW BotFather token.
echo 2. Double-click start_bot.cmd.
pause
exit /b 0

:failed
echo.
echo Installation failed. See the error above.
pause
exit /b 1

