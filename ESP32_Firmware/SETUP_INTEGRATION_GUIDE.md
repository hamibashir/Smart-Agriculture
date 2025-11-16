# 🔌 ESP32 Backend Integration Setup Guide

This guide will help you connect your ESP32 hardware to the Smart Agriculture backend and database.

## 📋 Prerequisites

1. **Backend Server Running**
   - Backend server must be running on `http://192.168.27.50:5000` (or your server IP)
   - Database must be set up and accessible
   - Check backend is running: `http://192.168.27.50:5000/health`

2. **Arduino IDE Setup**
   - Install Arduino IDE (1.8.x or 2.x)
   - Install ESP32 Board Support:
     - File → Preferences → Additional Board Manager URLs
     - Add: `https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json`
     - Tools → Board → Boards Manager → Search "ESP32" → Install

3. **Required Libraries**
   Install these libraries via Arduino IDE Library Manager (Sketch → Include Library → Manage Libraries):
   - **WiFi** (ESP32 built-in - no installation needed)
   - **HTTPClient** (ESP32 built-in - no installation needed)
   - **ArduinoJson** by Benoit Blanchon (version 6.x recommended)
   - **DHT sensor library** by Adafruit

## 🔧 Configuration Steps

### Step 1: Configure WiFi Credentials

Open `sketchworkingcode_nov15a.ino` and update these lines (around line 9-10):

```cpp
const char* ssid = "YOUR_WIFI_SSID";           // Your WiFi network name
const char* password = "YOUR_WIFI_PASSWORD";    // Your WiFi password
```

**Example:**
```cpp
const char* ssid = "MyFarmWiFi";
const char* password = "MySecurePassword123";
```

### Step 2: Configure Backend Server URL

Update the server URL to match your backend IP (around line 15):

```cpp
const char* serverURL = "http://192.168.27.50:5000";  // Your backend server IP
```

**Important:**
- Use your computer's local IP address where the backend is running
- Find your IP:
  - **Windows**: Open CMD, type `ipconfig`, look for "IPv4 Address"
  - **Mac/Linux**: Open Terminal, type `ifconfig`, look for "inet"
- Make sure ESP32 and backend server are on the **same WiFi network**

### Step 3: Configure Device ID

Set a unique device ID (around line 21):

```cpp
const char* deviceId = "ESP32_001";  // Unique device ID
```

**Important:**
- This `device_id` must match the `device_id` in your database `sensors` table
- Each ESP32 device should have a unique ID (e.g., "ESP32_001", "ESP32_002", etc.)

## 🗄️ Database Setup

### Step 4: Register Sensor in Database

Before the ESP32 can send data, you must register the sensor in the database:

1. **Create a Field** (if you haven't already):
   - Use the Flutter app or directly in database
   - Note the `field_id`

2. **Register the Sensor**:
   - Use the Flutter app's sensor registration feature, OR
   - Insert directly into database:

**Option 1: Using phpMyAdmin (Recommended for XAMPP users)**
1. Open phpMyAdmin: `http://localhost/phpmyadmin`
2. Select database: `smart_agriculture`
3. Click on `sensors` table → Insert tab
4. Fill in the form:
   - `field_id`: Select your field ID (check existing fields first)
   - `sensor_type`: Select `combined` (or appropriate type)
   - `device_id`: Enter `ESP32_001` (must match ESP32 code exactly)
   - `sensor_model`: Enter `ESP32 + DHT11 + YL-69`
   - `installation_date`: Select today's date
   - `location_description`: Enter location details
   - `is_active`: Check (1)
   - Leave other fields as default

**Option 2: Using SQL Command**
```sql
-- First, check available fields for your user
SELECT field_id, field_name, user_id FROM fields WHERE user_id = 5;

-- Then insert sensor (replace field_id with your actual field_id)
INSERT INTO sensors (
    field_id, 
    sensor_type, 
    device_id, 
    sensor_model, 
    installation_date, 
    location_description,
    is_active
) VALUES (
    6,                          -- Replace with your field_id (check fields table first!)
    'combined',                 -- Sensor type options: 'soil_moisture','temperature','humidity','light','rain','water_flow','combined'
    'ESP32_001',                -- Must match deviceId in ESP32 code EXACTLY! (case-sensitive)
    'ESP32 + DHT11 + YL-69',    -- Sensor model description
    CURDATE(),                  -- Installation date
    'Field center, near main gate',  -- Location description
    1                           -- is_active (1 = active, 0 = inactive)
);
```

**Important Notes:**
- The `device_id` in the database **must exactly match** the `deviceId` in your ESP32 code (case-sensitive!)
- Available sensor types: `'soil_moisture'`, `'temperature'`, `'humidity'`, `'light'`, `'rain'`, `'water_flow'`, `'combined'`
- Use `'combined'` if your ESP32 has multiple sensors (most common)
- Check existing fields: `SELECT * FROM fields;` to see available `field_id` values
- Check existing sensors: `SELECT sensor_id, device_id, field_id FROM sensors;` to verify registration

### Step 5: Set Up Database

**Important:** Your database must already exist with the `smart_agriculture` schema loaded.

1. **Import Database Schema** (if not already done):
   - Open phpMyAdmin or MySQL client
   - Create database `smart_agriculture` (if it doesn't exist)
   - Import the `smart_agriculture.sql` file from the `Database` folder
   - This will create all tables and sample data

2. **Configure Backend Environment Variables**:
   Create a `.env` file in the `Backend` folder:
   ```env
   DB_HOST=localhost
   DB_USER=root
   DB_PASSWORD=your_xampp_mysql_password
   DB_NAME=smart_agriculture
   DB_PORT=3306
   PORT=5000
   JWT_SECRET=your-secret-key-here
   NODE_ENV=development
   ```
   
   **For XAMPP users:**
   - `DB_HOST=localhost` or `127.0.0.1`
   - `DB_USER=root` (default XAMPP user)
   - `DB_PASSWORD=` (usually empty for XAMPP, or your MySQL password)
   - `DB_PORT=3306` (default MySQL port)

3. **Verify Database Connection**:
   - Start backend server: `cd Backend && npm start`
   - Check health endpoint: `http://localhost:5000/health`
   - Look for "✅ Database connected successfully" in console
   - Verify database connection appears in backend logs

## 📤 Upload Code to ESP32

### Step 6: Upload Firmware

1. **Connect ESP32** via USB to your computer
2. **Select Board**: Tools → Board → ESP32 Arduino → **ESP32 Dev Module**
3. **Select Port**: Tools → Port → Select your ESP32 port (COM3, COM4, etc. on Windows)
4. **Verify/Compile**: Click ✓ button to check for errors
5. **Upload**: Click → button to upload to ESP32

### Step 7: Monitor Serial Output

1. Open Serial Monitor: Tools → Serial Monitor
2. Set baud rate to **115200**
3. Watch for:
   - ✅ WiFi connection success
   - ✅ IP address assignment
   - ✅ Data transmission to backend
   - ✅ Response from backend server

## 🔍 Testing & Verification

### Step 8: Test Backend Connection

1. **Check Backend Logs**: Watch your backend server console for incoming requests
2. **Verify Data in Database**:
   
   **Using phpMyAdmin:**
   - Open phpMyAdmin → Select `smart_agriculture` database
   - Click on `sensor_readings` table → Browse tab
   - Sort by `reading_timestamp` descending
   - Verify new readings appear every 30 seconds
   
   **Using SQL:**
   ```sql
   -- View recent sensor readings
   SELECT * FROM sensor_readings 
   ORDER BY reading_timestamp DESC 
   LIMIT 10;
   
   -- View readings for your specific device
   SELECT sr.*, s.device_id, s.sensor_type 
   FROM sensor_readings sr
   JOIN sensors s ON sr.sensor_id = s.sensor_id
   WHERE s.device_id = 'ESP32_001'  -- Replace with your device_id
   ORDER BY sr.reading_timestamp DESC 
   LIMIT 10;
   
   -- Verify sensor is registered correctly
   SELECT sensor_id, device_id, field_id, sensor_type, is_active 
   FROM sensors 
   WHERE device_id = 'ESP32_001';  -- Replace with your device_id
   ```
3. **Check Flutter App**: 
   - Open your Flutter app
   - Navigate to Fields → Select Field → View Sensors
   - You should see real-time sensor readings

### Expected Serial Monitor Output

```
🌾 ========================================
🌾  ESP32 Smart Irrigation System
🌾  Backend Integration Enabled
🌾 ========================================

✓ DHT Sensor initialized
✓ Relay initialized (Pump OFF)
✓ Analog sensors ready

📶 Connecting to WiFi...
🔗 Connecting to WiFi.........
✅ WiFi connected successfully!
📍 IP Address: 192.168.1.105
📶 Signal Strength: -45 dBm
🔑 Device ID: ESP32_001
🌐 Backend URL: http://192.168.27.50:5000

✅ System ready! Starting readings...

┌─────────────────────────────────────┐
│      SENSOR READINGS                │
├─────────────────────────────────────┤
│ Soil Moisture: 2345 (DRY - Need Water)
│ Rain Sensor:   3156 (NO RAIN)
│ Light Level:   2876 (Light/Day)
│ Temperature:   25.3 °F
│ Humidity:      65.2 %
│ Pump Status:   OFF
└─────────────────────────────────────┘

📤 Sending sensor data to backend...
🌐 URL: http://192.168.27.50:5000/api/sensors/reading
📦 Payload: {"device_id":"ESP32_001","soil_moisture":57.3,"temperature":25.3,...}
📥 Response Code: 201
📝 Response: {"success":true,"message":"Sensor reading recorded successfully"}
✅ Data sent to backend successfully!
```

## 🐛 Troubleshooting

### Problem: WiFi Connection Failed

**Symptoms:**
- Serial monitor shows "❌ WiFi connection failed"
- No IP address assigned

**Solutions:**
- ✅ Check WiFi SSID and password are correct (case-sensitive)
- ✅ Ensure WiFi network is 2.4 GHz (ESP32 doesn't support 5 GHz)
- ✅ Move ESP32 closer to WiFi router
- ✅ Check WiFi router settings (MAC filtering, etc.)

### Problem: HTTP Error -1

**Symptoms:**
- Serial monitor shows "❌ HTTP Error: -1"
- Backend not receiving data

**Solutions:**
- ✅ Verify backend server is running
- ✅ Check server URL is correct
- ✅ Ensure ESP32 and backend are on same network
- ✅ Try accessing backend URL from browser: `http://192.168.27.50:5000/health`
- ✅ Check Windows Firewall isn't blocking port 5000

### Problem: Sensor Not Found Error

**Symptoms:**
- Backend returns: `"Sensor not found with this device ID"`

**Solutions:**
- ✅ Verify `device_id` in ESP32 code matches database exactly (case-sensitive!)
- ✅ Check sensor is registered in `sensors` table: `SELECT * FROM sensors WHERE device_id = 'ESP32_001';`
- ✅ Verify `device_id` has no extra spaces or special characters
- ✅ Check sensor is active: `SELECT device_id, is_active FROM sensors;` (is_active should be 1)
- ✅ Run: `SELECT device_id, sensor_id, field_id FROM sensors;` to see all registered devices
- ✅ Verify field exists: `SELECT field_id, field_name FROM fields WHERE field_id = X;` (replace X with your field_id)

### Problem: DHT Sensor Reading Errors

**Symptoms:**
- Temperature shows "ERROR"
- Humidity shows "ERROR"

**Solutions:**
- ✅ Check DHT11 wiring (power, ground, data pin)
- ✅ Verify DHT_PIN is set correctly (GPIO 4)
- ✅ Try disconnecting and reconnecting sensor
- ✅ DHT11 needs 2-3 seconds between readings (code handles this)

### Problem: Data Not Appearing in Flutter App

**Symptoms:**
- Backend receives data successfully
- Flutter app shows no readings

**Solutions:**
- ✅ Verify sensor is linked to the correct field: `SELECT s.sensor_id, s.field_id, s.device_id, f.field_name FROM sensors s JOIN fields f ON s.field_id = f.field_id;`
- ✅ Check Flutter app API URL matches backend (should be `http://YOUR_IP:5000/api`)
- ✅ Ensure you're viewing the correct field in Flutter app
- ✅ Refresh Flutter app data (pull to refresh)
- ✅ Check backend logs for any errors
- ✅ Verify user authentication in Flutter app (user must be logged in)
- ✅ Check sensor belongs to logged-in user's field

## 📊 Data Flow

```
ESP32 Sensors
    ↓
Read Sensor Data (every 2 seconds)
    ↓
Control Pump Locally
    ↓
Send to Backend (every 30 seconds)
    ↓
POST /api/sensors/reading
    ↓
Backend API (sensorController.js)
    ↓
MySQL Database (sensor_readings table)
    ↓
Flutter Mobile App
    ↓
Display Real-time Data to User
```

## ⚙️ Advanced Configuration

### Change Data Transmission Interval

To send data more/less frequently, modify `BACKEND_SEND_INTERVAL` (around line 46):

```cpp
#define BACKEND_SEND_INTERVAL 30000    // 30 seconds (default)
// Change to:
// #define BACKEND_SEND_INTERVAL 60000   // 1 minute
// #define BACKEND_SEND_INTERVAL 600000  // 10 minutes
```

### Adjust Sensor Calibration

If sensor readings seem inaccurate, adjust conversion functions (around line 308):

```cpp
float convertSoilMoistureToPercentage(int rawValue) {
  // Adjust these values based on your sensor calibration
  float percentage = map(rawValue, 0, 4095, 0, 100);
  return constrain(percentage, 0, 100);
}
```

### Multiple ESP32 Devices

For multiple devices:

1. **Change Device ID** for each ESP32:
   ```cpp
   const char* deviceId = "ESP32_001";  // First device
   const char* deviceId = "ESP32_002";  // Second device
   ```

2. **Register Each Device** in database with matching `device_id`

3. **Connect to Same WiFi** network

4. **Same Backend Server** - all devices send to same backend

## ✅ Verification Checklist

### Configuration
- [ ] WiFi credentials configured correctly in ESP32 code
- [ ] Backend server URL matches your computer's local IP (e.g., `http://192.168.27.50:5000`)
- [ ] Device ID in ESP32 code matches database sensor registration exactly
- [ ] Backend `.env` file configured with correct database credentials

### Database Setup
- [ ] Database `smart_agriculture` exists in MySQL/XAMPP
- [ ] Database schema imported from `smart_agriculture.sql`
- [ ] Sensor registered in `sensors` table with correct `device_id`
- [ ] Sensor is linked to a valid `field_id`
- [ ] Sensor `is_active` field is set to `1` (active)

### Backend Server
- [ ] Backend server is running (`npm start` in Backend folder)
- [ ] Database connection successful (check console for "✅ Database connected successfully")
- [ ] Health endpoint accessible: `http://localhost:5000/health`
- [ ] Backend accessible from ESP32 network (check firewall settings)

### ESP32 Hardware
- [ ] ESP32 firmware uploaded successfully
- [ ] All required libraries installed (WiFi, HTTPClient, ArduinoJson, DHT)
- [ ] Serial monitor shows successful WiFi connection
- [ ] Serial monitor shows IP address assigned
- [ ] Serial monitor shows "Data sent to backend successfully!" every 30 seconds

### Data Verification
- [ ] Backend logs show incoming POST requests to `/api/sensors/reading`
- [ ] Data appears in `sensor_readings` table (check phpMyAdmin or SQL)
- [ ] Recent readings have correct `sensor_id` linked to your device
- [ ] Sensor readings include all expected fields (soil_moisture, temperature, humidity, etc.)

### Mobile App
- [ ] Flutter app displays sensor data
- [ ] Data refreshes automatically or on pull-to-refresh
- [ ] Sensor readings show correct timestamps
- [ ] No connection errors in Flutter app

## 📞 Support

If you encounter issues:

1. Check Serial Monitor output for error messages
2. Verify all configuration values are correct
3. Test backend API directly using Postman or curl
4. Check database connections and table structure
5. Review backend server logs for errors

## 🎉 Success!

Once everything is working:
- ESP32 will send sensor data every 30 seconds
- Backend will store data in database
- Flutter app will display real-time readings
- Pump will still work automatically based on local sensor readings

Happy farming! 🌾🚜

