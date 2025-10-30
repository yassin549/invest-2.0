# Railway Environment Variables Setup

## Required Variables for `invest-2.0` Service

After adding the MySQL database and linking it to your service, you only need to add these **2 variables** in your `invest-2.0` service:

### 1. APP_KEY
```
APP_KEY=base64:8KzP3vJ9mN2qR5tW7xY1zA4bC6dE8fG0hI2jK4lM6nO=
```

### 2. APP_URL
```
APP_URL=https://invest-20-production.up.railway.app
```
*(Replace with your actual Railway URL)*

---

## MySQL Variables (Automatically Provided)

When you link the MySQL service, these variables are **automatically available**:
- `MYSQLHOST` - MySQL server hostname
- `MYSQLPORT` - MySQL port (usually 3306)
- `MYSQLDATABASE` - Database name
- `MYSQLUSER` - Database username
- `MYSQLPASSWORD` - Database password

**You don't need to manually add these!** Railway provides them automatically when you reference the MySQL service.

---

## How to Link MySQL Service

1. Go to your `invest-2.0` service
2. Click **"Variables"** tab
3. Click **"+ New Variable"** → **"Add Reference"**
4. Select your **MySQL** service
5. Check all MySQL variables
6. Click **"Add"**

---

## Verification

After adding variables and linking MySQL:

1. Go to **"Variables"** tab in `invest-2.0`
2. You should see:
   - `APP_KEY` (your value)
   - `APP_URL` (your URL)
   - `MYSQLHOST` (from MySQL service)
   - `MYSQLPORT` (from MySQL service)
   - `MYSQLDATABASE` (from MySQL service)
   - `MYSQLUSER` (from MySQL service)
   - `MYSQLPASSWORD` (from MySQL service)

---

## Optional Variables

If you need to customize other settings, you can add:

```env
APP_ENV=production          # Default: production
APP_DEBUG=false            # Default: false
LOG_LEVEL=error            # Default: error
```

But these are already set with defaults in `nixpacks.toml`, so they're optional.

---

## ⚠️ Important Notes

1. **Never commit APP_KEY to Git** - Keep it in Railway variables only
2. **Generate a new APP_KEY for production** - Don't use the example key
3. **Update APP_URL** - Use your actual Railway domain
4. **MySQL must be linked** - Without it, the app will crash with connection errors

---

## Generate New APP_KEY

To generate a secure APP_KEY locally:

```bash
cd Files/core
php artisan key:generate --show
```

Copy the output and paste it as the `APP_KEY` value in Railway.
