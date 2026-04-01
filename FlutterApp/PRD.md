# 📱 Product Requirements Document (PRD)
# Smart Agriculture Flutter App — v2.0

> **Classification:** Internal Development Document  
> **Product:** Smart AI-Powered Agriculture Mobile Application  
> **Platform:** Flutter (Android & iOS)  
> **Version:** 2.0 (Complete Rebuild)  
> **Date:** April 2, 2026  
> **Status:** Draft → Active Development  

---

## 📖 Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Product Vision & Goals](#2-product-vision--goals)
3. [Target Users & Personas](#3-target-users--personas)
4. [System Context](#4-system-context)
5. [Tech Stack & Architecture](#5-tech-stack--architecture)
6. [Feature Requirements](#6-feature-requirements)
   - [F-01 Onboarding & Authentication](#f-01-onboarding--authentication)
   - [F-02 Dashboard](#f-02-dashboard)
   - [F-03 Field Management](#f-03-field-management)
   - [F-04 Sensor Monitoring](#f-04-sensor-monitoring)
   - [F-05 Irrigation Control](#f-05-irrigation-control)
   - [F-06 Alerts & Notifications](#f-06-alerts--notifications)
   - [F-07 AI Crop Recommendations](#f-07-ai-crop-recommendations)
   - [F-08 Weather Integration](#f-08-weather-integration)
   - [F-09 Analytics & Reports](#f-09-analytics--reports)
   - [F-10 Profile & Settings](#f-10-profile--settings)
   - [F-11 Admin Panel](#f-11-admin-panel)
   - [F-12 Offline Mode](#f-12-offline-mode)
7. [API Integration Reference](#7-api-integration-reference)
8. [Data Models](#8-data-models)
9. [UI/UX Design System](#9-uiux-design-system)
10. [Screen Inventory & Navigation](#10-screen-inventory--navigation)
11. [Non-Functional Requirements](#11-non-functional-requirements)
12. [Security Requirements](#12-security-requirements)
13. [Testing Requirements](#13-testing-requirements)
14. [Release Plan & Milestones](#14-release-plan--milestones)
15. [Open Issues & Decisions](#15-open-issues--decisions)

---

## 1. Executive Summary

The **Smart Agriculture Flutter App v2.0** is a complete ground-up rebuild of the existing mobile application for the Smart Agriculture IoT System. The v1.0 app has a solid functional foundation (85% feature complete) but lacks real-time updates, offline support, push notifications, maps integration, automated tests, and a modern premium UI.

This PRD defines all requirements for rebuilding the app with:
- A **premium, modern UI** (dark mode, glassmorphism, animations)
- **Real-time data** via Socket.IO WebSocket integration
- **Push notifications** via Firebase Cloud Messaging (FCM)
- **Offline-first** architecture using local SQLite/Hive database
- **Google Maps** for GPS field location management
- **Complete test coverage** (unit, widget, integration)
- **Urdu language** support

The backend (Node.js + MySQL) and ESP32 firmware remain unchanged. This is a **Flutter-only rebuild**.

---

## 2. Product Vision & Goals

### 2.1 Vision Statement

> *"An intelligent farming companion in every Pakistani farmer's pocket — empowering them with real-time field intelligence, automated irrigation, and AI-driven decisions, even without an internet connection."*

### 2.2 Product Goals

| # | Goal | Metric |
|---|------|--------|
| G-1 | Improve farmer engagement with daily active use | DAU/MAU ≥ 60% |
| G-2 | Reduce farmer response time to critical alerts | Alert → Action ≤ 5 minutes |
| G-3 | Support offline usage in low-connectivity areas | Offline reads available 100% of the time |
| G-4 | Deliver real-time sensor data with minimal latency | Socket.IO update ≤ 3 seconds |
| G-5 | Achieve production-grade code quality | Test coverage ≥ 80% |
| G-6 | Support Urdu-speaking users | Full Urdu UI available |

### 2.3 Success Metrics

- **App Store Rating:** ≥ 4.5 stars
- **Crash Rate:** < 0.5%
- **App Startup Time:** < 1.5 seconds (cold start)
- **API Response Rendering:** < 300ms perceived latency
- **APK Release Size:** < 25 MB

---

## 3. Target Users & Personas

### 3.1 Primary Persona — The Smallholder Farmer

> **Ahmed Ali, 42, Gujranwala**

- Manages 10 acres of wheat
- Basic smartphone literacy (WhatsApp, camera)
- Prefers Urdu UI
- Unreliable 4G connectivity in the field
- Needs simple, icon-driven navigation
- **Pain point:** Has to physically visit field to check irrigation status

**Needs from the app:**
- Large text, high contrast UI
- Simple one-tap irrigation control
- Voice-friendly alert system
- Works offline in the field

---

### 3.2 Secondary Persona — The Multi-Field Farm Manager

> **Fatima Hussain, 35, Nawabshah**

- Manages 3 fields (25 acres), rice & cotton
- Tech-savvy, uses mobile banking and apps daily
- English + Urdu bilingual
- Has stable WiFi at home, 4G in fields

**Needs from the app:**
- Field-by-field comparison dashboard
- Detailed charts and trend analysis
- Scheduled irrigation management
- Data export for planning

---

### 3.3 Tertiary Persona — The System Admin / Technician

> **Bilal Raza, 28, Lahore**

- Manages the smart agriculture system for multiple clients
- Technical background, monitors system health
- Needs admin-level access across all users

**Needs from the app:**
- Admin dashboard with all users/fields
- Sensor health monitoring system-wide
- Audit logs and system settings

---

## 4. System Context

The Flutter app is one of **four components** in the Smart Agriculture ecosystem:

```
┌──────────────────────────────────────────────────────┐
│                 SMART AGRICULTURE SYSTEM             │
│                                                      │
│  ┌──────────────┐      ┌──────────────────────────┐  │
│  │  ESP32 +     │─────▶│   Node.js Backend API    │  │
│  │  Sensors     │      │   (Express + Socket.IO)  │  │
│  │  (IoT Layer) │      │   Port: 5000             │  │
│  └──────────────┘      └────────────┬─────────────┘  │
│                                     │                 │
│                          ┌──────────▼──────────────┐  │
│                          │   MySQL Database         │  │
│                          │   (11 Tables)            │  │
│                          └──────────────────────────┘  │
│                                     │                 │
│                          ┌──────────▼──────────────┐  │
│                          │  Flutter Mobile App v2   │  │ ← This PRD
│                          │  (Android + iOS)         │  │
│                          └──────────────────────────┘  │
└──────────────────────────────────────────────────────┘
```

### 4.1 Backend API Base URL
- **Development:** `http://10.0.2.2:5000/api` (Android Emulator)
- **Local Device:** `http://<computer-ip>:5000/api`
- **Production:** `https://api.smartagri.pk/api` (planned)

### 4.2 WebSocket URL
- **Development:** `http://10.0.2.2:5000`
- **Production:** `wss://api.smartagri.pk`

### 4.3 Database Tables (Backend-owned, read via API)
`users`, `fields`, `sensors`, `sensor_readings`, `irrigation_logs`, `irrigation_schedules`, `crop_recommendations`, `alerts`, `weather_data`, `system_settings`, `audit_logs`

---

## 5. Tech Stack & Architecture

### 5.1 Core Stack

| Layer | Technology | Version | Rationale |
|-------|-----------|---------|-----------|
| Framework | Flutter | ≥ 3.19.0 | Cross-platform, performance |
| Language | Dart | ≥ 3.3.0 | Null-safe, modern |
| State Management | **Riverpod** | ≥ 2.5.0 | Superior to Provider: compile-safe, testable |
| Navigation | **GoRouter** | ≥ 14.0.0 | Declarative routing, deep links |
| HTTP Client | Dio | ≥ 5.4.3 | Interceptors, cancellation, retry |
| WebSocket | **socket_io_client** | ≥ 2.0.3 | Real-time sensor data |
| Local DB | **Isar** | ≥ 3.1.0 | Fast NoSQL for offline mode |
| Notifications | **firebase_messaging** | ≥ 15.0.0 | FCM push notifications |
| Maps | **google_maps_flutter** | ≥ 2.7.0 | Field GPS visualization |
| Charts | **fl_chart** | ≥ 0.71.0 | Sensor data charts |
| Auth Storage | **flutter_secure_storage** | ≥ 9.0.0 | Encrypted JWT storage |
| Localization | **flutter_localizations** | SDK | English + Urdu support |
| Image | **image_picker** | ≥ 1.1.0 | Profile & field photos |
| Connectivity | **connectivity_plus** | ≥ 6.0.0 | Offline detection |
| Animations | **lottie** | ≥ 3.1.2 | Rich loading animations |
| UI Polish | **shimmer** | ≥ 3.0.0 | Loading skeletons |
| Fonts | **google_fonts** | ≥ 6.2.0 | Inter + Noto Nastaliq (Urdu) |

### 5.2 Architecture Pattern: Clean Architecture + Riverpod

```
lib/
├── core/
│   ├── constants/         # App-wide constants, API URLs
│   ├── errors/            # Failure classes, exceptions
│   ├── network/           # Dio client, interceptors, socket
│   ├── theme/             # AppTheme, ColorScheme, Typography
│   ├── utils/             # Helpers, extensions, formatters
│   └── router/            # GoRouter configuration
│
├── features/              # Feature-first folder structure
│   ├── auth/
│   │   ├── data/          # AuthRepository, AuthRemoteDataSource
│   │   ├── domain/        # AuthEntity, IAuthRepository, UseCases
│   │   └── presentation/  # Screens, Widgets, Notifiers
│   ├── dashboard/
│   ├── fields/
│   ├── sensors/
│   ├── irrigation/
│   ├── alerts/
│   ├── recommendations/
│   ├── weather/
│   ├── analytics/
│   ├── profile/
│   └── admin/
│
├── shared/
│   ├── widgets/           # Reusable UI components
│   ├── models/            # Shared data models
│   └── providers/         # App-level providers
│
└── main.dart
```

### 5.3 State Management (Riverpod)

All features use the **Notifier + AsyncNotifier** pattern:
- `AsyncNotifierProvider` for async data with loading/error/data states
- `StreamNotifierProvider` for real-time socket streams
- `StateProvider` for simple UI state (toggles, tabs)
- `FutureProvider` for one-shot reads

---

## 6. Feature Requirements

---

### F-01: Onboarding & Authentication

#### F-01.1 Splash Screen
- Display app logo with agricultural animation (Lottie)
- Check stored JWT token validity
- Auto-navigate: if token valid → Home; if invalid → Onboarding
- Duration: max 2 seconds

#### F-01.2 Onboarding Carousel (First Launch Only)
- 3 slides with animated illustrations:
  1. **"Monitor Your Fields"** — sensor data visualization
  2. **"Smart Irrigation"** — auto pump control
  3. **"AI Recommendations"** — crop suggestions
- Skip button on all slides
- Language selector (English / اردو) on slide 1
- "Get Started" CTA on last slide
- Stores `onboarding_complete` flag in local prefs

#### F-01.3 Login Screen

**Fields:**
| Field | Type | Validation |
|-------|------|-----------|
| Email | TextInput (email keyboard) | Required, valid email format |
| Password | TextInput (obscured) | Required, min 8 chars |
| Remember Me | Checkbox | Optional |

**Actions:**
- Login button → calls `POST /api/auth/login`
- "Forgot Password" → TODO (out of scope for v2.0)
- "Create Account" → navigates to Register

**Behaviors:**
- Shows loading spinner during API call
- Show SnackBar on error with specific backend message
- On success: store JWT in `flutter_secure_storage`, navigate to `/home`
- Show/hide password toggle icon
- Form validation before API call

#### F-01.4 Register Screen

**Fields:**
| Field | Type | Validation |
|-------|------|-----------|
| Full Name | TextInput | Required, min 3 chars |
| Email | TextInput | Required, valid email |
| Phone | TextInput (phone keyboard) | Required, Pakistan format (+92XXXXXXXXXX) |
| City | TextInput | Required |
| Province | DropdownButton | Required — Punjab, Sindh, KPK, Balochistan, etc. |
| Password | TextInput (obscured) | Required, min 8 chars, 1 uppercase, 1 number |
| Confirm Password | TextInput (obscured) | Must match Password |
| Terms checkbox | Checkbox | Must be checked |

**Actions:**
- Register → calls `POST /api/auth/register`
- "Already have account" → navigate to Login

#### F-01.5 JWT Token Management
- Store JWT in `flutter_secure_storage` (encrypted, not SharedPreferences)
- Inject token in all API requests via Dio `AuthInterceptor`
- On 401 response: clear token, navigate to Login (auto-logout)
- Token expiry: handled by backend (24h), no refresh required for v2.0

---

### F-02: Dashboard

The home screen — the first screen after login. Shows a comprehensive overview.

#### F-02.1 Header
- Greeting: "Good morning, Ahmed 👋" (time-based)
- Current date in Pakistani format
- Unread alerts badge (top right)
- Avatar icon → Profile screen

#### F-02.2 Stat Cards (Horizontal Scroll)
Four animated gradient stat cards:

| Card | Data Source | Icon |
|------|------------|------|
| 🌾 Total Fields | `dashboard.total_fields` | Fields icon |
| 📡 Active Sensors | `dashboard.active_sensors` | Sensor icon |
| 🚨 Unread Alerts | `alerts.unread_count` | Bell icon |
| 💧 Water Saved (L) | `dashboard.water_saved` | Water drop icon |

Card design: gradient background, animated counter on load, tap → navigate to respective screen.

#### F-02.3 Live Sensor Overview (Real-time via Socket.IO)
Displays latest readings from the most recently active field:

| Metric | Icon | Unit | Color Coding |
|--------|------|------|-------------|
| Soil Moisture | 🌱 | % | Green ≥ 40%, Yellow 20-40%, Red < 20% |
| Temperature | 🌡️ | °C | Green < 35°C, Yellow 35-40°C, Red > 40°C |
| Humidity | 💧 | % | Normal range 40-80% |
| Light Level | ☀️ | Lux | Daytime / Night indicator |
| Rain Status | 🌧️ | Boolean | Raining / No Rain badge |

- Updates in real-time via WebSocket `sensor_reading` event
- Fallback: manual refresh if WebSocket disconnected
- "Last updated: X seconds ago" timestamp

#### F-02.4 Quick Actions Row
Four action buttons:

| Button | Action |
|--------|--------|
| ➕ Add Field | Navigate to Add Field screen |
| 💧 Irrigate | Navigate to Irrigation Control |
| 📊 Analytics | Navigate to Analytics screen |
| 🤖 AI Advice | Navigate to Recommendations screen |

#### F-02.5 Recent Activity Feed
Last 5 events from `GET /api/dashboard/activity`:
- Alert triggered
- Irrigation started/stopped
- Recommendation accepted
- Sensor went offline
- Each item: icon, description, time ago

#### F-02.6 Irrigation Status Banner
If any field has active irrigation:
- Show animated banner: "💧 Irrigation Active — Field: [name] · Duration: 00:12:34"
- Tap → navigate to irrigation screen
- Banner pulses with animation

---

### F-03: Field Management

#### F-03.1 Fields List Screen

**Layout:** Switchable between Grid (default) and List view  
**Data:** `GET /api/fields`

Each field card shows:
- Field name (bold)
- Current crop + icon
- Area size (acres/hectares)
- Sensor count badge
- Active irrigation indicator (blue animated dot)
- Last reading time
- Soil moisture mini progress bar

**Actions:**
- Pull-to-refresh
- FAB → Add new field
- Tap card → Field Detail screen
- Long press → Quick actions (Edit, Delete) bottom sheet
- Empty state: illustration + "Add your first field" CTA

#### F-03.2 Field Detail Screen

**Tabbed interface with 4 tabs:**

**Tab 1: Overview**
- Field name, location (map snippet if GPS available)
- Crop type, soil type, planting date, expected harvest
- Area size with unit
- Current conditions (soil moisture, temp, humidity)
- Field status (Active / Inactive toggle)

**Tab 2: Sensors**
- List of all sensors for this field
- Per sensor: type, device ID, status (online/offline), battery %, last reading
- "Add Sensor" button → Sensor Binding flow
- Swipe sensor card → Unbind sensor

**Tab 3: Irrigation**
- Current pump status (ON/OFF with animation)
- Manual Start/Stop buttons
- Today's irrigation duration & water used
- Irrigation log timeline (last 7 days)
- Active schedules list
- "Add Schedule" button

**Tab 4: History**
- Combined activity timeline
- Filter: All / Irrigation / Alerts / Sensor Events
- Date range picker
- Paginated (20 items per page)

#### F-03.3 Add / Edit Field Screen

**Form fields:**
| Field | Type | Validation |
|-------|------|-----------|
| Field Name | TextInput | Required, max 100 chars |
| Location (GPS) | MapPicker or manual Lat/Long | Optional |
| Area Size | NumberInput | Required, > 0 |
| Area Unit | Dropdown (Acres / Hectares / Sq. Meters) | Required |
| Soil Type | Dropdown (Clay, Sandy, Loamy, Silt, Peaty, Chalky) | Required |
| Current Crop | Dropdown + custom option (Wheat, Rice, Cotton, Sugarcane, Maize, Other) | Required |
| Planting Date | DatePicker | Optional, must be past |
| Expected Harvest | DatePicker | Optional, must be after planting |
| Notes | MultilineTextInput | Optional, max 500 chars |
| Field Photo | ImagePicker | Optional |

**Endpoints:**
- Add: `POST /api/fields`
- Edit: `PUT /api/fields/:id`
- Delete: `DELETE /api/fields/:id` (with confirmation dialog)

---

### F-04: Sensor Monitoring

#### F-04.1 Sensor Dashboard

**Per-sensor real-time display:**
- Sensor type icon and label
- Device ID / ESP32 identifier
- Live reading value with unit
- Battery level indicator
- WiFi signal strength (bars)
- Status badge: Online (green pulse) / Offline (red)
- Last reading timestamp

**Real-time updates via Socket.IO** on event `sensor_reading`:
```json
{
  "sensor_id": 1,
  "soil_moisture": 42.5,
  "temperature": 30.2,
  "humidity": 58.1,
  "timestamp": "2026-04-02T02:33:00Z"
}
```

#### F-04.2 Sensor Reading Charts

For each sensor, show **charts for the last 24 hours** (switchable: 7 days, 30 days):

| Sensor Type | Chart Type | Y-Axis |
|-------------|-----------|--------|
| Soil Moisture | Line chart (Area fill) | 0–100% |
| Temperature | Line chart | 0–60°C |
| Humidity | Line chart (Area fill) | 0–100% |
| Light Intensity | Bar chart | Lux |
| Rainfall | Bar chart | mm |

- Charts use `fl_chart` library
- Threshold lines (e.g., 30% soil moisture critical threshold)
- Tap chart point → show exact value + timestamp tooltip

**Endpoints:**
- `GET /api/sensors/field/:fieldId`
- `GET /api/sensors/:sensorId/readings?from=&to=`
- `GET /api/sensors/:sensorId/latest`

#### F-04.3 Sensor Binding Screen

Flow to associate an ESP32 device with a field:
1. Enter Device ID (ESP32 MAC address or unique ID)
2. Select target field from dropdown
3. Select sensor type
4. Enter installation date and location description
5. Confirm binding → `PUT /api/sensors/:sensorId` with `field_id`

---

### F-05: Irrigation Control

#### F-05.1 Irrigation Control Panel

**Current Status Section:**
- Animated water drop icon (flowing when ON, static when OFF)
- Status text: "Pump is ON" / "Pump is OFF"
- If active: elapsed duration counter (HH:MM:SS)
- Field selector dropdown (when multiple fields)

**Control Buttons:**
- **Start Irrigation** (green, large) → `POST /api/irrigation/start`
  - Opens bottom sheet: confirm field, enter optional notes
  - Shows loading state during API call
- **Stop Irrigation** (red, large) → `POST /api/irrigation/stop`
  - With confirmation dialog

**Auto-Irrigation Settings:**
- Toggle: Enable Auto-Irrigation
- Soil moisture threshold slider (0–100%)
- "Activate when moisture falls below [X]%"
- Save settings button

#### F-05.2 Irrigation Schedules

**Schedule List:**
- Active/Inactive toggle per schedule
- Schedule name, frequency, time of day, duration
- Next scheduled run countdown

**Add Schedule Form:**
| Field | Type | Options |
|-------|------|---------|
| Schedule Name | TextInput | Required |
| Frequency | Dropdown | Daily, Alternate Days, Weekly, Custom |
| Custom Days | Multi-select checkboxes | Mon–Sun (if Frequency = Custom) |
| Time of Day | TimePicker | HH:MM |
| Duration | NumberInput | Minutes |
| Start Date | DatePicker | Required |
| End Date | DatePicker | Optional |

**Endpoints:**
- `GET /api/irrigation/logs/:fieldId`
- `POST /api/irrigation/start`
- `POST /api/irrigation/stop`
- `GET /api/irrigation/schedules/:fieldId`

#### F-05.3 Irrigation History Log

- List of all irrigation events (auto + manual + scheduled)
- Per entry: type badge, start/end time, duration, water used (L), trigger reason
- Total water used (today / this week / this month) summary cards
- Filter by type (automatic, manual, scheduled)

---

### F-06: Alerts & Notifications

#### F-06.1 Alerts Screen

**Layout:** Categorized list with severity color coding

| Severity | Color | Icon |
|----------|-------|------|
| 🔴 Critical | Red | Warning triangle |
| 🟡 Warning | Amber | Exclamation |
| 🔵 Info | Blue | Info circle |
| 🟢 Success | Green | Checkmark |

**Per alert card:**
- Severity badge
- Alert category icon (soil, temperature, irrigation, sensor, crop, weather)
- Title (bold) + Message
- Field name (linked)
- Relative time ("3 minutes ago")
- Unread dot (blue)
- Resolve / Read action buttons

**Actions:**
- Swipe right → Mark as read
- Swipe left → Resolve
- Tap → Alert detail sheet with full message + what triggered it
- Filter tabs: All / Unread / Critical / Resolved

**Unread badge** on bottom nav tab (real-time via Socket.IO `new_alert` event)

**Endpoint:** `GET /api/alerts`, `PUT /api/alerts/:id/read`, `PUT /api/alerts/:id/resolve`

#### F-06.2 Push Notifications (Firebase Cloud Messaging)

**Setup:**
- Integrate `firebase_messaging`
- Request notification permissions on first login
- Store FCM device token → send to backend for registration
- Handle foreground, background, and terminated app states

**Notification Types:**
| Type | Title Format | Tap Action |
|------|-------------|-----------|
| Critical Alert | "⚠️ [Field Name]: [Alert Title]" | Open Alert Detail |
| Irrigation Started | "💧 Irrigation Started — [Field]" | Open Irrigation screen |
| Irrigation Stopped | "✅ Irrigation Complete — [Field]" | Open Irrigation screen |
| Sensor Offline | "📡 Sensor Offline — [Device ID]" | Open Sensor screen |
| AI Recommendation | "🤖 New Crop Recommendation" | Open Recommendations |

**In-app notification overlay** for foreground FCM messages (custom styled banner, auto-dismiss 5s).

---

### F-07: AI Crop Recommendations

#### F-07.1 Recommendations Screen

**Per field recommendations list (from `GET /api/recommendations/:fieldId`):**

Each recommendation card shows:
- Recommended crop name + crop icon
- **Confidence score** with animated progress ring (e.g., 87%)
- Pakistani season (Kharif / Rabi)
- Key reasons (2-3 bullet points from `recommendation_reason`)
- Expected yield and water requirement badges
- Growth duration (e.g., "120 days to harvest")
- "Accept Recommendation" button → `PUT /api/recommendations/:id/accept`

#### F-07.2 Field Selector
- Dropdown to switch between fields
- Shows last updated date per recommendation

#### F-07.3 Accepted Recommendation Confirmation
- On accept: animated checkmark + "Great choice! Recommendation saved."
- Store accepted crop in the field record

---

### F-08: Weather Integration

> **Note:** The DB has a `weather_data` table. This feature fetches and displays weather data from the backend (which integrates with OpenWeatherMap or similar).

#### F-08.1 Weather Widget on Dashboard
- Current conditions: temp, humidity, wind speed, weather condition icon
- 5-day forecast strip (horizontal scrollable)
- Rain probability indicator

#### F-08.2 Weather Detail Screen
- Full 7-day forecast
- Hourly forecast for today
- "Irrigation Advice" based on forecast:
  - "Rain expected tomorrow — consider skipping irrigation"
  - "Dry week ahead — increase irrigation frequency"

**Endpoint:** To be added to backend — `GET /api/weather/:fieldId`

---

### F-09: Analytics & Reports

#### F-09.1 Analytics Screen

**Date Range Selector:** Today / 7 Days / 30 Days / Custom

**Sections:**

1. **Water Usage Analytics**
   - Total water used in period (L)
   - Line chart: daily water usage
   - Comparison: manual vs. auto vs. scheduled
   - Estimated water saved vs. traditional farming

2. **Soil Moisture Trend**
   - Multi-line chart per field
   - Threshold overlays
   - Annotations when irrigation was triggered

3. **Temperature & Humidity Heatmap**
   - Daily average temperature chart
   - Humidity trend line

4. **Irrigation Efficiency**
   - Average irrigation effectiveness (soil moisture before vs. after)
   - Duration per irrigation session bar chart

5. **Alert Statistics**
   - Pie chart: alert breakdown by type
   - Alert frequency over time
   - Most common alert types

#### F-09.2 Export

- Export analytics as **PDF report** or **CSV data**
- Share via WhatsApp, Email, etc. using `share_plus`

---

### F-10: Profile & Settings

#### F-10.1 Profile Screen

**User Info Section:**
- Avatar (photo from camera/gallery via `image_picker`)
- Full name, email, phone, city, province
- Member since date
- Role badge (Farmer / Admin / Technician)

#### F-10.2 Edit Profile
Editable fields: Full Name, Phone, City, Province, Address  
**Endpoint:** `PUT /api/auth/profile`

#### F-10.3 Change Password
Fields: Current Password, New Password, Confirm New Password  
**Endpoint:** `PUT /api/auth/change-password` (to be added to backend)

#### F-10.4 Notification Settings

| Setting | Type | Default |
|---------|------|---------|
| Critical Alerts | Toggle | ON |
| Warning Alerts | Toggle | ON |
| Irrigation Events | Toggle | ON |
| AI Recommendations | Toggle | ON |
| Email Notifications | Toggle | OFF |

#### F-10.5 App Settings

| Setting | Type | Options |
|---------|------|---------|
| Language | Dropdown | English / اردو |
| Theme | Dropdown | Light / Dark / System |
| Temperature Unit | Toggle | °C / °F |
| Area Unit | Toggle | Acres / Hectares |
| Data Refresh Interval | Slider | 30s / 1m / 5m / Manual |

#### F-10.6 About & Support
- App version
- Build number
- Link to documentation
- Contact support
- Privacy policy link
- Rate app link (Play Store / App Store)

#### F-10.7 Logout
- Confirmation dialog
- Clear JWT from secure storage
- Navigate to Login screen

---

### F-11: Admin Panel

Only visible if `user.role === 'admin'`. Accessible via a special admin tab or settings toggle.

#### F-11.1 Admin Dashboard
- System-wide stats: total users, total fields, total sensors, system alerts
- Server health indicators
- Latest audit log entries

#### F-11.2 User Management
- List all registered users
- Search by name/email
- Activate / Deactivate user accounts
- Change user role
- View user's fields and sensors

#### F-11.3 System Settings
- Global threshold settings
- Alert configuration
- Feature flags (enable/disable features per user type)

**Endpoints:** `GET/PUT /api/admin/*`

---

### F-12: Offline Mode

#### F-12.1 Offline Detection
- Use `connectivity_plus` to monitor network state
- Show persistent offline banner at top: "📡 No Internet — Showing cached data"
- All UI still functional with cached data

#### F-12.2 Local Database (Isar)

**Cached entities:**
| Entity | TTL | Purpose |
|--------|-----|---------|
| `CachedField` | 7 days | Field list and details |
| `CachedSensorReading` | 24 hours | Last known sensor values |
| `CachedAlert` | 24 hours | Alerts list |
| `CachedIrrigationLog` | 7 days | Irrigation history |
| `CachedDashboardStats` | 1 hour | Dashboard counters |
| `CachedRecommendation` | 7 days | AI recommendations |

#### F-12.3 Sync on Reconnect
- When connectivity restored: auto-sync local changes to backend
- Queue failed writes (start/stop irrigation, mark alert read) locally
- Show "Syncing..." progress indicator on reconnect
- Resolve conflicts: server data always wins (last-write-wins)

#### F-12.4 Offline Limitations
- Cannot start/stop irrigation without connectivity (show error)
- Cannot view new alerts (show cached)
- Cannot view real-time sensor data (show last known value with timestamp)

---

## 7. API Integration Reference

All API calls use the centralized `ApiService` with Dio. Base URL configured in `AppConfig`.

### Request Headers (All Requests)
```
Content-Type: application/json
Authorization: Bearer <JWT_TOKEN>
```

### Endpoint Summary

| Module | Endpoint | Method | Description |
|--------|----------|--------|-------------|
| **Auth** | `/auth/login` | POST | Login |
| | `/auth/register` | POST | Register |
| | `/auth/profile` | GET | Get profile |
| | `/auth/profile` | PUT | Update profile |
| **Dashboard** | `/dashboard/stats` | GET | Dashboard stats |
| | `/dashboard/activity` | GET | Recent activity |
| **Fields** | `/fields` | GET | List fields |
| | `/fields/:id` | GET | Field detail |
| | `/fields` | POST | Create field |
| | `/fields/:id` | PUT | Update field |
| | `/fields/:id` | DELETE | Delete field |
| **Sensors** | `/sensors/field/:fieldId` | GET | Field sensors |
| | `/sensors/:id/readings` | GET | Sensor readings |
| | `/sensors/:id/latest` | GET | Latest reading |
| | `/sensors/:id` | PUT | Bind sensor |
| **Irrigation** | `/irrigation/start` | POST | Start irrigation |
| | `/irrigation/stop` | POST | Stop irrigation |
| | `/irrigation/logs/:fieldId` | GET | Irrigation logs |
| | `/irrigation/schedules/:fieldId` | GET | Schedules |
| **Alerts** | `/alerts` | GET | List alerts |
| | `/alerts/unread-count` | GET | Unread count |
| | `/alerts/:id/read` | PUT | Mark as read |
| | `/alerts/:id/resolve` | PUT | Resolve alert |
| **Recommendations** | `/recommendations/:fieldId` | GET | Get recommendations |
| | `/recommendations/:id/accept` | PUT | Accept recommendation |
| **Admin** | `/admin/users` | GET | List users |
| | `/admin/users/:id` | PUT | Update user |
| | `/admin/stats` | GET | System stats |

### Error Response Format
```json
{
  "success": false,
  "message": "Human-readable error message",
  "errors": [ { "field": "email", "message": "Invalid email" } ]
}
```

### Socket.IO Events

| Event | Direction | Payload |
|-------|-----------|---------|
| `sensor_reading` | Server → Client | `{ sensor_id, soil_moisture, temperature, humidity, timestamp }` |
| `new_alert` | Server → Client | `{ alert_id, type, severity, title, field_id }` |
| `irrigation_status` | Server → Client | `{ field_id, pump_status, started_at }` |
| `sensor_offline` | Server → Client | `{ sensor_id, device_id, field_id }` |
| `join_field` | Client → Server | `{ field_id }` — subscribe to field room |
| `leave_field` | Client → Server | `{ field_id }` — unsubscribe |

---

## 8. Data Models

### 8.1 User
```dart
class UserEntity {
  final int id;
  final String fullName;
  final String email;
  final String phone;
  final String? address;
  final String? city;
  final String? province;
  final UserRole role;  // farmer | admin | technician
  final bool isActive;
  final DateTime createdAt;
  final DateTime? lastLogin;
}
```

### 8.2 Field
```dart
class FieldEntity {
  final int id;
  final int userId;
  final String fieldName;
  final double? locationLatitude;
  final double? locationLongitude;
  final double areaSize;
  final String areaUnit;   // acres | hectares | square_meters
  final String? soilType;
  final String? currentCrop;
  final DateTime? plantingDate;
  final DateTime? expectedHarvestDate;
  final bool isActive;
  final DateTime createdAt;
}
```

### 8.3 Sensor
```dart
class SensorEntity {
  final int id;
  final int fieldId;
  final SensorType sensorType;
  final String deviceId;
  final String? sensorModel;
  final DateTime installationDate;
  final bool isActive;
  final double? batteryLevel;
  final String? firmwareVersion;
}

class SensorReadingEntity {
  final int id;
  final int sensorId;
  final double? soilMoisture;
  final double? temperature;
  final double? humidity;
  final double? lightIntensity;
  final double? rainfall;
  final double? batteryVoltage;
  final int? signalStrength;
  final DateTime readingTimestamp;
}
```

### 8.4 Alert
```dart
class AlertEntity {
  final int id;
  final int userId;
  final int? fieldId;
  final int? sensorId;
  final AlertType alertType;        // critical | warning | info | success
  final AlertCategory category;     // soil_moisture | temperature | irrigation | ...
  final String title;
  final String message;
  final double? thresholdValue;
  final double? currentValue;
  final bool isRead;
  final bool isResolved;
  final DateTime createdAt;
}
```

### 8.5 IrrigationLog
```dart
class IrrigationLogEntity {
  final int id;
  final int fieldId;
  final IrrigationType irrigationType;  // automatic | manual | scheduled
  final DateTime startTime;
  final DateTime? endTime;
  final int? durationMinutes;
  final double? waterUsedLiters;
  final String? triggerReason;
  final double? soilMoistureBefore;
  final double? soilMoistureAfter;
  final PumpStatus pumpStatus;  // on | off | error
}
```

### 8.6 CropRecommendation
```dart
class RecommendationEntity {
  final int id;
  final int fieldId;
  final String recommendedCrop;
  final double confidenceScore;
  final String? season;
  final double? expectedYield;
  final String? waterRequirement;
  final int? growthDurationDays;
  final String? recommendationReason;
  final bool isAccepted;
  final DateTime createdAt;
}
```

---

## 9. UI/UX Design System

### 9.1 Color Palette

#### Light Theme
```dart
// Primary Brand
primary:          Color(0xFF22c55e)  // Vibrant Green
primaryDark:      Color(0xFF16a34a)
primaryLight:     Color(0xFF86efac)

// Backgrounds
background:       Color(0xFFF9FAFB)
surfaceCard:      Color(0xFFFFFFFF)
surfaceElevated:  Color(0xFFF3F4F6)

// Text
textPrimary:      Color(0xFF111827)
textSecondary:    Color(0xFF6B7280)
textTertiary:     Color(0xFF9CA3AF)

// Semantic
error:            Color(0xFFEF4444)
warning:          Color(0xFFF59E0B)
success:          Color(0xFF10B981)
info:             Color(0xFF3B82F6)

// IoT-specific
soilDry:          Color(0xFFEF4444)
soilModerate:     Color(0xFFF59E0B)
soilWet:          Color(0xFF22C55E)
```

#### Dark Theme
```dart
primary:          Color(0xFF4ADE80)
background:       Color(0xFF0F172A)
surfaceCard:      Color(0xFF1E293B)
surfaceElevated:  Color(0xFF334155)
textPrimary:      Color(0xFFF8FAFC)
textSecondary:    Color(0xFF94A3B8)
```

### 9.2 Typography

| Style | Font | Size | Weight |
|-------|------|------|--------|
| Display Large | Inter | 32px | Bold (700) |
| Headline | Inter | 24px | SemiBold (600) |
| Title | Inter | 20px | SemiBold (600) |
| Body Large | Inter | 16px | Regular (400) |
| Body Medium | Inter | 14px | Regular (400) |
| Caption | Inter | 12px | Regular (400) |
| Label | Inter | 11px | Medium (500) |
| **Urdu Body** | Noto Nastaliq Urdu | 16px | Regular |

### 9.3 Spacing Scale
```
4px / 8px / 12px / 16px / 20px / 24px / 32px / 48px / 64px
```

### 9.4 Border Radius
```
Small:   8px   (badges, chips)
Medium:  12px  (cards)
Large:   16px  (bottom sheets, modals)
XLarge:  24px  (hero cards)
Pill:    100px (buttons, tags)
```

### 9.5 Elevation & Shadows
- Cards: `BoxShadow(color: black.withOpacity(0.06), blurRadius: 12, offset: Offset(0, 4))`
- Bottom Sheet: blurred overlay backdrop

### 9.6 Animations & Micro-interactions
- **Page transitions:** Slide + fade (GoRouter custom transitions)
- **Card entrance:** Staggered slide-up animations
- **Stat counters:** AnimatedCounter widget (count from 0 to value on load)
- **Pump status:** Lottie animation for water flowing
- **Soil moisture arc:** AnimatedCircularProgress widget
- **Alert severity pulse:** Repeating pulse animation for critical alerts
- **Loading skeletons:** Shimmer effect matching actual layout

### 9.7 Glassmorphism Components
Use frosted glass effect for:
- Dashboard hero card
- Sensor live overlay on map
- Alert severity banners

```dart
// Glass card decoration
BoxDecoration(
  color: Colors.white.withOpacity(0.15),
  borderRadius: BorderRadius.circular(16),
  border: Border.all(color: Colors.white.withOpacity(0.3)),
  boxShadow: [...],
)
// with BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10))
```

---

## 10. Screen Inventory & Navigation

### 10.1 Navigation Structure

```
App
├── /splash                    SplashScreen
├── /onboarding               OnboardingScreen
├── /login                    LoginScreen
├── /register                 RegisterScreen
│
└── /home                     HomeScreen (ShellRoute - Bottom Nav)
    ├── /home/dashboard        DashboardScreen
    ├── /home/fields           FieldsScreen
    │   ├── /home/fields/:id   FieldDetailScreen
    │   └── /home/fields/add   AddFieldScreen
    ├── /home/alerts           AlertsScreen
    │   └── /home/alerts/:id   AlertDetailScreen
    └── /home/profile          ProfileScreen
        ├── /home/profile/edit     EditProfileScreen
        └── /home/profile/settings SettingsScreen

/irrigation                   IrrigationScreen (push, from Dashboard/Fields)
/sensors/:fieldId             SensorMonitorScreen
/sensors/bind                 SensorBindingScreen
/analytics                    AnalyticsScreen
/recommendations/:fieldId     RecommendationsScreen
/weather/:fieldId             WeatherScreen
/admin                        AdminDashboardScreen (role-gated)
    /admin/users              AdminUsersScreen
    /admin/users/:id          AdminUserDetailScreen
```

### 10.2 Bottom Navigation Tabs

| Tab | Icon | Label | Badge |
|-----|------|-------|-------|
| 1 | 🏠 | Dashboard | — |
| 2 | 🌾 | Fields | Active count |
| 3 | 🚨 | Alerts | Unread count |
| 4 | 👤 | Profile | — |

---

## 11. Non-Functional Requirements

### 11.1 Performance
| Metric | Target |
|--------|--------|
| App cold start time | < 1.5 seconds |
| Screen navigation transition | < 300ms |
| API data rendering latency | < 300ms |
| List scroll framerate | 60 FPS |
| Socket.IO reconnect time | < 5 seconds |
| APK release size | < 25 MB |
| Memory usage (idle) | < 100 MB |

### 11.2 Reliability
- Crash rate: < 0.5%
- ANR (App Not Responding) rate: < 0.1%
- Socket.IO auto-reconnect: up to 5 attempts with exponential backoff
- Dio retry on network failure: 3 retries

### 11.3 Accessibility
- Minimum tap target: 48×48dp
- WCAG AA color contrast (4.5:1 for body text)
- Semantic labels on all icons
- Screen reader compatible (Talkback / VoiceOver)
- Support font scaling up to 1.5×

### 11.4 Compatibility
| Platform | Min Version |
|----------|------------|
| Android | API 23 (Android 6.0 Marshmallow) |
| iOS | iOS 13.0 |
| Flutter | 3.19.0+ |
| Dart | 3.3.0+ |

### 11.5 Localization
- **English (en):** Primary language, complete
- **Urdu (ur):** Secondary language, complete for all UI strings
- Use `flutter_localizations` with ARB files
- RTL layout support for Urdu
- Date formats: Pakistan locale (DD/MM/YYYY)
- Number formats: comma separators

---

## 12. Security Requirements

### 12.1 Token Storage
- JWT stored in `flutter_secure_storage` (AES encrypted on Android Keystore / iOS Keychain)
- Never stored in SharedPreferences or plain files
- FCM token stored in secure storage

### 12.2 API Security
- All requests over HTTPS in production
- Dio `AuthInterceptor` injects token; handles 401 → navigate to login
- Certificate pinning for production (optional, v2.1)
- No sensitive data logged in production builds

### 12.3 Input Validation
- All forms validated client-side before API call
- Sanitize inputs to prevent XSS in displayed content
- Phone number regexp for Pakistan format

### 12.4 Biometric Authentication (v2.1 feature, documented here)
- Optional fingerprint/face unlock for returning users
- Uses `local_auth` package

---

## 13. Testing Requirements

### 13.1 Unit Tests (Target: 80% code coverage)

| Layer | Test Target |
|-------|------------|
| Models | `fromJson()`, `toJson()`, field validations |
| Repositories | Mock API responses, error handling |
| Notifiers | State transitions (loading/data/error) |
| Utils | Date formatters, validators, helpers |

**Test framework:** `flutter_test`, `mocktail`

### 13.2 Widget Tests

| Screen | Key Test Cases |
|--------|---------------|
| LoginScreen | Form validation, login success, login error |
| DashboardScreen | Renders stats, shows error state, pull-to-refresh |
| FieldsScreen | Empty state, list render, add field navigation |
| AlertsScreen | Alert categorization, swipe actions |
| IrrigationScreen | Start/stop button state, confirmation dialog |

**Tools:** `flutter_test`, `golden_toolkit` (visual regression)

### 13.3 Integration Tests

- Full login → dashboard flow
- Add field → assign sensor → view reading
- Trigger alert → receive notification → resolve alert
- Start irrigation → stop irrigation → view log

**Tool:** `integration_test` package

### 13.4 CI/CD Pipeline

```yaml
# GitHub Actions triggers on PR to main:
1. Run flutter analyze (lint)
2. Run flutter test --coverage
3. Check coverage ≥ 80%
4. Build APK (release)
5. Upload APK to Firebase App Distribution (beta channel)
```

---

## 14. Release Plan & Milestones

### Phase 1 — Foundation (Weeks 1–2)
- [ ] Project setup (Riverpod, GoRouter, Dio, theme)
- [ ] Core architecture, folder structure
- [ ] Auth screens (Login, Register, Splash, Onboarding)
- [ ] JWT token management with secure storage
- [ ] Network layer (Dio client + AuthInterceptor)
- [ ] Local DB setup (Isar schema)

### Phase 2 — Core Features (Weeks 3–4)
- [ ] Dashboard screen with stats
- [ ] Fields CRUD (list, detail, add, edit, delete)
- [ ] Sensor monitoring screen + charts
- [ ] Alerts screen (list, read, resolve)
- [ ] Profile screen + settings

### Phase 3 — Real-Time & Notifications (Weeks 5–6)
- [ ] Socket.IO integration for live sensor data
- [ ] Firebase Cloud Messaging setup
- [ ] Push notification handling (foreground, background, killed)
- [ ] FCM token registration with backend
- [ ] In-app notification overlay component

### Phase 4 — Advanced Features (Weeks 7–8)
- [ ] Irrigation control panel + schedules
- [ ] Recommendations screen
- [ ] Weather integration
- [ ] Analytics & reports screen
- [ ] Google Maps for field GPS
- [ ] Image picker for profile + field photos

### Phase 5 — Offline & Localization (Weeks 9–10)
- [ ] Offline-first caching with Isar
- [ ] Sync-on-reconnect mechanism
- [ ] Urdu language complete translation
- [ ] RTL layout validation
- [ ] Dark mode implementation

### Phase 6 — Testing & Release (Weeks 11–12)
- [ ] Unit tests (≥ 80% coverage)
- [ ] Widget tests for all screens
- [ ] Integration tests for critical flows
- [ ] CI/CD pipeline setup
- [ ] Performance profiling + optimization
- [ ] Play Store / App Store submission

---

## 15. Open Issues & Decisions

| # | Issue | Owner | Status |
|---|-------|-------|--------|
| OI-1 | Backend endpoint needed: `PUT /api/auth/change-password` | Backend Team | 🔴 Pending |
| OI-2 | Backend endpoint needed: `GET /api/weather/:fieldId` | Backend Team | 🔴 Pending |
| OI-3 | FCM backend integration (store device token, send push on alert creation) | Backend Team | 🔴 Pending |
| OI-4 | Socket.IO `join_field` rooms: confirm event names with backend | Backend Team | 🟡 In Discussion |
| OI-5 | Google Maps API key procurement and billing setup | Product Owner | 🟡 In Progress |
| OI-6 | Urdu translation: hire translator or use community? | Product Owner | 🟡 In Discussion |
| OI-7 | Certificate pinning: include in v2.0 or defer to v2.1? | Architect | 🟡 In Discussion |
| OI-8 | Weather data provider: OpenWeatherMap API key needed | Product Owner | 🔴 Pending |
| OI-9 | Flavor config: dev/staging/prod environments | Lead Dev | 🟡 In Progress |
| OI-10 | App Store / Play Store developer account ready? | Product Owner | 🔴 Pending |

---

## Appendix A: Environment Configuration

```dart
// lib/core/constants/app_config.dart

class AppConfig {
  static const String appName = 'Smart Agriculture';
  static const String appVersion = '2.0.0';

  // Flavors: dev | staging | prod
  static const String flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');

  static String get apiBaseUrl {
    switch (flavor) {
      case 'prod': return 'https://api.smartagri.pk/api';
      case 'staging': return 'https://staging.smartagri.pk/api';
      default: return 'http://10.0.2.2:5000/api';  // Android emulator
    }
  }

  static String get socketUrl {
    switch (flavor) {
      case 'prod': return 'wss://api.smartagri.pk';
      default: return 'http://10.0.2.2:5000';
    }
  }

  // Sensor thresholds (defaults, overridden by user settings)
  static const double soilMoistureCriticalLow = 20.0;
  static const double soilMoistureWarningLow = 30.0;
  static const double temperatureCriticalHigh = 40.0;
  static const double humidityWarningLow = 30.0;

  // Pagination
  static const int pageSize = 20;

  // Cache TTL (seconds)
  static const int fieldCacheTtl = 604800;    // 7 days
  static const int sensorCacheTtl = 86400;    // 24 hours
  static const int alertCacheTtl = 86400;     // 24 hours
  static const int dashboardCacheTtl = 3600;  // 1 hour
}
```

---

## Appendix B: Glossary

| Term | Definition |
|------|-----------|
| Field | A land plot owned by a farmer, managed in the system |
| Sensor | An ESP32-based IoT device installed in a field |
| ESP32 | The microcontroller hardware used in the IoT sensors |
| DHT11 | Temperature and humidity sensor chip |
| Relay | Electronic switch that controls the irrigation pump |
| Socket.IO | WebSocket library for real-time bidirectional communication |
| FCM | Firebase Cloud Messaging — push notification service |
| JWT | JSON Web Token — stateless authentication token |
| Isar | Fast NoSQL local database for Flutter (offline storage) |
| Riverpod | Next-generation state management for Flutter |
| GoRouter | Declarative navigation/routing package for Flutter |
| Kharif | Pakistani summer crop season (April–October) |
| Rabi | Pakistani winter crop season (October–April) |
| PRD | Product Requirements Document |

---

**Document Control**

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-04-02 | AI Assistant | Initial draft — complete PRD |

---

*Smart Agriculture PRD v2.0 — For Pakistani Farmers 🌾🇵🇰*
