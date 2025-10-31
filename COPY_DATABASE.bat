@echo off
echo ========================================
echo HYIP Lab Database Copy Script
echo ========================================
echo.

echo Copying database file...
copy "c:\Users\khoua\OneDrive\Desktop\hyip\install\database.sql" "c:\Users\khoua\OneDrive\Desktop\hyiplab_v5.4.1\database_full.sql"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo SUCCESS! Database file copied to:
    echo c:\Users\khoua\OneDrive\Desktop\hyiplab_v5.4.1\database_full.sql
    echo.
    echo ========================================
    echo Next Steps:
    echo ========================================
    echo 1. Read IMPORT_FULL_DATABASE.md for instructions
    echo 2. Import database_full.sql to Railway MySQL
    echo 3. Visit your app URL
    echo.
) else (
    echo.
    echo ERROR: Failed to copy database file
    echo.
)

pause
