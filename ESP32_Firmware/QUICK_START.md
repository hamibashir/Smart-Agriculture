# 🚀 Quick Start: ESP32 Backend Integration

## ⚡ 5-Minute Setup

### 1. Update Configuration (3 values to change)

Open `sketchworkingcode_nov15a.ino` and update:

```cpp
// Line 9-10: WiFi Credentials
const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";

// Line 15: Backend Server IP
const char* serverURL = "http://192.168.27.50:5000";  // Your computer's IP

// Line 21: Device ID (must match database)
const char* deviceId = "ESP32_001";  // Unique ID for this device
```

### 2. Register Sensor in Database

**Option A: Using SQL**
```sql
INSERT INTO sensors (field_id, sensor_type, device_id, sensor_model, installation_date)
VALUES (1, 'combined', 'ESP32_001', 'ESP32 + DHT11 + YL-69', CURDATE());
```
*(Replace `1` with your actual `field_id`)*

**Option B: Using Flutter App**
- Open Flutter app → Fields → Select Field → Add Sensor
- Enter `device_id`: `ESP32_001`
- Fill in other details

### 3. Upload Code

1. Connect ESP32 via USB
2. Select Board: **ESP32 Dev Module**
3. Select Port: Your ESP32 port
4. Click **Upload** (→)

### 4. Monitor & Verify

1. Open Serial Monitor (115200 baud)
2. Look for: `✅ WiFi connected successfully!`
3. Look for: `✅ Data sent to backend successfully!`
4. Check backend logs for incoming requests
5. Check database: `SELECT * FROM sensor_readings ORDER BY reading_timestamp DESC LIMIT 5;`

## ✅ Success Indicators

- ✅ Serial monitor shows WiFi connected
- ✅ Serial monitor shows "Data sent to backend successfully!"
- ✅ Backend logs show POST requests to `/api/sensors/reading`
- ✅ Database has new rows in `sensor_readings` table
- ✅ Flutter app displays sensor data

## 🐛 Quick Troubleshooting

| Problem | Solution |
|---------|----------|
| WiFi won't connect | Check SSID/password, use 2.4GHz WiFi |
| HTTP Error -1 | Verify backend is running, check IP address |
| "Sensor not found" | Ensure `device_id` in code matches database |
| No data in app | Refresh app, check sensor is linked to field |

## 📖 Full Guide

See `SETUP_INTEGRATION_GUIDE.md` for detailed instructions.

---

**Ready?** Update the 3 values above, register the sensor, upload, and you're done! 🎉

