@echo off
echo ========================================================
echo PostgreSQL Interactive Console - College Database
echo ========================================================
echo.
set PGPASSWORD=vmax
set PG_BIN=C:\Users\shiro\PostgreSQLPortable\App\PgSQL\bin\psql.exe

"%PG_BIN%" -h 127.0.0.1 -p 5432 -U postgres -d college -c "SELECT * FROM student ORDER BY regno ASC;"

echo.
echo --------------------------------------------------------
echo You are now in the PostgreSQL interactive shell (college database).
echo Type: SELECT * FROM student; to see all current records.
echo Type: \q to exit.
echo --------------------------------------------------------
echo.

"%PG_BIN%" -h 127.0.0.1 -p 5432 -U postgres -d college
