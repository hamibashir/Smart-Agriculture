# 📋 cPanel Deployment Checklist

Use this checklist to ensure a smooth deployment to cPanel shared hosting.

---

## 🗂️ Phase 1: Pre-Deployment Preparation

### Local Testing
- [ ] Backend runs successfully locally (`npm run dev`)
- [ ] All API endpoints tested and working
- [ ] Database schema is finalized
- [ ] Environment variables documented

### File Preparation
- [ ] `app.js` created (cPanel entry point)
- [ ] `.htaccess` created (Apache configuration)
- [ ] `.env.cpanel` template ready
- [ ] All dependencies in `package.json`
- [ ] No development-only code in production files

---

## 🗄️ Phase 2: cPanel Database Setup

### Create Database
- [ ] Logged into cPanel
- [ ] Created MySQL database (note the full name with prefix)
- [ ] Created MySQL user with strong password
- [ ] Added user to database with ALL PRIVILEGES
- [ ] Noted down all credentials:
  ```
  DB_HOST: _______________
  DB_USER: _______________
  DB_PASSWORD: _______________
  DB_NAME: _______________
  DB_PORT: 3306
  ```

### Import Schema
- [ ] Opened phpMyAdmin
- [ ] Selected the database
- [ ] Imported `Database/schema.sql`
- [ ] Verified tables created successfully
- [ ] (Optional) Imported `Database/sample_data.sql`
- [ ] Tested database connection in phpMyAdmin

---

## 📤 Phase 3: File Upload

### Files to Upload
- [ ] `app.js` (cPanel entry point)
- [ ] `.htaccess` (Apache config)
- [ ] `package.json`
- [ ] `package-lock.json`
- [ ] `src/` folder (complete with all subfolders)
  - [ ] `src/config/`
  - [ ] `src/controllers/`
  - [ ] `src/middleware/`
  - [ ] `src/routes/`

### Files NOT to Upload
- [ ] Verified `node_modules/` is NOT uploaded
- [ ] Verified `.git/` is NOT uploaded
- [ ] Verified local `.env` is NOT uploaded

### Upload Location
- [ ] Decided on directory: `public_html/api` or `public_html/`
- [ ] Uploaded all files to chosen directory
- [ ] Verified file permissions (usually 644 for files, 755 for directories)

---

## ⚙️ Phase 4: Environment Configuration

### Create .env File
- [ ] Created `.env` file in application root
- [ ] Added all required variables:
  - [ ] `PORT=5000`
  - [ ] `NODE_ENV=production`
  - [ ] `DB_HOST=localhost`
  - [ ] `DB_USER=your_cpanel_db_user`
  - [ ] `DB_PASSWORD=your_db_password`
  - [ ] `DB_NAME=your_cpanel_db_name`
  - [ ] `DB_PORT=3306`
  - [ ] `JWT_SECRET=generated_secret_key`
  - [ ] `JWT_EXPIRES_IN=24h`
  - [ ] `CORS_ORIGIN=*`

### Generate JWT Secret
- [ ] Generated strong JWT secret:
  ```bash
  node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
  ```
- [ ] Added to `.env` file
- [ ] Saved and verified `.env` file

---

## 🔧 Phase 5: Node.js Application Setup

### Configure in cPanel
- [ ] Opened cPanel > Setup Node.js App
- [ ] Clicked "CREATE APPLICATION"
- [ ] Filled in application details:
  - [ ] Node.js version: `18.20.8` (or latest LTS)
  - [ ] Application mode: `Production`
  - [ ] Application root: `api` (or your chosen path)
  - [ ] Application URL: `hamzabashir.online`
  - [ ] Application startup file: `app.js`

### Environment Variables (Optional)
- [ ] Added environment variables in cPanel interface (if not using .env)
- [ ] Verified all variables are correct

### Create Application
- [ ] Clicked "CREATE" button
- [ ] Waited for setup to complete
- [ ] Verified application appears in list

---

## 📦 Phase 6: Install Dependencies

### Run npm install
- [ ] In Node.js app interface, found command input box
- [ ] Entered: `npm install --production`
- [ ] Clicked "Run" button
- [ ] Waited for installation to complete (may take 2-5 minutes)
- [ ] Checked for any error messages
- [ ] Verified `node_modules/` folder created

---

## ▶️ Phase 7: Start Application

### Launch App
- [ ] Clicked "START" button in Node.js interface
- [ ] Waited for status to change to "Running"
- [ ] Checked application logs for startup messages
- [ ] Verified no error messages in logs

---

## ✅ Phase 8: Testing & Verification

### Basic Tests
- [ ] Opened browser to: `https://hamzabashir.online/health`
- [ ] Verified health check returns:
  ```json
  {
    "success": true,
    "message": "Smart Agriculture API is running",
    "timestamp": "...",
    "environment": "production"
  }
  ```
- [ ] Tested root endpoint: `https://hamzabashir.online/`
- [ ] Verified API endpoints list is returned

### Database Connection Test
- [ ] Tested user registration:
  ```bash
  curl -X POST https://hamzabashir.online/api/auth/register \
    -H "Content-Type: application/json" \
    -d '{
      "full_name": "Test User",
      "email": "test@example.com",
      "phone": "+92-300-1234567",
      "password": "testpass123",
      "address": "Test",
      "city": "Lahore",
      "province": "Punjab",
      "postal_code": "54000"
    }'
  ```
- [ ] Verified user created successfully
- [ ] Checked database in phpMyAdmin for new user

### Authentication Test
- [ ] Tested login endpoint
- [ ] Received JWT token
- [ ] Tested protected endpoint with token
- [ ] Verified authentication works

### All Endpoints Test
- [ ] `/api/auth/*` - Authentication endpoints
- [ ] `/api/fields/*` - Field management
- [ ] `/api/sensors/*` - Sensor data
- [ ] `/api/irrigation/*` - Irrigation control
- [ ] `/api/alerts/*` - Alert system
- [ ] `/api/recommendations/*` - Recommendations
- [ ] `/api/dashboard/*` - Dashboard stats
- [ ] `/api/admin/*` - Admin functions

---

## 🔐 Phase 9: Security Hardening

### SSL/HTTPS
- [ ] Enabled SSL certificate in cPanel (AutoSSL)
- [ ] Verified HTTPS works: `https://hamzabashir.online`
- [ ] Added HTTPS redirect in `.htaccess` (if needed)

### File Permissions
- [ ] `.env` file is protected (not publicly accessible)
- [ ] Sensitive files have correct permissions
- [ ] Directory browsing is disabled

### Security Headers
- [ ] Verified security headers in `.htaccess`
- [ ] Tested with security header checker tool

---

## 📱 Phase 10: Flutter App Integration

### Update Flutter Configuration
- [ ] Updated `app_config.dart` with production URL:
  ```dart
  static const String apiBaseUrl = 'https://hamzabashir.online/api';
  ```
- [ ] Rebuilt Flutter app
- [ ] Tested app connection to production API
- [ ] Verified all features work with production backend

### End-to-End Testing
- [ ] User registration from app
- [ ] User login from app
- [ ] Field creation and management
- [ ] Sensor data viewing
- [ ] Irrigation control
- [ ] Alerts and notifications
- [ ] Dashboard statistics

---

## 🎯 Phase 11: Monitoring & Maintenance

### Set Up Monitoring
- [ ] Bookmarked Node.js app interface for quick access
- [ ] Checked application logs regularly
- [ ] Set up uptime monitoring (optional)
- [ ] Configured error notifications (optional)

### Backup Strategy
- [ ] Enabled cPanel automatic backups
- [ ] Created manual backup of database
- [ ] Backed up application files
- [ ] Documented backup locations

### Documentation
- [ ] Documented all credentials securely
- [ ] Saved database connection details
- [ ] Noted application directory path
- [ ] Recorded Node.js version used

---

## 🚀 Phase 12: Go Live!

### Final Checks
- [ ] All tests passing
- [ ] No errors in logs
- [ ] Performance is acceptable
- [ ] Security measures in place
- [ ] Backups configured
- [ ] Documentation complete

### Launch
- [ ] Announced to users (if applicable)
- [ ] Monitored for first 24 hours
- [ ] Responded to any issues quickly
- [ ] Collected user feedback

---

## 📊 Post-Deployment Monitoring

### Daily Checks (First Week)
- [ ] Check application status (Running/Stopped)
- [ ] Review error logs
- [ ] Monitor response times
- [ ] Check database size growth

### Weekly Checks
- [ ] Review application logs
- [ ] Check disk space usage
- [ ] Verify backups are working
- [ ] Update dependencies if needed

### Monthly Checks
- [ ] Review security updates
- [ ] Optimize database (if needed)
- [ ] Check for Node.js version updates
- [ ] Review and clean old logs

---

## 🐛 Troubleshooting Reference

### Application Won't Start
- [ ] Check Node.js version compatibility
- [ ] Verify `app.js` exists
- [ ] Review error logs
- [ ] Reinstall dependencies

### Database Connection Issues
- [ ] Verify credentials in `.env`
- [ ] Check database exists
- [ ] Confirm user privileges
- [ ] Test connection in phpMyAdmin

### 404 Errors
- [ ] Verify `.htaccess` uploaded
- [ ] Check Apache mod_rewrite enabled
- [ ] Confirm application URL correct

### Performance Issues
- [ ] Check shared hosting resources
- [ ] Optimize database queries
- [ ] Review connection pool settings
- [ ] Consider upgrading hosting plan

---

## ✅ Deployment Complete!

**Congratulations! Your Smart Agriculture backend is now live on cPanel!**

### Quick Reference
- **API URL:** `https://hamzabashir.online/api`
- **Health Check:** `https://hamzabashir.online/health`
- **cPanel:** Your hosting control panel
- **Support:** Contact your hosting provider for cPanel issues

### Next Steps
1. Monitor application for 24-48 hours
2. Gather user feedback
3. Plan for scaling if needed
4. Keep documentation updated

---

**Deployment Date:** _____________

**Deployed By:** _____________

**Notes:** 
_____________________________________________
_____________________________________________
_____________________________________________

---

**Built with ❤️ for Pakistani Farmers**
