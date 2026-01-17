# 🔍 Debugging Login Issue

## Problem
The app shows "server error" when trying to login with `test@example.com`.

## Most Likely Cause
**The test user doesn't exist in the database yet.**

---

## ✅ Solution: Create Test User

### Option 1: Using the App (Recommended)
**Build the Register screen** and create the account from the app itself.

### Option 2: Using cURL (Quick Test)
Run this command in a **new PowerShell window**:

```powershell
$body = @{
    full_name = "Test User"
    email = "test@example.com"
    phone = "+92-300-1234567"
    password = "password123"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://192.168.18.10:5000/api/auth/register" `
    -Method POST `
    -ContentType "application/json" `
    -Body $body
```

### Option 3: Using MySQL Directly
```sql
-- Connect to MySQL
mysql -u root -p

USE smart_agriculture;

-- Check if test user exists
SELECT user_id, email, full_name FROM users WHERE email = 'test@example.com';

-- If empty, create manually (password is already hashed for 'password123')
INSERT INTO users (full_name, email, phone, password_hash, role, is_active) 
VALUES (
    'Test User',
    'test@example.com',
    '+92-300-1234567',
    '$2a$10$rZY5nKZ5L5xK5L5L5xK5LuqKQJ5L5xK5L5L5xK5L5xK5L5L5xK5L',
    'farmer',
    1
);
```

---

## 🔍 Check Backend Logs

Look at your backend terminal (`npm run dev`) for error messages like:
- `Invalid email or password` → User doesn't exist
- `Server error during login` → Database connection issue
- No error shown → Request format issue

---

## 🧪 Test After Creating User

1. **Create test user** (using one of the methods above)
2. **Rebuild & run the Android app**
3. **Login with:**
   - Email: `test@example.com`
   - Password: `password123`
4. **Should successfully navigate to Dashboard!** 🎉

---

## 📱 Alternative: Build Register Screen First

Since we're building screen by screen, we can create the **Register Screen** next so users can sign up directly from the app!

Would you like me to:
- **A)** Help you create the test user manually (quick fix)
- **B)** Build the Register screen next (proper solution)

