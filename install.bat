@echo off

REM Define variables
set SERVICE_NAME=AnvilAppService
set SERVICE_PATH=%cd%
set SERVICE_EXECUTABLE=run.bat
set SERVICE_USER=.\anvil-user
set SERVICE_PASSWORD=PLACEHOLDER_PASSWORD
set LOG_FILE=%SERVICE_PATH%\log\service.log

REM Create log directory if it doesn't exist
if not exist "%SERVICE_PATH%\log" (
    echo Creating log directory...
    mkdir "%SERVICE_PATH%\log"
)

REM Check if the service already exists
echo Checking if service "%SERVICE_NAME%" exists...
nssm.exe status %SERVICE_NAME% >nul 2>&1
if not errorlevel 1 (
    echo Service "%SERVICE_NAME%" already exists. Stopping and removing it...
    nssm.exe stop %SERVICE_NAME%
    nssm.exe remove %SERVICE_NAME% confirm
    if errorlevel 1 (
        echo [ERROR] Failed to remove existing service "%SERVICE_NAME%".
        exit /b 1
    )
)

REM Install the service with correct path and startup directory
echo Installing service "%SERVICE_NAME%"...
nssm.exe install %SERVICE_NAME% "%SERVICE_PATH%\%SERVICE_EXECUTABLE%"
if errorlevel 1 (
    echo [ERROR] Failed to install service "%SERVICE_NAME%".
    exit /b 1
)

REM Set the startup directory
echo Configuring service startup directory...
nssm.exe set %SERVICE_NAME% AppDirectory "%SERVICE_PATH%"
if errorlevel 1 (
    echo [ERROR] Failed to configure startup directory for service "%SERVICE_NAME%".
    exit /b 1
)

REM Set the service to run as the specified user
echo Configuring service to run as "%SERVICE_USER%"...
nssm.exe set %SERVICE_NAME% ObjectName %SERVICE_USER% %SERVICE_PASSWORD%
if errorlevel 1 (
    echo [ERROR] Failed to configure service user "%SERVICE_USER%".
    exit /b 1
)

REM Configure single log file for both stdout and stderr
echo Configuring service logging...
nssm.exe set %SERVICE_NAME% AppStdout "%LOG_FILE%"
nssm.exe set %SERVICE_NAME% AppStderr "%LOG_FILE%"
if errorlevel 1 (
    echo [ERROR] Failed to configure logging for service "%SERVICE_NAME%".
    exit /b 1
)

REM Start the service
echo Starting service "%SERVICE_NAME%"...
nssm.exe start %SERVICE_NAME%
if errorlevel 1 (
    echo [ERROR] Failed to start service "%SERVICE_NAME%".
    exit /b 1
)

echo Service "%SERVICE_NAME%" installed and started successfully.
exit /b 0
