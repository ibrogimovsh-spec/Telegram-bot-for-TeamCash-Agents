@echo off
setlocal
cd /d "%~dp0"

if not exist ".venv\Scripts\python.exe" (
    echo The bot is not installed yet. Run setup_bot.cmd first.
    pause
    exit /b 1
)

echo Starting Telegram bot...
".venv\Scripts\python.exe" bot.py

echo.
echo The bot has stopped. Check the message above.
pause
start

