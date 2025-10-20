@echo off
echo ====================================
echo Laravel Application Setup and Run
echo ====================================
echo.

echo Checking PHP installation...
php --version
if %errorlevel% neq 0 (
    echo ERROR: PHP is not installed or not in PATH
    pause
    exit /b 1
)
echo.

echo Checking Composer installation...
composer --version
if %errorlevel% neq 0 (
    echo ERROR: Composer is not installed or not in PATH
    pause
    exit /b 1
)
echo.

echo Installing Composer dependencies...
composer install
if %errorlevel% neq 0 (
    echo ERROR: Composer install failed
    pause
    exit /b 1
)
echo.

echo Checking if .env file exists...
if not exist .env (
    echo Creating .env file from .env.example...
    copy .env.example .env
    echo Configuring MySQL database...
    powershell -Command "(Get-Content .env) -replace 'DB_CONNECTION=.*', 'DB_CONNECTION=mysql' | Set-Content .env"
    powershell -Command "(Get-Content .env) -replace 'DB_HOST=.*', 'DB_HOST=127.0.0.1' | Set-Content .env"
    powershell -Command "(Get-Content .env) -replace 'DB_PORT=.*', 'DB_PORT=3306' | Set-Content .env"
    powershell -Command "(Get-Content .env) -replace 'DB_DATABASE=.*', 'DB_DATABASE=principal_desk_ddd' | Set-Content .env"
    powershell -Command "(Get-Content .env) -replace 'DB_USERNAME=.*', 'DB_USERNAME=root' | Set-Content .env"
    powershell -Command "(Get-Content .env) -replace 'DB_PASSWORD=.*', 'DB_PASSWORD=' | Set-Content .env"
    echo Generating application key...
    php artisan key:generate
)
echo.

where mysql >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: The 'mysql' command is not found. Please add MySQL to your PATH or create the database manually.
    echo To create the database manually, run:
    echo mysql -u root -e "CREATE DATABASE principal_desk_ddd;"
    pause
    goto afterdb
)

echo Creating MySQL database if not exists...
mysql -u root -e "CREATE DATABASE IF NOT EXISTS principal_desk_ddd;"
if %errorlevel% neq 0 (
    echo WARNING: Could not create database. Make sure MySQL is running and accessible.
    echo You may need to create the database manually: CREATE DATABASE principal_desk_ddd;
    pause
)
:afterdb
echo.

echo Running session table migration if needed...
php artisan session:table
echo.

echo Running database migrations...
php artisan migrate
echo.

echo Linking storage to public/storage (symlink)...
php artisan storage:link
echo.

echo Clearing and warming configuration cache...
php artisan config:clear
echo.

echo ====================================
echo Starting Laravel development server...
echo Application will be available at http://localhost:8000
echo Press Ctrl+C to stop the server
echo ====================================
echo.

php artisan serve
