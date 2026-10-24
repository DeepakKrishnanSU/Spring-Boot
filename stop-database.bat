@echo off
title Stop PostgreSQL Server
echo ========================================================
echo Stopping PostgreSQL Server...
echo ========================================================
echo.

set PG_DIR=C:\Users\shiro\PostgreSQLPortable\App\PgSQL\bin
set PG_DATA=C:\Users\shiro\PostgreSQLPortable\Data

"%PG_DIR%\pg_ctl.exe" -D "%PG_DATA%" stop >nul 2>&1
taskkill /F /IM postgres.exe >nul 2>&1

echo [INFO] PostgreSQL server stopped successfully.
echo.
pause
