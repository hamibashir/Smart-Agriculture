#include <DHT.h>

#define SOIL_PIN 34
#define RAIN_PIN 35
#define LIGHT_PIN 32
#define DHT_PIN 4
#define RELAY_PIN 14

#define DHT_TYPE DHT11
DHT dht(DHT_PIN, DHT_TYPE);

#define SOIL_DRY_THRESHOLD 2500
#define RAIN_THRESHOLD 2000
#define LIGHT_DARK_THRESHOLD 3000

#define READING_INTERVAL 2000
#define PUMP_MIN_RUN_TIME 1500

unsigned long lastReadTime = 0;
unsigned long pumpStartTime = 0;
bool pumpRunning = false;

void setup() {
  Serial.begin(115200);
  delay(20000);
  Serial.println("\n=================================");
  Serial.println("ESP32 Smart Irrigation System");
  Serial.println("=================================\n");
  
  dht.begin();
  Serial.println("✓ DHT Sensor initialized");
  
  pinMode(RELAY_PIN, OUTPUT);
  digitalWrite(RELAY_PIN, LOW);
  Serial.println("✓ Relay initialized (Pump OFF)");
  
  Serial.println("✓ Analog sensors ready");
  
  Serial.println("\nSystem ready! Starting readings...\n");
  delay(1000);
}

void loop() {
  unsigned long currentTime = millis();
  
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
  
  if (pumpRunning && (currentTime - pumpStartTime >= PUMP_MIN_RUN_TIME)) {
  }
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
  if (rain < RAIN_THRESHOLD) {
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
    Serial.print("Dark/Night");
  }
  Serial.println(")");
  
  Serial.print("│ Temperature:   ");
  if (temp != -999) {
    Serial.print(temp, 1);
    Serial.println(" °F");
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
  
  bool soilIsDry = (soilValue > SOIL_DRY_THRESHOLD);
  bool notRaining = (rainValue > RAIN_THRESHOLD);
  bool isDaytime = (lightValue > LIGHT_DARK_THRESHOLD);
  
  if (soilIsDry && notRaining && !pumpRunning) {
    turnPumpOn();
    Serial.println("🚿 AUTO: Pump turned ON (Soil dry, no rain)");
    
  } else if (pumpRunning && (!soilIsDry || !notRaining)) {
    turnPumpOff();
    if (!notRaining) {
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