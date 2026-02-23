# 🌾 Smart Agriculture IoT System - Use Case Diagram Documentation

## 📋 Overview

This document provides a complete breakdown of all use cases in the Smart Agriculture IoT System. The system supports three main actors: **Farmer**, **Admin**, and **IoT Sensor Device**.

---

## 👥 Actors

### 1. **Farmer** (Primary User)
- The main end-user who manages agricultural fields
- Monitors sensor data and controls irrigation
- Receives alerts and recommendations
- Makes data-driven farming decisions

### 2. **Admin** (System Administrator)
- Manages system users and permissions
- Monitors overall system health
- Configures global settings
- Reviews audit logs and system metrics

### 3. **IoT Sensor Device** (Automated Actor)
- ESP32-based hardware deployed in fields
- Collects environmental data (soil moisture, temperature, humidity)
- Sends readings to the backend system
- Reports battery and operational status

---

## 🎯 Use Cases by Functional Group

### 📱 **GROUP 1: USER MANAGEMENT**

#### UC-01: Register Account
- **Actor:** Farmer, Admin
- **Description:** New users create an account to access the system
- **Preconditions:** None
- **Main Flow:**
  1. User opens mobile app
  2. Clicks "Register"
  3. Provides full name, email, phone, password, location
  4. System validates input
  5. Account is created
- **Postconditions:** User can login to the system

#### UC-02: Login
- **Actor:** Farmer, Admin
- **Description:** Authenticate and access the system
- **Preconditions:** User has registered account
- **Main Flow:**
  1. User enters email/phone and password
  2. System validates credentials
  3. JWT token is generated
  4. User is redirected to dashboard
- **Postconditions:** User session is active
- **Note:** This is **included** in most other use cases (authentication required)

#### UC-03: Manage Profile
- **Actor:** Farmer, Admin
- **Description:** View and update personal information
- **Preconditions:** User is logged in
- **Main Flow:**
  1. Navigate to profile section
  2. View current details
  3. Edit information (name, phone, city, etc.)
  4. Save changes
- **Postconditions:** Profile is updated

#### UC-04: Logout
- **Actor:** Farmer, Admin
- **Description:** End the current session
- **Preconditions:** User is logged in
- **Main Flow:**
  1. Click logout button
  2. Session token is invalidated
  3. User redirected to login screen
- **Postconditions:** Session ends

---

### 🌾 **GROUP 2: FIELD MANAGEMENT**

#### UC-05: Add Field
- **Actor:** Farmer
- **Description:** Register a new agricultural field
- **Preconditions:** User is logged in
- **Main Flow:**
  1. Navigate to Fields section
  2. Click "Add Field"
  3. Enter field details (name, area, soil type, crop, planting date)
  4. Optionally add GPS coordinates
  5. Save field
- **Postconditions:** New field is created and linked to user

#### UC-06: View Fields
- **Actor:** Farmer
- **Description:** Display list of all registered fields
- **Preconditions:** User is logged in
- **Main Flow:**
  1. Open Fields tab
  2. System displays all user's fields
  3. Shows field status, crop, area, sensor count
- **Postconditions:** User sees field overview

#### UC-07: Edit Field Details
- **Actor:** Farmer
- **Description:** Modify existing field information
- **Preconditions:** Field exists, user is owner
- **Main Flow:**
  1. Select a field
  2. Click edit option
  3. Update field information
  4. Save changes
- **Postconditions:** Field details are updated

#### UC-08: Delete Field
- **Actor:** Farmer
- **Description:** Remove a field from the system
- **Preconditions:** Field exists, user is owner
- **Main Flow:**
  1. Select field to delete
  2. Confirm deletion
  3. System removes field and associated data
- **Postconditions:** Field is permanently deleted

#### UC-09: Track Field Location
- **Actor:** Farmer
- **Description:** View field location on map
- **Preconditions:** Field has GPS coordinates
- **Main Flow:**
  1. Select field
  2. View location on map
  3. Optional: Update coordinates
- **Postconditions:** Location is displayed

---

### 📡 **GROUP 3: SENSOR MANAGEMENT**

#### UC-10: Register Sensor
- **Actor:** Farmer
- **Description:** Add a new IoT sensor to a field
- **Preconditions:** User is logged in, field exists
- **Main Flow:**
  1. Navigate to Sensors section
  2. Click "Add Sensor"
  3. Enter sensor device ID
  4. Select field to bind sensor
  5. Configure sensor settings
  6. Save sensor
- **Postconditions:** Sensor is active and monitoring field

#### UC-11: View Sensor Readings
- **Actor:** Farmer
- **Description:** Display current and real-time sensor data
- **Preconditions:** Sensor is registered and active
- **Main Flow:**
  1. Select a field or sensor
  2. View latest readings (soil moisture, temperature, humidity)
  3. See timestamp of last reading
- **Postconditions:** User understands current field conditions

#### UC-12: Monitor Sensor Status
- **Actor:** Farmer
- **Description:** Check operational status of sensors
- **Preconditions:** Sensor exists
- **Main Flow:**
  1. View sensor list
  2. Check status indicators (active, offline, error)
  3. View last communication time
- **Postconditions:** User knows sensor health

#### UC-13: View Historical Data
- **Actor:** Farmer
- **Description:** Access past sensor readings and trends
- **Preconditions:** Sensor has recorded data
- **Main Flow:**
  1. Select sensor or field
  2. Choose date range
  3. View data in graphs/tables
  4. Analyze trends
- **Postconditions:** User sees historical patterns

#### UC-14: Check Battery Level
- **Actor:** Farmer
- **Description:** Monitor battery status of IoT devices
- **Preconditions:** Sensor reports battery data
- **Main Flow:**
  1. View sensor details
  2. Check battery percentage
  3. Receive low battery alerts
- **Postconditions:** User knows when to replace/charge battery

---

### 💧 **GROUP 4: IRRIGATION CONTROL**

#### UC-15: Manual Irrigation Control (Start/Stop)
- **Actor:** Farmer
- **Description:** Manually control water pump
- **Preconditions:** User is logged in, field has irrigation system
- **Main Flow:**
  1. Navigate to Irrigation section
  2. Select field
  3. Click "Start Irrigation" or "Stop Irrigation"
  4. System sends command to IoT device
  5. Pump status updates
- **Postconditions:** Irrigation is started/stopped, log is created

#### UC-16: Enable Auto Irrigation
- **Actor:** Farmer
- **Description:** Activate automatic irrigation based on thresholds
- **Preconditions:** Field has sensors and irrigation system
- **Main Flow:**
  1. Go to irrigation settings
  2. Enable auto-irrigation mode
  3. Set soil moisture threshold (e.g., 30%)
  4. System monitors and triggers irrigation automatically
- **Postconditions:** System manages irrigation autonomously
- **Note:** This **extends** Manual Irrigation Control

#### UC-17: Schedule Irrigation
- **Actor:** Farmer
- **Description:** Set timed irrigation schedules
- **Preconditions:** Irrigation system is configured
- **Main Flow:**
  1. Open schedule settings
  2. Set irrigation times (e.g., daily at 6 AM)
  3. Set duration
  4. Save schedule
- **Postconditions:** Irrigation runs on schedule
- **Note:** This **extends** Manual Irrigation Control

#### UC-18: View Irrigation History
- **Actor:** Farmer
- **Description:** Review past irrigation activities
- **Preconditions:** Irrigation logs exist
- **Main Flow:**
  1. Navigate to Irrigation History
  2. View log entries
  3. See start time, duration, water used, trigger reason
- **Postconditions:** User understands irrigation patterns

#### UC-19: Track Water Usage
- **Actor:** Farmer
- **Description:** Monitor total water consumption
- **Preconditions:** System tracks irrigation
- **Main Flow:**
  1. View water usage dashboard
  2. See total liters used
  3. Compare with previous periods
  4. View water savings metrics
- **Postconditions:** User knows water efficiency

---

### 🔔 **GROUP 5: ALERT SYSTEM**

#### UC-20: View Alerts
- **Actor:** Farmer
- **Description:** Display system alerts and notifications
- **Preconditions:** User is logged in
- **Main Flow:**
  1. Open Alerts section
  2. View unread alerts (critical, warning, info)
  3. Read alert details
- **Postconditions:** User is informed of system events
- **Note:** This **includes** Configure Alert Thresholds

#### UC-21: Acknowledge Alerts
- **Actor:** Farmer
- **Description:** Mark alerts as read/resolved
- **Preconditions:** Alerts exist
- **Main Flow:**
  1. Select alert
  2. Mark as acknowledged
  3. Alert moves to archive
- **Postconditions:** Alert is no longer pending

#### UC-22: Configure Alert Thresholds
- **Actor:** Farmer
- **Description:** Set custom alert triggers
- **Preconditions:** Field and sensors exist
- **Main Flow:**
  1. Go to alert settings
  2. Set thresholds (e.g., soil moisture < 30%, temperature > 35°C)
  3. Choose alert severity
  4. Save settings
- **Postconditions:** System triggers alerts based on thresholds

#### UC-23: Receive Critical Notifications
- **Actor:** Farmer
- **Description:** Get immediate notifications for urgent issues
- **Preconditions:** Critical threshold is breached
- **Main Flow:**
  1. System detects critical condition
  2. Creates critical alert
  3. Notification sent to app (future: push notifications)
  4. User receives alert
- **Postconditions:** User can take immediate action

---

### 🌱 **GROUP 6: CROP MANAGEMENT**

#### UC-24: Get Crop Recommendations
- **Actor:** Farmer
- **Description:** Receive AI-powered crop suggestions
- **Preconditions:** Field has sensor data
- **Main Flow:**
  1. Select field
  2. Request crop recommendations
  3. System analyzes soil, climate, location
  4. Displays recommended crops with confidence scores
- **Postconditions:** User gets planting suggestions
- **Note:** This **includes** View Field Details

#### UC-25: View Yield Predictions
- **Actor:** Farmer
- **Description:** See expected crop yield estimates
- **Preconditions:** Crop is planted, data available
- **Main Flow:**
  1. Select field with active crop
  2. View yield predictions
  3. See expected quantity per acre
- **Postconditions:** User plans for harvest

#### UC-26: Check Water Requirements
- **Actor:** Farmer
- **Description:** Understand crop-specific water needs
- **Preconditions:** Crop is selected
- **Main Flow:**
  1. View crop details
  2. See recommended watering schedule
  3. View daily/weekly water requirements
- **Postconditions:** User optimizes irrigation

#### UC-27: Track Growth Progress
- **Actor:** Farmer
- **Description:** Monitor crop development stages
- **Preconditions:** Planting date is recorded
- **Main Flow:**
  1. View field dashboard
  2. See days since planting
  3. View expected harvest date
  4. Track growth milestones
- **Postconditions:** User knows crop timeline

---

### 📊 **GROUP 7: DASHBOARD & ANALYTICS**

#### UC-28: View Dashboard
- **Actor:** Farmer
- **Description:** See overview of all fields and activities
- **Preconditions:** User is logged in
- **Main Flow:**
  1. Open app (dashboard is home screen)
  2. View summary cards (fields, sensors, alerts)
  3. See recent activities
  4. Access quick actions
- **Postconditions:** User has system overview

#### UC-29: View Statistics
- **Actor:** Farmer
- **Description:** Access detailed analytics and metrics
- **Preconditions:** System has collected data
- **Main Flow:**
  1. Navigate to Statistics section
  2. View graphs and charts
  3. See trends over time
  4. Compare periods
- **Postconditions:** User makes data-driven decisions

#### UC-30: Monitor Field Conditions
- **Actor:** Farmer
- **Description:** Real-time monitoring of environmental conditions
- **Preconditions:** Sensors are active
- **Main Flow:**
  1. Select field
  2. View current conditions
  3. See color-coded status indicators
  4. Identify issues
- **Postconditions:** User knows field health

#### UC-31: View Water Savings
- **Actor:** Farmer
- **Description:** Track water conservation metrics
- **Preconditions:** System has irrigation data
- **Main Flow:**
  1. View analytics dashboard
  2. See water savings percentage
  3. Compare with traditional methods
  4. View liters saved
- **Postconditions:** User sees efficiency gains

---

### ⚙️ **GROUP 8: ADMIN FUNCTIONS**

#### UC-32: Manage Users
- **Actor:** Admin
- **Description:** Administer user accounts
- **Preconditions:** Admin is logged in
- **Main Flow:**
  1. Access admin panel
  2. View all users
  3. Edit user details, roles, status
  4. Deactivate/activate accounts
- **Postconditions:** User accounts are managed

#### UC-33: System Monitoring
- **Actor:** Admin
- **Description:** Monitor system health and performance
- **Preconditions:** Admin access
- **Main Flow:**
  1. View system dashboard
  2. Check server status, database health
  3. Monitor API performance
  4. View active connections
- **Postconditions:** Admin knows system status

#### UC-34: View Audit Logs
- **Actor:** Admin
- **Description:** Review system activity logs
- **Preconditions:** Admin access
- **Main Flow:**
  1. Access audit logs
  2. Filter by user, action, date
  3. Review activities
  4. Export logs if needed
- **Postconditions:** Admin has activity history

#### UC-35: Configure Global Settings
- **Actor:** Admin
- **Description:** Set system-wide configurations
- **Preconditions:** Admin access
- **Main Flow:**
  1. Open settings panel
  2. Configure parameters (default thresholds, alert types, etc.)
  3. Set system limits
  4. Save configurations
- **Postconditions:** System operates with new settings

---

### 🤖 **GROUP 9: IOT DEVICE OPERATIONS**

#### UC-36: Send Sensor Readings
- **Actor:** IoT Sensor Device
- **Description:** Transmit environmental data to backend
- **Preconditions:** Device is powered and connected
- **Main Flow:**
  1. Sensor measures soil moisture, temperature, humidity
  2. ESP32 formats data
  3. Sends POST request to API
  4. Backend stores data
  5. Checks thresholds and creates alerts if needed
- **Postconditions:** Latest reading is available in system

#### UC-37: Update Status
- **Actor:** IoT Sensor Device
- **Description:** Report device operational status
- **Preconditions:** Device is online
- **Main Flow:**
  1. Device sends heartbeat signal
  2. Reports status (active, error, maintenance)
  3. Backend updates sensor record
- **Postconditions:** System knows device health

#### UC-38: Report Battery Level
- **Actor:** IoT Sensor Device
- **Description:** Communicate battery status
- **Preconditions:** Device has battery monitoring
- **Main Flow:**
  1. Device measures battery voltage
  2. Calculates percentage
  3. Sends battery level with readings
  4. System creates alert if below threshold
- **Postconditions:** User can plan maintenance

---

## 🔗 Relationship Summary

### **<<include>> Relationships** (One use case always requires another)
- Most authenticated use cases **include** "Login"
- "View Alerts" **includes** "Configure Alert Thresholds"
- "Get Crop Recommendations" **includes** "View Field Details"

### **<<extend>> Relationships** (Optional enhancement of base use case)
- "Enable Auto Irrigation" **extends** "Manual Irrigation Control"
- "Schedule Irrigation" **extends** "Manual Irrigation Control"
- "Acknowledge Alerts" **extends** "View Alerts"

---

## 📈 Use Case Priorities

### **High Priority (MVP)**
- ✅ UC-01 to UC-04: User Management
- ✅ UC-05 to UC-09: Field Management
- ✅ UC-10 to UC-14: Sensor Management
- ✅ UC-15, UC-16, UC-18: Core Irrigation
- ✅ UC-20 to UC-22: Alert System
- ✅ UC-28, UC-30: Dashboard

### **Medium Priority (Phase 2)**
- 🔶 UC-17: Schedule Irrigation
- 🔶 UC-24 to UC-27: Crop Management
- 🔶 UC-29, UC-31: Advanced Analytics
- 🔶 UC-32 to UC-35: Admin Functions

### **Future Enhancements**
- 🔮 Push notifications for UC-23
- 🔮 Weather integration
- 🔮 Offline mode
- 🔮 Voice commands
- 🔮 Dark mode

---

## 💡 Implementation Notes

### **Security Considerations**
- All user interactions require JWT authentication (except registration)
- Admin functions have additional role-based access control
- IoT device communications should use API keys or tokens

### **Performance Considerations**
- Sensor readings should be throttled (every 5-15 minutes)
- Real-time updates can use WebSocket connections (future)
- Historical data queries should be paginated
- Dashboard should cache frequently accessed data

### **Scalability**
- System supports multiple fields per user
- Each field can have multiple sensors
- Supports concurrent irrigation operations
- Database is optimized for thousands of readings

---

## 📝 Use Case Traceability

Each use case maps to specific system components:

| Use Case Group | Backend Routes | Database Tables | Mobile Screens |
|----------------|----------------|-----------------|----------------|
| User Management | `/api/auth/*` | `users` | Login, Register, Profile |
| Field Management | `/api/fields/*` | `fields` | Fields List, Field Details |
| Sensor Management | `/api/sensors/*` | `sensors`, `sensor_readings` | Sensors, Readings |
| Irrigation | `/api/irrigation/*` | `irrigation_logs` | Irrigation Control |
| Alerts | `/api/alerts/*` | `alerts` | Alerts List |
| Crop Management | `/api/crops/*` | `crop_recommendations` | Crop Recommendations |
| Dashboard | `/api/dashboard/*` | All tables | Dashboard Screen |
| Admin | `/api/admin/*` | All tables | Admin Panel |

---

## ✅ Use Case Validation

All use cases have been:
- ✅ Validated against project requirements
- ✅ Verified with database schema
- ✅ Matched with API endpoints
- ✅ Confirmed with mobile app screens
- ✅ Aligned with IoT device capabilities

---

**Document Version:** 1.0  
**Last Updated:** February 15, 2026  
**Status:** Complete ✅

---

*For detailed technical specifications, refer to:*
- [API Documentation](./API_DOCUMENTATION.md)
- [Database Schema](./Database/README.md)
- [Project Guide](./PROJECT_GUIDE.md)
- [System Architecture](./SYNC_VERIFICATION.md)
