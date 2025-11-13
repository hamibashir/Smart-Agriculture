# 🚀 ESP32 Sensor Installation Guide

Complete step-by-step guide to integrate your sensors with the Smart Agriculture System.

## 📋 Pre-Installation Checklist

- [ ] ESP32 development board
- [ ] YL-69 soil moisture sensor
- [ ] DHT22 temperature/humidity sensor  
- [ ] FC-35 sound detection sensor
- [ ] CW020 liquid level sensor
- [ ] Jumper wires and breadboard
- [ ] Arduino IDE installed
- [ ] Backend server running
- [ ] Database accessible

## 🔧 Step 1: Hardware Assembly

### 1.1 Basic Wiring

```
ESP32 Pin    →    Component
─────────────────────────────
3.3V         →    All sensor VCC pins
GND          →    All sensor GND pins
GPIO 4       →    DHT22 Data pin
A0 (GPIO36)  →    YL-69 Analog output
A3 (GPIO39)  →    FC-35 Analog output
A6 (GPIO34)  →    CW020 Analog output
A7 (GPIO35)  →    Battery voltage divider
```

### 1.2 Power Circuit
Create a voltage divider for battery monitoring:
```
Battery+ ──[10kΩ]──●──[10kΩ]── GND
                   │
                   └── ESP32 A7
```

### 1.3 DHT22 Connection
```
DHT22 Pin    →    ESP32
─────────────────────────
VCC          →    3.3V
Data         →    GPIO 4
GND          →    GND
```
**Note**: Add 4.7kΩ pull-up resistor between Data and VCC if readings are unreliable.

## 💻 Step 2: Software Setup

### 2.1 Install Arduino IDE Libraries

1. Open Arduino IDE
2. Go to **Tools** > **Manage Libraries**
3. Install these libraries:
   - `ArduinoJson` by Benoit Blanchon
   - `DHT sensor library` by Adafruit
   - `Adafruit Unified Sensor` (dependency)

### 2.2 Configure ESP32 Board

1. Go to **File** > **Preferences**
2. Add ESP32 board URL:
   ```
   https://dl.espressif.com/dl/package_esp32_index.json
   ```
3. Go to **Tools** > **Board** > **Boards Manager**
4. Search "ESP32" and install **ESP32 by Espressif Systems**
5. Select **Tools** > **Board** > **ESP32 Dev Module**

### 2.3 Configure Network Settings

Edit `smart_agriculture_sensors.ino`:

```cpp
// WiFi Configuration - UPDATE THESE!
const char* ssid = "YourWiFiName";
const char* password = "YourWiFiPassword";

// Backend API Configuration - UPDATE YOUR SERVER IP!
const char* serverURL = "http://192.168.1.100:5000";

// Device Configuration - UPDATE THIS!
const char* deviceId = "ESP32_001";
```

**Find your server IP:**
- Windows: Open Command Prompt, type `ipconfig`
- Linux/Mac: Open Terminal, type `ifconfig`
- Look for your local network IP (usually starts with 192.168.x.x)

## 🗄️ Step 3: Database Setup

### 3.1 Register Your Sensor

1. Open MySQL Workbench or your database tool
2. Connect to your `smart_agriculture` database
3. Run the SQL script from `sensor_setup.sql`:

```sql
-- Check your existing fields first
SELECT field_id, field_name FROM fields WHERE user_id = YOUR_USER_ID;

-- Register your ESP32 (replace field_id with actual ID)
INSERT INTO sensors (
    field_id, sensor_type, device_id, sensor_model, 
    installation_date, location_description, is_active
) VALUES (
    1, 'combined', 'ESP32_001', 
    'ESP32 + YL69 + DHT22 + FC35 + CW020',
    CURDATE(), 'Field monitoring station', TRUE
);
```

### 3.2 Verify Registration
```sql
SELECT * FROM sensors WHERE device_id = 'ESP32_001';
```

## ⚡ Step 4: Upload Firmware

### 4.1 Connect ESP32
1. Connect ESP32 to computer via USB cable
2. Select correct **Port** in Arduino IDE
3. If port doesn't appear, install CP210x USB driver

### 4.2 Upload Code
1. Open `smart_agriculture_sensors.ino`
2. Verify your WiFi and server settings
3. Click **Upload** button (→)
4. Wait for "Done uploading" message

### 4.3 Monitor Serial Output
1. Open **Tools** > **Serial Monitor**
2. Set baud rate to **115200**
3. You should see:
```
🌾 ========================================
🌾  Smart Agriculture ESP32 Sensor Node
🌾 ========================================
🚀 Initializing sensors and WiFi...
✅ WiFi connected successfully!
📍 IP Address: 192.168.1.XXX
📊 Reading sensors...
📤 Sending data to backend...
✅ Data sent successfully!
```

## 🔍 Step 5: Testing & Verification

### 5.1 Check Database Readings
Run this query to see if data is arriving:
```sql
SELECT * FROM sensor_readings 
WHERE sensor_id = (
    SELECT sensor_id FROM sensors WHERE device_id = 'ESP32_001'
)
ORDER BY reading_timestamp DESC LIMIT 5;
```

### 5.2 Test Mobile App
1. Open your Flutter mobile app
2. Login with your credentials
3. Navigate to **Fields** tab
4. Select your field
5. You should see real-time sensor data

### 5.3 Test Web Dashboard
1. Open your web browser
2. Go to your web app URL
3. Login and check dashboard
4. Verify sensor readings are displayed

## 🛠️ Step 6: Troubleshooting

### WiFi Connection Issues
```
❌ WiFi connection failed!
```
**Solutions:**
- Double-check SSID and password
- Move ESP32 closer to router
- Check if WiFi network is 2.4GHz (ESP32 doesn't support 5GHz)
- Restart ESP32

### Backend Communication Issues
```
❌ HTTP Error: -1
```
**Solutions:**
- Verify server IP address
- Ensure backend server is running (`npm run dev`)
- Check if ESP32 and server are on same network
- Test API endpoint manually: `http://YOUR_IP:5000/health`

### Sensor Reading Errors
```
⚠️ DHT22 reading error! Using default values.
```
**Solutions:**
- Check DHT22 wiring
- Add 4.7kΩ pull-up resistor
- Replace DHT22 sensor if faulty
- Ensure stable power supply

### Database Issues
```
Sensor not found with this device ID
```
**Solutions:**
- Verify sensor was registered in database
- Check device_id matches exactly
- Ensure sensor is marked as active

## 🏁 Step 7: Final Deployment

### 7.1 Physical Installation
1. **Waterproof enclosure**: Use IP65-rated box for outdoor deployment
2. **Soil sensor placement**: Insert YL-69 probe 2-3 inches into soil
3. **Weather protection**: Shield DHT22 from direct rain
4. **Power supply**: Use solar panel + battery for remote fields

### 7.2 Production Configuration
1. **Reduce reading frequency** for battery conservation:
   ```cpp
   const unsigned long READING_INTERVAL = 300000; // 5 minutes
   ```
2. **Enable deep sleep** (advanced users)
3. **Set up monitoring alerts** in mobile app
4. **Regular maintenance schedule** (monthly battery/sensor check)

## 📊 Step 8: Monitoring & Maintenance

### 8.1 System Health Check
Monitor these metrics:
- **Battery voltage** (should be > 3.2V)
- **WiFi signal strength** (should be > -70 dBm)
- **Data transmission success rate**
- **Sensor reading consistency**

### 8.2 Mobile App Alerts
Configure alerts for:
- Low soil moisture (< 30%)
- High temperature (> 35°C)
- Low battery (< 20%)
- Sensor offline (no readings for 1 hour)

### 8.3 Regular Maintenance
- **Weekly**: Check sensor readings in app
- **Monthly**: Clean soil sensor probe
- **Quarterly**: Check all connections
- **Annually**: Replace sensors if needed

## 🎉 Success Criteria

Your installation is successful when:

- [ ] ESP32 connects to WiFi automatically
- [ ] Sensor readings appear in serial monitor
- [ ] Data successfully posts to backend API
- [ ] Database receives and stores readings
- [ ] Mobile app displays real-time sensor data
- [ ] Web dashboard shows field statistics
- [ ] Irrigation system responds to soil moisture

## 📞 Support & Next Steps

**If you encounter issues:**
1. Check serial monitor for error messages
2. Verify all connections and configurations  
3. Test each component individually
4. Review this guide step by step

**Next Steps:**
1. Set up automated irrigation system
2. Configure alert thresholds in mobile app
3. Deploy multiple sensors across different fields
4. Integrate weather API for advanced predictions
5. Set up crop recommendation system

---

**🎯 You now have a complete IoT sensor network integrated with your Smart Agriculture System!** 

The ESP32 will continuously monitor your field conditions and send real-time data to your backend, which you can view through your mobile app and web dashboard. 🌾📱
