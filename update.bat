@echo off
:: p0ckit updater - windows helper script
:: ai assisted so if any errors I'm sorry (but also why do you use windows)
:: mirrors the logic from update_fix.sh but for windows users

:: set working directory to script location
cd /d "%~dp0"

echo == p0ckit updater ==
echo.

:: check if we're in the right directory
if not exist "p0ckit.sh" (
    echo Error: run this script from the p0ckit root directory
    pause
    exit /b 1
)

:: check for git
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: git is not installed or not in PATH
    echo Download it from https://git-scm.com/install
    pause
    exit /b 1
)

:: check for docker
where docker >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: docker is not installed or not in PATH
    echo Download it from https://www.docker.com/products/docker-desktop/
    pause
    exit /b 1
)

:: pull latest from github - mirrors fw_upd() in update_fix.sh
echo Updating p0ckit please wait...
git pull origin main
if %errorlevel% neq 0 (
    echo Could not pull latest changes, aborting
    pause
    exit /b 1
)
echo Update done
echo.

:: check if docker image exists
for /f %%i in ('docker images -q p0ckit 2^>nul') do set img_id=%%i

if defined img_id (
    echo Found existing Docker image 'p0ckit'
    set /p ans="Do you want to rebuild it with the latest changes (Y/n)? "
    if /i "%ans%"=="" set ans=Y
    if /i "%ans%"=="y" (
        echo Rebuilding Docker image p0ckit please wait...
        docker build -t p0ckit .
        if %errorlevel% neq 0 (
            echo Docker build failed
            pause
            exit /b 1
        )
        echo Docker image rebuilt successfully
    ) else (
        echo Ok, not rebuilding the image
    )
) else (
    echo No Docker image 'p0ckit' found
    set /p ans="Do you want to build it now (Y/n)? "
    if /i "%ans%"=="" set ans=Y
    if /i "%ans%"=="y" (
        echo Building Docker image p0ckit please wait...
        docker build -t p0ckit .
        if %errorlevel% neq 0 (
            echo Docker build failed
            pause
            exit /b 1
        )
        echo Docker image built successfully
    ) else (
        echo Ok, not building the image
    )
)

echo.
echo Done
pause
