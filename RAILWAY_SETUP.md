# 🚂 Railway Deployment - Quick Fix Guide

## ❌ Current Error
```
SQLSTATE[HY000] [2002] No such file or directory
```

This error means your Laravel app is trying to connect to MySQL, but **no MySQL database service exists** in your Railway project.

---

## ✅ Solution: Add MySQL Database

### Step 1: Add MySQL Service to Railway

1. Open your Railway project dashboard
2. Click **"+ New"** button
3. Select **"Database"** → **"Add MySQL"**
4. Wait for MySQL to provision (takes ~30 seconds)

### Step 2: Link MySQL to Your App

Railway will automatically create these environment variables in the MySQL service:
- `MYSQLHOST`
- `MYSQLPORT`
- `MYSQLDATABASE`
- `MYSQLUSER`
- `MYSQLPASSWORD`

**Important:** You need to make these available to your `invest-2.0` service:

1. Click on your **`invest-2.0`** service
2. Go to **"Variables"** tab
3. Click **"+ New Variable"** → **"Add Reference"**
4. Select your MySQL service
5. This will link all MySQL variables to your app

### Step 3: Add Required Environment Variables

In your `invest-2.0` service, add these variables:

```env
APP_KEY=base64:GENERATE_THIS_KEY_BELOW
APP_ENV=production
APP_DEBUG=false
APP_URL=https://your-app-url.up.railway.app
```

#### Generate APP_KEY

Run this command locally to generate a key:
```bash
php artisan key:generate --show
```

Or use this pre-generated key (for testing only):
```
base64:8KzP3vJ9mN2qR5tW7xY1zA4bC6dE8fG0hI2jK4lM6nO=
```

**⚠️ Security Note:** Generate a new key for production!

### Step 4: Redeploy

1. The updated `nixpacks.toml` will automatically configure the database connection
2. Click **"Deploy"** or push a new commit to trigger redeployment
3. Railway will:
   - Install dependencies
   - Create `.env` file with MySQL credentials
   - Run migrations
   - Start the server

---

## 🔍 Verify Deployment

After deployment:

1. Check **Logs** tab in Railway
2. Look for:
   ```
   Migration table created successfully.
   Migrating: ...
   Server started successfully
   ```

3. Visit your app URL to confirm it's working

---

## 🐛 Still Having Issues?

### Check Database Connection

In Railway logs, verify these variables are set:
```
MYSQLHOST=containers-us-west-xxx.railway.app
MYSQLPORT=3306
MYSQLDATABASE=railway
MYSQLUSER=root
MYSQLPASSWORD=***
```

### Check App Variables

Ensure these are set in your service:
```
APP_KEY=base64:...
APP_ENV=production
DB_CONNECTION=mysql
```

### View Detailed Logs

1. Go to your service in Railway
2. Click **"Deployments"** tab
3. Click on the failed deployment
4. Check **"Build Logs"** and **"Deploy Logs"**

---

## 📝 What Changed?

The `nixpacks.toml` file was updated to:
1. Copy `.env.example` to `.env` during install
2. Automatically inject Railway MySQL credentials into `.env`
3. Set app configuration from environment variables

This means you don't need to manually create a `.env` file - it's done automatically during deployment!

---

## 🎯 Next Steps After Successful Deployment

1. **Configure Payment Gateways** (if needed)
   - Add Stripe/PayPal API keys to environment variables

2. **Set Up Email** (optional)
   - Configure SMTP settings in environment variables

3. **Custom Domain** (optional)
   - Go to Settings → Domains
   - Add your custom domain

---

## 💡 Pro Tips

- **Free Tier Limits:** Railway gives $5 credit/month (enough for small apps)
- **Database Backups:** Set up automated backups in MySQL service settings
- **Monitoring:** Use Railway's built-in metrics to monitor your app
- **Logs:** Always check logs when debugging deployment issues

---

## 🆘 Emergency Rollback

If deployment fails:
1. Go to **"Deployments"** tab
2. Find a working deployment
3. Click **"⋮"** → **"Redeploy"**

---

**Need more help?** Check the main [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md) for detailed instructions.
