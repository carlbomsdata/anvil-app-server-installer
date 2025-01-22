@echo off

REM Step 1: Create a virtual environment if it doesn't already exist
if not exist "env" (
    echo Creating virtual environment...
    python -m venv env
)

REM Step 2: Activate the virtual environment
echo Activating virtual environment...
call env\Scripts\activate

REM Step 3: Upgrade pip and install anvil-app-server
echo Upgrading pip and installing anvil-app-server...
pip install --upgrade pip
pip install anvil-app-server

REM Step 4: Set SSL_CERT_FILE to point to the certifi certificate file in the virtual environment
set SSL_CERT_FILE=%cd%\env\Lib\site-packages\certifi\cacert.pem

REM Step 5: Run the Anvil app server with the specified project name
echo Starting Anvil app server...
anvil-app-server --app PLACEHOLDER_PROJECT_NAME
