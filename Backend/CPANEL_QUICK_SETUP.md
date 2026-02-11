# 🚀 Quick Setup Guide for cPanel

## Fill in Your cPanel Node.js Application Form

Based on your screenshots, here's exactly what to enter:

### 📝 Application Settings

| Field | What to Enter |
|-------|---------------|
| **Node.js version** | Select `18.20.8 (recommended)` or latest LTS |
| **Application mode** | Select `Production` |
| **Application root** | Enter the folder path where you uploaded files<br>Example: `api` or `public_html/api` |
| **Application URL** | `hamzabashir.online` (already shown in your screenshot) |
| **Application startup file** | `app.js` |

### 🔧 Environment Variables (Click "+ ADD VARIABLE")

Add these one by one:

| Variable Name | Value | Notes |
|---------------|-------|-------|
| `NODE_ENV` | `production` | Sets production mode |
| `DB_HOST` | `localhost` | Usually localhost on cPanel |
| `DB_USER` | `your_cpanel_db_user` | From MySQL Databases section |
| `DB_PASSWORD` | `your_db_password` | Your database password |
| `DB_NAME` | `your_cpanel_db_name` | Full database name with prefix |
| `JWT_SECRET` | `your_generated_secret` | Generate using crypto |
| `PORT` | `5000` | Default port (cPanel manages this) |

---

## 📋 Before You Click "CREATE"

Make sure you have:

- ✅ Uploaded `app.js` to your application root folder
- ✅ Uploaded `package.json` to your application root folder  
- ✅ Uploaded entire `src/` folder to your application root
- ✅ Uploaded `.htaccess` to your application root
- ✅ Created `.env` file with your credentials (or use environment variables above)
- ✅ Created MySQL database in cPanel
- ✅ Imported database schema (`schema.sql`)
- ✅ Created database user and granted privileges

---

## 🎯 After Clicking "CREATE"

1. **Wait** for cPanel to set up the application (may take 30-60 seconds)

2. **Install Dependencies:**
   - In the Node.js app interface, find the command input box
   - Enter: `npm install --production`
   - Click **Run**
   - Wait for installation to complete

3. **Start Application:**
   - Click the **START** button
   - Wait for status to show "Running" (green)

4. **Test:**
   - Open browser: `https://hamzabashir.online/health`
   - Should see: `{"success": true, "message": "Smart Agriculture API is running"}`

---

## 🔍 Quick Troubleshooting

### Application won't start?
- Check that `app.js` exists in the application root
- Verify Node.js version is 18.x or higher
- Check error logs in the Node.js interface

### Database connection failed?
- Verify database credentials in environment variables
- Check database name includes cPanel username prefix
- Ensure database user has ALL PRIVILEGES

### 404 errors?
- Make sure `.htaccess` file is uploaded
- Check that `PassengerEnabled On` is in `.htaccess`
- Verify application URL matches your domain

---

## 📞 Need Help?

1. **Check Logs:** In Node.js app interface, scroll to "Application Logs"
2. **Restart App:** Click the "RESTART" button
3. **Contact Support:** Your hosting provider can help with cPanel-specific issues

---

## ✅ Success Indicators

You'll know it's working when:
- ✅ Status shows "Running" (green) in cPanel
- ✅ `/health` endpoint returns JSON response
- ✅ No errors in application logs
- ✅ Can register a test user via API

---

**Ready to deploy? Follow the detailed guide in `CPANEL_DEPLOYMENT_GUIDE.md`**
