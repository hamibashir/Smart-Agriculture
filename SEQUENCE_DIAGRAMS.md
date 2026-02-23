# 🌾 Smart Agriculture IoT System - Sequence Diagrams Documentation

## 📋 Overview

This document provides comprehensive System Sequence Diagrams (SSD) for the Smart Agriculture IoT System. These diagrams illustrate the interactions between different system components for key workflows.

---

## 📊 Diagram Index

1. **[Complete System Workflow](#1-complete-system-workflow)** - End-to-end system operation
2. **[User Registration](#2-user-registration)** - New user account creation
3. **[Sensor Data Flow & Alerts](#3-sensor-data-flow--alerts)** - IoT sensor reading and alert generation
4. **[Manual Irrigation Control](#4-manual-irrigation-control)** - Farmer-initiated irrigation
5. **[Automatic Irrigation Trigger](#5-automatic-irrigation-trigger)** - Threshold-based auto irrigation
6. **[Crop Recommendations](#6-crop-recommendations)** - AI-powered crop suggestions

---

## 1. Complete System Workflow

### 📖 Description
This is the master sequence diagram showing the complete working of the Smart Agriculture system from initial setup to ongoing operation and manual control.

### 🎯 Purpose
Demonstrates the full lifecycle of the system including:
- Initial setup and configuration
- Continuous monitoring
- Automatic irrigation triggers
- User interaction and manual control

### 👥 Participants
1. **Farmer** - End user who owns and manages fields
2. **Mobile App** - Flutter mobile application (UI layer)
3. **Backend Server** - Node.js/Express API (Business logic)
4. **Database** - MySQL database (Data persistence)
5. **IoT Sensor Device** - ESP32 with sensors (Hardware layer)
6. **Water Pump** - Irrigation pump controlled by relay

### 🔄 Workflow Phases

#### **Phase 1: Setup**
```
Farmer registers account → Creates field profiles → Registers IoT sensors
```
- User authentication and account creation
- Field information stored with GPS coordinates
- Sensor devices bound to specific fields

#### **Phase 2: Monitoring**
```
Sensors measure environmental data → Send to backend → Store in database → Check thresholds
```
- Continuous monitoring every 5-15 minutes
- Soil moisture, temperature, humidity readings
- Automatic threshold validation
- Alert creation if conditions are critical

#### **Phase 3: Auto Irrigation (Conditional)**
```
[IF moisture < threshold] → Backend triggers irrigation → Pump activated → Event logged
```
- Only executes when auto-irrigation is enabled
- Triggered by threshold violations
- Commands sent to IoT device
- All actions logged for history

#### **Phase 4: User Monitoring**
```
Farmer opens app → Requests latest data → Displays dashboard with readings and alerts
```
- Real-time data fetching
- Visual representation of field conditions
- Alert notifications displayed
- Quick access to field status

#### **Phase 5: Manual Control**
```
Farmer controls irrigation → Command sent to device → Pump responds → Confirmation shown
```
- Manual override capability
- Start/Stop irrigation on demand
- Real-time status feedback
- Activity logging

### 💡 Key Takeaways
- System operates autonomously while allowing manual control
- Every action is logged for audit and analysis
- Multi-layer architecture ensures separation of concerns
- Real-time synchronization between IoT devices and mobile app

---

## 2. User Registration

### 📖 Description
Shows the complete flow of new user account creation in the system.

### 🎯 Purpose
Demonstrates secure user registration with validation and JWT token generation.

### 👥 Participants
- **Farmer** - New user creating account
- **Mobile App** - Registration interface
- **Backend API** - Authentication service
- **Database** - User data storage

### 🔄 Flow Steps

1. **Farmer Initiates Registration**
   - Opens mobile app
   - Navigates to registration screen

2. **Data Entry**
   - Farmer enters: Name, Email, Phone, Password, City, Province
   - Client-side validation checks format

3. **API Request**
   ```
   POST /api/auth/register
   {
     "full_name": "Ahmed Ali",
     "email": "ahmed@example.com",
     "phone": "+923001234567",
     "password": "SecurePass123",
     "city": "Lahore",
     "province": "Punjab"
   }
   ```

4. **Backend Processing**
   - Validates all fields
   - Checks for duplicate email/phone
   - Hashes password using bcrypt
   - Creates user record in database

5. **JWT Token Generation**
   - Generates authentication token
   - Sets expiry (24 hours default)
   - Returns token to client

6. **Session Establishment**
   - App stores token securely
   - Redirects to dashboard
   - User is now authenticated

### 🔒 Security Features
- ✅ Password hashing with bcrypt (10 rounds)
- ✅ Input validation (email format, phone format)
- ✅ Duplicate prevention
- ✅ JWT token with expiration
- ✅ Secure token storage

### ⚠️ Error Handling
- Email already exists → 409 Conflict
- Invalid phone format → 400 Bad Request
- Weak password → 400 Bad Request
- Server error → 500 Internal Server Error

---

## 3. Sensor Data Flow & Alerts

### 📖 Description
Illustrates how IoT sensors collect and transmit data, how the backend processes it, and how alerts are generated and delivered to farmers.

### 🎯 Purpose
Shows the complete data pipeline from physical measurement to user notification.

### 👥 Participants
- **IoT Sensor** - Physical sensor (soil moisture, DHT11/22)
- **ESP32 Device** - Microcontroller managing sensors
- **Backend API** - Data processing service
- **Database** - Sensor readings and alerts storage
- **Alert System** - Alert generation and management
- **Mobile App** - Display and notification layer
- **Farmer** - End user receiving information

### 🔄 Flow Steps

#### **Data Collection Phase**
1. IoT sensors measure environmental parameters
2. ESP32 aggregates data from multiple sensors
3. Data formatted as JSON payload

#### **Data Transmission Phase**
```
POST /api/sensors/reading
{
  "device_id": "ESP32_001",
  "soil_moisture": 28,
  "temperature": 32,
  "humidity": 60,
  "battery_level": 85
}
```

#### **Backend Processing Phase**
1. Validate sensor device ID
2. Verify sensor is registered and active
3. Store reading in `sensor_readings` table
4. Execute threshold check logic

#### **Alert Generation Phase**
```javascript
if (soil_moisture < threshold) {
  createAlert({
    type: 'critical',
    title: 'Low Soil Moisture',
    message: 'Soil moisture is 28%, below threshold of 30%'
  });
}
```

#### **User Notification Phase**
1. Farmer opens app
2. App fetches latest readings and alerts
3. Dashboard displays:
   - Current sensor values
   - Alert badges
   - Visual indicators (color-coded)

### 📊 Data Storage
```sql
-- Sensor Reading
INSERT INTO sensor_readings 
(sensor_id, soil_moisture, temperature, humidity, timestamp)
VALUES (12, 28.0, 32.0, 60.0, NOW());

-- Alert Creation
INSERT INTO alerts 
(field_id, alert_type, title, message, severity, created_at)
VALUES (6, 'soil_moisture', 'Low Soil Moisture', 'Moisture at 28%', 'critical', NOW());
```

### 🔔 Alert Types
| Severity | Condition | Example |
|----------|-----------|---------|
| **Critical** | Immediate action needed | Moisture < 25% |
| **Warning** | Monitor situation | Moisture 25-30% |
| **Info** | General notification | Irrigation completed |

---

## 4. Manual Irrigation Control

### 📖 Description
Shows how farmers manually control irrigation systems through the mobile app.

### 🎯 Purpose
Demonstrates real-time control flow from user action to physical pump activation.

### 👥 Participants
- **Farmer** - User initiating control
- **Mobile App** - Control interface
- **Backend API** - Command processing
- **Database** - Logging service
- **ESP32 Device** - Actuator controller
- **Water Pump** - Physical irrigation pump

### 🔄 Flow Steps

#### **1. User Interaction**
```
Farmer navigates to Irrigation screen → Selects field → Clicks "Start Irrigation"
```

#### **2. API Request**
```
POST /api/irrigation/start
{
  "field_id": 6,
  "trigger_reason": "Manual irrigation by farmer"
}
```

#### **3. Backend Validation**
- Verify user authentication (JWT)
- Check field ownership (user owns field)
- Validate no irrigation already running
- Check sensor availability

#### **4. Database Logging**
```sql
INSERT INTO irrigation_logs 
(field_id, pump_status, start_time, trigger_type, triggered_by)
VALUES (6, 'on', NOW(), 'manual', 123);
```

#### **5. Device Command**
Backend sends command to ESP32:
```json
{
  "action": "START_PUMP",
  "field_id": 6,
  "duration": null  // Manual (no auto-stop)
}
```

#### **6. Hardware Activation**
- ESP32 receives command
- Activates relay module
- Relay powers water pump
- Pump starts delivering water

#### **7. Confirmation Flow**
- ESP32 confirms pump status
- Backend updates log status
- Mobile app receives success response
- User sees: "Pump Status: ON ✅"
- Timer starts showing duration

### 🎮 Control Options
- **Start Irrigation** - Activate pump
- **Stop Irrigation** - Deactivate pump
- **View Status** - Check current pump state
- **View History** - See past irrigation events

### ⏱️ Real-Time Updates
The app shows:
- Pump status (ON/OFF)
- Duration running (e.g., "00:05:32")
- Water usage estimate
- Field moisture level change

---

## 5. Automatic Irrigation Trigger

### 📖 Description
Demonstrates the autonomous operation where the system automatically triggers irrigation based on sensor thresholds.

### 🎯 Purpose
Shows how the system operates without human intervention to maintain optimal field conditions.

### 👥 Participants
- **IoT Sensor** - Monitoring device
- **Backend API** - Decision engine
- **Database** - State management
- **ESP32 Device** - Actuator controller
- **Water Pump** - Irrigation system
- **Mobile App** - Notification receiver
- **Farmer** - Informed user

### 🔄 Flow Steps

#### **1. Trigger Detection**
```
Sensor reading: soil_moisture = 28%
Threshold setting: 30%
Condition: 28% < 30% → TRUE
Auto-irrigation enabled: YES
→ TRIGGER IRRIGATION
```

#### **2. Automated Decision**
```javascript
// Backend logic
if (reading.soil_moisture < field.moisture_threshold && 
    field.auto_irrigation_enabled && 
    !isIrrigationActive(field_id)) {
  
  triggerAutoIrrigation(field_id);
}
```

#### **3. Irrigation Activation**
```sql
-- Create irrigation log
INSERT INTO irrigation_logs 
(field_id, pump_status, trigger_type, start_time)
VALUES (6, 'on', 'automatic', NOW());

-- Create informational alert
INSERT INTO alerts 
(field_id, alert_type, title, message, severity)
VALUES (6, 'irrigation', 'Auto Irrigation Started', 
        'Low moisture detected. Irrigation activated automatically.', 'info');
```

#### **4. Pump Control**
- Command sent to ESP32
- Pump activated via relay
- System monitors operation

#### **5. User Notification**
- Alert created in database
- Mobile app polls/receives notification
- Farmer sees: "Auto irrigation started for Field 6"

#### **6. Auto-Stop (Optional)**
If configured with smart stop:
```
Monitor moisture levels → When threshold reached → Auto-stop pump
```

### ⚙️ Configuration Settings
```javascript
{
  "field_id": 6,
  "auto_irrigation_enabled": true,
  "moisture_threshold": 30,  // Percentage
  "auto_stop_enabled": false,
  "max_duration": 3600  // Seconds (1 hour safety limit)
}
```

### 🛡️ Safety Features
- ✅ Prevents multiple simultaneous irrigation
- ✅ Maximum duration limit (prevents overwatering)
- ✅ Battery level check (ensures device has power)
- ✅ User notification for transparency
- ✅ Manual override always available

---

## 6. Crop Recommendations

### 📖 Description
Shows how the AI-powered crop recommendation system analyzes field conditions and provides intelligent planting suggestions.

### 🎯 Purpose
Demonstrates data-driven decision support for farmers to choose optimal crops.

### 👥 Participants
- **Farmer** - User seeking recommendations
- **Mobile App** - Interface for recommendations
- **Backend API** - Orchestration layer
- **Database** - Historical data source
- **AI Engine** - Machine learning recommendation engine

### 🔄 Flow Steps

#### **1. Request Initiation**
```
Farmer → Crop Recommendations screen → Selects Field
```

#### **2. Data Gathering**
Backend collects:
```javascript
// Field static data
{
  soil_type: "Loamy",
  area_size: 10,  // acres
  location: "Punjab",
  current_crop: "Wheat"
}

// Historical sensor data (last 30 days)
{
  avg_moisture: 45,
  avg_temperature: 28,
  avg_humidity: 65,
  rainfall_pattern: "moderate"
}
```

#### **3. AI Analysis**
```python
# ML model processes inputs
def recommend_crops(field_data, sensor_data, location):
    features = prepare_features(field_data, sensor_data)
    predictions = ml_model.predict(features)
    
    return [
        {
            "crop": "Rice",
            "confidence": 92,
            "expected_yield": 45,  # maunds/acre
            "water_requirement": 1500,  # mm
            "growth_duration": 120  # days
        },
        {
            "crop": "Cotton",
            "confidence": 85,
            "expected_yield": 30,
            "water_requirement": 800,
            "growth_duration": 180
        }
    ]
```

#### **4. Database Storage**
```sql
INSERT INTO crop_recommendations 
(field_id, crop_name, confidence_score, expected_yield, 
 water_requirement, growth_duration, created_at)
VALUES 
(6, 'Rice', 92, 45, 1500, 120, NOW()),
(6, 'Cotton', 85, 30, 800, 180, NOW());
```

#### **5. Result Display**
Mobile app shows:
```
┌─────────────────────────────────┐
│  Recommended Crops for Field 6  │
├─────────────────────────────────┤
│ 🌾 Rice                         │
│ Confidence: ████████░░ 92%      │
│ Yield: 45 maunds/acre           │
│ Water: 1500mm                   │
│ Duration: 120 days (4 months)   │
│ Best Planting: June             │
├─────────────────────────────────┤
│ 🌱 Cotton                       │
│ Confidence: ████████░░ 85%      │
│ ...                             │
└─────────────────────────────────┘
```

### 🧠 AI Model Factors
The recommendation engine considers:
1. **Soil Type** - Clay, Loamy, Sandy
2. **Climate Data** - Temperature, humidity patterns
3. **Water Availability** - Historical moisture levels
4. **Location** - Province, region-specific crops
5. **Season** - Current time of year
6. **Historical Success** - Past crop performance in area
7. **Market Demand** - Regional crop preferences

### 📊 Confidence Scoring
```
90-100%: Excellent match (Strongly recommended)
75-89%:  Good match (Recommended)
60-74%:  Fair match (Consider with caution)
<60%:    Poor match (Not recommended)
```

---

## 🔗 Integration Points

### API Endpoints Used

| Workflow | Endpoint | Method | Auth Required |
|----------|----------|--------|---------------|
| Registration | `/api/auth/register` | POST | No |
| Login | `/api/auth/login` | POST | No |
| Sensor Reading | `/api/sensors/reading` | POST | Yes (API Key) |
| Start Irrigation | `/api/irrigation/start` | POST | Yes (JWT) |
| Stop Irrigation | `/api/irrigation/stop` | POST | Yes (JWT) |
| Get Recommendations | `/api/crops/recommend` | GET | Yes (JWT) |
| Get Dashboard | `/api/dashboard/summary` | GET | Yes (JWT) |
| Get Alerts | `/api/alerts` | GET | Yes (JWT) |

### Database Tables Involved

| Table | Purpose | Key Fields |
|-------|---------|------------|
| `users` | User accounts | id, email, password_hash |
| `fields` | Field information | id, user_id, area, soil_type |
| `sensors` | Sensor devices | id, device_id, field_id, status |
| `sensor_readings` | Measurement data | sensor_id, moisture, temp, humidity |
| `irrigation_logs` | Irrigation history | field_id, pump_status, trigger_type |
| `alerts` | System alerts | field_id, type, severity, message |
| `crop_recommendations` | AI suggestions | field_id, crop_name, confidence |

---

## 📱 Mobile App Screens

### Screen Flow Mapping

```
Registration Screen ─────────────► User Registration SSD
   ↓
Login Screen ────────────────────► Authentication Flow
   ↓
Dashboard ───────────────────────► Complete System Workflow
   ├─► Fields Screen ────────────► Field Management
   ├─► Sensors Screen ───────────► Sensor Data Flow SSD
   ├─► Irrigation Screen ────────► Manual/Auto Irrigation SSDs
   ├─► Alerts Screen ────────────► Alert Flow
   └─► Recommendations Screen ───► Crop Recommendations SSD
```

---

## 💻 Implementation Technologies

### Communication Protocols
- **HTTP/HTTPS** - REST API communication
- **JSON** - Data format
- **JWT** - Authentication tokens
- **Future: MQTT** - Real-time IoT messaging
- **Future: WebSocket** - Live updates

### Data Flow Patterns
1. **Request-Response** - Modern app ↔ Backend
2. **Push** - IoT Device → Backend
3. **Pull** - Mobile App requests latest data
4. **Event-Driven** - Threshold triggers actions

---

## 🎯 Performance Considerations

### Response Time Targets
- Authentication: < 500ms
- Sensor data storage: < 200ms
- Dashboard load: < 1 second
- Irrigation command: < 2 seconds
- Crop recommendations: < 3 seconds

### Scalability
- Database indexed on frequently queried fields
- Sensor readings partitioned by date
- Alert system uses queues for processing
- API implements rate limiting

---

## 🔒 Security Measures

### Authentication & Authorization
- JWT tokens with expiration
- Role-based access control (RBAC)
- Field ownership validation
- API key for IoT devices

### Data Protection
- Passwords hashed with bcrypt
- HTTPS in production (recommended)
- Input validation and sanitization
- SQL injection prevention (parameterized queries)

---

## 📈 Monitoring & Logging

### What Gets Logged
✅ All user actions (audit trail)  
✅ Every sensor reading  
✅ All irrigation events  
✅ Alert generation  
✅ API requests and responses  
✅ Error conditions  

### Log Retention
- Sensor readings: 1 year
- Irrigation logs: Permanent
- Audit logs: 2 years
- Error logs: 6 months

---

## 🚀 Future Enhancements

### Planned Improvements
1. **WebSocket Integration** - Real-time updates without polling
2. **Push Notifications** - Mobile alerts via FCM/APNS
3. **Offline Mode** - Mobile app works without internet
4. **Advanced Analytics** - Predictive irrigation scheduling
5. **Weather Integration** - Forecast-based irrigation decisions
6. **Multi-sensor Support** - pH, NPK, light sensors
7. **Voice Commands** - "Start irrigation for wheat field"
8. **Image Analysis** - Crop disease detection via AI

---

## ✅ Validation Checklist

All sequence diagrams have been:
- ✅ Validated against actual API endpoints
- ✅ Verified with database schema
- ✅ Tested in development environment
- ✅ Reviewed for security best practices
- ✅ Optimized for performance
- ✅ Documented with clear explanations

---

**Document Version:** 1.0  
**Last Updated:** February 15, 2026  
**Status:** Complete ✅  
**Related Documents:**
- [Use Case Diagram](./USE_CASE_DIAGRAM.md)
- [Project Guide](./PROJECT_GUIDE.md)
- [Database Schema](./Database/smart_agriculture.sql)
- [API Documentation](./Backend/README.md)

---

## 📞 Support

For questions about these sequence diagrams or system architecture:
- Review the [Project Guide](./PROJECT_GUIDE.md)
- Check the [Sync Verification Document](./SYNC_VERIFICATION.md)
- Refer to Backend and Frontend README files

---

*These diagrams represent the current implementation. For the latest updates, always refer to the actual codebase.*
