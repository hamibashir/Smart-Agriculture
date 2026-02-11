# 🎯 cPanel Form Fill Guide

## Based on Your Screenshots

This guide shows you EXACTLY what to enter in each field of your cPanel Node.js application setup form.

---

## 📝 Screenshot 1: CREATE APPLICATION Form

### Field-by-Field Instructions

#### 1️⃣ **Node.js version**
```
What you see: Dropdown showing "10.24.1"
What to select: 18.20.8 (recommended)
```
**Why:** Version 18.20.8 is the LTS (Long Term Support) version and is most stable for production.

**How to select:**
- Click the dropdown
- Scroll down to find `18.20.8 (recommended)`
- Click to select it

---

#### 2️⃣ **Application mode**
```
What you see: Dropdown showing "Development"
What to select: Production
```
**Why:** Production mode optimizes performance and disables development features.

**How to select:**
- Click the dropdown
- Select `Production`

---

#### 3️⃣ **Application root**
```
What you see: Empty text field
What to enter: api
```
**Alternative options:**
- If you uploaded to `public_html/api`, enter: `api`
- If you uploaded to `public_html/backend`, enter: `backend`
- If you uploaded directly to `public_html`, leave empty or enter: `public_html`

**Important:** This is the folder path relative to your home directory where you uploaded the backend files.

**How to verify:**
1. Open cPanel File Manager
2. Navigate to where you uploaded `app.js`
3. Note the folder path
4. Enter that path here

---

#### 4️⃣ **Application URL**
```
What you see: "hamzabashir.online" (already filled)
What to do: Leave as is or modify if needed
```
**Options:**
- Main domain: `hamzabashir.online`
- Subdomain: `api.hamzabashir.online` (if you created a subdomain)
- Subfolder: `hamzabashir.online/api` (if using a subfolder)

**Recommended:** Use the main domain or create a subdomain like `api.hamzabashir.online`

---

#### 5️⃣ **Application startup file**
```
What you see: Empty text field
What to enter: app.js
```
**Important:** This MUST be exactly `app.js` (the file we created for cPanel compatibility)

**Do NOT enter:**
- ❌ `src/server.js` (that's for local development)
- ❌ `server.js`
- ❌ `index.js`
- ✅ `app.js` (correct!)

---

## 🔧 Environment Variables Section

### Click "+ ADD VARIABLE" for each of these:

#### Variable 1: NODE_ENV
```
Name: NODE_ENV
Value: production
```

#### Variable 2: DB_HOST
```
Name: DB_HOST
Value: localhost
```
**Note:** Usually `localhost` on cPanel, but check with your hosting provider.

#### Variable 3: DB_USER
```
Name: DB_USER
Value: [your_cpanel_username]_smart_agri_user
```
**Example:** If your cPanel username is `hamzabas`, enter: `hamzabas_smart_agri_user`

**How to find:**
1. Go to cPanel > MySQL® Databases
2. Look under "Current Users"
3. Copy the full username (includes prefix)

#### Variable 4: DB_PASSWORD
```
Name: DB_PASSWORD
Value: [your database password]
```
**Important:** This is the password you set when creating the database user.

#### Variable 5: DB_NAME
```
Name: DB_NAME
Value: [your_cpanel_username]_smart_agriculture
```
**Example:** If your cPanel username is `hamzabas`, enter: `hamzabas_smart_agriculture`

**How to find:**
1. Go to cPanel > MySQL® Databases
2. Look under "Current Databases"
3. Copy the full database name (includes prefix)

#### Variable 6: JWT_SECRET
```
Name: JWT_SECRET
Value: [generate a random secret]
```

**How to generate:**
Option 1 - Using Node.js locally:
```bash
node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
```

Option 2 - Use online generator:
- Visit: https://www.grc.com/passwords.htm
- Copy the 63 random printable ASCII characters

**Example result:**
```
a7f3d8e9c2b1a4f6e8d9c3b2a5f7e9d1c4b3a6f8e0d2c5b4a7f9e1d3c6b5a8f0e2d4c7b6a9
```

#### Variable 7: PORT (Optional)
```
Name: PORT
Value: 5000
```
**Note:** cPanel usually manages ports automatically, but it's good to set this.

---

## 🎬 Complete Form Example

Here's what your filled form should look like:

```
┌─────────────────────────────────────────────────────┐
│ CREATE APPLICATION                                   │
├─────────────────────────────────────────────────────┤
│                                                      │
│ Node.js version:        [18.20.8 ▼]                │
│                                                      │
│ Application mode:       [Production ▼]              │
│                         Adds value for NODE_ENV     │
│                                                      │
│ Application root:       [api                    ]   │
│                         Physical address to app     │
│                                                      │
│ Application URL:        [hamzabashir.online ▼]     │
│                         HTTP/HTTPS link to app      │
│                                                      │
│ Application startup:    [app.js                 ]   │
│                                                      │
├─────────────────────────────────────────────────────┤
│ Environment variables                    [+ ADD]     │
├─────────────────────────────────────────────────────┤
│ NODE_ENV          = production                       │
│ DB_HOST           = localhost                        │
│ DB_USER           = hamzabas_smart_agri_user        │
│ DB_PASSWORD       = ••••••••••••••••                │
│ DB_NAME           = hamzabas_smart_agriculture      │
│ JWT_SECRET        = a7f3d8e9c2b1a4f6e8d9c3b2...    │
│ PORT              = 5000                             │
└─────────────────────────────────────────────────────┘

            [CANCEL]  [CREATE]
```

---

## ✅ Before Clicking CREATE

### Pre-flight Checklist:
- [ ] Node.js version is 18.20.8 or higher
- [ ] Application mode is "Production"
- [ ] Application root matches where you uploaded files
- [ ] Application startup file is exactly "app.js"
- [ ] All environment variables are added
- [ ] Database credentials are correct (verify in MySQL Databases)
- [ ] JWT_SECRET is generated and added

---

## 🚀 After Clicking CREATE

### What Happens Next:

1. **cPanel processes your request** (30-60 seconds)
   - Creates Node.js environment
   - Sets up Passenger configuration
   - Configures Apache

2. **Application appears in list**
   - Status: "Stopped" (red) initially
   - You'll see your application details

3. **Next steps:**
   - Install dependencies (see below)
   - Start the application
   - Test the endpoints

---

## 📦 Installing Dependencies

### After application is created:

1. **Find the command input box** in the Node.js interface
   - It's usually below the application details
   - Labeled "Run command" or similar

2. **Enter this command:**
   ```
   npm install --production
   ```

3. **Click "Run"**
   - Wait for installation (2-5 minutes)
   - Watch for "Installation complete" message

4. **Check for errors**
   - If errors appear, check your `package.json` is uploaded
   - Verify you're in the correct directory

---

## ▶️ Starting the Application

### Once dependencies are installed:

1. **Click the "START" button**
   - Usually a green play button
   - Or a button labeled "START APP"

2. **Wait for status change**
   - Status should change from red (Stopped) to green (Running)
   - May take 10-30 seconds

3. **Check logs**
   - Scroll down to "Application Logs"
   - Look for: "✅ Database connected successfully"
   - Look for: "🚀 Server running on port 5000"

---

## 🧪 Testing Your Deployment

### Test 1: Health Check
Open browser and visit:
```
https://hamzabashir.online/health
```

**Expected response:**
```json
{
  "success": true,
  "message": "Smart Agriculture API is running",
  "timestamp": "2026-02-11T08:25:58.000Z",
  "environment": "production"
}
```

### Test 2: API Root
Visit:
```
https://hamzabashir.online/
```

**Expected response:**
```json
{
  "success": true,
  "message": "Smart Agriculture API",
  "version": "1.0.0",
  "endpoints": { ... }
}
```

### Test 3: Register User
Use curl or Postman:
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

**Expected response:**
```json
{
  "success": true,
  "message": "User registered successfully",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": { ... }
  }
}
```

---

## 🐛 Common Issues

### ❌ "Application failed to start"
**Check:**
- Is `app.js` in the application root?
- Is Node.js version 18.x or higher?
- Are dependencies installed?

**Fix:**
- Verify file locations in File Manager
- Reinstall dependencies: `npm install --production`
- Check error logs

### ❌ "Cannot find module"
**Check:**
- Did you run `npm install --production`?
- Is `package.json` uploaded?

**Fix:**
- Run: `npm install --production`
- Wait for completion
- Restart application

### ❌ "Database connection failed"
**Check:**
- Are database credentials correct?
- Does database exist?
- Does user have privileges?

**Fix:**
- Verify credentials in MySQL Databases
- Check database name includes prefix
- Grant ALL PRIVILEGES to user

---

## 🎉 Success!

If all tests pass, your backend is successfully deployed!

### Next Steps:
1. ✅ Update Flutter app with production URL
2. ✅ Test all features from mobile app
3. ✅ Monitor logs for any issues
4. ✅ Set up regular backups

---

**Need more help? Check:**
- `CPANEL_DEPLOYMENT_GUIDE.md` - Detailed step-by-step guide
- `DEPLOYMENT_CHECKLIST.md` - Complete deployment checklist
- Your hosting provider's support - For cPanel-specific issues

---

**Built with ❤️ for Pakistani Farmers**
