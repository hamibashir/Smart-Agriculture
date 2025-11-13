@echo off
echo.
echo ========================================
echo ESP32 Integration Quick Test
echo ========================================
echo.

echo [1/4] Testing backend server health...
curl -s -o nul -w "Status: %%{http_code}\n" http://localhost:5000/health
if %errorlevel% neq 0 (
    echo ERROR: Backend server not responding
    echo Please start your backend server: npm run dev
    pause
    exit /b 1
)

echo.
echo [2/4] Testing sensor data endpoint...
curl -X POST http://localhost:5000/api/sensors/reading ^
  -H "Content-Type: application/json" ^
  -d "{\"device_id\":\"ESP32_001\",\"soil_moisture\":45.2,\"temperature\":28.5,\"humidity\":65.3,\"light_intensity\":78.0,\"water_flow_rate\":12.5,\"battery_voltage\":3.8,\"signal_strength\":-45}" ^
  -w "\nStatus Code: %%{http_code}\n"

echo.
echo [3/4] Database verification query:
echo Run this in your MySQL client:
echo SELECT * FROM sensor_readings WHERE sensor_id = (SELECT sensor_id FROM sensors WHERE device_id = 'ESP32_001') ORDER BY reading_timestamp DESC LIMIT 3;

echo.
echo [4/4] Arduino IDE checklist:
echo - Install ArduinoJson library
echo - Install DHT sensor library  
echo - Configure WiFi credentials in code
echo - Set correct server IP address
echo - Select ESP32 Dev Module board
echo - Upload firmware to ESP32

echo.
echo ========================================
echo Test completed. Check output above.
echo ========================================
pause
