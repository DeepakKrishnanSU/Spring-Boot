@echo off
title PostgreSQL Server Controller
echo ========================================================
echo Starting PostgreSQL Server for Student Management System
echo ========================================================
echo.

set PG_DIR=C:\Users\shiro\PostgreSQLPortable\App\PgSQL\bin
set PG_DATA=C:\Users\shiro\PostgreSQLPortable\Data
set PG_LOG=C:\Users\shiro\PostgreSQLPortable\pgsql.log

rem Check if PostgreSQL is already running
"%PG_DIR%\pg_isready.exe" -h 127.0.0.1 -p 5432 >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo [INFO] PostgreSQL is ALREADY running on port 5432.
    goto ready
)

echo Starting PostgreSQL background process...
start "PostgreSQL Server" /MIN "%PG_DIR%\postgres.exe" -D "%PG_DATA%"
timeout /t 2 /nobreak >nul

:check_loop
"%PG_DIR%\pg_isready.exe" -h 127.0.0.1 -p 5432 >nul 2>&1
if %ERRORLEVEL% equ 0 (
    goto ready
) else (
    timeout /t 1 /nobreak >nul
    "%PG_DIR%\pg_isready.exe" -h 127.0.0.1 -p 5432 >nul 2>&1
    if %ERRORLEVEL% equ 0 goto ready
    echo [WARNING] Waiting for PostgreSQL to be ready...
    timeout /t 2 /nobreak >nul
)

:ready
"%PG_DIR%\pg_isready.exe" -h 127.0.0.1 -p 5432 >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo.
    echo ========================================================
    echo  [SUCCESS] PostgreSQL is RUNNING and READY on port 5432!
    echo ========================================================
    echo  Database: college
    echo  Username: postgres
    echo  Password: vmax
    echo.
    echo You can now run StudentApplication in Eclipse!
) else (
    echo.
    echo [ERROR] Could not verify PostgreSQL startup.
)
echo.
pause
