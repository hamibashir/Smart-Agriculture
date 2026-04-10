#include <WiFi.h>
#include <WiFiAP.h>
#include <WiFiClient.h>
#include <WiFiGeneric.h>
#include <WiFiMulti.h>
#include <WiFiSTA.h>
#include <WiFiScan.h>
#include <WiFiServer.h>
#include <WiFiType.h>
#include <WiFiUdp.h>

#include <WiFi.h>
#include <HTTPClient.h>
#include <ArduinoJson.h>
#include <DHT.h>

// ============================================
// WiFi Configuration - UPDATE THESE VALUES!
// ============================================
const char* ssid = "AccessDenied";           // Your WiFi network name
const char* password = "404404404";    // Your WiFi password

// ============================================
// Backend API Configuration - UPDATE YOUR SERVER IP!
// ============================================
const char* serverURL = "http://10.79.48.79:5000";  // Your backend server IP (same as Flutter app)
const char* apiEndpoint = "/api/sensors/reading";

// ============================================
// Device Configuration - UPDATE THIS!
// ============================================
const char* deviceId = "ESP_32test";  // Unique device ID (must match database sensor device_id)

// ============================================
// Pin Definitions
// ============================================
#define SOIL_PIN 34
#define RAIN_PIN 33
#define LIGHT_PIN 32
#define DHT_PIN 4
#define RELAY_PIN 14

#define DHT_TYPE DHT11
DHT dht(DHT_PIN, DHT_TYPE);

// ============================================
// Sensor Thresholds
// CHANGE HERE: Adjust these values to calibrate sensor trigger points
// ============================================
#define SOIL_DRY_THRESHOLD 2500 // Value > 2500 is considered DRY
#define RAIN_THRESHOLD 2000     // Value < 2000 is usually RAIN (depending on sensor logic)
#define LIGHT_DARK_THRESHOLD 3000 // Value > 3000 is DARK

// ============================================
// Timing Configuration
// ============================================
#define READING_INTERVAL 3000          // Local reading interval (3 seconds)
#define BACKEND_SEND_INTERVAL 30000    // Send to backend every 30 seconds
#define PUMP_MIN_RUN_TIME 1500

unsigned long lastReadTime = 0;
unsigned long lastBackendSendTime = 0;
unsigned long pumpStartTime = 0;
bool pumpRunning = false;

// WiFi connection tracking
bool wifiConnected = false;

void setup() {
  Serial.begin(115200);
  delay(2000);
  
  Serial.println("\n🌾 ========================================");
  Serial.println("🌾  ESP32 Smart Irrigation System");
  Serial.println("🌾  Backend Integration Enabled");
  Serial.println("🌾 ========================================\n");
  
  // Initialize sensors
  dht.begin();
  Serial.println("✓ DHT Sensor initialized");
  
  pinMode(RELAY_PIN, OUTPUT);
  digitalWrite(RELAY_PIN, LOW);
  Serial.println("✓ Relay initialized (Pump OFF)");
  
  Serial.println("✓ Analog sensors ready");
  
  // Connect to WiFi
  Serial.println("\n📶 Connecting to WiFi...");
  connectToWiFi();
  
  if (wifiConnected) {
    Serial.println("✅ WiFi connected successfully!");
    Serial.print("📍 IP Address: ");
    Serial.println(WiFi.localIP());
    Serial.print("📶 Signal Strength: ");
    Serial.print(WiFi.RSSI());
    Serial.println(" dBm");
    Serial.print("🔑 Device ID: ");
    Serial.println(deviceId);
    Serial.print("🌐 Backend URL: ");
    Serial.println(serverURL);
  } else {
    Serial.println("⚠️  WiFi connection failed. System will work locally only.");
  }
  
  Serial.println("\n✅ System ready! Starting readings...\n");
  delay(1000);
}

void loop() {
  unsigned long currentTime = millis();
  
  // Check WiFi connection periodically
  if (WiFi.status() != WL_CONNECTED) {
    if (wifiConnected) {
      Serial.println("⚠️  WiFi disconnected. Attempting to reconnect...");
      wifiConnected = false;
    }
    connectToWiFi();
  } else {
    wifiConnected = true;
  }
  
  // Local sensor readings and pump control (every 2 seconds)
  if (currentTime - lastReadTime >= READING_INTERVAL) {
    lastReadTime = currentTime;
    
    int soilValue = readSoilMoisture();
    int rainValue = readRainSensor();
    int lightValue = readLightSensor();
    float temperature = readTemperature();
    float humidity = readHumidity();
    
    displaySensorData(soilValue, rainValue, lightValue, temperature, humidity);
    
    controlPump(soilValue, rainValue, lightValue);
  }
  
  // Send data to backend (every 30 seconds)
  if (wifiConnected && (currentTime - lastBackendSendTime >= BACKEND_SEND_INTERVAL)) {
    lastBackendSendTime = currentTime;
    
    int soilValue = readSoilMoisture();
    int rainValue = readRainSensor();
    int lightValue = readLightSensor();
    float temperature = readTemperature();
    float humidity = readHumidity();
    
    // Send sensor data to backend
    bool success = sendSensorDataToBackend(soilValue, rainValue, lightValue, temperature, humidity);
    
    if (success) {
      Serial.println("✅ Data sent to backend successfully!\n");
    } else {
      Serial.println("❌ Failed to send data to backend\n");
    }
  }
  
  delay(100); // Small delay to prevent watchdog issues
}

int readSoilMoisture() {
  int value = analogRead(SOIL_PIN);
  return value;
}

int readRainSensor() {
  int value = analogRead(RAIN_PIN);
  return value;
}

int readLightSensor() {
  int value = analogRead(LIGHT_PIN);
  return value;
}

float readTemperature() {
  float temp = dht.readTemperature();
  if (isnan(temp)) {
    Serial.println("ERROR: Failed to read temperature!");
    return -999;
  }
  return temp;
}

float readHumidity() {
  float hum = dht.readHumidity();
  if (isnan(hum)) {
    Serial.println("ERROR: Failed to read humidity!");
    return -999;
  }
  return hum;
}

void displaySensorData(int soil, int rain, int light, float temp, float hum) {
  Serial.println("┌─────────────────────────────────────┐");
  Serial.println("│      SENSOR READINGS                │");
  Serial.println("├─────────────────────────────────────┤");
  
  Serial.print("│ Soil Moisture: ");
  Serial.print(soil);
  Serial.print(" (");
  if (soil > SOIL_DRY_THRESHOLD) {
    Serial.print("DRY - Need Water");
  } else if (soil > 1500) {
    Serial.print("MODERATE");
  } else {
    Serial.print("WET");
  }
  Serial.println(")");
  
  Serial.print("│ Rain Sensor:   ");
  Serial.print(rain);
  Serial.print(" (");
  if (rain < RAIN_THRESHOLD) { // Value < 2000 means Low Resistance (Wet)
    Serial.print("RAINING");
  } else {
    Serial.print("NO RAIN");
  }
  Serial.println(")");
  
  Serial.print("│ Light Level:   ");
  Serial.print(light);
  Serial.print(" (");
  if (light < LIGHT_DARK_THRESHOLD) {
    Serial.print("Light/Day");
  } else if (light < 3000) {
    Serial.print("MODERATE");
  } else {
    Serial.print("Day/Light");
  }
  Serial.println(")");
  
  Serial.print("│ Temperature:   ");
  if (temp != -999) {
    Serial.print(temp, 1);
    Serial.println(" °C");
  } else {
    Serial.println("ERROR");
  }
  
  Serial.print("│ Humidity:      ");
  if (hum != -999) {
    Serial.print(hum, 1);
    Serial.println(" %");
  } else {
    Serial.println("ERROR");
  }
  
  Serial.print("│ Pump Status:   ");
  Serial.println(pumpRunning ? "ON (Running)" : "OFF");
  
  Serial.println("└─────────────────────────────────────┘\n");
}

void controlPump(int soilValue, int rainValue, int lightValue) {
  
  // High Analog Value = Dry/No Rain (Open Circuit)
  // Low Analog Value = Wet/Raining (Short Circuit)
  
  bool soilIsDry = (soilValue > SOIL_DRY_THRESHOLD); // True if > 2500 (Dry)
  bool notRaining = (rainValue > RAIN_THRESHOLD);    // True if > 2000 (No Rain)
  
  if (soilIsDry && notRaining && !pumpRunning) {
    turnPumpOn();
    Serial.println("🚿 AUTO: Pump turned ON (Soil dry, no rain)");
    
  } else if (pumpRunning && (!soilIsDry || !notRaining)) {
    turnPumpOff();
    if (!notRaining) { // This means it IS Raining inside the logic check
      Serial.println("⛔ AUTO: Pump turned OFF (Rain detected)");
    } else {
      Serial.println("⛔ AUTO: Pump turned OFF (Soil wet enough)");
    }
  }
}

void turnPumpOn() {
  digitalWrite(RELAY_PIN, HIGH);
  pumpRunning = true;
  pumpStartTime = millis();
}

void turnPumpOff() {
  digitalWrite(RELAY_PIN, LOW);
  pumpRunning = false;
}

// ============================================
// WiFi Connection Function
// ============================================
void connectToWiFi() {
  if (WiFi.status() == WL_CONNECTED) {
    wifiConnected = true;
    return;
  }
  
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  
  Serial.print("🔗 Connecting to WiFi");
  unsigned long startTime = millis();
  
  while (WiFi.status() != WL_CONNECTED && (millis() - startTime < 15000)) {
    delay(500);
    Serial.print(".");
  }
  
  if (WiFi.status() == WL_CONNECTED) {
    wifiConnected = true;
    Serial.println();
  } else {
    wifiConnected = false;
    Serial.println("\n❌ WiFi connection failed");
  }
}

// ============================================
// Convert Sensor Values to Backend Format
// ============================================
float convertSoilMoistureToPercentage(int rawValue) {
  // CHANGE HERE: Adjust 0 (wettest) and 4095 (driest) to your specific sensor's range
  // ESP32 ADC is 12-bit (0-4095)
  // Higher raw value = drier soil (less moisture)
  // Lower raw value = wetter soil (more moisture)
  // Convert to percentage: 0% = very dry, 100% = very wet
  // Invert the mapping: 4095 (dry) -> 0%, 0 (wet) -> 100%
  float percentage = map(rawValue, 0, 4095, 100, 0);
  return constrain(percentage, 0, 100);
}

float convertRainToPercentage(int rawValue) {
  // CHANGE HERE: Adjust 0 and 4095 to calibrate rain sensitivity
  // Lower raw value = more rain detected
  // Convert to percentage: 0% = heavy rain, 100% = no rain
  float percentage = map(rawValue, 0, 4095, 0, 100);
  return constrain(percentage, 0, 100);
}

float convertLightToPercentage(int rawValue) {
  // CHANGE HERE: Adjust 0 and 4095 to calibrate light sensitivity
  // Convert to percentage: 0% = dark, 100% = bright
  // Invert: 0 (Bright) -> 100%, 4095 (Dark) -> 0%
  float percentage = map(rawValue, 0, 4095, 100, 0);
  return constrain(percentage, 0, 100);
}

// ============================================
// Send Sensor Data to Backend API
// ============================================
bool sendSensorDataToBackend(int soilRaw, int rainRaw, int lightRaw, float temp, float hum) {
  if (WiFi.status() != WL_CONNECTED) {
    Serial.println("❌ WiFi not connected. Cannot send data.");
    return false;
  }
  
  HTTPClient http;
  String fullURL = String(serverURL) + String(apiEndpoint);
  
  http.begin(fullURL);
  http.addHeader("Content-Type", "application/json");
  http.setTimeout(5000); // 5 second timeout
  
  // Convert sensor readings to backend format
  float soilMoisture = convertSoilMoistureToPercentage(soilRaw);
  float rainfall = convertRainToPercentage(rainRaw); // Higher = less rain (inverted)
  float lightIntensity = convertLightToPercentage(lightRaw);
  
  // Convert temperature from Fahrenheit to Celsius if needed
  float tempCelsius = temp;
  if (temp != -999) {
    // Assuming DHT11 reads in Celsius by default, but if your readings are in Fahrenheit:
    // tempCelsius = (temp - 32) * 5.0 / 9.0;
  }
  
  // Create JSON payload matching backend API format
  StaticJsonDocument<512> doc;
  doc["device_id"] = deviceId;
  
  // Add sensor values (always send soil moisture and light, others only if valid)
  doc["soil_moisture"] = soilMoisture;
  doc["light_intensity"] = lightIntensity;
  
  // Add temperature and humidity only if valid readings
  if (temp != -999) {
    doc["temperature"] = tempCelsius;
  }
  if (hum != -999) {
    doc["humidity"] = hum;
  }
  
  doc["rainfall"] = (100.0 - rainfall); // Invert: 0% = no rain, 100% = heavy rain
  doc["water_flow_rate"] = 0.0; // Not measured, set to 0
  doc["signal_strength"] = WiFi.RSSI();
  
  String jsonString;
  serializeJson(doc, jsonString);
  
  Serial.println("📤 Sending sensor data to backend...");
  Serial.printf("🌐 URL: %s\n", fullURL.c_str());
  Serial.printf("📦 Payload: %s\n", jsonString.c_str());
  
  // Send POST request
  int httpResponseCode = http.POST(jsonString);
  
  bool success = false;
  if (httpResponseCode > 0) {
    String response = http.getString();
    Serial.printf("📥 Response Code: %d\n", httpResponseCode);
    Serial.printf("📝 Response: %s\n", response.c_str());
    
    success = (httpResponseCode == 200 || httpResponseCode == 201);
  } else {
    Serial.printf("❌ HTTP Error: %d\n", httpResponseCode);
    Serial.printf("❌ Error: %s\n", http.errorToString(httpResponseCode).c_str());
  }
  
  http.end();
  return success;
}
