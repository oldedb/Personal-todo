@echo off
setlocal

:: Default Vite dev server port
set PORT=5173
set APP_URL=http://localhost:%PORT%

:: Check if something is already listening on the Vite port
netstat -ano | findstr "LISTENING" | findstr ":%PORT% " >nul 2>&1
if %errorlevel% == 0 (
    echo Todo app is already running. Opening browser...
    start "" "%APP_URL%"
    exit /b 0
)

:: Not running yet — start the dev server
echo Starting Todo app...
cd /d "%~dp0"
start "" /min cmd /c "npm run dev"

:: Wait for the server to become available (up to 30 seconds)
set /a attempts=0
:wait_loop
if %attempts% geq 30 (
    echo Timed out waiting for dev server to start.
    exit /b 1
)
timeout /t 1 /nobreak >nul
netstat -ano | findstr "LISTENING" | findstr ":%PORT% " >nul 2>&1
if %errorlevel% neq 0 (
    set /a attempts+=1
    goto wait_loop
)

:: Server is up — open the browser
start "" "%APP_URL%"
