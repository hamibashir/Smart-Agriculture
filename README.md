<div align="center">
  <img src="https://img.icons8.com/color/120/000000/sprout.png" alt="Smart Agriculture Logo"/>
  <h1>Smart Agriculture System</h1>
  <p><strong>AI-Powered IoT Farming Solution Built for Modern Agriculture</strong></p>
</div>

---

## 🌾 Overview
The **Smart Agriculture System** is a complete, end-to-end IoT farm management solution. It combines custom ESP32 hardware, a robust Node.js backend, a Python AI recommendation engine, and a beautiful Flutter mobile application. It empowers farmers to monitor fields in real-time, automate irrigation, and leverage Artificial Intelligence for crop recommendations and smart alerts.

## ✨ Core Features
* **💧 Automated Irrigation:** Near real-time pump control based on dynamic soil moisture readings.
* **🛡️ Instant Local Safety:** ESP32 hardware instantly kills the water pump if rain is detected or soil is saturated—even if the internet drops.
* **🤖 AI Insights & Chatbot:** Python Flask backend analyzes soil composition to recommend the best crops and provides predictive farming insights via an in-app AI Chatbot.
* **📱 Modern Mobile App:** A fast, aesthetic, and fully-featured Flutter app for monitoring dashboards, managing fields, and tracking live physical sensor statuses.
* **⚡ High Performance Architecture:** Fire-and-forget backend design ensures the hardware never hangs while waiting on heavy database or AI processes.

## 🏗️ System Architecture

The ecosystem is divided into four main pillars:

1. **Hardware (ESP32 IoT Node):**
   * Written in C++ using the Arduino framework.
   * Monitors Soil Moisture, Rain, Light, and Temperature/Humidity sensors.
   * Communicates via rapid REST API polling (1-second intervals for instant response).

2. **Core Backend (Node.js & Express):**
   * Handles hardware telemetry and mobile app requests.
   * Processes heavy tasks (Alerts, DB Inserts, AI Triggers) asynchronously.
   * Backed by a secure **MySQL** database.

3. **AI Engine (Python Flask):**
   * Machine learning microservice for crop yield recommendations.
   * Powers the natural language "AgriBot" chatbot.

4. **Mobile App (Flutter):**
   * Cross-platform frontend featuring smooth animations, live sensor statuses, and comprehensive field management.

## 📂 Repository Structure

```text
Smart-Agriculture/
├── Backend/           # Node.js REST API & MySQL integrations
├── ESP32_Firmware/    # Hardware code, WiFi, and sensor logic
├── Flask_AI/          # Python microservice for AI & Chatbot
├── FlutterApp/        # Dart codebase for the Mobile Application
└── Database/          # MySQL schemas and backups
```

## 🚀 Getting Started

### 1. Database
Import the SQL dump located in `/Database/defaultdb.sql` into your MySQL server. Update database credentials in the Node.js backend `.env`.

### 2. Backend (Node.js)
```bash
cd Backend
npm install
npm start
```

### 3. AI Server (Flask)
```bash
cd Flask_AI
pip install -r requirements.txt
python app.py
```

### 4. Mobile App (Flutter)
Ensure you have the Flutter SDK installed.
```bash
cd FlutterApp
flutter pub get
flutter run
```

### 5. Hardware (ESP32)
Flash the code from `/ESP32_Firmware` onto your ESP32. Ensure you update the WiFi credentials (`ssid` and `password`) and point the `BACKEND_HOST` to your active server IP/Domain.

---
<div align="center">
  <i>Cultivating the Future of Farming, One Byte at a Time. 🌱</i>
</div>
