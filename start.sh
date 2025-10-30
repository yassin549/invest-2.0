#!/bin/bash
set -e

echo "========================================="
echo "Starting HYIP Lab Deployment"
echo "========================================="

cd /app/Files/core

echo "→ PHP Version:"
php -v

echo ""
echo "→ Laravel Version:"
php artisan --version

echo ""
echo "→ Checking environment variables..."
echo "DB_HOST: ${MYSQLHOST}"
echo "DB_PORT: ${MYSQLPORT}"
echo "DB_DATABASE: ${MYSQLDATABASE}"
echo "DB_USERNAME: ${MYSQLUSER}"

echo ""
echo "→ Testing database connection..."
php artisan tinker --execute="
try {
    \$pdo = DB::connection()->getPdo();
    echo 'Database connection: SUCCESS\n';
    echo 'Database: ' . DB::connection()->getDatabaseName() . '\n';
} catch (\Exception \$e) {
    echo 'Database connection: FAILED\n';
    echo 'Error: ' . \$e->getMessage() . '\n';
    exit(1);
}
"

echo ""
echo "→ Running database migrations..."
php artisan migrate --force

echo ""
echo "→ Clearing and caching configuration..."
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear

echo ""
echo "→ Starting PHP built-in server from Files directory..."
cd /app/Files
php -S 0.0.0.0:${PORT} -t . index.php
