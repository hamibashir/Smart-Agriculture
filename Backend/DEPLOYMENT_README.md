# 📚 cPanel Deployment Documentation

## Quick Navigation

This folder contains everything you need to deploy your Smart Agriculture backend to cPanel shared hosting.

---

## 📖 Documentation Files

### 🚀 [CPANEL_QUICK_SETUP.md](CPANEL_QUICK_SETUP.md)
**Start here!** Quick reference for filling out the cPanel Node.js application form.
- ⏱️ **Read time:** 5 minutes
- 🎯 **Use when:** You're ready to create the app in cPanel
- ✨ **Contains:** Exact values to enter in each field

### 📝 [CPANEL_FORM_GUIDE.md](CPANEL_FORM_GUIDE.md)
**Visual guide** showing exactly what to enter in your cPanel form based on your screenshots.
- ⏱️ **Read time:** 10 minutes
- 🎯 **Use when:** You need detailed field-by-field instructions
- ✨ **Contains:** Screenshots reference, examples, troubleshooting

### 📋 [DEPLOYMENT_CHECKLIST.md](DEPLOYMENT_CHECKLIST.md)
**Complete checklist** covering all phases from preparation to post-deployment.
- ⏱️ **Read time:** 15 minutes
- 🎯 **Use when:** You want to ensure nothing is missed
- ✨ **Contains:** 12 phases with checkboxes, monitoring guide

### 📘 [CPANEL_DEPLOYMENT_GUIDE.md](CPANEL_DEPLOYMENT_GUIDE.md)
**Comprehensive guide** with step-by-step instructions for the entire deployment process.
- ⏱️ **Read time:** 30 minutes
- 🎯 **Use when:** First-time deployment or troubleshooting
- ✨ **Contains:** Database setup, file upload, testing, troubleshooting

---

## 🗂️ Deployment Files

### 📄 `app.js`
**cPanel entry point** - CommonJS version of server for shared hosting compatibility.
- ✅ Uses `require()` instead of `import`
- ✅ Compatible with older Node.js versions
- ✅ Optimized for Passenger (cPanel's Node.js handler)

### ⚙️ `.htaccess`
**Apache configuration** - Routes all requests to your Node.js app.
- ✅ Enables Passenger for Node.js
- ✅ Sets up URL rewriting
- ✅ Adds security headers and compression

### 🔐 `.env.cpanel`
**Environment template** - Copy this to `.env` on your server.
- ✅ Database configuration
- ✅ JWT secret placeholder
- ✅ Production settings

### 🗄️ `src/config/database.cjs`
**CommonJS database config** - For cPanel compatibility.
- ✅ MySQL connection pool
- ✅ Works with `require()` syntax
- ✅ Same functionality as ES6 version

---

## 🚀 Quick Start (3 Steps)

### Step 1: Prepare Database
1. Create MySQL database in cPanel
2. Import `Database/schema.sql`
3. Note your credentials

### Step 2: Upload Files
1. Upload `app.js`, `.htaccess`, `package.json`, and `src/` folder
2. Create `.env` file with your credentials
3. Set file permissions

### Step 3: Configure & Start
1. Open cPanel > Setup Node.js App
2. Fill in the form (see [CPANEL_QUICK_SETUP.md](CPANEL_QUICK_SETUP.md))
3. Run `npm install --production`
4. Click START

**Test:** Visit `https://hamzabashir.online/health`

---

## 📊 Deployment Flow

```
┌─────────────────────────────────────────────────────────┐
│                  DEPLOYMENT PROCESS                      │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│ 1. PREPARE DATABASE                                      │
│    • Create MySQL database                               │
│    • Import schema.sql                                   │
│    • Create user & grant privileges                      │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│ 2. UPLOAD FILES                                          │
│    • app.js (cPanel entry point)                        │
│    • .htaccess (Apache config)                          │
│    • package.json                                        │
│    • src/ folder (all backend code)                     │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│ 3. CONFIGURE ENVIRONMENT                                 │
│    • Create .env file                                    │
│    • Add database credentials                            │
│    • Generate JWT secret                                 │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│ 4. SETUP NODE.JS APP                                     │
│    • Open cPanel > Setup Node.js App                    │
│    • Fill in application details                         │
│    • Add environment variables                           │
│    • Click CREATE                                        │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│ 5. INSTALL DEPENDENCIES                                  │
│    • Run: npm install --production                       │
│    • Wait for completion                                 │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│ 6. START APPLICATION                                     │
│    • Click START button                                  │
│    • Wait for status: Running                            │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│ 7. TEST & VERIFY                                         │
│    • Test /health endpoint                               │
│    • Test user registration                              │
│    • Verify all API endpoints                            │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────┐
│ 8. UPDATE FLUTTER APP                                    │
│    • Change API URL to production                        │
│    • Rebuild and test                                    │
└─────────────────────────────────────────────────────────┘
                           │
                           ▼
                    ✅ DEPLOYED!
```

---

## 🎯 Recommended Reading Order

### For First-Time Deployment:
1. **CPANEL_QUICK_SETUP.md** - Get overview
2. **CPANEL_DEPLOYMENT_GUIDE.md** - Follow detailed steps
3. **DEPLOYMENT_CHECKLIST.md** - Check off each step
4. **CPANEL_FORM_GUIDE.md** - Reference when filling form

### For Quick Reference:
1. **CPANEL_QUICK_SETUP.md** - Fast lookup
2. **CPANEL_FORM_GUIDE.md** - Field values

### For Troubleshooting:
1. **CPANEL_DEPLOYMENT_GUIDE.md** - Troubleshooting section
2. **DEPLOYMENT_CHECKLIST.md** - Verify all steps completed

---

## 🔧 Key Differences: Development vs Production

### Development (Local)
```javascript
// Uses ES6 modules
import express from 'express';
export default app;

// Entry point
src/server.js

// Run with
npm run dev
```

### Production (cPanel)
```javascript
// Uses CommonJS
const express = require('express');
module.exports = app;

// Entry point
app.js

// Run with
npm start:cpanel
```

---

## 📦 Files Checklist

### ✅ Files to Upload to cPanel:
- `app.js` - cPanel entry point
- `.htaccess` - Apache configuration
- `package.json` - Dependencies list
- `package-lock.json` - Dependency versions
- `src/` - All source code
  - `src/config/`
  - `src/controllers/`
  - `src/middleware/`
  - `src/routes/`

### ❌ Files NOT to Upload:
- `node_modules/` - Will be installed on server
- `.git/` - Version control (not needed)
- `.env` - Create fresh on server
- `src/server.js` - Development entry point
- `README.md` - Documentation (optional)

### 📝 Files to Create on Server:
- `.env` - Environment variables (use `.env.cpanel` as template)

---

## 🌐 Your Production URLs

After deployment, your API will be available at:

### Main Endpoints:
- **Health Check:** `https://hamzabashir.online/health`
- **API Root:** `https://hamzabashir.online/`
- **API Base:** `https://hamzabashir.online/api`

### API Routes:
- **Auth:** `https://hamzabashir.online/api/auth/*`
- **Fields:** `https://hamzabashir.online/api/fields/*`
- **Sensors:** `https://hamzabashir.online/api/sensors/*`
- **Irrigation:** `https://hamzabashir.online/api/irrigation/*`
- **Alerts:** `https://hamzabashir.online/api/alerts/*`
- **Recommendations:** `https://hamzabashir.online/api/recommendations/*`
- **Dashboard:** `https://hamzabashir.online/api/dashboard/*`
- **Admin:** `https://hamzabashir.online/api/admin/*`

---

## 🆘 Getting Help

### Documentation Issues?
- Check the specific guide for your task
- Use the deployment checklist to verify steps
- Review troubleshooting sections

### cPanel Issues?
- Contact your hosting provider's support
- Check cPanel documentation
- Review error logs in Node.js interface

### Application Issues?
- Check application logs in cPanel
- Verify database connection
- Test endpoints with curl/Postman
- Review error messages

### Still Stuck?
1. Check all documentation files
2. Verify deployment checklist is complete
3. Review error logs
4. Contact hosting support
5. Check Node.js version compatibility

---

## 📊 System Requirements

### cPanel Requirements:
- ✅ Node.js support (version 18.x or higher)
- ✅ MySQL database access
- ✅ Apache with Passenger or similar
- ✅ File Manager or SSH access
- ✅ Sufficient disk space (500MB+)
- ✅ SSL certificate (for HTTPS)

### Recommended Hosting Specs:
- **Node.js Version:** 18.20.8 LTS or higher
- **Memory:** 512MB+ RAM
- **Storage:** 1GB+ available
- **Bandwidth:** Unlimited or 10GB+
- **MySQL:** Version 5.7+ or 8.0+

---

## 🔐 Security Checklist

Before going live:
- [ ] Generated strong JWT secret
- [ ] Database user has minimal required privileges
- [ ] `.env` file is protected (not publicly accessible)
- [ ] HTTPS/SSL is enabled
- [ ] Security headers are configured in `.htaccess`
- [ ] Directory browsing is disabled
- [ ] Strong database password is used
- [ ] Regular backups are configured

---

## 📈 Performance Tips

### Optimize for Shared Hosting:
1. **Database Connection Pool:** Already optimized (max 10 connections)
2. **Compression:** Enabled in `.htaccess`
3. **Caching:** Consider adding Redis if available
4. **Monitoring:** Check logs regularly for slow queries
5. **Upgrades:** Consider VPS if traffic grows

---

## 🎉 Success Indicators

You'll know deployment is successful when:
- ✅ Application status shows "Running" in cPanel
- ✅ `/health` endpoint returns success JSON
- ✅ Can register and login users
- ✅ Database queries work correctly
- ✅ Flutter app connects successfully
- ✅ No errors in application logs
- ✅ All API endpoints respond correctly

---

## 📞 Support Resources

### Documentation:
- **Quick Setup:** [CPANEL_QUICK_SETUP.md](CPANEL_QUICK_SETUP.md)
- **Form Guide:** [CPANEL_FORM_GUIDE.md](CPANEL_FORM_GUIDE.md)
- **Full Guide:** [CPANEL_DEPLOYMENT_GUIDE.md](CPANEL_DEPLOYMENT_GUIDE.md)
- **Checklist:** [DEPLOYMENT_CHECKLIST.md](DEPLOYMENT_CHECKLIST.md)

### External Resources:
- **cPanel Docs:** https://docs.cpanel.net/
- **Node.js Docs:** https://nodejs.org/docs/
- **Express Docs:** https://expressjs.com/
- **MySQL Docs:** https://dev.mysql.com/doc/

---

## 🚀 Ready to Deploy?

1. **Read:** [CPANEL_QUICK_SETUP.md](CPANEL_QUICK_SETUP.md)
2. **Follow:** [CPANEL_DEPLOYMENT_GUIDE.md](CPANEL_DEPLOYMENT_GUIDE.md)
3. **Check:** [DEPLOYMENT_CHECKLIST.md](DEPLOYMENT_CHECKLIST.md)
4. **Reference:** [CPANEL_FORM_GUIDE.md](CPANEL_FORM_GUIDE.md)

---

**Good luck with your deployment! 🌾**

**Built with ❤️ for Pakistani Farmers**
