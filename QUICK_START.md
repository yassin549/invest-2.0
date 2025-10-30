# ⚡ Quick Start - Deploy in 5 Minutes

## 🎯 Fastest Way: Railway.app

### Step 1: Push to GitHub (2 minutes)

```bash
# Navigate to your project
cd "c:\Users\khoua\OneDrive\Desktop\hyiplab_v5.4.1"

# Initialize git (if not already)
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit - Ready for deployment"

# Create a new repository on GitHub, then:
git remote add origin https://github.com/YOUR_USERNAME/hyiplab.git
git branch -M main
git push -u origin main
```

### Step 2: Deploy on Railway (2 minutes)

1. **Go to**: https://railway.app
2. **Sign up** with your GitHub account
3. Click **"New Project"**
4. Select **"Deploy from GitHub repo"**
5. Choose your `hyiplab` repository
6. Railway will automatically detect and deploy! 🎉

### Step 3: Add Database (1 minute)

1. In your Railway project dashboard
2. Click **"+ New"** → **"Database"** → **"Add MySQL"**
3. Railway automatically connects it to your app

### Step 4: Set Environment Variables (1 minute)

1. Click on your web service
2. Go to **"Variables"** tab
3. Add these essential variables:

```env
APP_KEY=base64:GENERATE_THIS_LOCALLY
APP_ENV=production
APP_DEBUG=false
APP_URL=https://your-app.railway.app
```

**Generate APP_KEY locally:**
```bash
cd core
php artisan key:generate --show
```

Copy the output and paste it as `APP_KEY` in Railway.

### Step 5: Done! ✅

Your app will be live at: `https://your-app-name.railway.app`

---

## 🔑 Important: Add Payment Gateway Credentials

After deployment, add your payment gateway credentials in Railway Variables:

### Stripe
```env
STRIPE_KEY=pk_live_xxxxx
STRIPE_SECRET=sk_live_xxxxx
```

### Mollie
```env
MOLLIE_KEY=live_xxxxx
```

### PayPal
```env
PAYPAL_CLIENT_ID=xxxxx
PAYPAL_SECRET=xxxxx
PAYPAL_MODE=live
```

### Razorpay
```env
RAZORPAY_KEY=rzp_live_xxxxx
RAZORPAY_SECRET=xxxxx
```

---

## 📧 Configure Email (Optional)

Add SMTP settings for email notifications:

```env
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=noreply@yourdomain.com
MAIL_FROM_NAME="${APP_NAME}"
```

---

## 🔄 Auto-Deploy Updates

Every time you push to GitHub, Railway automatically redeploys:

```bash
# Make changes to your code
git add .
git commit -m "Update feature"
git push

# Railway will automatically deploy the changes!
```

---

## 🐛 View Logs

In Railway dashboard:
1. Click on your web service
2. Go to **"Deployments"** tab
3. Click on latest deployment
4. View **"Logs"** to debug issues

---

## 💡 Pro Tips

1. **Custom Domain**: Add your domain in Railway Settings → Domains
2. **Database Backup**: Railway provides automatic backups
3. **Scaling**: Upgrade plan if you need more resources
4. **Monitoring**: Check metrics in Railway dashboard

---

## ⚠️ Before Going Live

- [ ] Test all payment gateways in production
- [ ] Verify email sending works
- [ ] Test user registration and login
- [ ] Check all pages load correctly
- [ ] Enable HTTPS (Railway does this automatically)
- [ ] Set `APP_DEBUG=false`
- [ ] Review security settings

---

## 🆘 Troubleshooting

**"500 Error"**
- Check logs in Railway dashboard
- Verify `APP_KEY` is set
- Ensure database is connected

**"Database Connection Failed"**
- Railway auto-connects MySQL
- Check if MySQL service is running
- Verify `DB_CONNECTION=mysql` in variables

**"Class Not Found"**
- Railway runs `composer install` automatically
- Check build logs for errors

---

## 📞 Need Help?

Check the full `DEPLOYMENT_GUIDE.md` for:
- Alternative hosting options (Render, InfinityFree)
- Detailed troubleshooting
- Advanced configuration

---

**Total Time: ~5 minutes** ⏱️

Your HYIP Lab will be live and accessible worldwide! 🌍
