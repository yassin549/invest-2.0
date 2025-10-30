# ✅ Pre-Deploy Checklist for Railway

## Before You Push, Verify These:

### 1. Railway Services Setup
- [ ] MySQL service exists and shows **"Active"** status (not "Deploying")
- [ ] App service exists (e.g., `invest-2.0`)
- [ ] Both services are in the same project

### 2. Environment Variables (App Service)
Go to your app service → **Variables** tab:

- [ ] `APP_KEY` is set (example: `base64:8KzP3vJ9mN2qR5tW7xY1zA4bC6dE8fG0hI2jK4lM6nO=`)
- [ ] `APP_URL` is set to your Railway URL (example: `https://invest-20-production.up.railway.app`)
- [ ] MySQL reference is added:
  - Click **"+ New Variable"**
  - Click **"Add Reference"**
  - Select your MySQL service
  - This adds: `MYSQLHOST`, `MYSQLPORT`, `MYSQLDATABASE`, `MYSQLUSER`, `MYSQLPASSWORD`

### 3. MySQL Service Check
Go to MySQL service → **Variables** tab:

You should see these variables (Railway creates them automatically):
- [ ] `MYSQLHOST` (example: `mysql.railway.internal`)
- [ ] `MYSQLPORT` (example: `3306`)
- [ ] `MYSQLDATABASE` (example: `railway`)
- [ ] `MYSQLUSER` (example: `root`)
- [ ] `MYSQLPASSWORD` (a long random string)

### 4. Local Files Check
Verify these files exist in your project:

- [ ] `nixpacks.toml` (in root directory)
- [ ] `Files/core/start.sh` (NEW - created by the fix)
- [ ] `Files/core/.env.example` (should exist)
- [ ] `Files/core/composer.json` (should exist)

### 5. Git Status
Run this to see what will be committed:
```bash
git status
```

You should see:
- Modified: `nixpacks.toml`
- Modified: `DEPLOYMENT_GUIDE.md`
- New file: `Files/core/start.sh`
- New file: `FIXES_APPLIED.md`
- New file: `QUICK_FIX_SUMMARY.md`
- New file: `PRE_DEPLOY_CHECKLIST.md`
- New file: `deploy-fix.bat`

---

## 🚀 Ready to Deploy?

If all checkboxes above are ✅, run:

```bash
# Windows
deploy-fix.bat

# Or manually
git add .
git commit -m "Fix: Railway deployment - Add storage dirs and startup script"
git push origin main
```

---

## 📊 After Pushing

1. **Go to Railway Dashboard**
2. **Click on your app service** (e.g., `invest-2.0`)
3. **Go to "Deployments" tab**
4. **Watch the build progress** (takes 2-3 minutes)
5. **Click on the latest deployment**
6. **Go to "Deploy Logs" tab**

---

## ✅ Success Indicators

In the Deploy Logs, you should see:

```
==> Starting HYIP Lab Application
==> PHP Version:
PHP 8.3.x (cli) (built: ...)
==> Testing database connection...
==> Running database migrations...
Migration table created successfully.
Migrating: 2024_01_01_000000_create_users_table
Migrated:  2024_01_01_000000_create_users_table (123.45ms)
...
==> Starting web server on 0.0.0.0:3000
[Thu Oct 30 12:00:00 2025] PHP 8.3.x Development Server (http://0.0.0.0:3000) started
```

---

## 🚨 Failure Indicators

If you see these, check the specific error:

### "ERROR: .env file not found!"
- Build phase failed
- Check **Build Logs** tab instead

### "WARNING: Could not connect to database"
- MySQL not ready or not linked
- Wait 1 minute and redeploy
- Verify MySQL reference is added

### "ERROR: Migration failed!"
- SQL error or wrong credentials
- Check the specific SQL error message
- Verify `APP_KEY` is set

---

## 🔄 Need to Redeploy?

If you change environment variables or want to retry:

1. Go to your app service
2. Click the **"..."** menu (top right)
3. Click **"Redeploy"**
4. Wait for new deployment

---

## 📞 Still Stuck?

Share these details:
1. Screenshot of your Railway services (show both MySQL and App)
2. Screenshot of app Variables tab (blur sensitive values)
3. Copy the error message from Deploy Logs
4. Confirm: Did you add MySQL reference to app variables?

---

**Good luck! The fix is solid, just make sure everything is checked above! 🚀**
