@echo off
REM ============================================================
REM osTicket Docker - Helper Script for Windows
REM ============================================================
REM This script provides easy access to common Docker commands
REM Usage: Run this file to see menu options
REM
REM Requirements:
REM - Docker Desktop installed and running
REM - Docker Compose installed (included with Docker Desktop v2+)
REM - PowerShell or Command Prompt
REM ============================================================

setlocal enabledelayedexpansion

REM Color codes (Windows 10+ supports ANSI)
set "COLOR_INFO=[94m"
set "COLOR_SUCCESS=[92m"
set "COLOR_WARNING=[93m"
set "COLOR_ERROR=[91m"
set "COLOR_RESET=[0m"

REM Check if Docker is running
docker ps >nul 2>&1
if errorlevel 1 (
    echo.
    echo %COLOR_ERROR%[ERROR]%COLOR_RESET% Docker is not running or not installed
    echo Please start Docker Desktop and try again
    pause
    exit /b 1
)

:menu
cls
echo.
echo ========================================
echo   osTicket Docker Helper (Windows)
echo ========================================
echo 1. Start containers
echo 2. Stop containers
echo 3. Restart containers
echo 4. View logs (web)
echo 5. View logs (database)
echo 6. View all logs
echo 7. Open PowerShell in web container
echo 8. Open MySQL console
echo 9. Backup database
echo 10. Fix permissions
echo 11. Health check
echo 12. Show status
echo 13. Exit
echo ========================================
echo.
set /p choice="Pilih menu (1-13): "

if "%choice%"=="1" goto start
if "%choice%"=="2" goto stop
if "%choice%"=="3" goto restart
if "%choice%"=="4" goto logs_web
if "%choice%"=="5" goto logs_db
if "%choice%"=="6" goto logs_all
if "%choice%"=="7" goto powershell
if "%choice%"=="8" goto mysql
if "%choice%"=="9" goto backup
if "%choice%"=="10" goto permissions
if "%choice%"=="11" goto health
if "%choice%"=="12" goto status
if "%choice%"=="13" exit /b 0

goto invalid

:start
echo.
echo %COLOR_INFO%[INFO]%COLOR_RESET% Starting containers...
docker compose up -d
echo %COLOR_SUCCESS%[SUCCESS]%COLOR_RESET% Containers started
docker compose ps
pause
goto menu

:stop
echo.
echo %COLOR_INFO%[INFO]%COLOR_RESET% Stopping containers...
docker compose stop
echo %COLOR_SUCCESS%[SUCCESS]%COLOR_RESET% Containers stopped
pause
goto menu

:restart
echo.
echo %COLOR_INFO%[INFO]%COLOR_RESET% Restarting containers...
docker compose restart
echo %COLOR_SUCCESS%[SUCCESS]%COLOR_RESET% Containers restarted
timeout /t 5 /nobreak
docker compose ps
pause
goto menu

:logs_web
echo.
echo %COLOR_INFO%[INFO]%COLOR_RESET% Showing web logs (press Ctrl+C to stop)...
docker compose logs -f web
goto menu

:logs_db
echo.
echo %COLOR_INFO%[INFO]%COLOR_RESET% Showing database logs (press Ctrl+C to stop)...
docker compose logs -f db
goto menu

:logs_all
echo.
echo %COLOR_INFO%[INFO]%COLOR_RESET% Showing all logs (press Ctrl+C to stop)...
docker compose logs -f
goto menu

:powershell
echo.
echo %COLOR_INFO%[INFO]%COLOR_RESET% Entering PowerShell in web container...
echo %COLOR_WARNING%[WARNING]%COLOR_RESET% Type 'exit' to return
docker compose exec web bash
goto menu

:mysql
echo.
echo %COLOR_INFO%[INFO]%COLOR_RESET% Connecting to MySQL console...
echo %COLOR_WARNING%[WARNING]%COLOR_RESET% Type 'exit' to return
docker compose exec db mysql -u osticket -p
goto menu

:backup
echo.
setlocal
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c%%a%%b)
for /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)
set backup_file=backup_%mydate%_%mytime%.sql

echo %COLOR_INFO%[INFO]%COLOR_RESET% Creating backup to %backup_file%...

REM Get password from .env
for /f "tokens=2 delims==" %%a in ('findstr "MYSQL_PASSWORD=" .env') do set mysql_pass=%%a

docker compose exec db mysqldump -u osticket -p%mysql_pass% osticket > %backup_file%

if errorlevel 0 (
    echo %COLOR_SUCCESS%[SUCCESS]%COLOR_RESET% Backup created: %backup_file%
    dir %backup_file%
) else (
    echo %COLOR_ERROR%[ERROR]%COLOR_RESET% Backup failed
)
endlocal
pause
goto menu

:permissions
echo.
echo %COLOR_INFO%[INFO]%COLOR_RESET% Fixing file permissions...
docker compose exec web chown -R www-data:www-data /var/www/html
docker compose exec web chmod -R 755 /var/www/html
docker compose exec web chmod -R 775 /var/www/html/upload/attachments
docker compose exec web chmod -R 775 /var/www/html/upload/include
echo %COLOR_SUCCESS%[SUCCESS]%COLOR_RESET% Permissions fixed
pause
goto menu

:health
echo.
echo %COLOR_INFO%[INFO]%COLOR_RESET% Performing health checks...
echo.

echo 1. Container status:
docker compose ps
echo.

echo 2. Web service health check:
docker compose exec web curl -s http://localhost > nul
if errorlevel 0 (
    echo %COLOR_SUCCESS%[SUCCESS]%COLOR_RESET% Web service is responding
) else (
    echo %COLOR_ERROR%[ERROR]%COLOR_RESET% Web service is not responding
)
echo.

echo 3. Database connection test:
for /f "tokens=2 delims==" %%a in ('findstr "MYSQL_PASSWORD=" .env') do set mysql_pass=%%a
docker compose exec web mysql -h db -u osticket -p%mysql_pass% -e "SELECT 1;" >nul 2>&1
if errorlevel 0 (
    echo %COLOR_SUCCESS%[SUCCESS]%COLOR_RESET% Database is accessible
) else (
    echo %COLOR_ERROR%[ERROR]%COLOR_RESET% Database connection failed
)
echo.

echo 4. PHP extensions check:
docker compose exec web php -m | findstr /R "mysqli gd imap intl zip" >nul
if errorlevel 0 (
    echo %COLOR_SUCCESS%[SUCCESS]%COLOR_RESET% Required PHP extensions are installed
) else (
    echo %COLOR_WARNING%[WARNING]%COLOR_RESET% Some extensions may be missing
)
echo.

echo 5. Disk usage:
docker system df

pause
goto menu

:status
echo.
echo %COLOR_INFO%[INFO]%COLOR_RESET% Container Status:
docker compose ps
echo.
pause
goto menu

:invalid
echo.
echo %COLOR_ERROR%[ERROR]%COLOR_RESET% Pilihan tidak valid
echo.
pause
goto menu
