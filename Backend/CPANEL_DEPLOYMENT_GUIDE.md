# 🚀 cPanel Deployment Guide - Smart Agriculture Backend

This guide will help you deploy your Smart Agriculture Node.js backend to cPanel shared hosting.

## 📋 Prerequisites

Before you begin, ensure you have:
- ✅ cPanel account with Node.js support
- ✅ MySQL database access in cPanel
- ✅ SSH access (optional but recommended)
- ✅ Your domain configured (e.g., `hamzabashir.online`)

---

## 🗂️ Step 1: Prepare Your cPanel Database

### 1.1 Create MySQL Database

1. Log into cPanel
2. Go to **MySQL® Databases**
3. Create a new database:
   - Database Name: `smart_agriculture` (or similar)
   - Click **Create Database**

### 1.2 Create Database User

1. Scroll to **MySQL Users**
2. Create a new user:
   - Username: `smart_agri_user` (or similar)
   - Password: Generate a strong password
   - Click **Create User**

### 1.3 Add User to Database

1. Scroll to **Add User To Database**
2. Select your user and database
3. Grant **ALL PRIVILEGES**
4. Click **Make Changes**

### 1.4 Import Database Schema

1. Go to **phpMyAdmin** in cPanel
2. Select your database
3. Click **Import** tab
4. Upload `Database/schema.sql` from your project
5. Click **Go**
6. (Optional) Import `Database/sample_data.sql` for test data

### 1.5 Note Your Database Credentials

Write down:
- Database Host: Usually `localhost` (check in cPanel)
- Database Name: `your_cpanel_username_smart_agriculture`
- Database User: `your_cpanel_username_smart_agri_user`
- Database Password: Your created password
- Database Port: `3306` (default)

---

## 📦 Step 2: Upload Backend Files

### Option A: Using File Manager (Easier)

1. In cPanel, go to **File Manager**
2. Navigate to `public_html` or create a subdirectory like `public_html/api`
3. Click **Upload**
4. Upload these files from your `Backend` folder:
   ```
   ✅ app.js (cPanel entry point)
   ✅ .htaccess
   ✅ package.json
   ✅ package-lock.json
   ✅ src/ (entire folder with all subfolders)
   ```
5. **DO NOT upload:**
   - ❌ node_modules/
   - ❌ .env (you'll create this on server)
   - ❌ .git/

### Option B: Using SSH/FTP (Advanced)

**Via SSH:**
```bash
# Connect to your server
ssh your_username@hamzabashir.online

# Navigate to your directory
cd public_html/api

# Upload files using SCP or Git
git clone your-repository-url .
# OR use SCP from your local machine
```

**Via FTP:**
- Use FileZilla or similar FTP client
- Connect using cPanel FTP credentials
- Upload files to `public_html/api`

---

## ⚙️ Step 3: Configure Environment Variables

### 3.1 Create .env File

1. In cPanel File Manager, navigate to your backend directory
2. Click **+ File** and create `.env`
3. Edit the file and add:

```env
# Server Configuration
PORT=5000
NODE_ENV=production

# Database Configuration (USE YOUR CPANEL CREDENTIALS)
DB_HOST=localhost
DB_USER=your_cpanel_username_smart_agri_user
DB_PASSWORD=your_database_password
DB_NAME=your_cpanel_username_smart_agriculture
DB_PORT=3306

# JWT Configuration
# Generate using: node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
JWT_SECRET=YOUR_GENERATED_SECRET_KEY_HERE
JWT_EXPIRES_IN=24h

# CORS Configuration
CORS_ORIGIN=*

# Application URL
APP_URL=https://hamzabashir.online
```

### 3.2 Generate JWT Secret

**Option 1: Using Node.js locally**
```bash
node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
```

**Option 2: Using online generator**
- Visit: https://www.grc.com/passwords.htm
- Copy the 63 random printable ASCII characters
- Paste into `JWT_SECRET`

---

## 🔧 Step 4: Set Up Node.js Application in cPanel

### 4.1 Access Node.js Setup

1. In cPanel, search for **Setup Node.js App**
2. Click on it to open the Node.js application manager

### 4.2 Create Application

Click **CREATE APPLICATION** and fill in:

| Field | Value | Example |
|-------|-------|---------|
| **Node.js version** | 18.20.8 (recommended) or latest LTS | `18.20.8` |
| **Application mode** | Production | `Production` |
| **Application root** | Path to your backend folder | `api` or `public_html/api` |
| **Application URL** | Your domain or subdomain | `hamzabashir.online` or `api.hamzabashir.online` |
| **Application startup file** | Entry point file | `app.js` |

### 4.3 Add Environment Variables (Optional)

If you prefer, you can add environment variables here instead of using `.env`:

Click **+ ADD VARIABLE** for each:
- `NODE_ENV` = `production`
- `DB_HOST` = `localhost`
- `DB_USER` = `your_db_user`
- `DB_PASSWORD` = `your_db_password`
- `DB_NAME` = `your_db_name`
- `JWT_SECRET` = `your_secret_key`

### 4.4 Click CREATE

cPanel will:
- Set up the Node.js environment
- Create necessary configuration
- Prepare the application

---

## 📥 Step 5: Install Dependencies

### 5.1 Using cPanel Terminal (Recommended)

1. In cPanel, go to **Terminal** (if available)
2. Navigate to your application directory:
   ```bash
   cd public_html/api
   ```
3. Install dependencies:
   ```bash
   npm install --production
   ```

### 5.2 Using SSH

```bash
ssh your_username@hamzabashir.online
cd public_html/api
npm install --production
```

### 5.3 Using cPanel Node.js Interface

1. Go back to **Setup Node.js App**
2. Click on your application
3. In the command input box, enter:
   ```
   npm install --production
   ```
4. Click **Run**

---

## ▶️ Step 6: Start the Application

### 6.1 Start via cPanel Interface

1. Go to **Setup Node.js App**
2. Find your application in the list
3. Click the **START** button (or restart if already running)
4. Wait for status to show **Running**

### 6.2 Verify Application is Running

1. Check the **Status** column shows green/running
2. Note the **Actions** column for restart/stop options

---

## ✅ Step 7: Test Your Deployment

### 7.1 Test Health Endpoint

Open your browser and visit:
```
https://hamzabashir.online/health
```

You should see:
```json
{
  "success": true,
  "message": "Smart Agriculture API is running",
  "timestamp": "2026-02-11T08:25:58.000Z",
  "environment": "production"
}
```

### 7.2 Test API Root

Visit:
```
https://hamzabashir.online/
```

Should return API information with all endpoints listed.

### 7.3 Test Database Connection

Try registering a user:
```bash
curl -X POST https://hamzabashir.online/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "full_name": "Test User",
    "email": "test@example.com",
    "phone": "+92-300-1234567",
    "password": "testpassword123",
    "address": "Test Address",
    "city": "Lahore",
    "province": "Punjab",
    "postal_code": "54000"
  }'
```

---

## 🔧 Step 8: Configure Your Flutter App

Update your Flutter app's API configuration:

**File: `FlutterApp/lib/config/app_config.dart`**

```dart
class AppConfig {
  // Change from localhost to your cPanel domain
  static const String apiBaseUrl = 'https://hamzabashir.online/api';
  
  // Other settings...
}
```

Rebuild your Flutter app and test!

---

## 🐛 Troubleshooting

### ❌ Application Won't Start

**Check:**
1. Node.js version compatibility (use 18.20.8 LTS)
2. `app.js` file exists in application root
3. All dependencies installed (`npm install`)
4. Check error logs in cPanel Node.js interface

**Solution:**
```bash
# Reinstall dependencies
cd public_html/api
rm -rf node_modules
npm install --production
```

### ❌ Database Connection Failed

**Check:**
1. Database credentials in `.env` are correct
2. Database user has ALL PRIVILEGES
3. Database host is correct (usually `localhost`)
4. Database exists and schema is imported

**Solution:**
- Verify credentials in cPanel > MySQL Databases
- Test connection using phpMyAdmin
- Check database name includes cPanel username prefix

### ❌ 404 Errors on API Routes

**Check:**
1. `.htaccess` file exists in application root
2. Apache mod_rewrite is enabled (usually enabled on cPanel)
3. Application URL is correctly configured

**Solution:**
- Re-upload `.htaccess` file
- Ensure PassengerEnabled is On
- Contact hosting support to enable mod_rewrite

### ❌ CORS Errors from Flutter App

**Check:**
1. `CORS_ORIGIN` in `.env` is set to `*` or your domain
2. CORS middleware is properly configured in `app.js`

**Solution:**
Update `.env`:
```env
CORS_ORIGIN=*
```

### ❌ Application Crashes/Restarts

**Check:**
1. Memory limits (shared hosting has limits)
2. Error logs in cPanel
3. Database connection pool size

**Solution:**
- Reduce database pool size in `src/config/database.cjs`
- Contact hosting support for memory limit increase
- Check error logs: cPanel > Setup Node.js App > View Logs

### ❌ Slow Performance

**Optimize:**
1. Enable compression in `.htaccess` (already included)
2. Reduce database queries
3. Use caching where possible
4. Consider upgrading to VPS if needed

---

## 📊 Monitoring & Maintenance

### View Application Logs

1. Go to **Setup Node.js App** in cPanel
2. Click on your application
3. Scroll down to **Application Logs**
4. View recent logs for errors or issues

### Restart Application

1. Go to **Setup Node.js App**
2. Click **RESTART** button for your app
3. Wait for status to return to Running

### Update Application

1. Upload new files via File Manager or SSH
2. If `package.json` changed, run `npm install`
3. Restart the application
4. Test endpoints

---

## 🔐 Security Best Practices

### 1. Secure Your .env File

Add to `.htaccess`:
```apache
<Files .env>
  Order allow,deny
  Deny from all
</Files>
```

### 2. Use Strong JWT Secret

Generate a new secret for production:
```bash
node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
```

### 3. Enable HTTPS

1. In cPanel, go to **SSL/TLS Status**
2. Enable AutoSSL for your domain
3. Force HTTPS in `.htaccess`:

```apache
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
```

### 4. Limit Database Access

- Use a dedicated database user (not root)
- Grant only necessary privileges
- Use strong passwords

### 5. Regular Backups

- Use cPanel backup feature
- Backup database regularly
- Keep local copies of important data

---

## 📞 Support

### cPanel Issues
- Contact your hosting provider's support
- Check cPanel documentation
- Community forums

### Application Issues
- Check application logs
- Review error messages
- Test locally first

### Database Issues
- Use phpMyAdmin to verify data
- Check connection credentials
- Review MySQL error logs

---

## ✨ Success Checklist

Before going live, ensure:

- [ ] Database created and schema imported
- [ ] `.env` file configured with correct credentials
- [ ] Dependencies installed (`npm install`)
- [ ] Application running in cPanel (green status)
- [ ] Health endpoint returns success
- [ ] Can register/login users
- [ ] Flutter app connects successfully
- [ ] HTTPS enabled (SSL certificate)
- [ ] Error logs are clean
- [ ] Backup strategy in place

---

## 🎉 You're Live!

Your Smart Agriculture backend is now running on cPanel shared hosting!

**API Base URL:** `https://hamzabashir.online/api`

**Next Steps:**
1. Update Flutter app with production API URL
2. Test all features thoroughly
3. Monitor logs for any issues
4. Set up regular backups
5. Consider CDN for static assets

---

**Built with ❤️ for Pakistani Farmers**

*For issues or questions, check the troubleshooting section or contact support.*
