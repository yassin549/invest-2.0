# MySQL Connection Fix - "No such file or directory" Error

## The Problem

Your app builds successfully and the `.env` file has correct MySQL credentials, but you're getting:
```
SQLSTATE[HY000] [2002] No such file or directory
```

This error means Laravel **cannot reach the MySQL server**, even though credentials are correct.

---

## Solution 1: Verify MySQL Service is in Same Project (MOST LIKELY FIX)

### Check This First:

1. Go to Railway dashboard
2. Look at the left sidebar - you should see **TWO services**:
   - `invest-2.0` (your app)
   - `MySQL` (your database)

3. **If you only see ONE service**, that's the problem! You need to add MySQL to **this project**.

### To Fix:

1. Click **"+ New"** in your project
2. Select **"Database"** → **"Add MySQL"**
3. Wait for it to provision
4. **Link it to your app**:
   - Click on `invest-2.0` service
   - Go to **"Variables"** tab
   - Click **"+ New Variable"** → **"Add Reference"**
   - Select the MySQL service
   - Check all MySQL variables

---

## Solution 2: Use MySQL Public URL (If Private Network Doesn't Work)

Railway MySQL provides a **public URL** that works from anywhere.

### In Railway Dashboard:

1. Click on your **MySQL** service
2. Go to **"Connect"** tab
3. Copy the **"Public URL"** or individual connection details:
   - **MYSQL_PUBLIC_URL** or
   - **Host**, **Port**, **Database**, **Username**, **Password**

### Update Environment Variables in `invest-2.0`:

Instead of using the private network variables, add these in your `invest-2.0` service Variables tab:

```
MYSQLHOST=containers-us-west-xxx.railway.app
MYSQLPORT=6379
MYSQLDATABASE=railway
MYSQLUSER=root
MYSQLPASSWORD=your_password_here
```

*(Replace with your actual public connection details)*

---

## Solution 3: Check if MySQL is Actually Running

1. Go to your **MySQL** service in Railway
2. Check the **"Deployments"** tab
3. Ensure the latest deployment shows **"Success"** and is **"Active"**
4. If it's crashed or stopped, restart it

---

## Solution 4: Test Connection Manually

Add a test command to verify MySQL connectivity:

### In Railway, go to `invest-2.0` → Settings → Add this as a one-time command:

```bash
cd Files/core && php artisan tinker --execute="DB::connection()->getPdo(); echo 'Connected successfully';"
```

This will tell you if PHP can reach MySQL at all.

---

## Solution 5: Enable Private Networking (Railway V2)

If you're on Railway V2:

1. Go to **Project Settings**
2. Look for **"Private Networking"** or **"Service Discovery"**
3. Ensure it's **enabled**
4. Redeploy both services

---

## Quick Debug: Check What's in .env

Add this temporary command to your start script to see what's actually in the `.env` file:

### Update `nixpacks.toml` start command temporarily:

```toml
[start]
cmd = "cd Files/core && cat .env && php artisan migrate --force && php artisan serve --host=0.0.0.0 --port=$PORT"
```

This will print the `.env` contents in the logs so you can verify the MySQL variables are correct.

---

## Most Common Causes:

1. ❌ **MySQL service not in the same project** - Add it!
2. ❌ **MySQL service crashed** - Restart it
3. ❌ **Private network not enabled** - Use public URL instead
4. ❌ **Wrong variable names** - Ensure you're using `MYSQLHOST`, not `MYSQL_HOST`
5. ❌ **MySQL service not linked** - Add reference in Variables tab

---

## After Trying These Solutions:

1. Commit the updated `nixpacks.toml`:
   ```bash
   git add nixpacks.toml
   git commit -m "Fix: Add DB_SOCKET empty value to force TCP connection"
   git push
   ```

2. Check the deployment logs carefully
3. Look for the actual MySQL connection details being used

---

## Still Not Working?

Share a screenshot of:
1. Your Railway project showing ALL services in the left sidebar
2. The Variables tab of your `invest-2.0` service
3. The full deployment logs from the "Deploy Logs" tab

This will help identify the exact issue.
