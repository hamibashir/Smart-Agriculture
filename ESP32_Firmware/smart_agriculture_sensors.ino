/*
 * ============================================
 * Smart Agriculture ESP32 Sensor Integration
 * ============================================
 * 
 * Sensors Integrated:
 * - YL-69: Soil Moisture Sensor
 * - DHT22: Temperature & Humidity Sensor  
 * - FC-35: Sound Detection (repurposed for light)
 * - CW020: Liquid Level Sensor
 * 
 * Features:
 * - WiFi connectivity
 * - HTTP POST to backend API
 * - Battery voltage monitoring
 * - WiFi signal strength monitoring
 * - Automatic data transmission every 30 seconds
 * - Error handling and retry logic
 * 
 * Author: Smart Agriculture System
 * Version: 1.0.0
 * ============================================
 */

#include <WiFi.h>
#include <HTTPClient.h>
#include <ArduinoJson.h>
#include <DHT.h>

// ============================================
// Configuration Constants
// ============================================

// WiFi Configuration - UPDATE THESE!
const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";

// Backend API Configuration - UPDATE YOUR SERVER IP!
const char* serverURL = "http://192.168.1.100:5000"; // Change to your server IP
const char* apiEndpoint = "/api/sensors/reading";

// Device Configuration - UPDATE THIS!
const char* deviceId = "ESP32_001"; // Unique identifier for this device

// Pin Definitions
#define DHT_PIN 4          // DHT22 connected to GPIO 4
#define SOIL_MOISTURE_PIN A0   // YL-69 analog pin
#define SOUND_SENSOR_PIN A3    // FC-35 analog pin (repurposed for light)
#define LIQUID_LEVEL_PIN A6    // CW020 analog pin
#define BATTERY_PIN A7         // Battery voltage monitoring

// Sensor Configuration
#define DHT_TYPE DHT22
DHT dht(DHT_PIN, DHT_TYPE);

// Timing Configuration
const unsigned long READING_INTERVAL = 30000; // 30 seconds
const unsigned long WIFI_TIMEOUT = 10000;     // 10 seconds
const unsigned long HTTP_TIMEOUT = 5000;      // 5 seconds

// Global Variables
unsigned long lastReading = 0;
int wifiRetryCount = 0;
const int MAX_WIFI_RETRIES = 3;

// ============================================
// Setup Function
// ============================================
void setup() {
  Serial.begin(115200);
  delay(1000);
  
  Serial.println();
  Serial.println("🌾 ========================================");
  Serial.println("🌾  Smart Agriculture ESP32 Sensor Node");
  Serial.println("🌾 ========================================");
  Serial.println("🚀 Initializing sensors and WiFi...");
  
  // Initialize sensors
  dht.begin();
  
  // Configure analog pins
  pinMode(SOIL_MOISTURE_PIN, INPUT);
  pinMode(SOUND_SENSOR_PIN, INPUT);
  pinMode(LIQUID_LEVEL_PIN, INPUT);
  pinMode(BATTERY_PIN, INPUT);
  
  // Initialize WiFi
  connectToWiFi();
  
  Serial.println("✅ Setup completed successfully!");
  Serial.println("📊 Starting sensor readings...");
  Serial.println();
}

// ============================================
// Main Loop Function
// ============================================
void loop() {
  unsigned long currentTime = millis();
  
  // Check if it's time for a new reading
  if (currentTime - lastReading >= READING_INTERVAL) {
    lastReading = currentTime;
    
    // Check WiFi connection
    if (WiFi.status() != WL_CONNECTED) {
      Serial.println("📶 WiFi disconnected. Reconnecting...");
      connectToWiFi();
    }
    
    if (WiFi.status() == WL_CONNECTED) {
      // Read all sensors
      SensorData data = readAllSensors();
      
      // Print sensor data
      printSensorData(data);
      
      // Send data to backend
      bool success = sendSensorData(data);
      
      if (success) {
        Serial.println("✅ Data sent successfully!");
      } else {
        Serial.println("❌ Failed to send data");
      }
    } else {
      Serial.println("❌ WiFi connection failed. Skipping this reading.");
    }
    
    Serial.println("⏱️ Next reading in 30 seconds...");
    Serial.println("----------------------------------------");
  }
  
  delay(1000); // Small delay to prevent watchdog issues
}

// ============================================
// Sensor Data Structure
// ============================================
struct SensorData {
  float soilMoisture;
  float temperature;
  float humidity;
  float lightIntensity;
  float waterLevel;
  float batteryVoltage;
  int signalStrength;
};

// ============================================
// WiFi Connection Function
// ============================================
void connectToWiFi() {
  WiFi.begin(ssid, password);
  Serial.print("🔗 Connecting to WiFi");
  
  unsigned long startTime = millis();
  while (WiFi.status() != WL_CONNECTED && (millis() - startTime) < WIFI_TIMEOUT) {
    delay(500);
    Serial.print(".");
  }
  
  if (WiFi.status() == WL_CONNECTED) {
    Serial.println();
    Serial.println("✅ WiFi connected successfully!");
    Serial.print("📍 IP Address: ");
    Serial.println(WiFi.localIP());
    Serial.print("📶 Signal Strength: ");
    Serial.print(WiFi.RSSI());
    Serial.println(" dBm");
    wifiRetryCount = 0;
  } else {
    Serial.println();
    Serial.println("❌ WiFi connection failed!");
    wifiRetryCount++;
  }
}

// ============================================
// Read All Sensors Function
// ============================================
SensorData readAllSensors() {
  SensorData data;
  
  Serial.println("📊 Reading sensors...");
  
  // Read DHT22 (Temperature & Humidity)
  data.temperature = dht.readTemperature();
  data.humidity = dht.readHumidity();
  
  // Check DHT22 readings
  if (isnan(data.temperature) || isnan(data.humidity)) {
    Serial.println("⚠️ DHT22 reading error! Using default values.");
    data.temperature = 25.0; // Default temperature
    data.humidity = 50.0;    // Default humidity
  }
  
  // Read YL-69 Soil Moisture
  int soilMoistureRaw = analogRead(SOIL_MOISTURE_PIN);
  // Convert to percentage (0-100%) - calibrate based on your sensor
  data.soilMoisture = map(soilMoistureRaw, 0, 4095, 100, 0); // ESP32 ADC is 12-bit
  data.soilMoisture = constrain(data.soilMoisture, 0, 100);
  
  // Read FC-35 Sound Sensor (repurposed as light sensor)
  int lightRaw = analogRead(SOUND_SENSOR_PIN);
  // Convert to percentage (0-100%)
  data.lightIntensity = map(lightRaw, 0, 4095, 0, 100);
  data.lightIntensity = constrain(data.lightIntensity, 0, 100);
  
  // Read CW020 Liquid Level
  int waterLevelRaw = analogRead(LIQUID_LEVEL_PIN);
  // Convert to percentage (0-100%)
  data.waterLevel = map(waterLevelRaw, 0, 4095, 0, 100);
  data.waterLevel = constrain(data.waterLevel, 0, 100);
  
  // Read Battery Voltage
  int batteryRaw = analogRead(BATTERY_PIN);
  // Convert to voltage (assuming 3.3V reference and voltage divider)
  data.batteryVoltage = (batteryRaw * 3.3) / 4095.0 * 2; // Adjust multiplier based on your circuit
  
  // Get WiFi Signal Strength
  data.signalStrength = WiFi.RSSI();
  
  return data;
}

// ============================================
// Print Sensor Data Function
// ============================================
void printSensorData(SensorData data) {
  Serial.println("📊 Sensor Readings:");
  Serial.printf("🌡️  Temperature: %.1f°C\n", data.temperature);
  Serial.printf("💧 Humidity: %.1f%%\n", data.humidity);
  Serial.printf("🌱 Soil Moisture: %.1f%%\n", data.soilMoisture);
  Serial.printf("☀️  Light Intensity: %.1f%%\n", data.lightIntensity);
  Serial.printf("💦 Water Level: %.1f%%\n", data.waterLevel);
  Serial.printf("🔋 Battery: %.2fV\n", data.batteryVoltage);
  Serial.printf("📶 WiFi Signal: %d dBm\n", data.signalStrength);
}

// ============================================
// Send Sensor Data to Backend
// ============================================
bool sendSensorData(SensorData data) {
  if (WiFi.status() != WL_CONNECTED) {
    Serial.println("❌ WiFi not connected");
    return false;
  }
  
  HTTPClient http;
  String fullURL = String(serverURL) + String(apiEndpoint);
  http.begin(fullURL);
  http.addHeader("Content-Type", "application/json");
  http.setTimeout(HTTP_TIMEOUT);
  
  // Create JSON payload
  StaticJsonDocument<512> doc;
  doc["device_id"] = deviceId;
  doc["soil_moisture"] = data.soilMoisture;
  doc["temperature"] = data.temperature;
  doc["humidity"] = data.humidity;
  doc["light_intensity"] = data.lightIntensity;
  doc["water_flow_rate"] = data.waterLevel; // Using water level for flow rate
  doc["battery_voltage"] = data.batteryVoltage;
  doc["signal_strength"] = data.signalStrength;
  
  String jsonString;
  serializeJson(doc, jsonString);
  
  Serial.println("📤 Sending data to backend...");
  Serial.printf("🌐 URL: %s\n", fullURL.c_str());
  Serial.printf("📦 Payload: %s\n", jsonString.c_str());
  
  // Send POST request
  int httpResponseCode = http.POST(jsonString);
  
  if (httpResponseCode > 0) {
    String response = http.getString();
    Serial.printf("📥 Response Code: %d\n", httpResponseCode);
    Serial.printf("📝 Response: %s\n", response.c_str());
    
    http.end();
    return (httpResponseCode == 200 || httpResponseCode == 201);
  } else {
    Serial.printf("❌ HTTP Error: %d\n", httpResponseCode);
    Serial.printf("❌ Error: %s\n", http.errorToString(httpResponseCode).c_str());
    http.end();
    return false;
  }
}

// ============================================
// Utility Functions
// ============================================

// Get uptime in readable format
String getUptime() {
  unsigned long uptimeMs = millis();
  unsigned long seconds = uptimeMs / 1000;
  unsigned long minutes = seconds / 60;
  unsigned long hours = minutes / 60;
  
  return String(hours) + "h " + String(minutes % 60) + "m " + String(seconds % 60) + "s";
}

// Print system info (call in setup if needed)
void printSystemInfo() {
  Serial.println("🔧 System Information:");
  Serial.printf("📱 Device ID: %s\n", deviceId);
  Serial.printf("💻 Chip Model: %s\n", ESP.getChipModel());
  Serial.printf("⚡ CPU Frequency: %d MHz\n", ESP.getCpuFreqMHz());
  Serial.printf("💾 Flash Size: %d bytes\n", ESP.getFlashChipSize());
  Serial.printf("🆔 MAC Address: %s\n", WiFi.macAddress().c_str());
}
