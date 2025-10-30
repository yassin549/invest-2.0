#!/bin/bash
set -e

echo "==> Starting HYIP Lab Application"

# Check PHP version
echo "==> PHP Version:"
php -v

# Check if .env exists
if [ ! -f .env ]; then
    echo "ERROR: .env file not found!"
    exit 1
fi

# Check database connection
echo "==> Testing database connection..."
php artisan db:show || {
    echo "WARNING: Could not connect to database. Will retry during migration."
}

# Run migrations
echo "==> Running database migrations..."
php artisan migrate --force || {
    echo "ERROR: Migration failed!"
    echo "==> Checking database configuration..."
    php artisan config:show database
    exit 1
}

# Start the application
echo "==> Starting web server on 0.0.0.0:${PORT}"
exec php artisan serve --host=0.0.0.0 --port=$PORT
