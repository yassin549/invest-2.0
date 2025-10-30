# 🚀 Free Deployment Guide for HYIP Lab (Laravel 11)

This guide covers **3 free hosting options** for your Laravel application.

---

## 📋 Prerequisites

Before deploying, ensure you have:
- ✅ Git installed
- ✅ GitHub account
- ✅ All dependencies installed locally
- ✅ Application tested locally

---

## 🎯 Option 1: Railway.app (RECOMMENDED)

**Best for:** Full Laravel apps with database, cron jobs, and storage
**Free Tier:** $5 credit/month (enough for small apps)

### Step 1: Prepare Your Project

1. **Create a Procfile** in the root directory (`Files/` folder):
```
web: cd core && php artisan migrate --force && php artisan config:cache && php artisan route:cache && php artisan view:cache && php artisan serve --host=0.0.0.0 --port=$PORT
```

2. **Create a railway.json** in the root directory:
```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "NIXPACKS"
  },
  "deploy": {
    "startCommand": "cd core && php artisan serve --host=0.0.0.0 --port=$PORT",
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 10
  }
}
```

### Step 2: Deploy to Railway

1. Go to [railway.app](https://railway.app) and sign up with GitHub
2. Click **"New Project"** → **"Deploy from GitHub repo"**
3. Select your repository
4. Railway will auto-detect Laravel and deploy

### Step 3: Add Database

1. In your Railway project, click **"+ New"** → **"Database"** → **"Add MySQL"**
2. Railway will automatically set `DATABASE_URL` environment variable
3. Add these environment variables in Railway dashboard:
   - `APP_KEY` - Generate with: `php artisan key:generate --show`
   - `APP_ENV=production`
   - `APP_DEBUG=false`
   - `APP_URL` - Your Railway app URL
   - `DB_CONNECTION=mysql`
   - `DB_HOST` - From Railway MySQL service
   - `DB_PORT=3306`
   - `DB_DATABASE` - From Railway MySQL service
   - `DB_USERNAME` - From Railway MySQL service
   - `DB_PASSWORD` - From Railway MySQL service

### Step 4: Run Migrations

1. In Railway dashboard, go to your app service
2. Click **"Settings"** → **"Deploy"**
3. Add to start command: `php artisan migrate --force`

---

## 🎯 Option 2: Render.com

**Best for:** Laravel apps with PostgreSQL
**Free Tier:** 750 hours/month, auto-sleep after 15 min inactivity

### Step 1: Create render.yaml

Create `render.yaml` in the root directory:

```yaml
services:
  - type: web
    name: hyiplab
    env: php
    buildCommand: cd core && composer install --no-dev --optimize-autoloader && php artisan config:cache && php artisan route:cache && php artisan view:cache
    startCommand: cd core && php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=$PORT
    envVars:
      - key: APP_KEY
        generateValue: true
      - key: APP_ENV
        value: production
      - key: APP_DEBUG
        value: false
      - key: DB_CONNECTION
        value: pgsql
      - key: DATABASE_URL
        fromDatabase:
          name: hyiplab-db
          property: connectionString

databases:
  - name: hyiplab-db
    databaseName: hyiplab
    user: hyiplab
```

### Step 2: Deploy to Render

1. Go to [render.com](https://render.com) and sign up
2. Click **"New +"** → **"Blueprint"**
3. Connect your GitHub repository
4. Render will read `render.yaml` and create services
5. Click **"Apply"** to deploy

### Step 3: Configure Environment

1. Go to your web service dashboard
2. Add environment variables:
   - `APP_KEY` - Generate with: `php artisan key:generate --show`
   - `APP_URL` - Your Render app URL
   - Any API keys (Stripe, Mollie, etc.)

---

## 🎯 Option 3: InfinityFree (Traditional PHP Hosting)

**Best for:** Simple deployment without complex setup
**Free Tier:** Unlimited bandwidth, 5GB storage

### Step 1: Sign Up

1. Go to [infinityfree.com](https://www.infinityfree.com)
2. Create a free account
3. Create a new website

### Step 2: Upload Files

1. Use FileZilla or InfinityFree's file manager
2. Upload all files from `Files/` directory to `htdocs/`
3. Ensure `.htaccess` is uploaded

### Step 3: Create Database

1. In InfinityFree control panel, go to **"MySQL Databases"**
2. Create a new database
3. Note: Database name, username, and password

### Step 4: Configure Environment

1. Create `.env` file in `core/` directory:
```env
APP_NAME="HYIP Lab"
APP_ENV=production
APP_KEY=base64:YOUR_APP_KEY_HERE
APP_DEBUG=false
APP_URL=http://your-domain.infinityfreeapp.com

DB_CONNECTION=mysql
DB_HOST=sqlXXX.infinityfree.com
DB_PORT=3306
DB_DATABASE=your_database_name
DB_USERNAME=your_database_user
DB_PASSWORD=your_database_password

# Add your other credentials
```

2. Generate APP_KEY locally: `php artisan key:generate --show`

### Step 5: Run Migrations

1. Access your site via SSH (if available) or use web-based terminal
2. Run: `php artisan migrate --force`
3. Or import SQL dump via phpMyAdmin

---

## 🔧 General Deployment Checklist

Before deploying to any platform:

### 1. Environment Configuration
- [ ] Set `APP_ENV=production`
- [ ] Set `APP_DEBUG=false`
- [ ] Generate new `APP_KEY`
- [ ] Configure database credentials
- [ ] Add payment gateway credentials (Stripe, Mollie, etc.)
- [ ] Configure mail settings (SMTP, Mailgun, etc.)

### 2. Security
- [ ] Remove `.env.example` from production
- [ ] Ensure `storage/` and `bootstrap/cache/` are writable
- [ ] Set proper file permissions (755 for directories, 644 for files)
- [ ] Enable HTTPS (most platforms provide free SSL)

### 3. Optimization
```bash
cd core
composer install --optimize-autoloader --no-dev
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan optimize
```

### 4. Database
```bash
php artisan migrate --force
php artisan db:seed --force  # If you have seeders
```

---

## 🌐 Custom Domain (Optional)

All platforms support custom domains:

### Railway
1. Go to **Settings** → **Domains**
2. Add your custom domain
3. Update DNS records as instructed

### Render
1. Go to **Settings** → **Custom Domains**
2. Add domain and verify DNS

### InfinityFree
1. Go to **Addon Domains**
2. Add your domain
3. Update nameservers

---

## 🐛 Troubleshooting

### "500 Internal Server Error"
- Check `storage/logs/laravel.log`
- Ensure `APP_KEY` is set
- Verify file permissions

### "Database Connection Error"
- Verify database credentials in `.env`
- Check if database service is running
- Ensure IP whitelist (for cloud databases)

### "Class not found"
- Run `composer install`
- Run `composer dump-autoload`
- Clear cache: `php artisan cache:clear`

### "Storage not writable"
```bash
chmod -R 775 storage bootstrap/cache
```

---

## 📊 Comparison Table

| Feature | Railway | Render | InfinityFree |
|---------|---------|--------|--------------|
| **Free Tier** | $5/month credit | 750 hours/month | Unlimited |
| **Database** | MySQL, PostgreSQL, Redis | PostgreSQL | MySQL |
| **Auto-deploy** | ✅ Yes | ✅ Yes | ❌ Manual |
| **Custom Domain** | ✅ Free SSL | ✅ Free SSL | ✅ Free SSL |
| **Cron Jobs** | ✅ Yes | ✅ Yes | ⚠️ Limited |
| **Best For** | Full-featured apps | Medium apps | Simple sites |

---

## 🎉 Recommended: Railway.app

For your HYIP Lab application with payment gateways and complex features, **Railway.app** is the best choice because:
- ✅ Easy deployment with GitHub integration
- ✅ Supports MySQL (required by your app)
- ✅ Automatic HTTPS
- ✅ Environment variables management
- ✅ Easy scaling
- ✅ Cron jobs support

---

## 📞 Need Help?

If you encounter issues:
1. Check the platform's documentation
2. Review Laravel logs: `storage/logs/laravel.log`
3. Verify environment variables
4. Test database connection

Good luck with your deployment! 🚀
