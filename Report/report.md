Smart AI Powered Agriculture System

Muhammad Awais (BSE223112)
Hamza Bashir (BSE223108)
Junaid Amin (BSE223107)
Supervised By
Adnan Karamat
Spring 2026
BS Software Engineering
Department of Software Engineering
Capital University of Science & Technology, Islamabad
Contents
1 Introduction
1.1 Project Introduction
1.2 Existing Examples / Solutions
1.3 Problem Statement
1.4 Business Scope
1.5 Useful Tools and Technologies
1.5.1 Hardware
1.5.2 Software
1.5.3 AI and Machine Learning
1.6 Project Work Break Down
1.7 Project Time Line
2 Requirement Specification and Analysis
2.1 Epics
2.1.1 E1: User Authentication and Profile Management
2.1.2 E2: Real-Time Sensor Data Monitoring
2.1.3 E3: Intelligent Irrigation Control
2.1.4 E4: AI-Driven Crop Recommendations
2.1.5 E5: Alerting and Notification System
2.1.6 E6: Historical Data Analytics and Visualization
2.2 User Stories
2.2.1 Epic E1: User Authentication and Profile Management
2.2.2 Epic E2: Real-Time Sensor Data Monitoring
2.2.3 Epic E3: Intelligent Irrigation Control
2.2.4 Epic E4: AI-Driven Crop Recommendations
2.2.5 Epic E5: Alerting and Notification System
2.2.6 Epic E6: Historical Data Analytics and Visualization
2.3 Test Cases
2.3.1 Test Case 1 — Verify User Registration with Valid Data
2.3.2 Test Case 2 — Verify Login with Valid Credentials
2.3.3 Test Case 3 — Verify Profile Management
2.3.4 Test Case 4 — Verify Field Overview Display Table of Contents ii
2.3.5 Test Case 5 — Verify Real-Time Data Display
2.3.6 Test Case 6 — Verify Sensor Status Monitoring
2.3.7 Test Case 7 — Verify Manual Pump Start
2.3.8 Test Case 8 — Verify Automatic Trigger on Low Moisture
2.3.9 Test Case 9 — Verify Irrigation Logging
2.3.10 Test Case 10 — Verify Crop Recommendation Generation
2.3.11 Test Case 11 — Verify Recommendation Confidence Score
2.3.12 Test Case 12 — Verify Accept Recommendation
2.3.13 Test Case 13 — Verify Critical Alert Delivery
2.3.14 Test Case 14 — Verify Unread Alert Count
2.3.15 Test Case 15 — Verify Resolve Alert Functionality
2.3.16 Test Case 16 — Verify Weekly Trend Graph
2.3.17 Test Case 17 — Verify Data Export
2.3.18 Test Case 18 — Verify Field Comparison
2.4 User Interface Design (Prototypes)
2.4.1 Login Screen
2.4.2 Dashboard (Sensor Overview)
2.4.3 Detailed Sensor Data Page
2.4.4 AI Crop Recommendation Screen
2.4.5 Irrigation Control Panel
2.4.6 Alerts & Notifications Screen
2.4.7 Settings / Profile Page
2.5 Traceability Matrix
3 System Design
3.1 Software Architecture
3.1.1 Architectural Layers
3.2 Components and Connector
3.2.1 Core Components
3.2.2 Connectors (Interfaces)
3.3 Hardware Specifications
3.3.1 Component Overview
3.3.2 Detailed Technical Specifications
3.3.3 Pin Configuration and Wiring
3.3.4 Power Consumption Analysis
3.3.5 Cost Estimation
3.4 Communication Protocols
3.5 Data Modeling
3.5.1 Relational Database Model (MySQL) Table of Contents iii
3.5.2 Database Schema Specification
3.6 Workflow Diagram
3.7 Third-Parties Dependencies
4 Software Development
4.1 Coding Standards
4.1.1 General Standards
4.1.2 ESP32 Firmware Standards
4.1.3 Backend Standards (Node.js)
4.1.4 Mobile Application Standards
4.2 Development Environment
4.2.1 Tools and Platforms
4.2.2 Testing Setup
4.3 Software Description
4.3.1 Snippet 1: Hardware Pin Configuration
4.3.2 Snippet 2: Sensor Threshold Configuration
4.3.3 Snippet 3: Three-Tier Timing System
4.3.4 Snippet 4: Safe System Initialization
4.3.5 Snippet 5: Main Execution Loop
4.3.6 Snippet 6: Smoothed Sensor Reading
4.3.7 Snippet 7: Sensor Data Acquisition
4.3.8 Snippet 8: Local Rain Safety Mechanism
4.3.9 Snippet 9: Backend Command Polling
4.3.10 Snippet 10: Relay Synchronization Logic
4.3.11 Snippet 11: Relay-Based Pump Control
4.3.12 Snippet 12: Offline Irrigation Logic
4.3.13 Snippet 13: Wi-Fi Connectivity and Reconnection
4.3.14 Snippet 14: Sensor Value Conversion
4.3.15 Snippet 15: Sensor Data Upload to Backend
4.4 Implementation Challenges and Resolutions
4.5 Summary
5 Software Deployment
5.1 Installation / Deployment Process Description
5.1.1 Deployment Overview
5.1.2 Hardware Setup and Field Installation
5.1.3 ESP32 Firmware Deployment
5.1.4 Backend Deployment (Node.js Server)
5.1.5 Database Deployment and Configuration Table of Contents iv
5.1.6 AI Service Deployment (Python)
5.1.7 Mobile Application Deployment
5.2 End-to-End System Validation
5.3 Summary
1.1 Work Breakdown Structure List of Figures
1.2 Gantt Chart
2.1 Login Screen UI Design
2.2 Dashboard UI Design
2.3 Detailed Sensor Data Page UI Design
2.4 AI Crop Recommendation Screen UI Design
2.5 Irrigation Control Panel UI Design
2.6 Alerts & Notifications Screen UI Design
2.7 Settings / Profile Page UI Design
3.1 System Architecture Diagram
3.2 Hardware Integration
3.3 Communication Protocol Stack
3.4 Entity Relationship Diagram (ERD)
3.5 Complete Database Schema
3.6 System Workflow Diagram
1.1 Existing Examples List of Tables
1.2 Lean Canvas
2.1 Verify User Registration with Valid Data
2.2 Verify Login with Valid Credentials
2.3 Verify Profile Management
2.4 Verify Field Overview Display
2.5 Verify Real-Time Data Display
2.6 Verify Sensor Status Monitoring
2.7 Verify Manual Pump Start
2.8 Verify Automatic Trigger on Low Moisture
2.9 Verify Irrigation Logging
2.10 Verify Crop Recommendation Generation
2.11 Verify Recommendation Confidence Score
2.12 Verify Accept Recommendation
2.13 Verify Critical Alert Delivery
2.14 Verify Unread Alert Count
2.15 Verify Resolve Alert Functionality
2.16 Verify Weekly Trend Graph
2.17 Verify Data Export
2.18 Verify Field Comparison
2.19 Traceability Matrix
3.1 Hardware Components and Primary Functions
3.2 Hardware Technical Specifications and Interface Details
3.3 ESP32 Pin Configuration
3.4 Estimated Hardware Costs
3.5 Users Table Schema
3.6 Fields Table Schema
3.7 Sensors Table Schema
3.8 Sensor Readings Table Schema
3.9 Irrigation Logs Table Schema
3.10 Alerts Table Schema
List of Tables vii

3.11 Crop Recommendations Table Schema.................... 51
1 Introduction
Agriculture in Pakistan faces challenges like water shortage, low productivity, and lack of
modern tools. To address this, the Smart AI Powered Agriculture System uses Internet
of Things (IoT) sensors to monitor soil and weather conditions, automates irrigation to save
water, and applies artificial intelligence (AI) to recommend suitable crops. This solution is
designed to help farmers improve yield, reduce costs, save water, and adopt smarter farming
practices.

1.1 Project Introduction
The Smart AI Powered Agriculture System is an IoT-based solution designed to make farm-
ing more efficient and sustainable. The system uses sensors to monitor soil moisture, tem-
perature, humidity, light, and rainfall in real time. This data is sent to a mobile application
through a backend server, allowing farmers to track field conditions, receive alerts, and
view historical records.
The system also includes automatic irrigation, where water is supplied only when the
soil is dry, and an AI module that recommends the most suitable crops for upcoming sea-
sons. The goal is to help farmers conserve water, improve crop yield, and make data-driven
decisions in agriculture.
The main beneficiaries of this project are small and medium scale farmers in Pakistan,
who often face challenges such as water wastage, low crop productivity, and lack of access
to modern agricultural tools. By using this system, farmers can monitor their fields easily,
save water through automated irrigation, and receive crop recommendations that support
better planning. This helps them reduce costs, increase income, and adopt smarter farming
practices.

1.2 Existing Examples / Solutions
Several existing systems and solutions in Pakistan and globally work towards precision
agriculture, smart irrigation, and farm monitoring. However, most of them are either ex-
pensive, focused on large-scale farms, or limited in scope. Table 1.1 summarizes some
examples and the gaps that remain.

1
CHAPTER 1. INTRODUCTION 2
Table 1.1: Existing Examples
Name What they do (features) What gap remains
SAWiE (Sustain-
able Agriculture
Water & Intelli-
gent Ecosystem)
Offers IoT and machine learn-
ing based advisory for farm-
ers; soil mapping and alerts for
droughts and floods.
Does not directly automate
irrigation hardware or pump
control.
Buraq Integrated
Solutions — Smart
Drip Irrigation
Implements drip irrigation sys-
tems with soil moisture and
temperature sensors.
Lacks an AI-based crop rec-
ommendation module.
VGreen —
CropSight™
Provides farm mapping, real-
time monitoring, and analyt-
ics; localized for Pakistani
farms.
Good dashboards and analyt-
ics but lacks full automation
(pump control and crop rec-
ommendation) and is costly for
small farmers.
Field Commander
— Valley Irriga-
tion Pakistan
Offers remote monitoring and
SMS/Email alerts.
Does not offer smart irriga-
tion and is mainly available for
large commercial farms.
Smart IoT Farm
at PMAS–AAUR,
Rawalpindi
University research farm with
sensors (e.g., soil moisture)
and real-time IoT monitoring
to demonstrate precision agri-
culture.
No dedicated mobile applica-
tion for farmers, no AI-based
decision support, and no auto-
mated irrigation.
The Smart AI Powered Agriculture System aims to combine IoT-based sensing, au-
tomatic irrigation, mobile app support, and AI-driven crop recommendations in a single
affordable solution targeted at small and medium farmers.

1.3 Problem Statement
Agriculture is the main source of income and food in many countries, especially in develop-
ing regions. Many farmers depend on farming for their livelihood, but they face challenges
such as water wastage, unpredictable weather, limited access to real-time information, and
lack of proper guidance for choosing crops or managing their fields. Traditional farming
methods often result in over-watering or under-watering, loss of soil nutrients, and low
crop production. Even though modern technology is available, many small and medium
farmers cannot afford or access smart farming tools. There is a need for an affordable and
easy-to-use smart agriculture system that uses IoT and AI to monitor the environment, save
resources such as water and energy, and provide useful recommendations to farmers.

CHAPTER 1. INTRODUCTION 3
1.4 Business Scope
The Smart AI Powered Agriculture System has strong potential in the agriculture sector of
Pakistan. Since many farmers face problems like water wastage, low crop yield, and lack
of modern tools, this system provides an affordable and simple solution.
By offering IoT-based smart farming kits (sensors, controller, and mobile application),
farmers can save water, achieve better crop production, and make smarter decisions. The
system can be adopted by small and medium farmers and can also be promoted through
government programs, non-governmental organizations (NGOs), and agriculture compa-
nies. The idea has strong business value because it directly improves farmers’ income and
supports food security.

Table 1.2: Lean Canvas
Problem Solution Unique Value Proposi-
tion
Water wastage due to
over-irrigation.
Low crop yield from
poor crop choice.
Lack of affordable smart
farming tools.
IoT sensors for soil and
weather.
Automatic irrigation
system.
Mobile app with AI-
based crop suggestion.
An affordable smart farm-
ing kit that saves water,
increases yield, and helps
farmers make better crop
decisions.
Existing Alternatives Key Metrics (Approx.) High-Level Concept
Manual irrigation.
Expensive imported sys-
tems.
100+ farmers use the
system.
45% water savings
(est.).
35% increase in yield
(est.).
A smart farming assistant
for every farmer, like a
personal digital guide for
crops.
Channels Cost Structure Customer Segments
Direct sales to farmers.
Partnerships with NGOs
and government programs.
Agriculture supply com-
panies.
IoT hardware (sensors,
controllers).
Mobile app and server
hosting.
Installation and support.
Small and medium
farmers.
Agriculture NGOs and
government projects.
Early Adopters Revenue Structure
Farmers with 1–4 acres
of land.
NGOs running pilot
agriculture projects.
Selling hardware kits.
Subscription for premium app features.
Installation and training services.
CHAPTER 1. INTRODUCTION 4
1.5 Useful Tools and Technologies
The key hardware and software components for the Smart AI Powered Agriculture System
are:

1.5.1 Hardware
ESP32 — Microcontroller with Wi-Fi support for sensor data processing and trans-
mission.
Soil Moisture Sensor (e.g., YL-69 or capacitive sensor) — Detects soil water level.
DHT22 Sensor — Measures temperature and humidity.
Light Sensor (LDR) — Monitors sunlight levels for crop growth.
Rain Sensor (e.g., FC-37 / YL-82) — Detects rainfall to avoid unnecessary irriga-
tion.
Relay Module — Controls water pump or valve for automation.
Water Flow Sensor — Measures water usage during irrigation.
1.5.2 Software
Arduino IDE (C++) — Programming the ESP32.
Backend Server: Node.js — Handles data from sensors and communicates with the
mobile app.
Database: MySQL — Stores sensor readings and historical records.
Mobile Application: Android (Java/Kotlin) or Flutter — Displays live data, his-
tory, and alerts.
Data Visualization: Libraries such as MPAndroidChart, Chart.js, or Recharts for
graphs and charts.
Notifications: Firebase Cloud Messaging — For sending push alerts.
1.5.3 AI and Machine Learning
Python (TensorFlow / Scikit-learn) — For crop recommendation and predictive
analytics.
Signal Processing Techniques — To filter and clean noisy sensor data before analy-
sis.
1.6 Project Work Break Down
The project is divided into multiple phases to ensure systematic development, testing, and
deployment. Major tasks include requirement analysis, hardware selection and setup, back-
end development, mobile app development, AI model training, integration, and testing.
Figure 1.1 shows a conceptual Work Breakdown Structure (WBS) of the project.

CHAPTER 1. INTRODUCTION 5
Figure 1.1: Work Breakdown Structure
1.7 Project Time Line
The project timeline spans from 29 September 2025 to 10 July 2026 and covers research,
hardware setup, software development, integration, and testing. Each phase is scheduled to
ensure steady progress and timely completion.
A Gantt chart is used to represent the project timeline, as shown in Figure 1.2.

Figure 1.2: Gantt Chart
2 Requirement Specification and Anal-
ysis
This chapter describes the functional requirements of the Smart AI Powered Agriculture
System in terms of epics, user stories, test cases, user interface design, and a traceability
matrix.

2.1 Epics
Epics are large, high-level features that represent significant functionalities of the system.
Each epic is later broken down into multiple user stories.

2.1.1 E1: User Authentication and Profile Management
Description: As a farmer or administrator, the user wants to securely log in, register, and
manage their profile so that data and farm configurations remain private and secure.

2.1.2 E2: Real-Time Sensor Data Monitoring
Description: As a farmer, the user wants to monitor real-time environmental data (soil
moisture, temperature, humidity) from the fields so that informed decisions can be made
about crop care.

2.1.3 E3: Intelligent Irrigation Control
Description: As a farmer, the user wants to control irrigation systems manually or set
automatic triggers based on sensor thresholds so that water usage is optimized and crops
receive adequate hydration.

2.1.4 E4: AI-Driven Crop Recommendations
Description: As a farmer, the user wants to receive AI-generated crop recommendations
based on soil and weather analysis so that yield can be maximized and the most suitable
crops for the season can be selected.

2.1.5 E5: Alerting and Notification System
Description: As a farmer, the user wants to receive immediate alerts about critical condi-
tions (e.g., low soil moisture, sensor failure) so that timely corrective actions can be taken
to prevent crop damage.

6
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 7
2.1.6 E6: Historical Data Analytics and Visualization
Description: As a farmer, the user wants to view historical trends and graphical visual-
izations of farm data so that long-term patterns can be analyzed and farming strategies
improved.

2.2 User Stories
Each epic is decomposed into smaller, actionable user stories. User stories are written from
the user’s perspective with clear acceptance criteria.

2.2.1 Epic E1: User Authentication and Profile Management
E1-US1: User Registration

Description: As a new user, the user wants to create an account using email and phone
number so that system features can be accessed.
Acceptance Criteria:

Given the user is on the registration screen,
When valid name, email, phone, and password are entered,
Then the system should create a new account and redirect to the login page.
E1-US2: Secure Login

Description: As a registered user, the user wants to log in using credentials so that the
personal dashboard can be accessed.
Acceptance Criteria:

Given the user has a valid account,
When the correct email and password are entered,
Then the system should authenticate the user and grant access to the dashboard.
E1-US3: Profile Management

Description: As a user, the user wants to update personal information and change the
password so that account details remain current and secure.
Acceptance Criteria:

Given the user is logged in,
When the user navigates to profile settings and updates the phone number,
Then the system should save the changes and display a success message.
2.2.2 Epic E2: Real-Time Sensor Data Monitoring
E2-US1: View Field Overview

Description: As a farmer, the user wants to see a list of all fields with their current status
so that the overall farm health can be assessed quickly.

CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 8
Acceptance Criteria:
Given the user is on the dashboard,
When the page loads,
Then the system should display all registered fields with summary indicators such as
“Healthy” or “Needs Water”.
E2-US2: Detailed Sensor Readings

Description: As a farmer, the user wants to view specific readings from individual sensors
(e.g., Sensor ID 14) so that issues in specific areas can be pinpointed.
Acceptance Criteria:

Given the user selects a specific field,
When a sensor node is tapped,
Then the system should show the latest values for soil moisture, temperature, and
humidity.
E2-US3: Sensor Status Monitoring

Description: As a farmer, the user wants to know if a sensor is offline or has low battery
so that maintenance can be performed.
Acceptance Criteria:

Given a sensor has stopped sending data,
When the user views the sensor list,
Then the system should display an “Offline” status indicator next to that sensor.
2.2.3 Epic E3: Intelligent Irrigation Control
E3-US1: Manual Irrigation Toggle

Description: As a farmer, the user wants to remotely turn the water pump on or off so that
the field can be irrigated immediately when needed.
Acceptance Criteria:

Given the irrigation system is connected,
When the user presses the “Start Irrigation” button,
Then the system should send a command to the actuator and update the status to
“Irrigating”.
E3-US2: Threshold-Based Automation

Description: As a farmer, the user wants to set a soil moisture threshold (e.g., 30%) so that
the system automatically irrigates when the soil becomes too dry.
Acceptance Criteria:

CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 9
Given the automation mode is enabled,
When soil moisture drops below the defined threshold,
Then the system should automatically trigger the irrigation pump without user inter-
vention.
E3-US3: Irrigation Logging

Description: As a farmer, the user wants to see a history of irrigation events so that water
usage can be tracked.
Acceptance Criteria:

Given an irrigation cycle has completed,
When the user views the irrigation logs,
Then the system should list the start time, end time, and total duration of each event.
2.2.4 Epic E4: AI-Driven Crop Recommendations
E4-US1: Request Crop Recommendation

Description: As a farmer, the user wants to request a crop recommendation based on the
field’s current soil data so that the most viable crop can be planted.
Acceptance Criteria:

Given the user is on the recommendation screen,
When the “Analyze Field” button is clicked,
Then the system should process the soil parameters and display a recommended crop
(e.g., “Wheat”).
E4-US2: View Recommendation Confidence

Description: As a farmer, the user wants to see the confidence score of the AI prediction
so that trust in the recommendation can be established.
Acceptance Criteria:

Given a recommendation is generated,
When the result is displayed,
Then the system should show a percentage confidence score (e.g., “85% Confidence”).
E4-US3: Accept Recommendation

Description: As a farmer, the user wants to mark a recommendation as “Accepted” so that
the system tracks what has actually been planted.
Acceptance Criteria:

Given a recommendation is displayed,
When the user clicks “Accept”,
Then the field’s current crop status should be updated to match the recommendation.
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 10
2.2.5 Epic E5: Alerting and Notification System
E5-US1: Critical Threshold Alerts

Description: As a farmer, the user wants to receive a notification when soil moisture is
critically low so that crops do not die due to lack of water.
Acceptance Criteria:

Given the soil moisture is below the critical limit,
When the sensor transmits the data,
Then the system should generate a “Critical Alert” and notify the user.
E5-US2: View Unread Alerts

Description: As a farmer, the user wants to see a badge count of unread alerts so that any
missed information is visible.
Acceptance Criteria:

Given there are new alerts,
When the user opens the app,
Then the notification icon should show a badge with the number of unread items.
E5-US3: Resolve Alerts

Description: As a farmer, the user wants to mark an alert as resolved so that the notification
feed can be cleared.
Acceptance Criteria:

Given an active alert exists,
When the user clicks “Mark as Resolved”,
Then the alert should be moved to the history archive and its status updated.
2.2.6 Epic E6: Historical Data Analytics and Visualization
E6-US1: View Moisture Trends

Description: As a farmer, the user wants to see a line graph of soil moisture over the last
week so that drying patterns can be understood.
Acceptance Criteria:

Given historical data exists,
When the user selects the “Weekly View” on the chart,
Then the system should render a line graph showing moisture levels over the past 7
days.
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 11
E6-US2: Export Data

Description: As a farmer, the user wants to export farm data so that offline records can be
kept.
Acceptance Criteria:

Given the user is on the analytics screen,
When the “Export” button is clicked,
Then the system should generate a downloadable report (e.g., CSV or PDF).
E6-US3: Compare Fields

Description: As a farmer, the user wants to compare the water usage of two different fields
so that inefficiencies can be identified.
Acceptance Criteria:

Given the user selects two fields,
When the “Compare” option is chosen,
Then the system should display side-by-side statistics for both fields.
2.3 Test Cases
This section defines formal test cases mapped to user stories. Each test case includes pre-
conditions, test inputs, expected results, actual results, and execution status.

CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 12
2.3.1 Test Case 1 — Verify User Registration with Valid Data
This test case verifies the user registration process. It checks whether the system correctly
accepts valid user details, creates a new user account, stores the information in the database,
and redirects the user to the login page successfully.

Table 2.1: Verify User Registration with Valid Data
Test ID TC-E1-US1-
User Story ID E1-US
Module User Authentication and Registration
Test Case Description Verify that a new user can successfully regis-
ter using valid credentials and personal infor-
mation.
Preconditions User is on the registration screen and backend
server is operational.
Test Inputs Name = “Ali Khan”
Email = “ali@test.com”
Phone = “+923001234567”
Password = “Pass123”
Expected Result A new user account should be created success-
fully in the users table and the user should be
redirected to the login page.
Actual Result User account was created successfully and redi-
rected to the login page correctly.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 13
2.3.2 Test Case 2 — Verify Login with Valid Credentials
This test case validates the login functionality and ensures that a registered user can access
the dashboard using valid credentials.

Table 2.2: Verify Login with Valid Credentials
Test ID TC-E1-US2-01
User Story ID E1-US2
Module User Authentication
Test Case Description Verify that a registered user can log into the sys-
tem successfully using valid credentials.
Preconditions User account already exists in the system
database.
Test Inputs Email = “ali@test.com”
Password = “Pass123”
Expected Result System authenticates the user, generates JWT
token, and redirects to dashboard with HTTP
200 OK response.
Actual Result User was authenticated successfully and dash-
board loaded correctly with valid JWT token.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 14
2.3.3 Test Case 3 — Verify Profile Management
This test case verifies that a logged-in user can update profile information successfully.

Table 2.3: Verify Profile Management
Test ID TC-E1-US3-01
User Story ID E1-US3
Module Profile Management
Test Case Description Verify that the user can update personal profile
information successfully.
Preconditions User is logged in and profile screen is accessi-
ble.
Test Inputs Updated Phone = “+923009876543”
Expected Result Updated profile information should be saved in
the users table and success message should
be displayed.
Actual Result Profile information was updated successfully
and success message was displayed.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 15
2.3.4 Test Case 4 — Verify Field Overview Display
This test case verifies that the dashboard displays all registered fields with their current
status.

Table 2.4: Verify Field Overview Display
Test ID TC-E2-US1-01
User Story ID E2-US1
Module Real-Time Sensor Data Monitoring
Test Case Description Verify that all registered fields are displayed on
the dashboard with their current status.
Preconditions User is logged in and fields are registered in the
system.
Test Inputs User opens the dashboard screen.
Expected Result Dashboard should display all registered fields
with status indicators such as “Healthy” or
“Needs Water”.
Actual Result Registered fields were displayed successfully
with correct status indicators.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 16
2.3.5 Test Case 5 — Verify Real-Time Data Display
This test case verifies that real-time sensor readings are correctly displayed on the dash-
board interface.

Table 2.5: Verify Real-Time Data Display
Test ID TC-E2-US2-01
User Story ID E2-US2
Module Real-Time Monitoring
Test Case Description Verify that the latest sensor readings are cor-
rectly displayed on the user interface.
Preconditions ESP32 device is connected and sending teleme-
try to backend server.
Test Inputs Sensor ID = 14
Moisture = 45%
Temperature = 30◦C
Expected Result Dashboard should display updated moisture and
temperature values matching the sensor read-
ings stored in the database.
Actual Result Dashboard displayed “Moisture: 45%” and
“Temperature: 30◦C” correctly.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 17
2.3.6 Test Case 6 — Verify Sensor Status Monitoring
This test case verifies that the system detects and displays sensor status correctly.

Table 2.6: Verify Sensor Status Monitoring
Test ID TC-E2-US3-01
User Story ID E2-US3
Module Sensor Status Monitoring
Test Case Description Verify that the system displays offline status
when a sensor stops sending data.
Preconditions Sensor is registered in the system and dash-
board is accessible.
Test Inputs Sensor ID = 14 stops sending telemetry data.
Expected Result System should mark the sensor status as “Of-
fline” on the dashboard or sensor detail page.
Actual Result Sensor status changed to “Offline” successfully
when telemetry was not received.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 18
2.3.7 Test Case 7 — Verify Manual Pump Start
This test case verifies the manual irrigation control functionality from the mobile applica-
tion.

Table 2.7: Verify Manual Pump Start
Test ID TC-E3-US1-01
User Story ID E3-US1
Module Irrigation Control System
Test Case Description Verify that the irrigation pump starts success-
fully when triggered manually by the user.
Preconditions ESP32 device and relay module are connected
and operational.
Test Inputs User clicks “Start Irrigation” button for Field ID
= 6.
Expected Result System should activate the relay, update pump
status to “ON”, and create a new irrigation log
entry.
Actual Result Pump activated successfully and irrigation sta-
tus updated correctly in the application.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 19
2.3.8 Test Case 8 — Verify Automatic Trigger on Low Moisture
This test case validates the automatic irrigation functionality based on soil moisture thresh-
olds.

Table 2.8: Verify Automatic Trigger on Low Moisture
Test ID TC-E3-US2-01
User Story ID E3-US2
Module Automated Irrigation Control
Test Case Description Verify that the system automatically starts irri-
gation when soil moisture falls below the con-
figured threshold.
Preconditions Auto-irrigation mode is enabled and threshold
is configured.
Test Inputs Threshold = 30%
Simulated Moisture Reading = 25%
Expected Result System should automatically activate irrigation
pump and generate a low moisture alert notifi-
cation.
Actual Result Irrigation triggered automatically and alert no-
tification generated successfully.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 20
2.3.9 Test Case 9 — Verify Irrigation Logging
This test case verifies that irrigation events are properly recorded after completion.

Table 2.9: Verify Irrigation Logging
Test ID TC-E3-US3-01
User Story ID E3-US3
Module Irrigation Logs
Test Case Description Verify that completed irrigation cycles are
stored in irrigation history.
Preconditions Irrigation cycle has been started and completed
successfully.
Test Inputs User opens irrigation history/logs for Field ID
= 6.
Expected Result System should display irrigation start time,
end time, duration, and pump status in
irrigationlogs.
Actual Result Irrigation log was created and displayed suc-
cessfully with correct event details.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 21
2.3.10 Test Case 10 — Verify Crop Recommendation Generation
This test case verifies the AI-based crop recommendation functionality.

Table 2.10: Verify Crop Recommendation Generation
Test ID TC-E4-US1-01
User Story ID E4-US1
Module AI Crop Recommendation System
Test Case Description Verify that the AI model generates a suitable
crop recommendation based on field conditions.
Preconditions AI recommendation service is active and histor-
ical field data is available.
Test Inputs Field ID = 6
Soil Type = Loamy
Season = Rabi
Expected Result System should generate crop recommendation
with confidence score and store the result in the
database.
Actual Result System recommended “Wheat” with confi-
dence score successfully.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 22
2.3.11 Test Case 11 — Verify Recommendation Confidence Score
This test case verifies that the confidence score is displayed with the AI-generated crop
recommendation.

Table 2.11: Verify Recommendation Confidence Score
Test ID TC-E4-US2-01
User Story ID E4-US2
Module AI Crop Recommendation System
Test Case Description Verify that the system displays a confidence
percentage with the recommended crop.
Preconditions Crop recommendation has been generated suc-
cessfully.
Test Inputs User views generated recommendation result
for Field ID = 6.
Expected Result System should display recommended crop with
confidence score, for example “Wheat – 85%
Confidence”.
Actual Result Recommended crop and confidence score were
displayed successfully.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 23
2.3.12 Test Case 12 — Verify Accept Recommendation
This test case verifies that the user can accept an AI-generated crop recommendation.

Table 2.12: Verify Accept Recommendation
Test ID TC-E4-US3-01
User Story ID E4-US3
Module AI Crop Recommendation System
Test Case Description Verify that accepting a crop recommendation
updates the field crop status.
Preconditions A crop recommendation is already displayed on
the recommendation screen.
Test Inputs User clicks “Accept” on the recommendation
result “Wheat”.
Expected Result Field crop status should be updated to the ac-
cepted crop and recommendation should be
marked as accepted in the database.
Actual Result Recommendation was accepted successfully
and field crop status was updated.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 24
2.3.13 Test Case 13 — Verify Critical Alert Delivery
This test case verifies the notification and alert generation system.

Table 2.13: Verify Critical Alert Delivery
Test ID TC-E5-US1-01
User Story ID E5-US1
Module Alerts and Notifications
Test Case Description Verify that the system generates and displays
alerts for critical moisture conditions.
Preconditions Notification service and backend alert system
are operational.
Test Inputs Moisture Reading = 10% (Critical threshold ¡
15%)
Expected Result System should create a critical alert record and
display notification badge on the dashboard.
Actual Result Critical alert generated successfully and notifi-
cation displayed on user interface.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 25
2.3.14 Test Case 14 — Verify Unread Alert Count
This test case verifies that unread alerts are counted and displayed correctly.

Table 2.14: Verify Unread Alert Count
Test ID TC-E5-US2-01
User Story ID E5-US2
Module Alerts and Notifications
Test Case Description Verify that the notification icon displays the cor-
rect unread alert count.
Preconditions At least one unread alert exists in the system.
Test Inputs User opens the application dashboard.
Expected Result Notification icon should display badge count
according to the number of unread alerts.
Actual Result Notification badge displayed the correct unread
alert count successfully.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 26
2.3.15 Test Case 15 — Verify Resolve Alert Functionality
This test case verifies that users can mark alerts as resolved.

Table 2.15: Verify Resolve Alert Functionality
Test ID TC-E5-US3-01
User Story ID E5-US3
Module Alerts and Notifications
Test Case Description Verify that an active alert can be marked as re-
solved by the user.
Preconditions An active unresolved alert exists in the alerts
list.
Test Inputs User clicks “Mark as Resolved” on a low mois-
ture alert.
Expected Result Alert status should be updated as resolved and
moved to alert history.
Actual Result Alert was marked as resolved successfully and
removed from active alerts list.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 27
2.3.16 Test Case 16 — Verify Weekly Trend Graph
This test case validates historical data visualization and trend graph generation.

Table 2.16: Verify Weekly Trend Graph
Test ID TC-E6-US1-01
User Story ID E6-US1
Module Historical Analytics and Visualization
Test Case Description Verify that the weekly moisture trend graph dis-
plays accurate historical data points.
Preconditions Historical sensor data for the previous 7 days
exists in the database.
Test Inputs User selects “Last 7 Days” filter from analytics
dashboard.
Expected Result System should render line chart with correct
moisture readings and date labels for the pre-
vious week.
Actual Result Weekly trend graph displayed correctly with ac-
curate data points and timestamps.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 28
2.3.17 Test Case 17 — Verify Data Export
This test case verifies that the user can export farm data for offline record keeping.

Table 2.17: Verify Data Export
Test ID TC-E6-US2-01
User Story ID E6-US2
Module Historical Analytics and Reporting
Test Case Description Verify that the user can export historical farm
data successfully.
Preconditions Historical sensor readings are available in the
database.
Test Inputs User clicks “Export” button on analytics screen.
Expected Result System should generate downloadable report
file in CSV or PDF format.
Actual Result Farm data report was generated and down-
loaded successfully.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 29
2.3.18 Test Case 18 — Verify Field Comparison
This test case verifies that users can compare two fields using historical data.

Table 2.18: Verify Field Comparison
Test ID TC-E6-US3-01
User Story ID E6-US3
Module Historical Analytics and Visualization
Test Case Description Verify that the system compares water usage
and sensor statistics of two different fields.
Preconditions At least two fields with historical sensor and ir-
rigation data exist in the system.
Test Inputs Field A = Field ID 6
Field B = Field ID 7
Expected Result System should display side-by-side comparison
of moisture trends, water usage, and field statis-
tics.
Actual Result Field comparison was displayed successfully
with correct side-by-side statistics.
Status Pass
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 30
2.4 User Interface Design (Prototypes)
User Interface (UI) design focuses on simplicity, clarity, and ease of use for farmers. The
following prototypes describe the main screens of the system.

2.4.1 Login Screen
Figure 2.1: Login Screen UI Design
UI Layout: Centered card layout with logo at the top.
Fields and Components:

Email Address (input field with email validation).
Password (input field with obscured text).
Login (primary button).
Register (text link).
Validation Rules:
Email must be in valid format.
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 31
Password cannot be empty.
Navigation Behavior:
On successful login→ Redirect to dashboard.
On failure→ Show error toast.
2.4.2 Dashboard (Sensor Overview)
Figure 2.2: Dashboard UI Design
UI Layout: Grid layout of cards representing different fields.
Fields and Components:

Field Name (header).
Status Indicator (green/red dot).
Quick Stats (average moisture, temperature).
Add Field (floating action button).
Validation Rules: Not applicable (display only).
Navigation Behavior:
Tap on a field card→ Navigate to Detailed Sensor Data Page.
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 32
2.4.3 Detailed Sensor Data Page
Figure 2.3: Detailed Sensor Data Page UI Design
UI Layout: Tabbed view (Live Data, History, Settings).
Fields and Components:

Gauge Chart (visualizing soil moisture percentage).
Digital Readout (temperature, humidity).
Last Updated (timestamp).
Sensor ID (label).
Validation Rules:
Data refreshes every 30 seconds.
Navigation Behavior:
Back button→ Dashboard.
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 33
2.4.4 AI Crop Recommendation Screen
Figure 2.4: AI Crop Recommendation Screen UI Design
UI Layout: Form input followed by a result card.
Fields and Components:

Soil Type (dropdown).
Season (dropdown).
Analyze (button).
Recommendation Card (displays crop name, confidence percentage, yield estimate).
Accept Recommendation (button).
Validation Rules:
All dropdowns must be selected before clicking “Analyze”.
Navigation Behavior:
“Accept”→ Updates field details.
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 34
2.4.5 Irrigation Control Panel
Figure 2.5: Irrigation Control Panel UI Design
UI Layout: Toggle switches and slider controls.
Fields and Components:

Manual Control (on/off switch).
Auto-Irrigation (checkbox).
Moisture Threshold (slider from 0–100%).
Status (text: “Pump Running” / “Idle”).
Validation Rules:
Manual Control cannot be enabled if Auto-Irrigation is active (mutual exclusion).
Navigation Behavior:
Toggling a switch sends an API request immediately.
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 35
2.4.6 Alerts & Notifications Screen
Figure 2.6: Alerts & Notifications Screen UI Design
UI Layout: List view of notification cards.
Fields and Components:

Alert Icon (warning triangle, info circle).
Title (e.g., “Low Moisture Warning”).
Time (relative time, e.g., “2 mins ago”).
Mark as Read (swipe action or button).
Validation Rules:
Unread items are highlighted.
Navigation Behavior:
Tap on alert→ Navigate to relevant Field/Sensor page.
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 36
2.4.7 Settings / Profile Page
Figure 2.7: Settings / Profile Page UI Design
UI Layout: List of settings categories.
Fields and Components:

Profile Image (avatar).
Name, Email (editable fields).
Change Password (button).
Notification Preferences (toggles).
Logout (destructive button).
Validation Rules:
Password change requires old password verification.
Navigation Behavior:
Logout→ Redirect to login screen.
CHAPTER 2. REQUIREMENT SPECIFICATION AND ANALYSIS 37
2.5 Traceability Matrix
Table 2.19: Traceability Matrix
Epic User Story Test Case UI Screen
E1 (Auth) E1-US1 (Register User) TC-E1-US1-01 Login Screen (Reg-
ister)
E1 (Auth) E1-US2 (Login User) TC-E1-US2-01 Login Screen
E1 (Auth) E1-US3 (Manage Profile) TC-E1-US3-01 Settings / Profile
Page
E2 (Moni-
toring)
E2-US1 (View Field
Overview)
TC-E2-US1-01 Dashboard
E2 (Moni-
toring)
E2-US2 (View Sensor
Details)
TC-E2-US2-01 Detailed Sensor
Data Page
E2 (Moni-
toring)
E2-US3 (Monitor Sensor
Status)
TC-E2-US3-01 Dashboard / Sensor
Page
E3 (Irriga-
tion)
E3-US1 (Manual Irriga-
tion Control)
TC-E3-US1-01 Irrigation Control
Panel
E3 (Irriga-
tion)
E3-US2 (Automatic Irri-
gation Trigger)
TC-E3-US2-01 Irrigation Control
Panel
E3 (Irriga-
tion)
E3-US3 (View Irrigation
Logs)
TC-E3-US3-01 Detailed Sensor
Data Page (History
Tab)
E4 (AI) E4-US1 (Generate Crop
Recommendation)
TC-E4-US1-01 AI Crop Recom-
mendation Screen
E4 (AI) E4-US2 (View Recom-
mendation Confidence)
TC-E4-US2-01 AI Crop Recom-
mendation Screen
E4 (AI) E4-US3 (Accept Recom-
mendation)
TC-E4-US3-01 AI Crop Recom-
mendation Screen
E5 (Alerts) E5-US1 (Critical Alert
Generation)
TC-E5-US1-01 Alerts & Notifica-
tions Screen
E5 (Alerts) E5-US2 (View Unread
Alerts)
TC-E5-US2-01 Dashboard (Alert
Icon)
E5 (Alerts) E5-US3 (Resolve Alerts) TC-E5-US3-01 Alerts & Notifica-
tions Screen
E6 (Analyt-
ics)
E6-US1 (View Moisture
Trends)
TC-E6-US1-01 Detailed Sensor
Data Page (His-
tory)
E6 (Analyt-
ics)
E6-US2 (Export Histori-
cal Data)
TC-E6-US2-01 Settings / Profile
Page
E6 (Analyt-
ics)
E6-US3 (Compare Field
Statistics)
TC-E6-US3-01 Dashboard (Com-
parison View)
3 System Design
This chapter presents the blueprint of the proposed Smart AI Powered Agriculture System
by describing how the system is structured, how major components interact, and how the
design supports the functional requirements. The design decisions are made to ensure clear
traceability from requirements to implementation and to enable scalability, maintainability,
and real-time monitoring.

3.1 Software Architecture
The Smart AI Powered Agriculture System follows a Layered IoT Architecture with
event-driven behavior for real-time data updates and alerting. The layered approach sepa-
rates responsibilities across device, connectivity, backend, and application layers, ensuring
modularity and easier future enhancements. Event-driven behavior enables immediate ac-
tions when sensor readings cross defined thresholds (e.g., low soil moisture triggers irriga-
tion and an alert).

3.1.1 Architectural Layers
The architecture is organized into the following layers:

Device Layer (Field Unit): Sensors acquire environmental readings; ESP32 con-
trols irrigation via relay.
Connectivity Layer: Wi-Fi-based communication using HTTP/REST; MQTT can
be used for lightweight telemetry.
Backend Layer: Node.js services ingest sensor data, apply validation/rules, store
records in MySQL database, and expose APIs.
Application Layer: Mobile application provides monitoring, history, control, alerts,
and AI recommendations.
38
CHAPTER 3. SYSTEM DESIGN 39
Figure 3.1: System Architecture Diagram
3.2 Components and Connector
The system consists of multiple interacting components connected through well-defined
interfaces to ensure reliable data acquisition, transmission, processing, and user interaction.

Figure 3.2: Hardware Integration
3.2.1 Core Components
Sensing Unit: Soil moisture sensor, DHT22 (temperature/humidity), LDR (light),
rain sensor, and water flow sensor.
CHAPTER 3. SYSTEM DESIGN 40
Control Unit: ESP32 microcontroller reads sensors and controls irrigation through
the relay module.
Actuation Unit: Relay-driven pump/solenoid valve for water control (manual and
automatic).
Backend Services: Node.js server for device ingestion, business rules, alerts, and
mobile APIs.
Data Storage: MySQL for sensor logs, events, and user configuration.
AI/ML Service: Python-based recommendation module using historical and envi-
ronmental patterns.
Mobile Application: Android/Flutter app for monitoring, control, analytics, and
notifications.
3.2.2 Connectors (Interfaces)
Sensor→ ESP32: GPIO/ADC readings (digital/analog).
ESP32→ Backend: Wi-Fi communication using HTTP/REST (MQTT optional).
Backend→ Database: Firebase SDK / SQL connector for storage and retrieval.
Backend→ Mobile App: REST APIs for dashboard, history, and control.
Backend→ Notifications: Firebase Cloud Messaging for push alerts.
Backend↔ AI Service: API calls for crop recommendations and confidence scor-
ing.
3.3 Hardware Specifications
This section details the hardware components required for the field unit deployment, in-
cluding technical specifications, operating parameters, and integration requirements. Table
3.1 provides an overview of all components, while Table 3.2 presents detailed technical
specifications.

CHAPTER 3. SYSTEM DESIGN 41
3.3.1 Component Overview
Table 3.1: Hardware Components and Primary Functions
Component Specification / Purpose
ESP32 Microcontroller Dual-core 32-bit microcontroller with integrated Wi-Fi
(802.11 b/g/n) and Bluetooth. Controls sensor data ac-
quisition, local threshold logic, irrigation actuation, and
backend communication via HTTP/REST protocol.
Soil Moisture Sensor Capacitive or resistive sensor (YL-69 / HL-69) that mea-
sures volumetric water content in soil. Provides analog
output (0–1023) proportional to moisture level, enabling
precise irrigation decision-making.
DHT22 Sensor Digital temperature and humidity sensor with calibrated
output. Measures ambient temperature (–40°C to +80°C)
and relative humidity (0–100%) for crop environment
monitoring and weather correlation.
LDR Light Sensor Light Dependent Resistor that measures ambient light in-
tensity (0–1023 lux equivalent). Supports day/night de-
tection, optimal irrigation timing, and crop photosynthe-
sis analysis.
Rain Sensor Digital rain detection module (FC-37 / YL-82) with ad-
justable sensitivity. Detects rainfall conditions to pre-
vent irrigation during rain events and conserve water re-
sources.
Water Flow Sensor Hall effect-based flow meter (YF-S201) that measures
water flow rate (1–30 L/min) using pulse frequency out-
put. Enables accurate water consumption tracking and
irrigation efficiency analysis.
Relay Module Single-channel 5V relay with optocoupler isolation.
Switches high-power pump/valve circuits (up to 10A at
250V AC or 30V DC) based on ESP32 digital output or
manual mobile app commands.
Water Pump / Solenoid
Valve
12V DC submersible pump or AC-powered solenoid
valve for irrigation actuation. Flow rate: 500–2000
L/hour depending on field size and crop requirements.
Power Supply 5V/2A regulated adapter for ESP32 and sensors (via
ESP32’s 3.3V regulator). Separate 12V/220V supply for
pump/valve with protection circuitry (fuse, surge protec-
tion).
CHAPTER 3. SYSTEM DESIGN 42
3.3.2 Detailed Technical Specifications
Table 3.2: Hardware Technical Specifications and Interface Details
Component Model Technical Specs Interface
ESP32 ESP-WROOM-
32
CPU: Dual-core Xtensa LX6 @
240MHz; RAM: 520KB; Flash: 4MB;
Wi-Fi: 2.4GHz 802.11n; GPIO: 34 pins
Power: 5V
(VIN)
Soil Moisture YL-69 / Capaci-
tive
Operating Voltage: 3.3V–5V; Output:
Analog (0–1023); Response Time:<1s;
Probe Length: 60mm
Analog (A0)
Temperature &
Humidity
DHT22
(AM2302)
Temp Range: –40°C to +80°C (±0.5°C);
Humidity: 0–100% RH (±2–5%); Sam-
pling: 0.5Hz
Digital (GPIO)
Light Sensor LDR (5mm) Resistance Range: 1kΩ–10MΩ; Spec-
tral Peak: 540nm; Voltage: 3.3V–5V
Analog (A1)
Rain Sensor FC-37 / YL-82 Operating Voltage: 3.3V–5V; Detection
Area: 5cm × 4cm; Output: Digital
(HIGH/LOW)
Digital (GPIO)
Water Flow YF-S201 Flow Range: 1–30 L/min; Pressure: ≤
1.75MPa; Output: Pulse (F = 7.5Q Hz);
Voltage: 5V DC
Interrupt
(GPIO 2)
Relay Module 5V Single Chan-
nel
Coil Voltage: 5V DC; Contact Rating:
10A @ 250V AC / 30V DC; Isolation:
Optocoupler
Digital (GPIO)
Pump 12V DC Sub-
mersible
Voltage: 12V DC; Current: 0.5–1A;
Flow Rate: 500–1200 L/h; Head: 1.5–
3m
Relay
NO/COM
Power Supply AC/DC Adapter Input: 100–240V AC; Output: 5V/2A
(ESP32/Sensors), 12V/1A (Pump - sep-
arate)
DC Jack / Ter-
minal
CHAPTER 3. SYSTEM DESIGN 43
3.3.3 Pin Configuration and Wiring
Table 3.3 shows the ESP32 pin assignments for all connected hardware components.

Table 3.3: ESP32 Pin Configuration
Component ESP32 Pin Pin Type Signal
Soil Moisture Sensor GPIO 36 (A0) Analog Input 0–1023 (Moisture
%)
LDR Light Sensor GPIO 39 (A1) Analog Input 0–1023 (Lux)
DHT22 Sensor GPIO 4 (D4) Digital I/O Data Protocol
Rain Sensor GPIO 5 (D5) Digital Input HIGH / LOW
Water Flow Sensor GPIO 2 (D2) Interrupt Input Pulse Frequency
Relay Module GPIO 14 (D7) Digital Output HIGH (ON) / LOW
(OFF)
Power (VIN) 5V Pin Power Input 5V DC
Ground (GND) GND Pin Ground Common Ground
3.3.4 Power Consumption Analysis
The total power consumption of the field unit is estimated as follows:

ESP32 (Wi-Fi active): 160–260mA @ 3.3V≈ 0.5–0.9W
DHT22 Sensor: 1–1.5mA @ 3.3V≈ 0.005W
Soil Moisture + LDR + Rain Sensors: 10–20mA @ 3.3V≈ 0.03–0.07W
Water Flow Sensor: 15mA @ 5V≈ 0.075W
Relay Module (coil): 70mA @ 5V≈ 0.35W
Total (sensors & control): ≈ 1–1.5W
Water Pump (12V): 0.5–1A @ 12V = 6–12W (during irrigation only)
A 5V/2A power supply is sufficient for continuous sensor operation and relay control.
The water pump requires a separate 12V/1A supply with adequate surge protection.

CHAPTER 3. SYSTEM DESIGN 44
3.3.5 Cost Estimation
Table 3.4 provides approximate costs for hardware components (in PKR, Pakistani Rupees).

Table 3.4: Estimated Hardware Costs
Component Qty Estimated Cost (PKR)
ESP32 Development Board 1 1,200
Soil Moisture Sensor 1 300
DHT22 Sensor 1 400
LDR Sensor 1 50
Rain Sensor Module 1 200
Water Flow Sensor (YF-S201) 1 600
5V Relay Module 1 150
12V DC Water Pump 1 1,500
5V/2A Power Supply 1 300
12V/1A Power Supply 1 400
Connecting Wires & Miscellaneous — 500
Enclosure (Weatherproof) 1 800
Total per Field Unit 6,400 PKR
The estimated cost of PKR 6,400 ( USD 23) per field unit makes the system affordable
for small and medium-scale farmers in Pakistan. Bulk procurement and local sourcing can
further reduce costs.

3.4 Communication Protocols
The system uses Wi-Fi connectivity for field-to-server communication. The protocol stack
is selected to support reliability, scalability, and real-time monitoring:

Physical / Data Link Layer: Wi-Fi (IEEE 802.11)
Network Layer: IPv4
Transport Layer: TCP
Application Layer: HTTP/REST for configuration, control, and data retrieval;
MQTT (optional) for lightweight publish/subscribe telemetry.
CHAPTER 3. SYSTEM DESIGN 45
Figure 3.3: Communication Protocol Stack
3.5 Data Modeling
Data modeling defines how sensor readings, users, devices, irrigation events, and AI rec-
ommendations are structured to support real-time monitoring and historical analysis. The
system uses a relational database model (MySQL) to ensure data integrity, support com-
plex queries, and enable structured analytics.

3.5.1 Relational Database Model (MySQL)
A relational model ensures data integrity through foreign key constraints and supports struc-
tured analytics through SQL queries. The database consists of 11 core tables organized into
functional groups:

User & Field Management

users: Stores farmer and administrator accounts with authentication credentials
(email, phone, password hash), role-based access control (farmer/admin/technician),
and profile information.
fields: Represents agricultural plots with GPS coordinates (latitude, longitude), area
measurements, soil type, current crop, and planting/harvest dates.
Sensor & Telemetry

sensors: Registry of IoT devices (ESP32 units) deployed in fields, including device
identifiers, sensor types, firmware versions, battery levels, and calibration offsets.
sensorreadings: Time-series telemetry data capturing soil moisture, temperature,
humidity, and light intensity at regular intervals (typically 30 seconds).
CHAPTER 3. SYSTEM DESIGN 46
Irrigation Management

irrigationlogs: Complete history of irrigation events with mode (manual/automatic/scheduled),
duration, water usage, soil moisture levels before and after irrigation, and trigger
reasons.
irrigationschedules: Automated scheduling configurations for recurring irrigation
with time of day, frequency (daily/alternate days/weekly), and custom day settings.
Alerts & Recommendations

alerts: System notifications categorized by type (critical/warning/info) and category
(soil moisture, temperature, sensor offline), with multi-channel delivery tracking
(push notification, email, SMS).
croprecommendations: AI-generated crop suggestions with confidence scores,
expected yield, water requirements, growth duration, and seasonal recommendations
(Kharif/Rabi).
System Management

weatherdata: Weather history and forecasts including temperature, humidity, rain-
fall, wind speed, and cloud cover for environmental context.
systemsettings: Configurable thresholds (soil moisture limits, temperature alerts)
and user preferences with support for global and user-specific settings.
auditlogs: Security and compliance tracking for all system actions (login, create,
update, delete) with user identification, IP addresses, and JSON-formatted change
logs.
Key Relationships

The relational model enforces referential integrity through foreign key constraints:

One user can manage multiple fields (1:N relationship)
Each field can have multiple sensors deployed (1:N)
Each sensor generates numerous time-series readings (1:N)
Fields maintain irrigation history, schedules, alerts, and crop recommendations (1:N)
All critical relationships use CASCADE deletion to maintain data consistency
CHAPTER 3. SYSTEM DESIGN 47
Figure 3.4: Entity Relationship Diagram (ERD)
The ERD (Figure 3.4) illustrates all 11 tables with their primary keys, foreign keys, and
relationships, demonstrating the complete data model architecture.

3.5.2 Database Schema Specification
This section provides detailed schema specifications for critical tables in the system, in-
cluding column definitions, data types, constraints, and indexing strategies.

Figure 3.5: Complete Database Schema
CHAPTER 3. SYSTEM DESIGN 48
Users Table

The users table stores authentication and profile information for all system users.

Column Name Data Type Description
userid INT(11) PK Auto-increment primary key
fullname VARCHAR(100) User’s full name
email VARCHAR(100) UNIQUE Email address for authentication
phone VARCHAR(20) UNIQUE Phone number with country code
passwordhash VARCHAR(255) bcrypt hashed password
role ENUM farmer / admin / technician
isactive TINYINT(1) Account status (1 = active)
createdat TIMESTAMP Account creation timestamp
lastlogin TIMESTAMP Last successful login
Table 3.5: Users Table Schema
Fields Table

The fields table represents agricultural plots managed by users.

Column Name Data Type Description
fieldid INT(11) PK Auto-increment primary key
userid INT(11) FK Foreign key to users table
fieldname VARCHAR(100) Name/identifier of the field
locationlatitude DECIMAL(10,8) GPS latitude coordinate
locationlongitude DECIMAL(11,8) GPS longitude coordinate
areasize DECIMAL(10,2) Field area (in acres/hectares)
soiltype VARCHAR(50) e.g., Loamy, Sandy, Clay
currentcrop VARCHAR(100) Currently planted crop
plantingdate DATE Crop planting date
expectedharvestdate DATE Expected harvest date
isactive TINYINT(1) Field status (1 = active)
Table 3.6: Fields Table Schema
CHAPTER 3. SYSTEM DESIGN 49
Sensors Table

The sensors table maintains a registry of all IoT devices deployed in the field.

Column Name Data Type Description
sensorid INT(11) PK Auto-increment primary key
fieldid INT(11) FK Foreign key to fields table
sensortype ENUM combined / soilmoisture / temperature
deviceid VARCHAR(100) UNIQUE ESP32 MAC address or identifier
sensormodel VARCHAR(100) e.g., ESP32 + DHT11 + Soil Sensor
installationdate DATE Sensor deployment date
batterylevel DECIMAL(5,2) Battery percentage (if applicable)
firmwareversion VARCHAR(20) Current firmware version
isactive TINYINT(1) Sensor status (1 = active)
Table 3.7: Sensors Table Schema
Sensor Readings Table

The sensorreadings table stores time-series telemetry data from ESP32 sensors.

Column Name Data Type Description
readingid BIGINT(20) PK Auto-increment primary key
sensorid INT(11) FK Foreign key to sensors table
readingtime TIMESTAMP Timestamp of sensor reading
soilmoisture DECIMAL(5,2) Soil moisture percentage (0-100)
temperature DECIMAL(5,2) Temperature in Celsius
humidity DECIMAL(5,2) Humidity percentage (0-100)
lightintensity INT(11) Light intensity in Lux
createdat TIMESTAMP Record creation timestamp
Table 3.8: Sensor Readings Table Schema
Indexes: Composite index on (sensorid, readingtime) for efficient time-series
queries. This table is expected to have high insert volume and requires periodic archiving.

Irrigation Logs Table

The irrigationlogs table tracks all irrigation events with detailed metrics.

CHAPTER 3. SYSTEM DESIGN 50
Column Name Data Type Description
logid BIGINT(20) PK Auto-increment primary key
fieldid INT(11) FK Foreign key to fields table
irrigationtype ENUM automatic / manual / scheduled
starttime TIMESTAMP Irrigation start timestamp
endtime TIMESTAMP Irrigation end timestamp
durationminutes INT(11) Calculated duration
waterusedliters DECIMAL(10,2) Water consumption
soilmoisturebefore DECIMAL(5,2) Pre-irrigation moisture
soilmoistureafter DECIMAL(5,2) Post-irrigation moisture
pumpstatus ENUM on / off / error
createdat TIMESTAMP Log creation timestamp
Table 3.9: Irrigation Logs Table Schema
Alerts Table

The alerts table manages system notifications with multi-channel delivery tracking.

Column Name Data Type Description
alertid BIGINT(20) PK Auto-increment primary key
userid INT(11) FK Foreign key to users table
fieldid INT(11) FK Foreign key to fields table
alerttype ENUM critical / warning / info / success
alertcategory ENUM soilmoisture / temperature / irriga-
tion
title VARCHAR(200) Alert title
message TEXT Detailed alert message
thresholdvalue DECIMAL(10,2) Configured threshold
currentvalue DECIMAL(10,2) Actual sensor value
isread TINYINT(1) Read status flag
isresolved TINYINT(1) Resolution status flag
pushnotificationsent TINYINT(1) FCM delivery flag
createdat TIMESTAMP Alert generation timestamp
Table 3.10: Alerts Table Schema
CHAPTER 3. SYSTEM DESIGN 51
Crop Recommendations Table

The croprecommendations table stores AI-generated crop suggestions.

Column Name Data Type Description
recommendationid INT(11) PK Auto-increment primary key
fieldid INT(11) FK Foreign key to fields table
recommendedcrop VARCHAR(100) Suggested crop name
confidencescore DECIMAL(5,2) AI model confidence (0-100)
soilmoistureavg DECIMAL(5,2) Average soil moisture
temperatureavg DECIMAL(5,2) Average temperature
season VARCHAR(20) e.g., Kharif, Rabi
expectedyield DECIMAL(10,2) Expected yield (kg/acre)
waterrequirement VARCHAR(50) Low / Medium / High
growthdurationdays INT(11) Days to harvest
recommendationreason TEXT AI explanation/justification
isaccepted TINYINT(1) Farmer acceptance flag
createdat TIMESTAMP Recommendation timestamp
Table 3.11: Crop Recommendations Table Schema
Indexing Strategy

To optimize query performance, the following indexes are implemented:

Primary Keys: Auto-increment indexes on all primary key columns
Foreign Keys: Indexes on all foreign key columns (userid, fieldid, sensorid)
Unique Constraints: Indexes on email, phone, deviceid for uniqueness enforce-
ment
Composite Indexes: (sensorid, readingtime) for time-series queries on sensorreadings
Status Flags: Indexes on isactive, isread, isresolved for filtered queries
Timestamps: Indexes on createdat, readingtime for chronological sorting
The database uses UTF-8 (utf8mb4) character encoding for multilingual support and
InnoDB storage engine for ACID compliance and transaction support.

CHAPTER 3. SYSTEM DESIGN 52
3.6 Workflow Diagram
The workflow describes the operational sequence from sensing to decision-making, actua-
tion, alerting, and AI-based recommendations:

ESP32 reads sensor values at defined intervals.
Sensor telemetry is transmitted to the backend server over Wi-Fi.
Backend validates and stores readings in MySQL.
Threshold rules are evaluated (e.g., soil moisture below limit).
If irrigation is required, the backend/ESP32 triggers the relay to turn the pump/valve
ON.
Irrigation events and water usage are logged using the flow sensor.
Alerts are generated for critical conditions and pushed to users via notifications.
AI service analyzes historical and current context to generate crop recommenda-
tions.
Figure 3.6: System Workflow Diagram
3.7 Third-Parties Dependencies
The proposed system integrates third-party libraries, frameworks, and services to reduce
development time and improve reliability:

CHAPTER 3. SYSTEM DESIGN 53
Arduino IDE / ESP32 SDK: Embedded development environment for ESP32 firmware.
Node.js + Express.js: Backend development framework for APIs and device inges-
tion.
MySQL (MariaDB): Relational database for structured storage, complex queries,
and analytics.
Firebase Cloud Messaging (FCM): Push notifications for alerts and updates.
Android (Java/Kotlin) / Flutter: Mobile application development platform.
Visualization Library: Graphs and charts (e.g., MPAndroidChart or equivalent).
Python ML Libraries: TensorFlow / Scikit-learn for crop recommendation model-
ing.
4 Software Development
This chapter describes the implementation of the Smart AI Powered Agriculture System at
a finer level of detail. It explains the development standards, environment, and key software
modules across the embedded firmware (ESP32), backend services (Node.js), mobile ap-
plication (Android/Flutter), and the AI/ML recommendation service. The implementation
is aligned with the system design described in Chapter 3.

4.1 Coding Standards
To ensure maintainability, readability, and consistent collaboration among team members,
the following coding standards were followed:

4.1.1 General Standards
Consistent naming conventions were used across all modules (camelCase for vari-
ables/functions, PascalCase for classes).
Functions were kept small and single-purpose to improve modularity and testability.
All modules include meaningful comments for complex logic and configuration pa-
rameters.
Sensitive information (API keys, tokens) was kept out of source code and stored
using environment variables or secure configuration files.
Proper error handling and validation were applied at the boundaries (API inputs,
sensor readings, and database writes).
4.1.2 ESP32 Firmware Standards
Clear separation of concerns: sensor reading, networking, and actuation logic im-
plemented as separate functions.
Debouncing and filtering used for noisy sensors (e.g., rain sensor) to avoid false
triggers.
Safe defaults: irrigation is turned OFF when network or sensor failures occur to
avoid uncontrolled watering.
54
CHAPTER 4. SOFTWARE DEVELOPMENT 55
4.1.3 Backend Standards (Node.js)
REST endpoints follow consistent URI patterns and HTTP status codes.
Middleware-based validation and authentication (JWT) is enforced for protected
routes.
Logging includes request IDs and timestamps for debugging and audit.
4.1.4 Mobile Application Standards
UI components follow a consistent design system for readability and ease of use.
Data is fetched asynchronously and cached for better user experience.
Input forms (thresholds, schedules) validate values before sending to backend.
4.2 Development Environment
This section describes the tools, platforms, and configurations used for software develop-
ment.

4.2.1 Tools and Platforms
Embedded/Firmware: Arduino IDE with ESP32 board support packages.
Backend: Node.js runtime with Express.js framework.
Database: MySQL (MariaDB) for all data storage and retrieval operations.
Mobile: Android Studio (Android) or Flutter SDK (cross-platform).
AI/ML: Python environment with TensorFlow / Scikit-learn.
Version Control: Git for collaborative development and change tracking.
4.2.2 Testing Setup
Firmware testing: Serial monitor logging and controlled sensor value simulation.
Backend testing: API testing using Postman and unit checks for validation logic.
Mobile testing: Emulators and physical device testing for UI and notifications.
End-to-end testing: Real sensor readings sent to backend, verified on app dash-
board and alert system.
CHAPTER 4. SOFTWARE DEVELOPMENT 56
4.3 Software Description
The Smart AI Powered Agriculture System is fully functional and deployed. The core im-
plementation is based on ESP32 firmware that integrates sensors, Wi-Fi communication,
backend API interaction, local safety control, and relay-based irrigation automation. The
firmware is responsible for reading environmental data, applying local decision logic, re-
ceiving pump commands from the backend, and uploading sensor readings for storage,
alerts, analytics, and AI-based processing.

4.3.1 Snippet 1: Hardware Pin Configuration
The ESP32 firmware defines dedicated GPIO pins for soil moisture, rainfall, light inten-
sity, temperature/humidity, and relay-based pump control. This configuration connects the
physical field unit with the software logic.

// Pin Definitions
#define SOIL_PIN 34
#define RAIN_PIN 33
#define LIGHT_PIN 32
#define DHT_PIN 4
#define RELAY_PIN 5

#define DHT_TYPE DHT22
DHT dht(DHT_PIN, DHT_TYPE);

Outcome: The hardware components are mapped with ESP32 pins, enabling the firmware
to collect sensor data and control the irrigation relay.

4.3.2 Snippet 2: Sensor Threshold Configuration
Threshold values are defined to classify soil condition, rainfall status, and light intensity.
These values are used by the firmware for local automation and safety decisions.

// Sensor Thresholds
#define SOIL_DRY_THRESHOLD 2800
#define SOIL_WET_THRESHOLD 1200
#define RAIN_THRESHOLD 2000
#define LIGHT_DARK_THRESHOLD 3000

Outcome: The system can identify dry soil, wet soil, rainfall, and dark light conditions
using predefined sensor thresholds.

CHAPTER 4. SOFTWARE DEVELOPMENT 57
4.3.3 Snippet 3: Three-Tier Timing System
The firmware uses a three-tier timing mechanism to separate fast local safety checks, back-
end command synchronization, and full telemetry upload.

// Timing Configuration
#define SENSOR_READ_INTERVAL 1000
#define COMMAND_POLL_INTERVAL 5000
#define SENSOR_UPLOAD_INTERVAL 30000
#define BACKEND_RETRY_INTERVAL 5000
#define WIFI_RETRY_INTERVAL_MS 10000
#define PUMP_MIN_RUN_TIME 1500

Outcome: Sensors are read every second, backend commands are checked every five
seconds, and complete sensor data is uploaded every thirty seconds.

4.3.4 Snippet 4: Safe System Initialization
During startup, the ESP32 initializes serial communication, starts the DHT sensor, config-
ures the relay pin, and keeps the pump OFF by default. Since the relay is active-low, HIGH
means OFF.

void setup() {
Serial.begin(115200);
delay(2000);

dht.begin();
// Active-LOW relay: HIGH = OFF
pinMode(RELAY_PIN, OUTPUT_OPEN_DRAIN);
digitalWrite(RELAY_PIN, HIGH);
connectToWiFi();
}

Outcome: The pump remains safely OFF during startup, preventing accidental irriga-
tion when the device powers on.

4.3.5 Snippet 5: Main Execution Loop
The main loop controls the complete execution flow. It checks Wi-Fi status, reads sensors,
applies local safety logic, polls backend commands, and uploads sensor data.

CHAPTER 4. SOFTWARE DEVELOPMENT 58
void loop() {
unsigned long now = millis();

if (WiFi.status() == WL_CONNECTED) {
wifiConnected = true;
} else {
wifiConnected = false;
if (now - lastWifiAttemptMs >= WIFI_RETRY_INTERVAL_MS) {
connectToWiFi();
lastWifiAttemptMs = millis();
}
}
if (now - lastSensorReadTime >= SENSOR_READ_INTERVAL) {
lastSensorReadTime = now;
readAllSensors(cachedSoilValue, cachedRainValue,
cachedLightValue, cachedTemp, cachedHum);
if (wifiConnected)
applyLocalRainSafety(cachedRainValue);
else
runOfflinePumpLogic(cachedSoilValue, cachedRainValue);
}
if (wifiConnected &&
now - lastCommandPollTime >= COMMAND_POLL_INTERVAL) {
lastCommandPollTime = now;
fetchPumpCommand();
}
if (wifiConnected &&
now - lastUploadTime >= SENSOR_UPLOAD_INTERVAL) {
if (sendSensorDataToBackend(cachedSoilValue, cachedRainValue,
cachedLightValue, cachedTemp, cachedHum)) {
lastUploadTime = now;
}
}
}

CHAPTER 4. SOFTWARE DEVELOPMENT 59
Outcome: The firmware performs real-time monitoring, backend synchronization, and
sensor data upload in a structured and efficient manner.

4.3.6 Snippet 6: Smoothed Sensor Reading
Analog sensor values are averaged using multiple samples to reduce noise and improve
reading stability.

int readAnalogSmoothed(uint8_t pin) {
long sum = 0;

for (int i = 0; i < ANALOG_SAMPLES; i++) {
sum += analogRead(pin);
delayMicroseconds(150);
}
return (int)(sum / ANALOG_SAMPLES);
}

Outcome: Sensor readings become more stable and reliable, reducing false triggers
caused by noisy analog signals.

4.3.7 Snippet 7: Sensor Data Acquisition
The firmware reads soil moisture, rainfall, light intensity, temperature, and humidity values
from the connected sensors.

bool readDht(float& tempC, float& humPct) {
humPct = dht.readHumidity();
tempC = dht.readTemperature();

if (isnan(humPct) || isnan(tempC)) {
tempC = -999;
humPct = -999;
return false;
}
return true;
}

void readAllSensors(int& soil, int& rain, int& light,
float& tempC, float& humPct) {

CHAPTER 4. SOFTWARE DEVELOPMENT 60
soil = readAnalogSmoothed(SOIL_PIN);
rain = readAnalogSmoothed(RAIN_PIN);
light = readAnalogSmoothed(LIGHT_PIN);
readDht(tempC, humPct);
}

Outcome: The ESP32 collects all required environmental readings and stores them in
cached variables for processing and upload.

4.3.8 Snippet 8: Local Rain Safety Mechanism
The system includes a local rain override mechanism. If rainfall is detected, the pump is
immediately turned OFF without waiting for backend response.

void applyLocalRainSafety(int rainValue) {
bool raining = (rainValue < RAIN_THRESHOLD);

if (raining) {
if (!rainOverrideActive) {
rainOverrideActive = true;
turnPumpOff();
Serial.println("Rain detected: pump OFF");
}
return;
}
if (rainOverrideActive) {
rainOverrideActive = false;
int restoreCmd = lastBackendPumpState;
lastBackendPumpState = -2;
syncRelayToCommand(restoreCmd, "rain_cleared_restore");
}
}

Outcome: The irrigation pump is protected from running during rainfall, reducing wa-
ter wastage and improving system safety.

4.3.9 Snippet 9: Backend Command Polling
The ESP32 polls the backend to check the latest pump command sent from the mobile
application or backend automation logic.

CHAPTER 4. SOFTWARE DEVELOPMENT 61
bool fetchPumpCommand() {
if (WiFi.status() != WL_CONNECTED) return false;

WiFiClientSecure secureClient;
HTTPClient http;
String endpoint = String("https://") + BACKEND_HOST +
COMMAND_PATH + deviceId;
secureClient.setInsecure();
if (!http.begin(secureClient, endpoint)) return false;
int code = http.GET();
if (code == 200) {
String response = http.getString();
StaticJsonDocument<128> doc;
if (!deserializeJson(doc, response) &&
doc.containsKey("pump_status")) {
int commanded = doc["pump_status"].as<int>();
const char* reason = doc["pump_reason"] | "unknown";
syncRelayToCommand(commanded, reason);
}
}
http.end();
return code == 200;
}

Outcome: The field device stays synchronized with backend pump commands and
supports remote irrigation control from the application.

4.3.10 Snippet 10: Relay Synchronization Logic
The relay synchronization function applies backend commands only when the pump state
changes. It also blocks ON commands during rainfall.

void syncRelayToCommand(int commanded, const char* reason) {
if (rainOverrideActive && commanded == 1) {
Serial.println("Command blocked due to rain override");

CHAPTER 4. SOFTWARE DEVELOPMENT 62
return;
}
if (commanded == lastBackendPumpState) {
return;
}
lastBackendPumpState = commanded;
if (commanded == 1 && !pumpRunning) {
turnPumpOn();
} else if (commanded == 0 && pumpRunning) {
turnPumpOff();
}
}

Outcome: The relay avoids unnecessary repeated switching and ensures backend com-
mands cannot override local rain safety.

4.3.11 Snippet 11: Relay-Based Pump Control
The pump is controlled through an active-low relay. Setting the relay pin LOW turns the
pump ON, while HIGH turns it OFF.

void turnPumpOn() {
digitalWrite(RELAY_PIN, LOW);
pumpRunning = true;
pumpStartTime = millis();
}

void turnPumpOff() {
digitalWrite(RELAY_PIN, HIGH);
pumpRunning = false;
}

Outcome: The system can physically control the irrigation pump through the ESP32
and relay module.

4.3.12 Snippet 12: Offline Irrigation Logic
If Wi-Fi is disconnected, the ESP32 continues irrigation control locally using soil moisture
and rainfall sensor values.

CHAPTER 4. SOFTWARE DEVELOPMENT 63
void runOfflinePumpLogic(int soilValue, int rainValue) {
bool raining = (rainValue < RAIN_THRESHOLD);
bool soilWet = (soilValue < SOIL_WET_THRESHOLD);
bool soilDry = (soilValue > SOIL_DRY_THRESHOLD);

if (soilDry) requestedPumpState = true;
else if (soilWet) requestedPumpState = false;
if (raining) {
rainOverrideActive = true;
if (pumpRunning) turnPumpOff();
return;
}
if (soilWet && pumpRunning &&
millis() - pumpStartTime >= PUMP_MIN_RUN_TIME) {
turnPumpOff();
return;
}
if (requestedPumpState && !pumpRunning) {
turnPumpOn();
}
}

Outcome: The irrigation system remains functional even when internet connectivity is
unavailable.

4.3.13 Snippet 13: Wi-Fi Connectivity and Reconnection
The ESP32 connects to Wi-Fi in station mode and updates the connection state. If the
connection fails, the firmware continues with offline logic.

void connectToWiFi() {
if (WiFi.status() == WL_CONNECTED) {
wifiConnected = true;
return;
}

WiFi.mode(WIFI_STA);
WiFi.begin("Your_SSID", "Your_Password");
CHAPTER 4. SOFTWARE DEVELOPMENT 64
unsigned long startTime = millis();
while (WiFi.status() != WL_CONNECTED &&
millis() - startTime < 12000) {
delay(400);
}
wifiConnected = (WiFi.status() == WL_CONNECTED);
}

Outcome: The firmware supports automatic Wi-Fi connection handling while main-
taining system operation in offline mode.

4.3.14 Snippet 14: Sensor Value Conversion
Raw analog values are converted into percentage values before transmission to the backend,
making the data easier to understand and display in the application.

float convertSoilMoistureToPercentage(int rawValue) {
return constrain((float)map(rawValue, 0, 4095, 100, 0),
0.0f, 100.0f);
}

float convertLightToPercentage(int rawValue) {
return constrain((float)map(rawValue, 0, 4095, 100, 0),
0.0f, 100.0f);
}

Outcome: Raw ADC readings are normalized into user-friendly percentage values for
dashboard visualization and backend processing.

4.3.15 Snippet 15: Sensor Data Upload to Backend
The firmware prepares a JSON payload containing device ID, sensor values, rainfall status,
and pump state. The data is uploaded to the deployed backend API using HTTP POST.

bool sendSensorDataToBackend(int soilRaw, int rainRaw,
int lightRaw, float temp, float hum) {
if (WiFi.status() != WL_CONNECTED) return false;

float soilMoisture = convertSoilMoistureToPercentage(soilRaw);
float lightIntensity = convertLightToPercentage(lightRaw);
CHAPTER 4. SOFTWARE DEVELOPMENT 65
bool raining = (rainRaw < RAIN_THRESHOLD);
StaticJsonDocument<384> doc;
doc["device_id"] = deviceId;
doc["soil_moisture"] = soilMoisture;
doc["light_intensity"] = lightIntensity;
doc["rainfall"] = raining;
doc["pump_on"] = pumpRunning? 1 : 0;
if (temp != -999) doc["temperature"] = temp;
if (hum != -999) doc["humidity"] = hum;
String jsonString;
serializeJson(doc, jsonString);
WiFiClientSecure secureClient;
HTTPClient http;
String endpoint = String("https://") + BACKEND_HOST + API_PATH;
secureClient.setInsecure();
http.begin(secureClient, endpoint);
http.addHeader("Content-Type", "application/json");
int code = http.POST(jsonString);
http.end();
return (code == 200 || code == 201);
}

Outcome: Sensor readings are successfully transmitted to the backend for database
storage, alerts, analytics, and application display.

4.4 Implementation Challenges and Resolutions
During implementation, several challenges were encountered and resolved:

Noisy Sensor Readings: Soil moisture and rain sensors produced unstable values
in early tests. This was resolved by applying filtering, threshold smoothing, and
debouncing logic.
CHAPTER 4. SOFTWARE DEVELOPMENT 66
Intermittent Wi-Fi Connectivity: Network dropouts caused missed telemetry up-
loads. Automatic reconnect and retry mechanisms were introduced in firmware.
Consistent Data Synchronization: Ensuring the dashboard always reflects the lat-
est reading required consistent timestamp handling and backend validation.
4.5 Summary
This chapter presented the implementation details of the Smart AI Powered Agriculture
System, including embedded firmware, backend services, mobile application logic, notifi-
cations, and AI-based crop recommendations. The described modules directly implement
the requirements defined in Chapter 2 and conform to the system design presented in Chap-
ter 3.

5 Software Deployment
This chapter describes the installation and deployment process of the Smart AI Powered
Agriculture System. The deployment includes four major deliverables: (1) ESP32 firmware
on the field unit, (2) backend server deployment, (3) database configuration, and (4) mobile
application installation. The goal is to ensure the complete system can be set up reliably
and used by end users (farmers) with minimal technical effort.

5.1 Installation / Deployment Process Description
5.1.1 Deployment Overview
The deployment is performed in the following order to ensure correct integration:

Prepare and connect hardware components (sensors, ESP32, relay, pump/valve).
Flash ESP32 firmware and configure Wi-Fi/device identifiers.
Deploy backend services (Node.js) and configure environment variables.
Configure the database (Firebase Realtime Database and/or MySQL).
Install and connect the mobile application to the backend.
Perform end-to-end verification (live readings, control actions, alerts, and AI out-
put).
5.1.2 Hardware Setup and Field Installation
The field unit installation ensures correct sensor placement and safe electrical connections.

ESP32 and Sensors: Connect soil moisture sensor to ESP32 ADC pin, DHT22 to
digital pin, LDR to ADC pin, rain sensor to digital pin, and flow sensor to interrupt-
capable pin.
Relay and Pump/Valve: Relay input is connected to ESP32 GPIO output. The
relay output is wired to the pump/valve power line to allow switching.
Power: Use regulated supply for ESP32 and sensors. If the pump requires higher
voltage/current, use a separate power source with proper isolation.
Placement: Soil moisture sensor is inserted into soil near crop roots; rain sensor is
placed in open air; flow sensor is installed inline with irrigation pipe.
67
CHAPTER 5. SOFTWARE DEPLOYMENT 68
Safety Note: Electrical wiring for pumps should be performed using proper insulation,
fuses, and safe grounding to prevent hazards.

5.1.3 ESP32 Firmware Deployment
The firmware is uploaded using Arduino IDE (or compatible toolchain) and configured for
the target farm environment.

Firmware Flashing Steps

Install Arduino IDE and ESP32 board support packages.
Connect ESP32 to a computer via USB.
Select the correct ESP32 board and COM port in Arduino IDE.
Update configuration parameters in the firmware:
Wi-Fi SSID and password
Backend base URL (API endpoint)
Device ID / Field ID mapping
Default moisture thresholds (initial values)
Upload the firmware to ESP32 and monitor serial logs for confirmation.
Post-Flash Verification

Confirm Wi-Fi connection is established.
Confirm sensor values are printed in serial logs.
Confirm telemetry requests are reaching the backend (HTTP 200 OK).
Confirm relay toggles correctly in manual test mode.
5.1.4 Backend Deployment (Node.js Server)
The backend server hosts REST APIs for device ingestion, user authentication, dashboard
data, irrigation control, alerts, and AI recommendation requests.

Backend Installation Requirements

Node.js runtime (LTS recommended)
Package manager (npm)
Firebase Admin SDK credentials (for Firebase option)
MySQL credentials (if MySQL option is enabled)
CHAPTER 5. SOFTWARE DEPLOYMENT 69
Backend Deployment Steps

Clone/copy backend source code to the target server machine.
Install dependencies:
npm install
Configure environment variables (example):
PORT=8080
JWT_SECRET=your_secret_key
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_SERVICE_ACCOUNT=path_to_service_account.json
MYSQL_HOST=localhost
MYSQL_USER=root
MYSQL_PASSWORD=******
MYSQL_DB=smart_agri
AI_SERVICE_URL=http://<ai-host>:5000
Start the backend service:
npm start
Verify health endpoint and API availability using a browser or API tool (e.g., Post-
man).
Backend Deployment Modes

Local Server Mode: Suitable for demos and lab testing (same network).
Cloud Server Mode: Recommended for remote access by farmers outside the local
network.
5.1.5 Database Deployment and Configuration
The system uses MySQL (MariaDB) as the relational database for all data storage, includ-
ing sensor telemetry, user management, irrigation logs, alerts, and AI-generated crop rec-
ommendations. MySQL ensures data integrity through foreign key constraints and supports
complex queries for analytics and reporting.

CHAPTER 5. SOFTWARE DEPLOYMENT 70
MySQL Database Setup

Install MySQL Server (or MariaDB) and start the service:
sudo systemctl start mysql
sudo systemctl enable mysql
Create the database and user:
CREATE DATABASE smart_agriculture;
CREATE USER ’smart_agri_user’@’localhost’
IDENTIFIED BY ’secure_password’;
GRANT ALL PRIVILEGES ON smart_agriculture.*
TO ’smart_agri_user’@’localhost’;
FLUSH PRIVILEGES;
Import the database schema (11 tables):
mysql -u smart_agri_user -p smart_agriculture
< schema.sql
Core tables created:
User & Field Management: users, fields
Sensor & Telemetry: sensors, sensorreadings
Irrigation: irrigationlogs, irrigationschedules
Alerts & AI: alerts, croprecommendations
System: weatherdata, systemsettings, auditlogs
Configure indexes for performance optimization:
Index on (sensorid, readingtime) for sensorreadings table
Index on (fieldid) for all related tables
Index on (userid) for authentication queries
Index on timestamps for time-series queries
Set up database connection in backend (Node.js):
const mysql = require(’mysql2/promise’);
const pool = mysql.createPool({
host: ’localhost’,
CHAPTER 5. SOFTWARE DEPLOYMENT 71
user: ’smart_agri_user’,
password: process.env.DB_PASSWORD,
database: ’smart_agriculture’,
waitForConnections: true,
connectionLimit: 10
});
Verify database connectivity:
SELECT COUNT(*) FROM users;
SELECT * FROM sensors WHERE is_active = 1;
5.1.6 AI Service Deployment (Python)
The AI service provides crop recommendations based on extracted features from sensor
history and environmental context.

Deployment Steps

Set up Python environment (virtual environment recommended).
Install required libraries (e.g., TensorFlow/Scikit-learn).
Place the trained model file in the service directory.
Run the AI service API (example):
python app.py
Configure backend AISERVICEURL to connect to the AI endpoint.
AI Verification

Send a test request with sample feature payload.
Confirm response contains recommended crop(s) and confidence score.
5.1.7 Mobile Application Deployment
The mobile application is used by farmers to view live sensor readings, irrigation status,
historical analytics, alerts, and AI crop recommendations.

Installation Steps

Build the mobile application APK (or install via test distribution).
Install on an Android device (enable “Install from unknown sources” if needed).
Configure base URL (backend server address) and sign in/register.
Add/register field/device mapping (Field ID and Device ID).
CHAPTER 5. SOFTWARE DEPLOYMENT 72
Mobile Verification Checklist

Live readings update correctly on dashboard.
Manual irrigation control toggles pump/valve.
Alerts appear in the app and push notifications are received.
Weekly trends / historical charts load from stored data.
AI recommendation screen returns crop suggestions with confidence.
5.2 End-to-End System Validation
After deployment, the complete system is validated using a practical checklist to ensure
correct integration:

Telemetry Check: ESP32 sends readings and backend stores them successfully.
Dashboard Check: Mobile app displays live readings and device status.
Automation Check: When soil moisture drops below threshold, irrigation triggers
automatically (rain condition blocks irrigation).
Logging Check: Irrigation events and water usage logs are recorded.
Alert Check: Critical low moisture generates a push notification.
AI Check: Crop recommendation is produced from recent/historical data with con-
fidence score.
5.3 Summary
This chapter described the deployment of the Smart AI Powered Agriculture System, in-
cluding hardware installation, ESP32 firmware flashing, backend and database configura-
tion, AI service deployment, and mobile application setup. A final validation checklist was
provided to confirm end-to-end system correctness after installation.