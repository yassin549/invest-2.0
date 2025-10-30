#!/bin/bash
set -e

echo "========================================="
echo "HYIP Lab Deployment Starting"
echo "========================================="

cd /app/Files/core

echo "→ PHP Version:"
php -v

echo ""
echo "→ Checking PHP Extensions:"
php -m | grep -E "(pdo|mysql|mbstring|xml|curl|gd|zip|bcmath|intl|fileinfo|tokenizer|ctype|json|openssl)" || echo "Some extensions may be missing"

echo ""
echo "→ Checking .env file:"
if [ -f .env ]; then
    echo ".env file exists"
    echo "First 5 lines of .env:"
    head -5 .env
else
    echo "ERROR: .env file not found!"
    exit 1
fi

echo ""
echo "→ Environment variables:"
echo "DB_HOST: ${MYSQLHOST}"
echo "DB_PORT: ${MYSQLPORT}"
echo "DB_DATABASE: ${MYSQLDATABASE}"
echo "DB_USERNAME: ${MYSQLUSER}"
echo "APP_KEY: ${APP_KEY:0:20}..."

echo ""
echo "→ Testing database connection..."
timeout 10 php -r "
\$host = getenv('MYSQLHOST');
\$port = getenv('MYSQLPORT');
\$db = getenv('MYSQLDATABASE');
\$user = getenv('MYSQLUSER');
\$pass = getenv('MYSQLPASSWORD');

try {
    \$pdo = new PDO(\"mysql:host=\$host;port=\$port;dbname=\$db\", \$user, \$pass);
    echo \"✓ Database connection successful\n\";
    echo \"  Connected to: \$db@\$host:\$port\n\";
} catch (PDOException \$e) {
    echo \"✗ Database connection failed\n\";
    echo \"  Error: \" . \$e->getMessage() . \"\n\";
    exit(1);
}
" || { echo "Database connection test failed or timed out"; exit 1; }

echo ""
echo "→ Clearing any cached config..."
php artisan config:clear || true
php artisan cache:clear || true

echo ""
echo "→ Running migrations..."
php artisan migrate --force --no-interaction || { echo "Migration failed"; exit 1; }

echo ""
echo "→ Optimizing application..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo ""
echo "→ Starting web server from Files directory..."
cd /app/Files
exec php -S 0.0.0.0:${PORT} -t . index.php
