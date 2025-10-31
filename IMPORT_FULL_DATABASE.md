# Import Full HYIP Lab Database - Complete Guide

## 📍 Database File Located!

**Location:** `c:\Users\khoua\OneDrive\Desktop\hyip\install\database.sql`  
**Size:** 231,939 bytes (232 KB)  
**Contains:** Complete HYIP Lab database schema with sample data

---

## 🎯 What This Database Includes

✅ **All 40+ Tables:**
- `admins` - Admin accounts
- `general_settings` - System configuration
- `plans` - Investment plans
- `invests` - User investments
- `transactions` - Financial records
- `deposits`, `withdrawals` - Payment records
- `gateways`, `gateway_currencies` - Payment methods
- `users` - User accounts
- `referrals` - Referral system
- `support_tickets` - Support system
- And 30+ more tables...

✅ **Sample Data:**
- Default admin account
- Sample investment plans
- Example configurations
- Payment gateway templates

---

## 🚀 Import Methods

### Method 1: Via Railway Dashboard (RECOMMENDED)

#### Step 1: Access Railway MySQL
1. Go to https://railway.app
2. Open your project
3. Click on **MySQL** service
4. Click **"Connect"** or **"Query"** tab

#### Step 2: Prepare Database
```sql
-- First, drop existing tables to avoid conflicts
DROP TABLE IF EXISTS cache;
DROP TABLE IF EXISTS cache_locks;
DROP TABLE IF EXISTS jobs;
DROP TABLE IF EXISTS job_batches;
DROP TABLE IF EXISTS failed_jobs;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS password_reset_tokens;
DROP TABLE IF EXISTS sessions;
```

#### Step 3: Import SQL File
1. Open `c:\Users\khoua\OneDrive\Desktop\hyip\install\database.sql` in a text editor
2. Copy ALL contents
3. Paste into Railway MySQL Query tab
4. Click **"Run"** or **"Execute"**

---

### Method 2: Via MySQL Client (Windows)

#### Step 1: Install MySQL Client (if not installed)
Download from: https://dev.mysql.com/downloads/mysql/

#### Step 2: Get Railway Connection Details
From Railway Dashboard → MySQL service → Variables:
- `MYSQLHOST`: mysql.railway.internal
- `MYSQLPORT`: 3306
- `MYSQLDATABASE`: railway
- `MYSQLUSER`: root
- `MYSQLPASSWORD`: [your password]

#### Step 3: Import via Command Line
```bash
# Open PowerShell or Command Prompt
cd "c:\Users\khoua\OneDrive\Desktop\hyip\install"

# Import (replace [PASSWORD] with actual password)
mysql -h mysql.railway.internal -P 3306 -u root -p[PASSWORD] railway < database.sql
```

---

### Method 3: Via Railway CLI

#### Step 1: Install Railway CLI
```bash
npm install -g @railway/cli
```

#### Step 2: Login and Link Project
```bash
railway login
cd "c:\Users\khoua\OneDrive\Desktop\hyiplab_v5.4.1"
railway link
```

#### Step 3: Import Database
```bash
cd "c:\Users\khoua\OneDrive\Desktop\hyip\install"
railway run mysql -u root -p railway < database.sql
```

---

### Method 4: Via phpMyAdmin (if available)

1. Access phpMyAdmin (if you have it set up)
2. Select `railway` database
3. Click **"Import"** tab
4. Choose file: `c:\Users\khoua\OneDrive\Desktop\hyip\install\database.sql`
5. Click **"Go"**

---

## 🔐 Default Admin Credentials (from database.sql)

**Admin Panel:** `https://your-app.railway.app/admin`

**Username:** `admin`  
**Email:** `aliabbasnadeem538@gmail.com`  
**Password:** (encrypted in database)

⚠️ **Password is hashed** - You'll need to reset it after import.

### Reset Admin Password

**Option A: Via SQL**
```sql
-- Set password to 'admin123'
UPDATE admins 
SET password = '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi'
WHERE username = 'admin';
```

**Option B: Via Laravel Tinker**
```bash
railway run php artisan tinker

# In tinker:
$admin = App\Models\Admin::where('username', 'admin')->first();
$admin->password = bcrypt('your-new-password');
$admin->save();
```

---

## ✅ Verify Import Success

### Step 1: Check Tables Created
```sql
USE railway;
SHOW TABLES;
```

**Expected Output:** 40+ tables including:
- admins
- general_settings
- plans
- invests
- transactions
- deposits
- withdrawals
- gateways
- users
- etc.

### Step 2: Check Data Exists
```sql
-- Check general settings
SELECT * FROM general_settings;

-- Check admin account
SELECT id, name, username, email FROM admins;

-- Check investment plans
SELECT id, name, interest, interest_type FROM plans;
```

### Step 3: Test Application
Visit: `https://your-app.railway.app`

**Should see:**
- ✅ Homepage loads with proper styling
- ✅ Investment plans displayed
- ✅ No database errors
- ✅ Admin panel accessible

---

## 🔧 After Import - Required Steps

### 1. Update General Settings
```sql
UPDATE general_settings SET
  site_name = 'Your Site Name',
  email_from = 'your-email@example.com',
  active_template = 'neo_dark',
  maintenance_mode = 0
WHERE id = 1;
```

### 2. Clear Application Caches
```bash
railway run php artisan config:clear
railway run php artisan cache:clear
railway run php artisan route:clear
railway run php artisan view:clear
```

### 3. Disable Debug Mode
Update `nixpacks.toml` line 29:
```toml
"cd Files/core && echo 'APP_DEBUG=false' >> .env",
```

Then deploy:
```bash
git add nixpacks.toml
git commit -m "Disable debug mode after database import"
git push
```

### 4. Change Admin Password
Login to admin panel and change password immediately.

### 5. Configure Payment Gateways
- Go to Admin Panel → Payment Gateways
- Configure your payment methods
- Add API keys for gateways you want to use

---

## 📊 Database Statistics

The imported database includes:

- **Tables:** 40+
- **Admin Account:** 1 (username: admin)
- **Sample Plans:** Several investment plans
- **Payment Gateways:** 30+ gateway templates
- **Languages:** English (default)
- **Templates:** 3 themes (bit_gold, invester, neo_dark)

---

## ⚠️ Important Notes

### 1. Backup First
If you have any existing data, back it up:
```sql
mysqldump -h mysql.railway.internal -u root -p railway > backup.sql
```

### 2. Table Conflicts
The import will **overwrite** existing tables. Make sure to drop conflicting tables first.

### 3. Email Configuration
Update email settings in Admin Panel → System Settings → Email Configuration

### 4. Cron Jobs
Set up cron job to hit: `https://your-app.railway.app/cron`  
Frequency: Every 5-15 minutes

### 5. File Permissions
Ensure storage directories are writable:
```bash
railway run chmod -R 775 Files/core/storage
railway run chmod -R 775 Files/core/bootstrap/cache
```

---

## 🐛 Troubleshooting

### Error: "Table already exists"
```sql
-- Drop all tables first
DROP DATABASE railway;
CREATE DATABASE railway;
USE railway;
-- Then import again
```

### Error: "Access denied"
Check Railway MySQL credentials are correct.

### Error: "Lost connection to MySQL server"
Database file is large. Try importing in smaller chunks or increase timeout.

### Homepage still shows errors
```bash
# Clear all caches
railway run php artisan optimize:clear
```

---

## 🎉 Success Checklist

After successful import, you should have:

- ✅ 40+ database tables
- ✅ Admin account accessible
- ✅ Homepage loads with investment plans
- ✅ Payment gateways configured
- ✅ No database errors
- ✅ Full HYIP functionality

---

## 📞 Next Steps After Import

1. **Login to Admin Panel** (`/admin`)
2. **Change admin password**
3. **Update site settings** (name, logo, colors)
4. **Configure email** (SMTP settings)
5. **Set up payment gateways** (add API keys)
6. **Create/edit investment plans**
7. **Test user registration**
8. **Test investment flow**
9. **Set up cron job**
10. **Go live!** 🚀

---

**The database file is ready to import. Choose your preferred method above and proceed!**

**File Location:** `c:\Users\khoua\OneDrive\Desktop\hyip\install\database.sql`
