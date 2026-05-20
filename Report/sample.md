Autonomous Drone Delivery System
Farhad Ali (BSE221026)
Hammad Mustafa (BSE221031)
Zunaira Manzoor (BSE221061)
Supervised By
Syed Awais Haider
Fall 2025
BS Software Engineering
Department of Software Engineering
Capital University of Science & Technology, Islamabad
ii
Project Report

VERSION V 7.4 NUMBER OF MEMBERS 3
TITLE AUTONOMOUS DRONE DELIVERY SYSTEM
SUPERVISOR NAME MR. SYED AWAIS HAIDER
MEMBER NAME REG. NO. EMAIL ADDRESS
FARHAD ALI BSE221026 FarhadIsOk@gmail.com

HAMMAD MUSTAFA BSE221031 LogicalHammad@gmail.com

ZUNAIRA MANZOOR BSE221061 GleamyZuni@gmail.com

MEMBERS’ SIGNATURES
Supervisor’s Signature
iii
Approval Certificate
This project, entitled as ”Autonomous Drone Delivery System” has been
approved for the award of
Bachelors of Science in Software Engineering
Committee Signatures:
Supervisor:
Mr. Syed Awais Haider
Project Coordinator:
Mr. Ibrar Arshad
Head of Department:
Dr. Nadeem Anjum
iv
Declaration
We, hereby, declare that “No portion of the work referred to, in this project has been
submitted in support of an application for another degree or qualification of this or any
other university/institute or other institution of learning”. It is further declared that this
undergraduate project, neither as a whole nor as a part there of has been copied out from
any sources, wherever references have been provided.

MEMBERS’ SIGNATURES
v
Acknowledgements
We would like to express our deepest gratitude to our supervisor, Sir Awais Haider, whose
constant guidance and encouragement carried us through every stage of this project. He
believed in our vision from the very beginning and stood by us through every challenge,
never letting us feel lost or unsupported. His patience, wisdom, and dedication inspired us
to push beyond our limits. Without his mentorship, this project would have remained just
an idea. We are truly honoured to have worked under his supervision.

We are equally grateful to Dr. Atif, whose vast knowledge and years of experience shaped
the direction of this project in ways we could not have achieved on our own. His thoughtful
advice and genuine care for our learning helped us grow not only as students but as individ-
uals. He saw potential in our work and guided us with a steady hand until our idea became
a reality. His contribution to this project is something we will always carry with us, and we
will forever be thankful for his support.

vi
Dedication
This project is specially dedicated to Mr. Sagheer Yousaf, for his expert knowledge and
advise and support in various stages of this project.

We dedicate this project to Mr. Arslan Latif from AJK, who not only helped us develop this
idea but also motivated us to bring it to life. His support and encouragement meant a lot to
us throughout this journey.

We also want to dedicate it to our friends, who always motivated us to keep working,
especially M. Saad Abdullah Malik, whose support and belief in us kept us going.

Finally, we dedicate this project to our parents. They have always believed in us, admired
our work, and kept us motivated. Their love and support gave us the energy to complete this
project.

We would also like to mention and appreciate Mr. Fida Hussain, Mr. Adnan Yousaf, Mr.
Asad Nazar, Mr. Rehan Ishfaq.

vii
Executive Summary
Traditional delivery methods in Pakistan face persistent challenges including traffic conges-
tion, rising operational costs, and critical delays in time-sensitive situations such as medical
supply delivery. These limitations motivated the development of the Autonomous Drone
Delivery System (ADDS), a comprehensive solution designed to enable fast, eco-friendly,
and fully autonomous package delivery using drones.

The system comprises four integrated modules: a React-based web frontend hosted on
Hostinger for user registration and order placement, a Firebase backend providing authen-
tication, real-time database synchronisation, and cloud functions, a Flask-based Ground
Control Station (GCS) deployed as a professional Windows installer for mission manage-
ment and monitoring, and a ROS2-based onboard system running inside a Docker container
on a Raspberry Pi 5 companion computer mounted on the drone. The drone hardware is
built around an F450 frame with a Pixhawk PX4 2.4.8 flight controller, communicating via
the MAVLink protocol. A secure Cloudflare communication tunnel enables remote drone
control over the internet, while the A* path planning algorithm ensures safe navigation
around no-fly zones.

The project was developed over approximately ten months, progressing from research
and simulation using Gazebo and ArduPilot SITL to a fully assembled physical drone.
The system was rigorously tested through unit, integration, and end-to-end system testing
across all modules, with over thirty documented test cases validating the complete delivery
workflow from order placement to autonomous flight and return.

viii
xiv

xvii

1 Introduction Contents
1.1 Project Introduction
1.2 Project Objectives
1.3 Existing Examples / Solutions
1.4 Business Scope
1.5 Useful Tools and Technologies
1.5.1 Useful Hardware
1.5.2 Price Table of all components
1.5.3 Useful Software
1.5.4 Terminology and Concepts
1.6 Project Work Break Down
1.7 Project Time Line
1.8 Chapter Summary
2 Requirement Specification and Analysis
2.1 Functional Requirements
2.2 Non-Functional Requirements
2.3 System Use Case Modeling
2.4 Use Cases to Functional Requirements Mapping
2.5 Use Case Details
2.5.1 Register Account
2.5.2 Log In
2.5.3 Manage Profile
2.5.4 Place Delivery Order
2.5.5 Track Delivery
2.5.6 View Order History
2.5.7 View Pending Orders
2.5.8 Validate Order
2.5.9 Start Delivery Mission
2.5.10 Monitor Active Mission
2.5.11 Override Drone Control
2.5.12 Change Flight Mode
2.5.13 Configure Drone Parameters
2.5.14 View Mission Logs
2.6 Activity Diagram
2.7 Component Diagram
2.8 Drone Electrical Block Diagram CONTENTS ix
2.9 SWOT Analysis for Autonomous Drone Delivery System
2.10 User Interface Design
2.10.1 Landing Page
2.10.2 Features Section
2.10.3 Tech Stack Details
2.10.4 Contact Section and Footer
2.10.5 Login and Sign Up Forms
2.10.6 Dashboard
2.10.7 Order Placement Interface
2.10.8 No-fly Zone Visualization
2.10.9 User Account Management
2.10.10 Ground Control Station (GCS) Dashboard Interface
2.10.11 GCS Manual Control Tab
2.10.12 GCS Pending Jobs Queue Tab
2.10.13 GCS History Tab
2.11 Chapter Summary
3 System Design
3.1 Software Architecture
3.1.1 Architecture Style Used
3.1.2 Main Components Involved
3.2 Components and Connector
3.2.1 Main System Components
3.2.2 How Everything is Connected
3.2.3 How They Work Together (Simple Flow)
3.3 Hardware Specifications
3.3.1 Why Hardware Matters
3.4 Communication Protocols
3.4.1 Application Layer
3.4.2 Transport Layer
3.4.3 Network Layer
3.4.4 Data Link and Physical Layer
3.5 Data Flow Diagram / Flowchart
3.6 Entity Relationship Diagram
3.7 Database Schema
3.8 Chapter Summary
4 Software Development
4.1 Coding Standards
4.1.1 Naming Conventions
4.1.2 Indentation CONTENTS x
4.1.3 File and Folder Naming
4.1.4 Code Organization
4.1.5 Project Directory Structure
4.1.6 Commenting Style
4.1.7 Code Formatting Tools
4.2 Development Environment
4.2.1 Operating System
4.2.2 Code Editor / IDE
4.2.3 Programming Languages Used
4.2.4 Libraries and Frameworks
4.2.5 Simulation Tools
4.2.6 Hosting and Deployment
4.3 Software Description
4.3.1 About the delivery job Flow
4.3.2 React Frontend (User Interface)
4.3.3 Firebase Integration (Firestore + Realtime Database)
4.3.4 Ground Control System (GCS)
4.3.5 ROS2 Architecture
4.4 Chapter Summary
5 Software Testing
5.1 Testing Methodology
5.1.1 Unit Testing
5.1.2 Component Testing
5.1.3 Integration Testing
5.1.4 System Testing
5.2 Testing Environment
5.2.1 Web Browser (Opera)
5.2.2 Firebase Console
5.2.3 VS Code (Visual Studio Code)
5.2.4 Node.js Development Server
5.2.5 Python Environment (GCS)
5.2.6 Map APIs
5.3 Test Cases
5.3.1 User Signup with Valid Email
5.3.2 Email Verification Blocking on Login
5.3.3 Firebase Auth Email Verification Triggered
5.3.4 Saving User to Firestore on Signup
5.3.5 Map Click Captures Coordinates
5.3.6 No-Fly Zone Distance Check (Haversine Formula) CONTENTS xi
5.3.7 Toast Notification for No-Fly Zone
5.3.8 Order Submission: Valid Input
5.3.9 Conditional Saving to Saved Locations
5.3.10 Firestore Security: Only Authenticated Writes Allowed
5.3.11 RTDB Mission Path Auth Access
5.3.12 GCS Listens to /jobs/pending Path
5.3.13 GCS Assigns Available Drone
5.3.14 GCS Moves Mission to /jobs/inprogress
5.3.15 GCS Pauses Job If No Drone Is Available
5.3.16 Drone Connection Heartbeat
5.3.17 WebSocket Telemetry Stream
5.3.18 Job Assignment & Acceptance
5.3.19 Manual Control Command
5.3.20 Firebase Job Monitoring
5.3.21 Job Status Transition
5.3.22 Drone Status & Location Broadcast
5.3.23 Complete Job Workflow
5.3.24 Movros FCU Connection & Heartbeat
5.3.25 Telemetry Propagation (FCU→ ROS)
5.3.26 Service-based Arming (ROS→ FCU)
5.3.27 GCS Job Submission (HTTP→ ROS)
5.3.28 MainNode Job Validation
5.3.29 Mission Waypoint Upload Protocol
5.3.30 Mission State Machine Transition
5.3.31 Waypoint Reached Event Handling
5.3.32 Manual Nudge Control
5.3.33 Crash Recovery & State Restoration
5.3.34 RTL Failsafe Detection & Mission Abort
5.3.35 GUIDED Mode Gate Before Arming
5.3.36 Takeoff Failure Retry Logic
5.3.37 Manual ARM Command ACK Timeout
5.4 Chapter Summary
6 Software Deployment
6.1 Deployment Overview
6.1.1 Deployment Architecture
6.1.2 Component Independence and Communication Flow
6.2 Frontend Deployment (React Web Application)
6.2.1 Production Build Process
6.2.2 Hosting Provider Selection CONTENTS xii
6.2.3 Domain and Subdomain Configuration
6.2.4 File Upload and Deployment
6.2.5 Deployment Verification and Accessibility Testing
6.2.6 Why This Deployment Approach?
6.3 Ground Control Station (GCS) Deployment
6.3.1 Local Deployment Strategy
6.3.2 Installer Design and Packaging
6.3.3 Installation Process
6.3.4 GCS Launch and Operation
6.3.5 System Resource and Dependency Management
6.3.6 Why This Deployment Approach?
6.4 Drone System Deployment (ROS2 via Docker)
6.4.1 Code Transfer to Raspberry Pi
6.4.2 Environment Setup on Drone
6.4.3 Docker Image Build Process
6.4.4 Container Deployment Using Docker Compose
6.4.5 Auto-Start, Restart Policies, and Fault Recovery
6.4.6 Why This Deployment Approach?
6.5 Security and Configuration Management
6.5.1 Credential Management and API Keys
6.5.2 Environment Variables and Configuration Files
6.6 Deployment Verification and Validation
6.6.1 End-to-End System Testing
6.6.2 Operational Readiness Checklist
6.7 Chapter Summary
7 Conclusion & Future Work
7.1 Project Summary
7.2 Objectives Achieved
7.3 Limitations
7.3.1 Landing Mechanism
7.3.2 Obstacle Awareness
7.3.3 Altitude Measurement for Landing
7.3.4 GCS Architecture
7.3.5 Map-Based Location Selection
7.3.6 Single Drone Operation
7.3.7 Known Software Defects
7.3.8 Battery and Flight Time
7.3.9 Safety Mechanisms
7.4 Future Work CONTENTS xiii
7.4.1 Package Delivery via Hovering and Zipline
7.4.2 Basic Obstacle Avoidance
7.4.3 Precision Landing with LiDAR and Camera
7.4.4 GCS Integration into the React Frontend
7.4.5 Enhanced Map View with Satellite Imagery
7.4.6 Multi-Drone Fleet Management
7.4.7 Parachute Recovery and Battery Safety
7.4.8 Resolution of Known Software Defects
7.5 Closing Statement
Bibliography
Plagiarism Report
Appendix
Appendix A: GCS Configuration Reference
Appendix B: Drone System Configuration Reference
Appendix C: Docker Compose Configuration
Appendix D: Project Repository Structure
Appendix E: User Manual
1.1 Final Image of the drone List of Figures
1.2 Brushless Emax MGII C2212 (1400KV) Motors for Drones
1.3 1045 2-Blade Propellers for Drones
1.4 4S 5200mAh 40C LiPo Battery
1.5 LiPro Balance Charger
1.6 Readytosky 40A ESCs
1.7 F450 Quadcopter Drone Frame
1.8 Tall Landing Gear
1.9 GPS Module
1.10 Pixhawk PX4 2.4.8 Flight Controller
1.11 Raspberry Pi Hardware
1.12 Microzone MC6C Mini Upgraded 6 Channel 2.4 GHz Radio Remote Control
1.13 XL4016 DC-DC buck converter.
1.14 VS Code Icon
1.15 Python & Flask Icons
1.16 HTML, CSS, and JavaScript Icons
1.17 Firebase Icon
1.18 ArduPilot (ArduCopter) Software
1.19 ROS2 Icon
1.20 Gazebo Icon
1.21 Linux Icon
1.22 Docker Icon
1.23 Cloudflare Icon
1.24 Mission Planner
1.25 Work Breakdown Structure
1.26 Project Timeline
2.1 Use Case Diagram
2.2 Activity Diagram
2.3 Component Diagram
2.4 Electrical Block Diagram
2.5 Landing Page
2.6 Features section of Landing Page
2.7 Tech Stack Details of Landing Page
2.8 Contact Section and Footer of Landing Page
2.9 Login and Sign Up Forms
2.10 Dashboard after login LIST OF FIGURES xv
2.11 Placing an order
2.12 No fly Zone
2.13 Manage User Account
2.14 Ground Control Station Dashboard (GCS)
2.15 Ground Control Station Manual Control
2.16 Ground Control Station Pending Jobs Queue
2.17 Ground Control Station History tab
3.1 System Architecture
3.2 Components and Connectors
3.3 Network Diagram
3.4 Data Flow Diagram
3.5 Entity Relationship Diagram
3.6 Database Schema
4.1 Prettier VS Code extension
4.2 Map integration
4.3 Firestore Database
4.4 Realtime Database Interface
4.5 ROS2 node architecture on the Raspberry Pi.
4.6 Telemetry pipeline from the flight controller to the operator’s browser.
6.1 Executing npm run build to generate production files.
6.2 Dist folder containing compiled and optimized React files.
6.3 Hostinger Logo.
6.4 Available Hostinger hosting plans for paid deployment.
6.5 Namecheap dashboard
6.6 Creating the subdomain drone.nelston.com with a custom folder
6.7 Hostinger dashboard showing the file manager button.
6.8 File manager displaying the publichtml directory as the web root.
6.9 Selected drone folder for uploading build files.
6.10 Uploaded build files inside the drone folder on the hosting server.
6.11 React front-end opened with subdomain URL visible.
6.12 React front-end dashboard hosted on drone.nelston.com.
6.13 Create Installer Script Code
6.14 Installer Script Run successfully and Installer Created
6.15 Installer Shown in Files
6.16 Installer Asking for Admin Permission
6.17 Installer Asking for Install Location
6.18 Installer Asking for Desktop Icon
6.19 Installer Ready to Install
6.20 Installer Installing LIST OF FIGURES xvi
6.21 Installation Complete
6.22 Desktop Icon
6.23 GCS Installed in GCS Folder
6.24 GCS Files in Program Files Folder
7.1 Order placement form popping up after marker selection
7.2 User account management interface
7.3 Ground Control Station main dashboard
7.4 Pending jobs queue showing all active orders in GCS
1.1 Cost Breakdown of Drone Components (PKR) List of Tables
2.1 Functional Requirements
2.2 Non-Functional Requirements
2.3 Mapping of Functional Requirements to Use Cases
2.4 Use Case - Register Account
2.5 Use Case - Log In
2.6 Use Case - Manage Profile
2.7 Use Case - Place Delivery Order
2.8 Use Case - Track Delivery
2.9 Use Case - View Order History
2.10 Use Case - View Pending Orders
2.11 Use Case - Validate Order
2.12 Use Case - Start Delivery Mission
2.13 Use Case - Monitor Active Mission
2.14 Use Case - Override Drone Control
2.15 Use Case - Change Flight Mode
2.16 Use Case - Configure Drone Parameters
2.17 Use Case - View Mission Logs
2.18 SWOT Analysis for Autonomous Drone Delivery System
3.1 Drone Hardware Components
4.1 Libraries and Frameworks Used
5.1 User Signup with Valid Email
5.2 Email Verification Blocking on Login
5.3 Firebase Auth Email Verification Triggered
5.4 Saving User to Firestore on Signup
5.5 Map Click Captures Coordinates
5.6 No-Fly Zone Distance Check (Haversine Formula)
5.7 Toast Notification for No-Fly Zone
5.8 Order Submission: Valid Input
5.9 Conditional Saving to Saved Locations
5.10 Firestore Security: Only Authenticated Writes Allowed
5.11 RTDB Mission Path Auth Access
5.12 GCS Listens to /jobs/pending Path
5.13 GCS Assigns Available Drone
5.14 GCS Moves Mission to /jobs/inprogress
5.15 GCS Pauses Job If No Drone Is Available LIST OF TABLES xviii
5.16 Drone Connection Heartbeat
5.17 WebSocket Telemetry Stream
5.18 Job Assignment & Acceptance
5.19 Manual Control Command
5.20 Firebase Job Monitoring
5.21 Job Status Transition
5.22 Drone Status & Location Broadcast
5.23 Complete Job Workflow
5.24 Movros FCU Connection & Heartbeat
5.25 Telemetry Propagation (FCU→ ROS)
5.26 Service-based Arming (ROS→ FCU)
5.27 GCS Job Submission (HTTP→ ROS)
5.28 MainNode Job Validation
5.29 Mission Waypoint Upload Protocol
5.30 Mission State Machine Transition
5.31 Waypoint Reached Event Handling
5.32 Manual Nudge Control
5.33 Crash Recovery & State Restoration
5.34 RTL Failsafe Detection & Mission Abort
5.35 GUIDED Mode Gate Before Arming
5.36 Takeoff Failure Retry Logic
5.37 Manual ARM Command ACK Timeout
7.1 GCS Environment Variables
7.2 Drone System Environment Variables
xix
This page is intentionally kept blank

1
Chapter 1
1 Introduction
Have you ever wondered why your pizza sometimes arrives cold, or why urgent medical
supplies get delayed in traffic? The answer often lies in traditional delivery methods.
Delivery riders are common on the roads, and while they help deliver food, medicine, and
other items, they also create some problems. More riders mean more traffic jams, more fuel
use, and more pollution [1]. This adds to global warming and the greenhouse effect.

For example, Chezious alone pays salaries of Rs. 34,000 to riders per month and covers extra
costs like free petrol, medical expenses, and sometimes even wedding costs. While these
benefits are helpful for riders, they increase business costs and may also affect customer
prices.

Now imagine a more serious situation where someone gets badly hurt in an accident and is
taken to a hospital. The doctors try to save the patient but urgently need blood bags. Even
if a nearby hospital or blood bank has them, the delivery may still be too slow due to traffic.
In such moments, every second counts, and traditional delivery methods may not be fast
enough [2].

1.1 Project Introduction
The solution to these problems is an Autonomous Drone Delivery System (ADDS). Un-
like traditional delivery vehicles, drones are faster, eco-friendly, and help reduce traffic
jams. Drones run on clean energy, which reduces carbon emissions and supports a greener
environment.

However, regular drones need someone to control them, which can still lead to human
errors. This is why our project focuses on an autonomous drone delivery system. An
autonomous drone can deliver packages without human control, ensuring faster and more
accurate deliveries.

This project can benefit any organization that needs fast and reliable deliveries. For example,
companies like Daraz, Food Panda, Chezious, and TeleMedicine could use this system to
improve their services. Whether it’s food, packages, or medical supplies, this drone delivery
system can help these organizations deliver faster and more efficiently. The final assembled
drone used in this project is shown in Figure 1.1.

Introduction 2

Figure 1.1: Final Image of the drone
1.2 Project Objectives
To guide the development of the Autonomous Drone Delivery System, a set of clear ob-
jectives were defined at the start of the project. These objectives outline the key goals
that the team aimed to achieve across hardware assembly, software development, system
integration, and testing. Together, they provide a structured roadmap for building a fully
functional autonomous delivery drone. The achievement of each objective is revisited in
Chapter 7.

OB-1. To design and build a quadcopter drone capable of autonomous flight using
ArduPilot and a Pixhawk flight controller.
OB-2. To develop a companion computer system using Raspberry Pi 5 and ROS2 that
can control the drone, execute delivery missions, and communicate with the
ground station.
OB-3. To create a web-based frontend using ReactJS and Firebase that allows users to
register, place delivery orders, and track deliveries in real time.
OB-4. To develop a Ground Control Station (GCS) that enables operators to monitor
Introduction 3

drone telemetry, approve delivery jobs, and manually control the drone when
needed.
OB-5. To implement a secure communication architecture between all system compo-
nents using Firebase, WebSocket, and encrypted cloud tunnels.
OB-6. To containerise the drone software using Docker for consistent and reliable de-
ployment on the Raspberry Pi.
OB-7. To test the complete system through structured test cases covering unit, integra-
tion, and system-level scenarios.
OB-8. To deploy the full system and verify its operational readiness through end-to-end
testing.
1.3 Existing Examples / Solutions
Many companies around the world have already made drone delivery systems. One of the
most famous is Zipline , which was actually the inspiration for this project [3].

Zipline was founded in 2014 and is known for using drones to deliver small packages, mainly
medical supplies like blood, vaccines, and medicines. Their goal is to help people in remote
areas who cannot get these supplies quickly.

A big problem with drone delivery is that drones are noisy and dangerous because of
their fast-moving propellers. No one wants loud drones flying anywhere near their homes,
especially with kids around [4]. Zipline solved this problem by using small delivery droids.
These droids are lowered using a rope and safely land on small areas like a dinner table or
doorstep, while the main drone stays high in the air.

Even though Zipline is very advanced, it still has some problems:

It does not operate in Pakistan or many other countries.
It is only available in some areas, so not everyone can use it.
It requires a big setup, which can be expensive.
It is only used by Zipline‘ itself. Other businesses cannot use it for their own deliveries.
This project will solve these issues by making an autonomous drone delivery system designed
specifically for Pakistan. Unlike Zipline, this system will be a product that any business can
use with little training for their staff. The project team/business will also provide proper
integration and deployment to other businesses so they can easily use drones for deliveries.

Introduction 4

1.4 Business Scope
This project is useful for any company that needs fast and reliable deliveries. Businesses
like Daraz, Food Panda, Chezious, and TeleMedicine can use this system to deliver food,
packages, or medical supplies quickly and efficiently.

This system will not be sold to individual customers. Instead, it will be given to businesses
so they can use it for their own deliveries. This will help them serve their customers faster.

Many businesses in Pakistan need quick deliveries. Right now, returning faulty items can
take up to 15 days. The business needs to collect the item, check it, and then send a refund.
With this drone system, returns can happen in a few hours instead of days, making refunds
faster.

This system also has other huge benefits:

Faster deliveries so customers don’t have to wait long.
Less traffic on the roads because fewer delivery bikes are needed.
Clean energy because drones use batteries instead of fuel.
Less pollution helping to protect the environment.
Businesses will need special training to use this system. The drones have advanced hardware,
like Pixhawk and Raspberry Pi 5, and powerful motors and batteries. Each drone can cost
up to Rs. 3,50,000, but it can save money in the long run by reducing fuel costs and delivery
staff salaries.

This project can change the way deliveries are made in Pakistan by making them cheaper
and faster while also making them better for the environment [5].

1.5 Useful Tools and Technologies
A drone has a lot of important parts, each of them help the drone fly and complete its tasks.
Below are some of the main components that the project team will use in this project along
with their roles:

1.5.1 Useful Hardware
This section explains hardware and some of the important components used to build the
drone.

Introduction 5

1.5.1.a. Motors

Motors generate the lift and control required for stable drone flight. The project employed
Emax GTII 2212C 1400KV brushless motors, as illustrated in Figure 1.2, where the KV
rating denotes the rotational speed per volt under no load. When powered by a 4S (14.8
V) LiPo battery, each motor reaches approximately 20,700 RPM no-load, producing around
1500 g of thrust, which ensured smooth takeoff, stable hovering, and responsive control. This
configuration provided efficient thrust suitable for payload-carrying autonomous delivery
operations.

Figure 1.2: Brushless Emax MGII C2212 (1400KV) Motors for Drones
1.5.1.b. Propellers

Propellers produce lift by displacing air downward, enabling the drone to ascend and main-
tain stability. The project utilized 1045 propellers, as shown in Figure 1.3, where “10”
representes the diameter in inches and “45” indicates the pitch of about 4.5 inch, corre-
sponding to the distance the propeller would theoretically move in one rotation through a
solid medium. These lightweight propellers efficiently convert motor thrust into lift, result-
ing in smooth and responsive flight, which was essential for safe and reliable autonomous
delivery operations.

Figure 1.3: 1045 2-Blade Propellers for Drones
1.5.1.c. Battery

The battery supplies power to the drone and all its major components, while also being the
heaviest component of the system with around 500g weight. The project used a 4S 5200mAh
40C LiPo battery, which offered a balance between high power output and extended flight

Introduction 6

time (Figure 1.4). The 40C rating indicates the maximum continuous discharge rate relative
to the battery capacity. For this battery, the maximum continuous current can be calculated
as 40 x 5.2 A≈ 208 A, which is a massive amount of current, ensuring that the motors and
electronics could draw sufficient current for lift, and payload-carrying operations without
overloading the battery. Two batteries were purchased for this project, one used on the drone
and one spare battery.

Figure 1.4: 4S 5200mAh 40C LiPo Battery
1.5.1.d. LiPro Balance Charger

A LiPo balance charger (referred to us LiPro Balance Charger) is used to charge lithium
polymer (LiPo) batteries safely and efficiently, ensuring that each cell within the battery
reaches the same voltage level. Uneven charging can lead to reduced performance, over-
heating, or even damage to the battery. The charger monitors the voltage of individual
cells and adjusts the current to balance them during charging (Figure 1.5). Using a balance
charger prolongs battery life, maintains optimal performance, and ensures safe operation of
the drone’s 4S 5200mAh 40C LiPo battery, allowing reliable flight for approximately 18
minutes per charge.

Figure 1.5: LiPro Balance Charger
Introduction 7

1.5.1.e. Electronic Speed Controllers (ESCs)

Electronic Speed Controllers (ESCs) regulate the rotational speed of the motors, translating
control signals from the flight controller into precise motor movements, which allows the
drone to fly smoothly and maintain stability. The project uses Readytosky 40A ESCs, shown
in figure 1.6, which are compatible with the 1400KV motors and 4S LiPo battery. These
ESCs offer reliable performance, rapid response, and overcurrent protection, ensuring safe
operation while efficiently converting electrical power into controlled mechanical motion,
making them essential for stable and responsive autonomous flight.

Figure 1.6: Readytosky 40A ESCs
1.5.1.f. Drone Frame

The drone frame provides the structural support that holds all components together, func-
tioning as the body of the drone and ensuring overall stability during flight. In this project,
an F450 frame was used as shown in figure 1.7, selected for its durability, lightweight
design, and ease of repair. The frame also acts as a Power Distribution Board (PDB), elec-
trically connecting the motors, ESCs, and battery while providing secure soldering points
for reliable power transmission to all components.

Figure 1.7: F450 Quadcopter Drone Frame
Introduction 8

1.5.1.g. Tall Landing Gear

The drone uses tall landing gear to keep the propellers and payload safely above the ground
during takeoff and landing (Figure 1.8). This helps prevent the drone from hitting the ground
and protects it on uneven surfaces. The landing gear also keeps the drone stable when it is
on the ground and prevents damage to the frame and other parts.

Figure 1.8: Tall Landing Gear
1.5.1.h. GPS Module

The drone uses a Ublox M8N GPS module mounted on top (Figure 1.9). It includes a
built-in compass for accurate heading information. The module is small, circular, and
lightweight, with a long stick holder to keep it higher above the drone frame. This elevated
mounting position provides an important benefit for compass accuracy. By positioning the
compass away from the drone’s electronics, motors, and battery, the stick holder reduces
electromagnetic interference that could affect compass readings. This separation ensures
more reliable heading data, which is essential for precise autonomous navigation.

The drone system uses two compasses for redundancy and accuracy. The first compass is
built into the GPS module, and the second compass is integrated inside the Pixhawk flight
controller. However, the GPS compass was given higher priority in the flight controller
configuration because of its better positioning away from electromagnetic sources. This
dual compass setup, combined with precise GPS positioning, provides accurate orientation
and location data, which is critical for stable flight control and successful autonomous
missions.

Introduction 9

Figure 1.9: GPS Module
1.5.1.i. Flight Controller

The flight controller is the central control unit of the drone and works as its engine, managing
all critical flight operations. This project uses the Pixhawk PX4 2.4.8, shown in figure
1.10. The flight controller has its own dedicated processor that runs ArduCopter software
from ArduPilot, which is a free and open-source flight control software. This software
continuously processes sensor data and adjusts motor speeds to keep the drone stable,
balanced, and responsive during flight.

The Pixhawk includes important built-in sensors such as an accelerometer, gyroscope,
compass, and barometer. These sensors help the drone understand its motion, orientation,
and position in real-time. The flight controller also has multiple ports that allow connection
of external peripherals such as GPS modules, telemetry radios, and companion computers.
Additionally, it has dedicated output ports to connect and control the Electronic Speed
Controllers (ESCs), which regulate the motor speeds. These ports enable the flight controller
to send precise control signals to each motor, allowing smooth and coordinated flight
movements. This combination of processing power, sensors, and connectivity makes the
flight controller essential for reliable autonomous navigation and stable flight operations.

Before the drone can fly, the Pixhawk requires careful configuration through Mission Planner
software. This includes calibrating the accelerometer and compass, setting up the correct
frame type, configuring flight modes, and tuning PID (Proportional-Integral-Derivative)
parameters that control how smoothly the drone responds to commands. The Pixhawk also
enforces strict pre-arm safety checks before allowing the motors to spin, such as verifying
GPS lock, checking battery voltage, and ensuring all sensors are functioning correctly.
These checks prevent the drone from taking off in an unsafe state. The flight controller also
supports multiple failsafe mechanisms, including automatic return-to-launch if the remote
signal is lost and forced landing if the battery drops below a critical level. These built-
in safety features make the Pixhawk a reliable and trusted choice for autonomous drone

Introduction 10

projects.

Figure 1.10: Pixhawk PX4 2.4.8 Flight Controller
1.5.1.j. Companion Computer

To enable the autonomous flight, the drone uses a Raspberry Pi 5 as its onboard computer,
responsible for running high-level processing tasks and the ROS2 architecture required for
autonomous operation as shown in Figure 1.11a. The Raspberry Pi 5 features a powerful
quad-core ARM Cortex processor and 8GB of RAM, providing sufficient processing power
to handle complex autonomous flight algorithms, sensor data processing, and real-time deci-
sion making. This processing capability allows the drone to perform navigation calculations,
mission planning, and obstacle detection without relying on external computers.

The Raspberry Pi operates on Raspberry Pi OS Lite, a lightweight Linux distribution in-
stalled on a USB drive for faster performance and improved reliability during flight. The
ROS2 architecture runs inside a Docker container, which is an isolated software environ-
ment that packages all necessary dependencies and libraries. This containerized approach
provides an important advantage because ROS2 is normally tightly tied to specific operat-
ing system versions, particularly Ubuntu 22.04 LTS. By using Docker, the system becomes
future-proof and independent of any specific distribution. This means the drone software can
run on different operating systems without modification, making updates and maintenance
much easier over time.

The Raspberry Pi is housed in the official Raspberry Pi 5 case, which includes an integrated
cooling fan to maintain safe operating temperatures during intensive processing tasks,
as shown in Figure 1.11b. A USB communication dongle is used to create a remote

Introduction 11

communication tunnel, allowing access to the drone’s GPS, telemetry data and sending
commands over the internet. The Raspberry Pi connects to the Pixhawk flight controller
through a micro-USB data cable, ensuring stable, low-latency data exchange for navigation,
mission control, and system monitoring. During development, it was powered from a power
supply, while on the drone it is powered by a power module named XL4016, ensuring all
power demands were met.

(a) Raspberry Pi 5 8GB (b) Raspberry Pi in the case
Figure 1.11: Raspberry Pi Hardware
1.5.1.k. Remote Controller

Although the drone is designed for autonomous operation, a Microzone MC6C Mini Up-
graded 6 Channel 2.4 GHz Radio Remote Control is used for initial testing, safety checks,
and manual override when required. This feature remains active in the prototype to ensure
full control in case of unexpected behavior during flight. The remote has six channels that
control different aspects of the drone. Channel 1 controls the roll movement (left and right
tilt), Channel 2 controls the pitch movement (forward and backward tilt), Channel 3 controls
the throttle (up and down movement), and Channel 4 controls the yaw movement (rotation).
Channel 5 is linked to a 3-position switch on the remote that is used to change the flight
mode of the drone. Channel 6 was left unused and remains available for future expansion
or additional features.

The 3-position switch on Channel 5 allows the operator to select between three different
flight modes by moving the switch to different positions. When the switch is in the
bottom position, the drone enters GUIDED mode, which allows the companion computer
(Raspberry Pi) to take full control for autonomous flight operations. The middle position
sets the drone to LOITER mode, where the drone uses GPS to maintain its current position
and altitude, effectively hovering in place. The top position activates ALT HOLD mode,
which maintains a constant altitude while allowing manual control of horizontal movement
through the remote. The drone configuration was set so that GUIDED and AUTO modes
enable autonomous control by the companion computer, while LOITER and ALT HOLD

Introduction 12

modes allow manual override through the remote controller. This switching capability
provides an essential safety layer, ensuring that the operator can immediately take direct
control if autonomous functions need to be interrupted during flight.

Figure 1.12: Microzone MC6C Mini Upgraded 6 Channel 2.4 GHz Radio Remote Control
1.5.1.l. Power Module for Pi

The drone used an XL4016 DC-DC buck converter, shown in Figure 1.13, to safely power
the Raspberry Pi 5 from the main LiPo battery. Careful selection of the power module was
essential, as an incorrect voltage or current rating could permanently damage the Raspberry
Pi. Although the device supports USB Type-C adapter, it requires a Power Delivery (PD)
source capable of supplying 5V at up to 5A, which is not supported by standard chargers.
Since the system was battery-powered, a buck converter capable of delivering a stable 5V
at high current was required. After extensive evaluation of multiple modules, the XL4016
was selected due to its ability to provide up to 8-9A at the adjusted voltage.

To connect the module to the Raspberry Pi, a USB Type-C cable was cut open to expose
its internal power wires, which were then connected to the output terminals of the XL4016.
The output voltage was carefully measured and set to precisely 5.0–5.1V using a multimeter,
ensuring that the Raspberry Pi received a safe and stable power supply throughout flight
operations.

Introduction 13

Figure 1.13: XL4016 DC-DC buck converter.
1.5.2 Price Table of all components
The components listed in Table 1.1 were sourced with a careful balance between cost and
performance. Extremely low-cost modules were avoided due to their unsuitability for a
heavy-weight drone, while high-cost options were excluded to remain within the project
budget. Since all parts were not available from a single supplier, they were obtained from
multiple local shops in Islamabad and various online platforms after extensive research and
comparison.

Table 1.1: Cost Breakdown of Drone Components (PKR)
Component Full-Sized Drone Qty Cost (PKR)
Single Total
Motors EMAX GTII 2212C (1400KV) 4 4,000 16,000
Propellers 1045 Two-Blade Propellers 6 800 4,800
Propeller Guard F450 Propellers Guard 1 1,300 1,300
Battery 4S 5200 mAh 40C LiPo Battery 3 14,500 43,500
ESCs ReadySky 40A ESCs 4 2,500 10,000
Frame F450 Frame (Black and Red) 1 3,500 3,500
Flight Controller Pixhawk PX4 2.4.8 1 30,500 30,500
Companion Comp. Raspberry Pi 5 (8GB RAM) 1 28,000 28,000
Pi Case Case for Raspberry Pi 5 1 2,500 2,500
Continued on next page
Introduction 14

Component Full-Sized Drone Qty Cost (PKR)
Single Total
USB Sandisk Ultra 64 GB (for RPi) 1 1,500 1,500
Remote Controller Microzone MC6C Mini 1 10,500 10,500
GPS Ublox M8N 1 6,500 6,500
Battery Charger LiPro Balance Charger 1 8,000 8,000
Legs Tall Landing Gear 1 3,000 3,000
Power Module XL4016 DC-DC Buck Con-
verter
1 850 850
Power Supply 5V 5A 25W Type-C PD Adapter 1 2,500 2,500
Weight Scale Generic Precision Weight Scale 1 1,000 1,000
Cables HDMI/Micro USB/Other ca-
bles
1 2,400 2,400
Generic Tools Soldering Iron/Screw
Drivers/Other
1 10,000 10,000
Total Cost 186,350
1.5.3 Useful Software
This section explains the software, programming languages, and tools used to develop
and test the drone. The project required a combination of different technologies working
together, from low-level flight controller firmware to high-level web applications. Each tool
was selected based on its suitability for the task, community support, and compatibility with
the rest of the system.

1.5.3.a. Development Environment

The development of the autonomous drone delivery system was carried out on Ubuntu
22.04 LTS, as it is the officially supported and recommended operating system for ROS2
Humble. The desktop version of the operating system was used on a 64-bit x86 architecture
platform. Visual Studio Code (figure 1.14) served as the primary integrated development
environment (IDE) due to its lightweight design, multi-language support, and strong sup-
port for robotics and AI development. The development workstation provided sufficient
computational resources for coding, simulation, and system testing.

Introduction 15

Operating System: Ubuntu 22.04 LTS (Desktop), officially supported by ROS2
Humble.
System Architecture: 64-bit x86 (Intel-based platform).
IDE: Visual Studio Code with robotics, ROS2, and Python extensions (figure 1.14).
Processor: Intel Core i7, 5th Generation.
Memory: 12 GB RAM.
Figure 1.14: VS Code Icon
1.5.3.b. Programming Languages

Python was used for writing all the main code in this project (figure 1.15a). The ROS2
code that runs on the drone was written in Python. This code controls the drone and makes
it fly on its own. The GCS (Ground Control Station) was also built using Python with the
Flask framework (figure 1.15b). Flask is a simple web framework that helps build web
applications. The GCS runs on a local server and allows users to control and monitor the
drone. Python is easy to use and many people use it for robotics projects (figure 1.15).

(a) Python Icon (b) Flask Icon
Figure 1.15: Python & Flask Icons
React was used to build the web dashboard (figure 1.16). React is a JavaScript library that
makes it easy to build user interfaces. React uses JSX, which is a mix of JavaScript and

Introduction 16

HTML. This makes writing web pages easier. The web dashboard connects to Firebase for
storing data and handling user login. This dashboard allows users to see drone status and
manage delivery orders.

HTML, CSS, and JavaScript were used to build the GCS web interface (figure 1.16).
HTML creates the structure of web pages, CSS makes up for the UI and design, and
JavaScript adds interactive features. These are simple web technologies that work well for
making local web pages.

Figure 1.16: HTML, CSS, and JavaScript Icons
Firebase was used for authentication, cloud data storage, and real-time communication
within the system (Figure 1.17). Firebase Authentication handled secure user login and
access control, while Cloud Firestore was used to store structured application data like user
details and delivery orders. The Firebase Realtime Database enabled instantaneous delivery
of new job requests to the ground control station and allowed continuous tracking of the
drone by updating its location on the front-end interface in real time.

Figure 1.17: Firebase Icon
Bash scripts were also written for the drone. Bash is a scripting language used in Linux
systems. These scripts help automate tasks like starting the drone software, managing
Docker containers, and running system commands. This makes the drone easier to operate.

1.5.3.c. Flight Controller Software

The Pixhawk flight controller mentioned earlier in hardware components uses ArduPilot
(ArduCopter) flight software, which is a free and open-source software that allows control of

Introduction 17

many different types of vehicles (figure 1.18). ArduPilot has specific versions for different
vehicles, and ArduCopter is the version designed for multi-rotor drones. This software
installs directly into the Pixhawk flight controller and handles all the low-level tasks such as
reading sensor data and controlling motor speeds. By managing these low-level operations,
ArduCopter allows the development team to focus on high-level autonomous flight control
logic, which is what makes the drone truly autonomous.

ArduCopter is written in C++, making it both robust and lightweight. It is highly reliable
and includes many important safety features to protect the drone during flight. These safety
features include Radio Failsafe (returns the drone to home if remote connection is lost),
Battery Failsafe (triggers landing or return when battery is low), Geofence (prevents the
drone from flying outside a defined area), and Return to Launch or RTL (brings the drone
back to its starting point automatically). The software also performs pre-flight checks
before takeoff to ensure all systems are working correctly. These features make ArduCopter
a dependable choice for autonomous drone operations.

Figure 1.18: ArduPilot (ArduCopter) Software
1.5.3.d. ROS2 (Robot Operating System 2)

ROS2 (Robot Operating System version 2) is an open-source framework designed for
building complex robotic systems (figure 1.19). It provides tools and libraries that help
manage communication between different software components, making it easier to develop
modular and scalable robotics applications. ROS2 was chosen for this project because it
offers several important benefits. It allows different parts of the software to run as separate
nodes that communicate with each other, making the system more organized and easier
to debug. ROS2 also provides built-in support for real-time communication, distributed
systems, and hardware abstraction, which are essential for autonomous drone operations.
Additionally, ROS2 has a large community and extensive documentation, making it easier
to find solutions and integrate existing packages.

However, using ROS2 also comes with some limitations. It adds complexity to the system
because developers need to understand ROS2 concepts such as nodes, topics, and services.
This increases the initial development time and makes testing more difficult compared to
simpler approaches. Despite these challenges, the benefits of using ROS2 outweigh the
drawbacks. The modular architecture, reusability of code, and ability to simulate and test
in virtual environments make ROS2 worth the additional effort. For a complex autonomous
drone system like this one, ROS2 provides the necessary structure and tools to build reliable

Introduction 18

and maintainable software.

Figure 1.19: ROS2 Icon
1.5.3.e. Autonomous Drone Software

The Raspberry Pi 5, as mentioned earlier in the hardware components, runs the custom
autonomous flight software developed specifically for this project. This software is built
using the ROS2 (Robot Operating System 2) architecture, which provides a framework for
managing complex robotic systems. The entire ROS2 system runs inside a Docker container,
which offers several important benefits including isolation from the host system, easy
deployment across different environments, consistent behavior regardless of the underlying
operating system, and simplified updates and version control. This containerized approach
ensures that the drone software remains portable and maintainable.

The autonomous flight system consists of three main ROS2 nodes, each handling specific
responsibilities. The first node is the movrosnode , which is a custom-built replacement
for the standard MAVROS package. This node handles all communication between the
ROS2 system and the Pixhawk flight controller using the MAVLink protocol. It sends flight
commands to the Pixhawk and receives telemetry data such as GPS position, battery status,
and sensor readings. The second node is the mainnode , which contains the high-level
autonomous flight control logic developed by the project team. This node is responsible
for mission planning, waypoint navigation, decision making, and coordinating the overall
autonomous behavior of the drone.

The third node is the gcsclientnode , which manages communication with the Ground
Control Station (GCS). This node implements FastAPI and WebSockets to enable real-
time communication between the drone and the GCS over the internet. It connects to a
Cloudflare tunnel using the custom domain nldrone.space, allowing remote monitoring and
control of the drone from anywhere. This architecture demonstrates a well-organized system
where each component has a clear purpose, making the software easier to develop, test, and
maintain.

1.5.3.f. Simulation Environment

Gazebo and RViz are open-source software tools that are part of the ROS2 ecosystem.
Gazebo is a physics simulator that creates a virtual environment where the drone can be
tested without any risk of damage or crashes (figure 1.20). It simulates real-world physics

Introduction 19

including gravity, wind, and sensor behavior, allowing the development team to test flight
algorithms and control logic in a safe and controlled setting. RViz is a visualization tool
that displays the drone’s sensor data, flight path, and system status in real-time, making it
easier to understand what the drone is doing and identify problems.

These tools were used extensively during development to test the autonomous flight software
before deploying it on the real drone. The testing was performed using ArduPilot SITL
(Software In The Loop), which runs the ArduCopter firmware in a simulated environment.
This allowed the team to test the complete system including the ROS2 nodes, flight controller
software, and communication protocols without needing the physical drone. Testing in a
virtual environment helped identify bugs earlier in the development process, reduced the risk
of crashes, and made the overall testing process faster and more efficient. Once the software
worked correctly in simulation, it was then deployed to the real drone with confidence.

Figure 1.20: Gazebo Icon
1.5.3.g. Operating Systems

The Raspberry Pi 5 runs Raspberry Pi OS Lite , which is a lightweight Linux distribution
designed for embedded systems and servers. Unlike regular desktop operating systems,
Raspberry Pi OS Lite does not have a graphical user interface (GUI). It is similar to
Ubuntu Server, providing only a terminal interface where all tasks must be performed
using text commands. This terminal-only approach makes the system very lightweight and
efficient, using minimal resources so that more processing power is available for running
the autonomous flight software. Since the Raspberry Pi is mounted on the drone and does
not have a monitor or keyboard attached, a GUI was not needed. Instead, all configuration
and maintenance tasks were performed remotely using SSH (Secure Shell), which allows
secure access to the Raspberry Pi’s terminal from a laptop over the network. This approach
worked well for the project because it kept the system simple and focused on running the
drone software.

For development and testing purposes, Ubuntu 22.04 LTS was installed on the development
laptop, as mentioned earlier. Ubuntu is a popular Linux distribution that is widely used for
robotics development (figure 1.21). It was chosen because it provides full support for ROS2

Introduction 20

architecture. Ubuntu 22.04 LTS allowed the team to install ROS2 directly on the laptop
without using Docker, which simplified the development process. More importantly, Ubuntu
made it possible to run Gazebo and RViz smoothly for simulation and visualization. These
tools require a graphical interface and significant computing power, which the development
laptop could provide. The Docker containers running on the Raspberry Pi also use Ubuntu
22.04 LTS as their base image to ensure consistency between the development environment
and the deployment environment.

Figure 1.21: Linux Icon
1.5.3.h. Docker

Docker was used to address operating system compatibility limitations on the Raspberry
Pi, as Raspberry Pi OS does not natively support the Ubuntu version required for seamless
ROS2 Humble operation. A ROS2 Humble base image built on Ubuntu was used, on top of
which the custom application code was installed and configured. The container image was
transferred to the Raspberry Pi, built locally, and deployed for execution. The container was
configured to start automatically on boot, ensuring that the ROS2 system initialized without
manual intervention. In addition to portability, Docker provided environment isolation,
simplified dependency management, and ensured consistent behavior across development
and deployment platforms (Figure 1.22).

Figure 1.22: Docker Icon
1.5.3.i. Networking and Communication Protocols

MAVLink (Micro Air Vehicle Link) protocol was used for communication between the
Raspberry Pi 5 and the Pixhawk flight controller. It is a lightweight messaging protocol
designed specifically for drones and unmanned vehicles. MAVLink is widely used in

Introduction 21

robotics because it is efficient and reliable. It allows the companion computer to send flight
commands to the Pixhawk and receive telemetry data such as GPS position, battery voltage,
flight mode, and sensor readings. This protocol is essential for enabling autonomous control
of the drone [6].

In addition to onboard communication, a secure communication tunnel was established
using Cloudflare (figure 1.23) and linked to the custom domain nldrone.space. This
tunnel enabled remote connectivity between the ground control station and the Raspberry
Pi without exposing the local network. It served as the primary communication channel
for transmitting delivery job data, receiving telemetry, and coordinating delivery operations
over the internet in real time.

Figure 1.23: Cloudflare Icon
1.5.3.j. Mission Planner

Mission Planner is a free and open-source Windows software used to configure and monitor
the drone. Figure 1.24 shows the Mission Planner with CUST university in the satellite
view. When a laptop is connected to the Pixhawk via a micro-USB cable, Mission Planner
establishes communication with the flight controller. This software allows the installation
of ArduCopter firmware into the Pixhawk and provides tools to configure important flight
parameters such as flight modes, sensor calibration, and safety settings. Mission Planner
also makes it easy to configure hardware components like the remote controller by providing
a simple interface for channel mapping and mode assignment. Additionally, it helps identify
and diagnose errors that occur in the flight controller by displaying real-time telemetry data
and system status messages. This makes Mission Planner an essential tool for setting up
and maintaining the drone.

Introduction 22

Figure 1.24: Mission Planner
1.5.4 Terminology and Concepts
Before moving on, there are a few terminologies and concepts used throughout this project
that the reader should understand to properly follow this report. These are introduced below:

1.5.4.a. Delivery Job

A delivery job refers to the complete life cycle of a delivery task. It starts from the
drone’s takeoff at the home location, includes reaching the delivery destination via multiple
waypoints, avoiding restricted or no-fly zones, delivering the payload, and returning safely
back to the home location. Essentially, a delivery job represents the entire end-to-end
journey of the drone for a single delivery.

1.5.4.b. Mission

A mission is a smaller, manageable segment of a delivery job. It represents a single flight
journey of the drone, such as traveling from the home location to the delivery point or
returning back. A delivery job can consist of multiple missions. Each mission involves the
drone moving along planned waypoints and executing tasks defined in that segment.

1.5.4.c. Flight Modes

Flight modes define the behavior of the drone and are provided by the ArduPilot software.
They control how the drone responds to inputs from the remote or companion computer.

Introduction 23

The main flight modes used in this project include:

Loiter: The drone hovers in place using GPS to maintain a fixed position. However,
it can be manually controlled but the flight is much smooth in this mode.
Alt Hold: The drone maintains a constant altitude, allowing manual horizontal
movement while keeping the height steady.
RTL (Return to Launch): The drone automatically returns to its takeoff location.
Guided: The drone is controlled by the companion computer (Raspberry Pi), enabling
autonomous navigation along planned waypoints.
Auto: Executes pre-programmed missions automatically, including waypoint navi-
gation and delivery tasks.
Circle: The drone flies in a circle with a configured radius at a fixed height. This
mode is primarily used for testing and demonstration purposes.
1.5.4.d. Remote Control Override

The remote controller allows switching between three key modes for manual override. When
switched to Guided , the Raspberry Pi takes control of the drone. When switched to Loiter ,
the user can manually control the drone via the remote. Other modes can also be controlled
using the Ground Control Station (GCS) for additional testing or demonstration purposes.

1.6 Project Work Break Down
The figure 1.25 explains the work breakdown structure of our Autonomous Drone Delivery
System project. The project was divided into different phases, including research, hardware
and software development, integration, testing, and final deployment. Each phase contains
important tasks that were needed to complete the project successfully.

The tasks were divided among group members, which are indicated by background colors
with Cyan for Farhad Ali, Green for Hammad Mustafa, and Pink for Zunaira Manzoor to
show individual responsibilities.

Introduction 24

Figure 1.25: Work Breakdown Structure
1.7 Project Time Line
The figure 1.26 shows the Project Timeline for our Autonomous Drone Delivery System.
Research and Planning were continued until mid-April. Software Development begun in
April and continued until early October, while Hardware Development started in June
and ran until early October. Integration and Testing took place from August to the end
of November, alongside hardware and software development. Finally, Deployment and
Documentation began in November and continued until the end of January.

Introduction 25

Figure 1.26: Project Timeline
1.8 Chapter Summary
This chapter introduced the Autonomous Drone Delivery System by outlining the project’s
objectives, scope, and motivation. It identified the key technologies and tools used through-
out the project, including ArduPilot, ROS2, ReactJS, Firebase, and Docker, and described
the hardware components that make up the drone platform. The chapter also presented the
project’s work breakdown structure and timeline, establishing a clear overview of the de-
velopment effort. The next chapter presents the literature review, existing solutions, system
requirements, and the detailed design of the proposed system.

26
Chapter 2
2 Requirement Specification and Analysis
This Chapter presents the requirement specification and analysis for the autonomous drone
delivery system, forming the foundation for its design and development. It details func-
tional requirements, such as autonomous navigation, and payload delivery, alongside non-
functional requirements focusing on performance, safety, and reliability. The chapter em-
ploys analytical tools, including use case diagrams to depict user interactions, a domain
model to outline key entities, system sequence diagrams (SSDs) to illustrate event flows,
and user interface prototypes to inform design. These elements ensure clarity, alignment
with user needs, and compliance with regulatory standards.

2.1 Functional Requirements
The functional requirements of the Autonomous Drone Delivery System describe the main
capabilities the system must possess to operate safely, efficiently, and reliably. This project
is divided into four major modules, each responsible for a specific part of the delivery
process. These modules work together to form a complete end-to-end delivery pipeline,
from the moment a user places an order to the point where the drone successfully delivers
the package and returns home.

The first module is the React-based frontend application, which allows users to register, log
in, place delivery orders, select delivery locations, and track their requests. Once a user
submits an order, it is stored in Firebase, specifically in both Firestore and the Realtime
Database. Firebase provides a cloud-hosted NoSQL database that stores data in JSON
format and synchronises it in real time across all connected clients, eliminating the need
for a dedicated application server [7]. The Realtime Database ensures that new orders are
instantly available, enabling real-time system response without delays.

The third module is the Ground Control Station (GCS), which continuously monitors the
Firebase Realtime Database. As soon as a new job appears, the GCS validates the user
input, stores job data, and selects a suitable drone if multiple drones are available. Once a
job is approved, the GCS sends mission instructions to the selected drone through a secure
communication channel. This communication channel is established using Cloudflare,
which exposes the drone’s local APIs and WebSocket connections through the domain
nldrone.space. Access to these APIs is protected using a specific API key, ensuring that

Requirement Specification and Analysis 27

only authorized systems can send commands, while unauthorized requests are automatically
rejected.

The fourth module is the drone and its onboard system, which consists of the physical flight
hardware and the control software running on the Raspberry Pi. The drone connects to the
internet using a USB EVO Chargi, which creates a secure communication tunnel between
the drone and the GCS. Through this tunnel, the drone receives job commands such as
GPS coordinates and flight instructions, and sends back real-time telemetry data including
position, battery level, altitude, speed, and flight status. Telemetry refers to this automatic
exchange of flight data, which enables continuous monitoring, safe operation, and informed
decision-making during autonomous flight.

The system must support autonomous navigation using onboard sensors and intelligent
algorithms to fly accurately across diverse environments. A comprehensive survey of drone-
aided routing approaches highlights the growing importance of optimised path planning for
delivery operations, including techniques for handling no-fly zones, energy constraints, and
multi-drop scenarios [8]. It must ensure secure payload handling and precise delivery to
designated locations.

Continuous communication with the control system enables real-time monitoring, manual
intervention when needed, and emergency recovery in critical situations. The system also
performs data logging and delivery confirmation for performance tracking and verification.
A manual override option is included to support testing and emergency control scenarios.

In this context, the term “Drone” refers to the physical hardware, including the Raspberry
Pi and flight control software, that is responsible for flight and payload delivery. The term
“System” refers to the complete solution, which includes all four modules. The term “job”
or “delivery job” refers to a full delivery task, including takeoff, reaching the delivery
location, and returning to the home position. A “user” is the person who places a delivery
order, while an “operator” is the person who operates and monitors the GCS. Together, these
definitions form the foundation for the functional requirements listed in Table 2.1 below.

The functional requirements listed below were written following widely accepted software
engineering practices, such as those described in standard requirements engineering litera-
ture [9]. Each requirement is stated using clear, testable language, follows the “shall” format,
describes a single system behavior, avoids design or implementation bias, and remains ver-
ifiable and measurable. The requirements are categorized logically, uniquely identified,
and written to directly reflect the implemented behavior of the system, ensuring traceability
between system design, implementation, and validation.

Requirement Specification and Analysis 28

Table 2.1: Functional Requirements
ID Name Description Type
User Interface (React Frontend)
FR1 User Registration
and Login
The system shall allow users to reg-
ister and authenticate using a web-
based interface before placing deliv-
ery orders.
Core
FR2 Order Placement The system shall allow authenticated
users to place a delivery order by se-
lecting a delivery location and pack-
age type through an interactive map
interface.
Core
FR3 Location Selection
via Map
The system shall allow users to select
delivery coordinates by clicking on
a map, triggering a form populated
with the selected location.
Core
FR4 Order Data Storage The system shall store full order de-
tails in Firestore and a simplified ver-
sion of the order in the Firebase Re-
altime Database.
Core
Ground Control Station (GCS)
FR5 Real-Time Order
Detection
The GCS shall continuously monitor
the Firebase Realtime Database and
detect new delivery jobs as soon as
they are created.
Core
FR6 Order Validation The GCS shall validate incoming de-
livery jobs before presenting them to
the operator.
Core
FR7 Operator Approval The GCS shall require the operator to
manually approve and start a delivery
job after the operator has physically
placed the package on the drone.
Core
Continued on next page
Requirement Specification and Analysis 29

ID Name Description Type
FR8 Job Queue
Management
The GCS shall maintain a queue of
pending delivery jobs and display the
most recent job to the operator.
Supportive
FR9 Job Dispatch to
Drone
The GCS shall transmit approved job
details to the drone through a secure
communication tunnel.
Core
FR10 Telemetry Reception The GCS shall receive real-time
telemetry data from the drone, in-
cluding position, battery level, alti-
tude, and flight status.
Core
FR11 Telemetry Storage The GCS shall store received teleme-
try data in a local SQLite database for
monitoring and analysis.
Supportive
FR12 Operator Interface The GCS shall provide a web-based
interface for the operator to monitor
drone status, job progress, and sys-
tem logs.
Core
FR13 No-Fly Zone Aware
Path Planning
The GCS shall retrieve no-fly zones
from Firebase and use the A* path
planning algorithm to generate an or-
dered set of waypoints for safe navi-
gation.
Core
Communication & Security
FR14 Secure
Communication
Tunnel
The system shall establish a secure
communication tunnel using Cloud-
flare between the GCS and the drone
via a custom domain.
Core
FR15 API Authentication The system shall restrict access to
drone APIs using an API key and
reject unauthorized requests.
Core
Continued on next page
Requirement Specification and Analysis 30

ID Name Description Type
FR16 WebSocket
Telemetry Channel
The system shall use WebSocket
connections to transmit real-time
telemetry data from the drone to the
GCS.
Core
Drone System (ROS2-Based Architecture)
FR17 Pixhawk
Communication via
MOVROS
The system shall use the MOVROS
node to communicate with the
Pixhawk flight controller using
MAVLink over a USB connection.
Core
FR18 High-Level Flight
Command
Processing
The system shall use the main ROS2
node to generate high-level flight
commands and forward them to
MOVROS for execution.
Core
FR19 GCS Client
Communication
Node
The system shall use a GCS client
node to manage API requests and
WebSocket communication with the
GCS through the secure tunnel.
Core
FR20 Job Reception on
Drone
The drone shall receive delivery job
details, including coordinates and
job parameters, from the GCS via
the FastAPI interface.
Core
FR21 Autonomous
Takeoff and
Navigation
The drone shall autonomously take
off, ascend to a predefined altitude,
navigate to the delivery location, and
return to the home position without
human intervention.
Core
FR22 Configurable Flight
Parameters
The system shall store flight parame-
ters (e.g., delivery altitude) in a local
SQLite database on the drone and
allow updates via the GCS when no
active job is running.
Core
Continued on next page
Requirement Specification and Analysis 31

ID Name Description Type
FR23 Parameter
Synchronization
The system shall transmit updated
flight parameters from the GCS to
the drone over the secure communi-
cation channel.
Core
FR24 Onboard Telemetry
Logging
The drone shall log telemetry data lo-
cally in an onboard SQLite database
during each delivery job.
Supportive
FR25 Telemetry
Transmission to
GCS
The drone shall transmit telemetry
data to the GCS client node for mon-
itoring and storage.
Core
FR26 Real-Time Location
Updates to User
The system shall update the drone’s
GPS position in the Firebase Real-
time Database during a delivery job
to allow the user to track the drone
on the map in real time.
Core
FR27 Flight Mode
Verification
The drone shall verify that it is in
GUIDED mode before starting a de-
livery job and remain idle if the mode
is not appropriate.
Core
Safety & Reliability
FR28 Pre-Flight
Readiness Check
The system shall verify system readi-
ness before job start, including com-
munication availability and parame-
ter validity.
Core
FR29 Return-to-Launch
(RTL) Handling
The system shall command the drone
to return to the home position in case
of job completion, operator com-
mand, or critical system failure.
Core
FR30 Manual Abort
Capability
The system shall allow the operator
to abort a job from the GCS interface
when necessary.
Core
Continued on next page
Requirement Specification and Analysis 32

ID Name Description Type
FR31 Pre-Flight System
Check
The drone shall verify GPS readiness
by waiting for a minimum of four
satellites and perform onboard sys-
tem checks before allowing job start.
Core
FR32 Manual Override
During Flight
The system shall pause autonomous
operation and allow manual control
if the operator switches the drone to
LOITER or ALT HOLD mode dur-
ing a delivery job.
Core
FR33 Home Location
Recording
The drone shall record a home lo-
cation before job start and use it to
return after completing the delivery
job.
Core
FR34 Regulatory
Compliance
The system shall prevent flight into
no-fly zones and beyond configured
altitude limits in accordance with op-
erational regulations.
Core
Configuration and Control
FR35 Remote Flight Mode
Change
The GCS shall allow the operator to
change the drone’s flight mode when
no delivery job is active, for testing
and calibration purposes.
Optional
FR36 Manual Motion
Control
The GCS shall allow the operator to
control cruise motion, rotation, and
altitude of the drone when no deliv-
ery job is active.
Optional
User Interaction
FR37 View Order History The system shall allow authenticated
users to view a history of their past
delivery orders, including order sta-
tus and delivery details.
Supportive
Continued on next page
Requirement Specification and Analysis 33

ID Name Description Type
FR38 Manage User Profile The system shall allow authenticated
users to view and update their pro-
file information, including personal
details and account settings.
Supportive
2.2 Non-Functional Requirements
The non-functional requirements (NFRs) define how the autonomous drone delivery system
performs and behaves rather than what functions it performs. These NFRs were writ-
ten following widely accepted software engineering guidelines: each requirement is clear,
measurable, feasible, and unambiguous. They ensure security, reliability, usability, main-
tainability, and regulatory compliance of the system. The following table lists the NFRs
applicable to the current implementation, reflecting the actual system architecture, which
includes the React frontend, Firebase backend, GCS, ROS2-based drone system, Cloudflare
communication tunnel, and SQLite data storage.

The Autonomous Drone Delivery System relies on software to deliver packages au-
tonomously, with users only selecting the delivery location and operator loading the package.
The non-functional requirements (NFRs) below outline the expected qualities of the soft-
ware, such as how secure, fast, and user-friendly it must be, ensuring it meets the project’s
goals within budget and constraints [10].

Table 2.2: Non-Functional Requirements
ID Category Description
NFR1 Security The system shall secure all communication chan-
nels using API keys, Cloudflare tunnels, and Fire-
base authentication, ensuring that unauthorized
access to the drone, GCS, and telemetry data is
prevented.
NFR2 Storage The system shall store telemetry and logs on lo-
cal SQLite databases on both the drone and the
GCS while maintaining real-time mission data in
Firebase, ensuring efficient storage use without ex-
ceeding capacity.
Continued on next page
Requirement Specification and Analysis 34

ID Category Description
NFR3 Configuration The system shall provide a clear and user-friendly
interface on the GCS for configuring flight param-
eters and system settings when no delivery job is
active.
NFR4 Cost The drone shall be developed using hardware
and software components that collectively cost no
more than Rs. 2,00,000, utilizing cost-effective
open-source tools where possible.
NFR5 Interoperability The drone shall integrate seamlessly with the GCS
and frontend using ROS2, MAVLink, FastAPI,
WebSockets, Pixhawk, and Raspberry Pi, ensuring
consistent operation across all system modules.
NFR6 Flexibility The system shall have a modular architecture to
support future enhancements, including adding
new drones or modules, without requiring a com-
plete system redesign.
NFR7 Disaster Recovery The system shall recover from failures such as
power loss, communication drops, or software
crashes by safely returning the drone to home
(RTL) or pausing the mission, while preserving
mission data.
NFR8 Accessibility The system shall provide a simple and intuitive
interface for users to register, select delivery loca-
tions on a map, and track deliveries in real-time
with minimal training.
NFR9 Maintainability The system shall use well-documented, modu-
lar code across all components (React frontend,
Flask GCS, ROS2 drone nodes) to support effi-
cient maintenance, updates, and bug fixes.
NFR10 Regulatory
Compliance
The system shall enforce altitude limits and prevent
flights into no-fly zones as defined in Firebase, en-
suring compliance with local aviation regulations.
Continued on next page
Requirement Specification and Analysis 35

ID Category Description
NFR11 Performance The system shall update the user-facing real-time
drone location on the frontend via Firebase at least
once every 2 seconds to ensure smooth tracking.
NFR12 Reliability The communication tunnel shall maintain high
availability, ensuring that commands and teleme-
try messages between GCS and drone are reliably
delivered.
2.3 System Use Case Modeling
Use case modeling illustrates all the main interactions between the actors and the system
to complete a delivery job. This technique, formalised as part of the Unified Modeling
Language (UML), provides a structured way to capture functional requirements from the
perspective of each actor [11]. Each use case represents a specific goal or task, such
as registering an account, placing a delivery order, monitoring the drone, or configuring
system parameters, and clearly identifies which actor performs each action. By organizing
the system’s functionality this way, we can see how the User, Operator (via the Ground
Control Station), and the Drone system work together to ensure reliable and secure delivery
operations, as shown in figure 2.1.

Requirement Specification and Analysis 36

Figure 2.1: Use Case Diagram
2.4 Use Cases to Functional Requirements Mapping
This section establishes traceability between the functional requirements defined earlier and
the system use cases, ensuring that every required system capability is supported by at least
one use case. Table 2.3 maps each functional requirement to the corresponding use case(s),
helping verify completeness, consistency, and coverage across the system design.

By explicitly linking each requirement to user interactions, we guarantee that no critical
functionality acts in isolation. This traceability not only simplifies the testing and validation
phases by providing clear paths from user goals to technical specifications but also makes
future maintenance more manageable by highlighting the dependencies between different
system modules.

Requirement Specification and Analysis 37

Table 2.3: Mapping of Functional Requirements to Use Cases
ID Functional Requirements Mapped Use Case(s)
FR1 User Registration and Login Register Account, Log in
FR2 Order Placement Place Delivery Order
FR3 Location Selection via Map Place Delivery Order
FR4 Order Data Storage Place Delivery Order
FR5 Real-Time Order Detection View Pending Orders
FR6 Order Validation Validate Order
FR7 Operator Approval Start Delivery Mission
FR8 Job Queue Management View Pending Orders
FR9 Job Dispatch to Drone Start Delivery Mission
FR10 Telemetry Reception Monitor Active Mission
FR11 Telemetry Storage Monitor Active Mission
FR12 Operator Interface Monitor Active Mission, View Mis-
sion Logs
FR13 No-Fly Zone Aware Path Planning Validate Order
FR14 Secure Communication Tunnel Start Delivery Mission, Monitor Ac-
tive Mission
FR15 API Authentication Start Delivery Mission, Monitor Ac-
tive Mission
FR16 WebSocket Telemetry Channel Monitor Active Mission
FR17 Pixhawk Communication via
MOVROS
Start Delivery Mission, Monitor Ac-
tive Mission
FR18 High-Level Flight Command Pro-
cessing
Start Delivery Mission, Monitor Ac-
tive Mission
FR19 GCS Client Communication Node Start Delivery Mission, Monitor Ac-
tive Mission
FR20 Job Reception on Drone Start Delivery Mission
FR21 Autonomous Takeoff and Navigation Start Delivery Mission
Continued on next page
Requirement Specification and Analysis 38

ID Functional Requirements Mapped Use Case(s)
FR22 Configurable Flight Parameters Configure Drone Parameters
FR23 Parameter Synchronization Configure Drone Parameters
FR24 Onboard Telemetry Logging Monitor Active Mission
FR25 Telemetry Transmission to GCS Monitor Active Mission
FR26 Real-Time Location Updates to User Track Delivery
FR27 Flight Mode Verification Start Delivery Mission
FR28 Pre-Flight Readiness Check Start Delivery Mission
FR29 Return-to-Launch (RTL) Handling Override Drone Control
FR30 Manual Abort Capability Override Drone Control
FR31 Pre-Flight System Check Start Delivery Mission
FR32 Manual Override During Flight Override Drone Control
FR33 Home Location Recording Start Delivery Mission
FR34 Regulatory Compliance Validate Order
FR35 Remote Flight Mode Change Change Flight Mode
FR36 Manual Motion Control Change Flight Mode
FR37 View Order History View Order History
FR38 Manage User Profile Manage Profile
2.5 Use Case Details
This section describes each use case in detail using a structured table that includes its ID,
name, actors, description, triggers, conditions, and flows. These specifications clearly show
how users and operators interact with the system and how it responds in different situations,
supporting implementation, testing, and validation.

2.5.1 Register Account
This use case describes how a new user creates an account on the system through the web
interface. The complete interaction between the user and the system is detailed in Table 2.4.

Requirement Specification and Analysis 39

Table 2.4: Use Case - Register Account
Use Case ID: UC1
Use Case Name: Register Account
Created By: Hammad Mustafa Last Updated By: Hammad
Mustafa
Date Created: 9th May, 2025 Last Revision Date: 26-Jan,
2026
Actors: User
Description: User creates a new account on the web platform to access
delivery services.
Trigger: User clicks the ”Register” button on the web interface.
Preconditions: User is not already logged into the system.
Post conditions: A new user account is successfully created and stored in
the system.
Normal Flow Actor System
User opens the registration
page
User enters required registra-
tion details (e.g., name, email,
password)
User clicks the ”Register” but-
ton
System validates the entered in-
formation
System creates a new user ac-
count
System confirms successful
registration to the user
Requirement Specification and Analysis 40

Alternative Flows: A1: If any required field is missing, the system displays
an error message and asks the user to complete all fields.
A2: If the email is already registered, the system displays
a message indicating that the account already exists.
Exceptions: If the authentication service is unavailable, the system
displays a ”Registration Failed” message and does not
create the account.
2.5.2 Log In
This use case explains how an existing user accesses the system by logging into their account.
The interaction between the user and the system is shown in Table 2.5.

Table 2.5: Use Case - Log In
Use Case ID: UC2
Use Case Name: Log In
Created By: Zunaira Manzoor Last Updated By: Zunaira
Manzoor
Date Created: 9th May, 2025 Last Revision Date: 20-Jan,
2026
Actors: User
Description: User logs into the system to access their account and
delivery services.
Trigger: User clicks the ”Log In” button on the web interface.
Preconditions: User already has a registered account.
Post conditions: User is authenticated and granted access to the system.
Normal Flow Actor System
User opens the login page
User enters email and password
Requirement Specification and Analysis 41

User clicks the ”Log In” button System validates the creden-
tials
System authenticates the user
System redirects the user to the
dashboard
Alternative Flows: A1: If the email or password is incorrect, the system
displays an error message and asks the user to try again.
Exceptions: If the authentication service is unavailable, the system
displays a ”Login Failed” message and does not grant
access.
2.5.3 Manage Profile
This use case describes how a user views and updates their personal information within the
system. The interaction between the user and the system is detailed in Table 2.6.

Table 2.6: Use Case - Manage Profile
Use Case ID: UC3
Use Case Name: Manage Profile
Created By: Farhad Ali Last Updated By: Hammad
Mustafa
Date Created: 9th May, 2025 Last Revision Date: 21-Jan,
2026
Actors: User
Description: User views and updates their profile information, includ-
ing name, phone number, location, password, or deletes
their account.
Trigger: User selects the ”Profile” option from the dashboard on
the web interface.
Preconditions: User is logged into the system.
Requirement Specification and Analysis 42

Post conditions: User profile information is updated or the user account is
deleted from the system.
Normal Flow Actor System
User opens the profile settings
page
System displays current profile
information
User edits name, phone num-
ber, location, or password
User clicks the ”Save” button System validates the updated
information
System updates the user profile
System confirms successful up-
date to the user
Alternative Flows: A1: If the user chooses to delete their account, the system
asks for confirmation. Upon confirmation, the system
permanently deletes the account.
Exceptions: If the system fails to update or delete the profile due to a
server error, the system displays an error message and no
changes are applied.
2.5.4 Place Delivery Order
This use case describes how a logged-in user places a delivery order by selecting a destination
on the map and submitting delivery details. The process begins when the user interacts with
the integrated map interface, which provides a visual and intuitive way to pinpoint the exact
delivery location while automatically preventing selections within restricted no-fly zones.
The complete interaction between the user and the system is described in Table 2.7.

Table 2.7: Use Case - Place Delivery Order
Use Case ID: UC4
Use Case Name: Place Delivery Order
Requirement Specification and Analysis 43

Created By: Hammad Mustafa Last Updated By: Hammad
Mustafa
Date Created: 9th May, 2025 Last Revision Date: 26-Jan,
2026
Actors: User
Description: User places a delivery order by selecting a destination on
the map and submitting package details.
Trigger: User clicks on a location on the map interface.
Preconditions: User is logged into the system.
Post conditions: A new delivery order is created and stored in the system
for processing.
Normal Flow Actor System
User opens the dashboard page System displays the interactive
map
User clicks on a precise deliv-
ery location on the map
System opens the delivery form
with selected coordinates
User enters receiver name (or
selects self) and package type
User clicks the ”Confirm Or-
der” button
System validates the entered in-
formation
System creates a new delivery
order
System stores full order data in
Firestore
System stores simplified job
data in Realtime Database
System confirms successful or-
der placement to the user
Requirement Specification and Analysis 44

Alternative Flows: A1: If the user selects an invalid or missing location, the
system displays an error message and asks the user to
select a valid location.
A2: If required fields are missing, the system displays an
error message and asks the user to complete all fields.
A3: If the user tries to click on a no-fly zone, the system
prevents selecting that location.
Exceptions: If the system fails to store the order due to a server or
database error, the system displays an error message and
the order is not created.
2.5.5 Track Delivery
This use case describes how a user views the real-time location of the drone during an active
delivery using the map interface. The interaction between the user and the system is detailed
in Table 2.8.

Table 2.8: Use Case - Track Delivery
Use Case ID: UC5
Use Case Name: Track Delivery
Created By: Hammad Mustafa Last Updated By: Farhad alti-
tude
Date Created: 9th May, 2025 Last Revision Date: 23-Jan,
2026
Actors: User
Description: User views the real-time location of the delivery drone
on the map during an active delivery.
Trigger: A delivery becomes active for the user’s placed order.
Preconditions: User is logged into the system and has an active delivery
order.
Requirement Specification and Analysis 45

Post conditions: User continuously views updated drone position until de-
livery is completed.
Normal Flow Actor System
User remains on the dashboard System displays the map inter-
face
System displays a drone icon on
the map
System continuously updates
the drone’s GPS position in real
time
User observes the drone’s
movement on the map
System stops live updates when
delivery is completed
Alternative Flows: A1: If the user refreshes the page during an active deliv-
ery, the system reloads the map and resumes displaying
the current drone position.
Exceptions: If real-time telemetry data is unavailable, the system dis-
plays the last known drone location and shows a connec-
tion error message.
2.5.6 View Order History
This use case describes how a user views a list of their active and past delivery orders along
with their details. The interaction between the user and the system is detailed in Table 2.9.

Table 2.9: Use Case - View Order History
Use Case ID: UC6
Use Case Name: View Order History
Created By: Zunaira Manzoor Last Updated By: Farhad Ali
Requirement Specification and Analysis 46

Date Created: 9th May, 2025 Last Revision Date: 23-Jan,
2026
Actors: User
Description: User views a list of their active and past delivery orders
along with relevant order details.
Trigger: User navigates to the ”My Orders” section on the dash-
board.
Preconditions: User is logged into the system.
Post conditions: User successfully views the list of orders and their details.
Normal Flow Actor System
User opens the ”My Orders”
section
System retrieves active and past
orders for the user
System displays each order
with status, date/time, destina-
tion, and package type
Alternative Flows: A1: If the user has no orders, the system displays a
message indicating that no orders are available.
Exceptions: If the system fails to retrieve order data due to a database
error, the system displays an error message and no order
data is shown.
2.5.7 View Pending Orders
This use case describes how the operator views all pending delivery orders that are awaiting
validation or execution. The GCS provides a dashboard where new orders appear in real time
directly from the database. This allows the operator to quickly assess the queue, prioritize
incoming requests, and prepare the drone for its next mission. The interaction between the
operator and the system is detailed in Table 2.10.

Table 2.10: Use Case - View Pending Orders
Use Case ID: UC7
Requirement Specification and Analysis 47

Use Case Name: View Pending Orders
Created By: Farhad Ali Last Updated By: Farhad Ali
Date Created: 9th May, 2025 Last Revision Date: 23-Jan,
2026
Actors: Operator
Description: Operator views all pending delivery orders that are await-
ing validation or execution.
Trigger: Operator opens the ”Jobs” section from the GCS side
panel.
Preconditions: GCS is running and connected to the firebase via internet.
Post conditions: Pending delivery orders are displayed to the operator in
a queue.
Normal Flow Actor System
Operator opens the ”Jobs” page
from the side panel
System retrieves pending jobs
from the database
System displays all pending or-
ders in a queue
System automatically updates
the list when new orders arrive
Alternative Flows: A1: If there are no pending orders, the system displays a
message indicating that no jobs are available.
Exceptions: If the system fails to retrieve pending orders due to a
connection error, the system displays an error message
and no jobs are shown.
2.5.8 Validate Order
This use case describes how the operator validates a pending delivery order before it can be
executed by the drone. The interaction between the operator and the system is detailed in
Table 2.11.

Requirement Specification and Analysis 48

Table 2.11: Use Case - Validate Order
Use Case ID: UC8
Use Case Name: Validate Order
Created By: Farhad Ali Last Updated By: Farhad Ali
Date Created: 9th May, 2025 Last Revision Date: 24-Jan,
2026
Actors: Operator
Description: Operator validates a delivery order by checking coordi-
nate validity and ensuring no no-fly zones are violated.
Trigger: Operator selects a pending order from the jobs list.
Preconditions: At least one pending delivery order exists.
Post conditions: The order is either approved for execution or cancelled if
validation fails.
Normal Flow Actor System
Operator selects a pending or-
der
System displays order details
Operator initiates validation System checks whether the co-
ordinates are within range
System checks whether the
route intersects any no-fly
zones
System marks the order as valid
System makes the order avail-
able for mission start
Alternative Flows: A1: If the coordinates are out of range or intersect a
no-fly zone, the system marks the order as invalid and
cancels the order.
Requirement Specification and Analysis 49

Exceptions: If the validation service fails due to a system error, the
system displays an error message and the order remains
unprocessed.
2.5.9 Start Delivery Mission
This use case describes how the operator starts a delivery mission by sending a validated
job to the drone after physically placing the payload. The interaction between the operator
and the system is detailed in Table 2.12.

Table 2.12: Use Case - Start Delivery Mission
Use Case ID: UC9
Use Case Name: Start Delivery Mission
Created By: Farhad Ali Last Updated By: Farhad Ali
Date Created: 9th May, 2025 Last Revision Date: 24-Jan,
2026
Actors: Operator
Description: Operator starts a delivery mission by confirming payload
placement and sending the job to the drone.
Trigger: Operator clicks the ”Start Job” button on a validated or-
der.
Preconditions: A delivery order has been validated and no active mission
is currently running.
Post conditions: The delivery job is sent to the drone and the mission is
initiated.
Normal Flow Actor System
Operator selects a validated or-
der
GCS displays the order details
Operator places the payload on
the drone
Requirement Specification and Analysis 50

Operator clicks the ”Start Job”
button
GCS sends the delivery job to
the drone
Drone receives the delivery job
Drone initiates the mission
Alternative Flows: A1: If the operator does not confirm payload placement,
the GCS does not allow mission start.
Exceptions: If communication with the drone fails, the GCS displays
an error message and the mission is not started.
2.5.10 Monitor Active Mission
This use case describes how the operator monitors the ongoing delivery mission through
real-time telemetry and system status information. The interaction between the operator
and the system is detailed in Table 2.13.

Table 2.13: Use Case - Monitor Active Mission
Use Case ID: UC10
Use Case Name: Monitor Active Mission
Created By: Zunaira Manzoor Last Updated By: Zunaira
Manzoor
Date Created: 9th May, 2025 Last Revision Date: 21-Jan,
2026
Actors: Operator
Description: Operator monitors the active delivery mission using real-
time telemetry and system status information.
Trigger: A delivery mission becomes active.
Preconditions: A delivery mission is currently running.
Post conditions: Operator remains informed of the mission status until
completion or termination.
Requirement Specification and Analysis 51

Normal Flow Actor System
Operator opens the mission
monitoring page
System displays live telemetry
data
System displays drone location
coordinates
System displays current flight
mode
System displays current job
state (e.g., IDLE, ARMING,
etc.)
Operator observes mission
progress
System continuously updates
telemetry and status informa-
tion
Alternative Flows: A1: If the operator refreshes the page, the system reloads
and resumes displaying current telemetry and mission
status.
Exceptions: If telemetry data becomes unavailable, the system dis-
plays the last known values and shows a connection error
message.
2.5.11 Override Drone Control
This use case describes how the operator can take manual control of the drone during an
active delivery mission using the RC remote. The interaction between the operator and the
system is detailed in Table 2.14.

Table 2.14: Use Case - Override Drone Control
Use Case ID: UC11
Use Case Name: Override Drone Control
Requirement Specification and Analysis 52

Created By: Hammad Mustafa Last Updated By: Hammad
Mustafa
Date Created: 9th May, 2025 Last Revision Date: 27-Jan,
2026
Actors: Operator
Description: Operator manually overrides the drone during an active
mission using the RC remote by changing the switch to
LOITER mode.
Trigger: Operator moves the three-position switch on the RC re-
mote from down to middle.
Preconditions: A delivery mission is currently active and the drone is
airborne.
Post conditions: Drone pauses autonomous control and allows operator
manual control via RC remote.
Normal Flow Actor System
Operator moves the switch to
the middle (LOITER) position
System transitions the drone
into LOITER mode
Operator manipulates the drone
using RC controls
System pauses mission com-
mands from GCS
Operator flies the drone manu-
ally
System continuously updates
telemetry and mission state
Alternative Flows: A1: Operator returns switch to down position, system re-
sumes mission in GUIDED mode from current location.
Exceptions: If RC communication fails, the drone remains in its last
flight mode and system displays an error message.
2.5.12 Change Flight Mode
This use case describes how the operator can change the drone’s flight mode via the GCS
interface when no delivery mission is active. The interaction between the operator and the
system is detailed in Table 2.15.

Requirement Specification and Analysis 53

Table 2.15: Use Case - Change Flight Mode
Use Case ID: UC12
Use Case Name: Change Flight Mode
Created By: Farhad Ali Last Updated By: Farhad Ali
Date Created: 9th May, 2025 Last Revision Date: 24-Jan,
2026
Actors: Operator
Description: Operator changes the drone’s flight mode via GCS when
no delivery mission is active. Allowed modes include
Land, RTL, ALT HOLD, GUIDED, LOITER, and CIR-
CLE.
Trigger: Operator selects a flight mode from the GCS interface.
Preconditions: No active delivery mission is currently running and GCS
is connected to the drone.
Post conditions: Drone flight mode changes to the selected mode.
Normal Flow Actor System
Operator selects desired flight
mode from GCS
System validates that no active
delivery mission exists
System sends the flight mode
command to the drone
System updates the mission
state and telemetry to reflect the
new flight mode
Alternative Flows: A1: If an active mission is running, the system prevents
mode change and shows an error message.
Exceptions: If communication with the drone fails, the system displays
an error and flight mode remains unchanged.
Requirement Specification and Analysis 54

2.5.13 Configure Drone Parameters
This use case describes how the operator configures specific drone parameters via the GCS
when no delivery mission is active. The interaction between the operator and the system is
detailed in Table 2.16.

Table 2.16: Use Case - Configure Drone Parameters
Use Case ID: UC13
Use Case Name: Configure Drone Parameters
Created By: Hammad Mustafa Last Updated By: Hammad
Mustafa
Date Created: 9th May, 2025 Last Revision Date: 27-Jan,
2026
Actors: Operator
Description: Operator configures specific drone parameters such as
wait time at destination, wait time before job start, and
pre-flight altitude via GCS.
Trigger: Operator selects ”Configure Parameters” in GCS and
modifies the values.
Preconditions: No active delivery mission is currently running. GCS is
connected to the drone.
Post conditions: Updated parameter values are sent to the drone and stored
locally in its SQLite database.
Normal Flow Actor System
Operator opens the ”Configure
Parameters” page
System fetches current param-
eter values from drone SQLite
database
Operator updates parameter
values
System validates inputs
Operator clicks ”Save” System sends updated values to
drone
Requirement Specification and Analysis 55

System updates drone’s local
SQLite database with new pa-
rameters
System confirms update to op-
erator
Alternative Flows: A1: If operator enters invalid values, system shows an
error and requests correction.
Exceptions: If communication with the drone fails, parameter update
is aborted and an error message is displayed.
2.5.14 View Mission Logs
This use case describes how the operator views completed mission logs via GCS, including
telemetry, mission details, and filtering/search options. The interaction between the operator
and the system is detailed in Table 2.17.

Table 2.17: Use Case - View Mission Logs
Use Case ID: UC14
Use Case Name: View Mission Logs
Created By: Farhad Ali Last Updated By: Farhad Ali
Date Created: 9th May, 2025 Last Revision Date: 24-Jan,
2026
Actors: Operator
Description: Operator views past mission logs in GCS, including
telemetry, mission states, and other mission details, with
filtering and search options.
Trigger: Operator selects ”View Mission Logs” from the GCS
interface.
Preconditions: GCS is connected to the local SQLite database containing
mission logs.
Requirement Specification and Analysis 56

Post conditions: Mission logs are displayed to the operator according to
selected filters/search criteria.
Normal Flow Actor System
Operator opens ”Mission
Logs” page
System fetches mission logs
from GCS SQLite database
Operator selects filters or enters
search terms
System filters logs based on cri-
teria
Operator views selected logs System displays mission details
and telemetry
Alternative Flows: A1: If no logs match the filter/search criteria, system
displays a ”No records found” message.
Exceptions: If GCS cannot access the database, system shows an error
and no logs are displayed.
2.6 Activity Diagram
The operational workflow of the proposed drone delivery system is illustrated in Figure 2.2.
Activity diagrams are among the most widely adopted UML behavioural diagrams in soft-
ware engineering research, as they effectively represent concurrent and sequential workflows
[12]. The process begins with Order Initiation when a user places a delivery order and se-
lects a pinpoint address on the interactive map. The Ground Control Station receives this
request and immediately performs GPS validation. If the coordinates are invalid, the request
is rejected and the user is notified. Otherwise, the system proceeds to Resource Allocation.
During this phase, the system checks for an available drone. If all drones are occupied,
the request is added to a queue. Once a drone is available, an evaluation of its readiness is
performed. If the check passes, the mission is transmitted to the drone. A communication
check ensures the mission data was received successfully before the physical preparation
phase begins.

The remaining part of the diagram focuses on Flight Operations and Mission Conclusion.
Once the payload is attached and the final launch signal is given, the drone takes off
and climbs to its cruising altitude, continuously logging and transmitting telemetry data
as it navigates toward the destination. The workflow includes a specialized logic loop
for obstacle handling, allowing the drone to maneuver around detected obstacles without

Requirement Specification and Analysis 57

aborting the path. Upon reaching the destination coordinates, the drone initiates its landing
sequence, descending to a designated drop height to safely release the package. Following
the successful drop-off, post-delivery protocols are executed: the drone logs the final flight
data, triggers its Return-to-Base (RTB) protocol, and uploads a comprehensive mission
report upon arrival, thus concluding the operational cycle at the final End state.

Figure 2.2: Activity Diagram
2.7 Component Diagram
The component diagram in Figure 2.3 shows the high-level software structure of the Au-
tonomous Drone Delivery System and how its major parts interact with each other. The
system is divided into four main components: the React frontend, Firebase cloud backend,
Ground Control Station (GCS), and the drone system. Each component is further decom-
posed into smaller modules to clearly represent responsibilities such as user authentication,

Requirement Specification and Analysis 58

order management, job processing, telemetry handling, and flight control. This diagram
helps in understanding how data and commands flow across the system and how different
technologies work together to achieve autonomous drone delivery.

Figure 2.3: Component Diagram
2.8 Drone Electrical Block Diagram
The electrical block diagram in Figure 2.4 illustrates the physical hardware layout of the
drone and how its main electronic components are interconnected. It shows how power
flows from the battery to the motors through electronic speed controllers (ESCs), and how
control and communication are handled by the Pixhawk flight controller and Raspberry
Pi. Additional components such as the GPS module, camera, and charging module are
also included to present a complete view of the drone’s onboard electrical system. This
diagram helps in understanding the hardware architecture that supports the autonomous
flight operations.

Requirement Specification and Analysis 59

Figure 2.4: Electrical Block Diagram
2.9 SWOT Analysis for Autonomous Drone Delivery System
The SWOT analysis presented in Table 2.18 provides a structured and comprehensive
evaluation of the Autonomous Drone Delivery System by identifying its internal strengths
and weaknesses, alongside external opportunities and threats. This strategic assessment is
essential for understanding the system’s current architectural capabilities, such as its robust
realtime communication and autonomous navigation features, while also acknowledging
potential areas for growth and improvement. By establishing a clear picture of these
internal dynamics, the project team can better align the system’s core competencies with
future logistical demands.

Equally important is the evaluation of external factors that could influence the system’s
operational success and safety. Among the most significant external threats are unpredictable
and adverse weather conditions, which directly affect flight stability, battery consumption,
and overall delivery reliability. Recent research has demonstrated the critical impact of wind
speed and precipitation on drone routing decisions, proposing robust optimisation models to
mitigate these environmental effects [13]. By thoroughly examining these external variables
alongside system constraints, stakeholders and developers can make informed, proactive
decisions regarding system enhancements, operational protocols, and future deployments in
diverse weather scenarios.

Requirement Specification and Analysis 60

Table 2.18: SWOT Analysis for Autonomous Drone Delivery System
SWOT Description
Strengths •Low operation cost
Usage of existing resources
Elimination of delivery vehicles
Weaknesses •Short drone operation
Uncertainty of autonomous mobility route
Drone-delivery receiving mode
Opportunities •Growth of E-Commerce
Growth of mobility
Development of commercial drones
Development of autonomous driving - Increasing traffic congestions
Threats •Drone Regulation
Weather conditions
Unalignment of last-mile delivery and autonomous mobility service
providers
2.10 User Interface Design
This section presents the design and structure of the web-based interfaces developed for users
and system operators. Effective human–machine interface (HMI) design is particularly
important in UAV ground control stations, where operators must supervise autonomous
operations and intervene quickly when necessary [14]. The interfaces were designed with
a focus on clarity, ease of use, and consistent navigation, ensuring that both end-users and
administrators could interact with the system efficiently and reliably.

2.10.1 Landing Page
The landing page served as the primary entry point to the system and provided a high-level
overview of the platform. The complete landing page layout is shown in Figure 2.5, which
illustrates the visual design, navigation structure, and overall presentation of the system.

Requirement Specification and Analysis 61

Figure 2.5: Landing Page
2.10.2 Features Section
The features section, shown in Figure 2.6, highlighted the main capabilities of the platform
in a concise and structured manner.

Figure 2.6: Features section of Landing Page
2.10.3 Tech Stack Details
The technology stack used to build the system was presented on the landing page to provide
transparency and technical clarity. This section, shown in Figure 2.7, displayed the core

Requirement Specification and Analysis 62

tools and frameworks used in the development of the platform.

Figure 2.7: Tech Stack Details of Landing Page
2.10.4 Contact Section and Footer
The contact section and footer of the landing page provided essential communication details
and navigation links. This section, shown in Figure 2.8, ensured that users could easily
access support information and system resources.

Figure 2.8: Contact Section and Footer of Landing Page
Requirement Specification and Analysis 63

2.10.5 Login and Sign Up Forms
User authentication was implemented through dedicated sign-in and sign-up forms to ensure
secure access to the system. The login interface is shown in Figure 2.9a, while the registration
interface is shown in Figure 2.9b. These forms were designed to be simple, clear, and easy
to use.

(a) Sign In Form (b) Sign Up Form
Figure 2.9: Login and Sign Up Forms
2.10.6 Dashboard
After successful authentication, users were directed to the main dashboard, which served as
the central interface for interacting with the system. The dashboard layout, shown in Figure
2.10, provided access to key system features and user actions.

Requirement Specification and Analysis 64

Figure 2.10: Dashboard after login
2.10.7 Order Placement Interface
The order placement interface allowed users to submit delivery requests through a structured
and guided process. This interface, shown in Figure 2.11, was designed to simplify the
submission of delivery information and reduce user errors.

Figure 2.11: Placing an order
Requirement Specification and Analysis 65

2.10.8 No-fly Zone Visualization
The system included a no-fly zone visualization feature to ensure flight safety and compliance
with operational constraints. This interface, shown in Figure 2.12, displayed restricted areas
that the drone must avoid during operation.

Figure 2.12: No fly Zone
2.10.9 User Account Management
User account management functionality was provided to allow users to view and update their
profile information. This interface, shown in Figure 2.13, supported secure and controlled
account handling.

Requirement Specification and Analysis 66

Figure 2.13: Manage User Account
2.10.10 Ground Control Station (GCS) Dashboard Interface
The ground control station (GCS) interface was designed for system operators to monitor
and control drone operations. The main GCS dashboard, shown in Figure 2.14, provided
access to flight status, telemetry data, and operational controls.

Figure 2.14: Ground Control Station Dashboard (GCS)
Requirement Specification and Analysis 67

2.10.11 GCS Manual Control Tab
Manual control functionality was included to allow operators to directly control the drone
when required. This interface, shown in Figure 2.15, supported controlled intervention
during testing or exceptional situations.

Figure 2.15: Ground Control Station Manual Control
2.10.12 GCS Pending Jobs Queue Tab
The pending jobs queue interface displayed all delivery requests awaiting execution. This
view, shown in Figure 2.16, allowed operators to monitor upcoming tasks and manage job
priorities.

Figure 2.16: Ground Control Station Pending Jobs Queue
Requirement Specification and Analysis 68

2.10.13 GCS History Tab
The history tab provided a record of completed missions and system activity. This interface,
shown in Figure 2.17, enabled post-operation review and performance analysis.

Figure 2.17: Ground Control Station History tab
2.11 Chapter Summary
This chapter reviewed existing literature and solutions related to autonomous drone delivery,
establishing the academic and practical foundation for the project. It then defined both
functional and non-functional requirements, formally specifying the expected capabilities
and quality attributes of the system. UML diagrams including use case, sequence, class,
activity, and component diagrams were presented to model the system’s structure and
behaviour from multiple perspectives. Finally, user interface mockups for the React frontend
and the Ground Control Station were shown to illustrate the intended user experience. The
next chapter focuses on the detailed system design and architecture of the proposed solution.

69
Chapter 3
3 System Design
In this chapter, the working of the Autonomous Drone Delivery System is explained in
detail. It shows how all parts of the system are connected, how they communicate with each
other, and how they enable the drone to fly, deliver the package, and return safely.

The system consists of four main parts:

The drone (which flies and delivers)
The Ground Control System (GCS) (which assigns delivery jobs and monitors the
drone)
The Firebase (which stores data, provides realtime functions)
The React Frontend (which allows the user to place a delivery order)
Diagrams are also included to make everything easier to understand. These diagrams show
how parts are connected and how information moves inside the system. This chapter is
very important because it gives a clear picture of the brain and body of the system. Even
if someone doesn’t read the actual code, they can understand how the system works just by
reading this chapter.

3.1 Software Architecture
Software architecture is like a blueprint. It shows how the software is built, how different
parts talk to each other, and how the system reacts to different situations.

3.1.1 Architecture Style Used
The system uses a combination of Client-Server and Event-Driven architecture styles. The
Ground Control System (GCS) works like a server. It receives delivery requests from users
through firebase, verifies them, and then sends commands to the drone. The drone works like
a client. It receives commands from the GCS and performs actions like flying, delivering,
and returning home. The system is also event-driven. This means the system responds when
something happens. These events include:

System Design 70

A new delivery job is received
The drone reaches the delivery location
The drone flight mode is changed
Each event starts a new action automatically. For example, if the drone flight mode is
changed, the drone will act according to the mode automatically. The system also follows
a microservices architecture combined with event-driven communication patterns, an ap-
proach that has been shown to improve scalability and fault isolation in distributed systems
[15]. It is divided into separate components, each functioning independently. If one com-
ponent fails, it does not affect the operation of the others. The main components include the
React frontend, Firebase backend, Ground Control System (GCS), and the Drone as shown
in figure 3.1 below. All of these software modules operate independently and are loosely
coupled.

Figure 3.1: System Architecture
System Design 71

3.1.2 Main Components Involved
The software is divided into different parts, and each part has a job to do:

3.1.2.a. Ground Control System (GCS)

This is a web-based system which receives delivery location from firebase which translates
to coordinates. It checks the data and sends it to the drone. It also shows real-time updates
from the drone like battery level and current location.

3.1.2.b. Raspberry Pi 5 (Companion Computer)

This is the brain of the drone. It runs the smart software that makes decisions like finding
the path and checking the battery level, etc. It also sends flight commands to the Pixhawk.

3.1.2.c. Pixhawk 2.4.8 (Flight Controller)

This is the part that actually controls the motors and flies the drone. The Pixhawk is one of
the most widely adopted open-source flight control platforms in both academic research and
commercial UAV applications [16]. It keeps the drone stable and follows the instructions
given by the Raspberry Pi.

3.1.2.d. Sensors (GPS, IMU, LiDAR)

These provide data about location, speed, balance, and surroundings. The software uses
this data to fly safely and accurately.

3.1.2.e. How These Parts Work Together

All the parts talk to each other using internet and MAVLink, which is a lightweight mes-
saging protocol designed specifically for communication between micro air vehicles and
their ground stations [6]. It is like a common language used for communication between
Raspberry Pi and the Pixhawk. The GCS sends the delivery job to the Raspberry Pi using a
communication tunnel. The Raspberry Pi reads the delivery job, checks all conditions, and
sends flying instructions to the Pixhawk using MAVLink.

The Pixhawk controls the drone’s flight based on those instructions. The drone sends
back updates like position, speed, battery level to the GCS. This structure keeps everything
modular and independent. If an upgrade is needed for one part later (like adding a camera),
it can be done easily without changing the whole system.

System Design 72

3.2 Components and Connector
In this section, all the main hardware and software components used in the project are
explained, along with how they are connected to work together as a complete system. Each
component has a special job, and all components are connected like team members working
together to complete the delivery delivery job.

3.2.1 Main System Components
Below are the most important components in the system:

3.2.1.a. Drone Frame and Hardware

This is the body of the drone, which holds everything together. The frame has:

Motors: These make the drone fly by spinning the propellers.
Propellers: These push air down to lift the drone up.
Battery: Gives power to the whole drone.
ESCs (Electronic Speed Controllers): Control how fast the motors spin.
RC Receiver: Receives commands from Remote Controller.
GPS Module: Used by drone to know it’s position in the real world.
Power Distribution Board: Distributes power from the battery to other parts, and is
part of the frame itself.
These are all physical components mounted on the drone’s frame.

3.2.1.b. Pixhawk 2.4.8 (Flight Controller)

This is the main controller that keeps the drone balanced, stable, and flies it safely. It takes
care of low-level flight (like keeping altitude, adjusting speed). It receives flight commands
from the Raspberry Pi. Think of it like providing the stearing wheel of the drone. Just like
in a car, you turn stearing, press paddles and these translate to rotation of wheels and engine
speed, Pixhawk works in the same way. This is also mounted on the drone itself.

3.2.1.c. Raspberry Pi 5 (Companion Computer)

This is the smart brain of the drone. It runs the autonomous software built on the Robot

System Design 73

Operating System (ROS2) framework, which provides a modular publish-subscribe com-
munication model for robotic applications [17]. The flight control stack itself is based on the
PX4 open-source autopilot framework, which provides a node-based architecture optimised
for deeply embedded platforms [18]. It decides where to fly, when to avoid obstacles, and
when to return home. It sends high-level commands to Pixhawk using MAVLink. Think
of it like the thinking brain of the drone. This is the component that takes control of the
stearing wheel provided by the Pixhawk. It is also mounted on the drone and physically
connected to Pixhawk via a micro USB cable.

3.2.1.d. Sensors (GPS, IMU)

These give the drone information about the world around it:

GPS: Tells the drone its exact location.
IMU (Accelerometer + Gyroscope): Tells if the drone is moving or tilted.
Compass: Helps the drone know about it’s orientation.
Barometer: Helps the drone estimate it’s height by using atmospheric pressure.
The Raspberry Pi reads this data to make smart decisions during the delivery job.

3.2.1.e. Ground Control System (GCS)

The Ground Control System (GCS) was implemented as a web-based Flask application.
It receives delivery job requests from Firebase and performes verification and validation
before displaying them on an operator dashboard. After the delivery item is physically
placed on the drone, the operator reviewes and approves the job through the dashboard
interface. Once approved, the job is assigned to an available drone through the secure
communication tunnel.

In addition to job management, the GCS receives telemetry data from the drones and
streams this data to Firebase for real-time monitoring. Firebase, as a Backend-as-a-Service
(BaaS) platform, provides real-time data synchronisation across all connected clients without
requiring a dedicated application server [7]. This allowes authorized users to observe drone
status and delivery job progress through the web interface. The GCS serves as the central
coordination layer of the system, connecting the database, operator interface, and drone
communication infrastructure.

3.2.2 How Everything is Connected
All components talk to each other through communication links:

System Design 74

3.2.2.a. Raspberry Pi to Pixhawk Connection

The communication between the Raspberry Pi and the Pixhawk flight controller is estab-
lished through a direct physical serial connection using a micro-USB cable. They exchange
data continuously using the lightweight MAVLink protocol.

3.2.2.b. GCS to Drone Connection

The Ground Control Station communicates with the drone’s Raspberry Pi over the internet
using a secure and reliable communication tunnel. This wireless link acts as the primary
lifeline for remote operations. When a validated delivery job is approved, the GCS transmits
the mission parameters through this tunnel directly to the drone, while simultaneously
receiving a continuous stream of real-time telemetry data back from the drone to keep the
operator fully informed.

3.2.2.c. Sensors to Raspberry Pi Connection

Multiple onboard sensors, including the GPS, IMU, and LiDAR, are physically wired to
the Raspberry Pi using standard hardware interfaces such as GPIO, I2C, or direct USB
connections. These sensors constantly feed environmental and spatial data into the com-
panion computer, allowing the autonomous software to perceive its surroundings with high
accuracy, and calculate its exact global position.

3.2.3 How They Work Together (Simple Flow)
The end-to-end operation of the Autonomous Drone Delivery System requires a highly
coordinated sequence of actions between the user, the Ground Control System (GCS), the
internet-based communication tunnel, and the onboard drone hardware. The following
steps outline the typical lifecycle of a successful delivery mission, demonstrating how these
individual components seamlessly collaborate to achieve the final goal:

User opens website and selects a delivery location.
User complete delivery details and submits.
The delivery job is saved in firebase realtime database.
Delivery job is instantly received by the GCS.
GCS processes the delivery job and assigns it to a drone if valid and approved by
operator.
System Design 75

GCS sends the delivery job details via communication channel to the drone.
Raspberry Pi reads the delivery job and makes decisions.
Pixhawk controls the motors and flies the drone.
Sensors send data to Raspberry Pi (e.g., location).
Drone delivers the package and returns home.
GCS shows live updates throughout the delivery job.
To further visualize these structural interactions, the Components and Connectors diagram
presented in Figure 3.2 maps out the specific interfaces between the four core layers of
the system. Starting at the user-facing React frontend, authentication and delivery requests
are passed directly to the Firebase backend infrastructure. Firebase acts as the central data
hub, using Firestore for persistent order storage, the Realtime Database to facilitate live
bi-directional updates, and serverless Cloud Functions to handle event-driven logic. The
Ground Control Station (GCS) then bridges this cloud environment with the physical drone
by pulling validated mission data and dispatching operational commands. Finally, at the
hardware layer, the drone’s onboard Raspberry Pi receives these high-level instructions from
the GCS and translates them into specific low-level navigation and stabilization commands
for the Pixhawk flight controller to execute.

Figure 3.2: Components and Connectors
System Design 76

3.3 Hardware Specifications
This section explains all the physical hardware components that were used to build the
Autonomous Drone Delivery System, which are completely listed in Table 3.1. Building
a reliable and safe delivery drone requires choosing the right physical parts that can work
together without any problems. Each individual component was very carefully selected to
match the strict requirements of this project. For example, the drone needs to have excellent
flight stability in the air, a good battery range to cover long distances, and enough power to
safely carry the weight of the delivery package. The hardware also needs to support smart,
automatic decision-making during the flight. The detailed table below shows the specific
name of each component, its exact model number, some of its most important technical
specifications, and a simple explanation of why it was chosen and used in this project.

Table 3.1: Drone Hardware Components
Sr. Component Model / Type Specification Purpose
1 Flight Con-
troller
Pixhawk 2.4.8 Supports GPS,
IMU, Barome-
ter, Accelerome-
ter
Controls the
drone’s flight
and keeps it
stable
2 Companion
Computer
Raspberry Pi 5 8GB RAM,
Quad-core CPU,
Linux OS
Runs the smart
AI software
and controls
autonomous
behavior
3 Motors Emax GTII
2212C 1400KV
Brushless,
High speed,
Lightweight
Generates lift
and movement
by spinning
propellers
4 Propellers 2-blade 1045
props
Lightweight,
Durable
Creates airflow
to lift the drone
5 Battery 4S 5200mAh
LiPo
Rechargeable,
14.8V, Long
flight time
Powers all the
components in
the drone
System Design 77

Sr. Component Model / Type Specification Purpose
6 ESC (Speed
Controller)
Readytosky 40A
ESCs
40A support,
Lightweight,
Reliable
Controls the
speed of each
motor individu-
ally
7 Frame F450 Frame Rigid, Strong,
Lightweight
Holds all parts
together and
supports the
drone structure
8 GPS Module Ublox M8N High-accuracy
GPS, Fast lock
time
Provides loca-
tion data for
navigation
9 IMU (Sensor) Built-in Pix-
hawk
Measures accel-
eration, rotation,
and altitude
Helps balance
and stabilize the
drone
3.3.1 Why Hardware Matters
The selection of the hardware components listed above was driven by the strict operational
requirements of the autonomous drone delivery system. Every component was carefully
evaluated and chosen to ensure the drone satisfies the following core objectives:

The drone must be lightweight but strong
It must fly smoothly and safely
It must collect real-time data
It must make decisions on its own
It must provide long battery time
It must carry weight easily
The combination of Pixhawk and Raspberry Pi gives us both flight stability and smart
decision-making.

System Design 78

3.4 Communication Protocols
In this section, how different parts of the system send and receive information is explained.
Just like humans need a common language to talk, the drone, Raspberry Pi, flight controller,
and ground control system also need communication protocols to understand each other.
The project uses different protocols at different layers of communication. These protocols
help make the system fast, reliable, and safe, even when the drone is flying far away.

3.4.1 Application Layer
At the highest level of software interaction, the MAVLink protocol is heavily utilized.
MAVLink (which stands for Micro Air Vehicle Link) is a very lightweight and highly effi-
cient messaging protocol designed specifically for communication between small unmanned
aircraft and their ground control stations [6]. In this project, it serves as the primary lan-
guage layer for communication between the Pixhawk flight controller and the Raspberry
Pi. This protocol guarantees that both the onboard computer and the flight controller per-
fectly understand the distinct format of commands, ensuring critical flight data is never
misinterpreted.

3.4.2 Transport Layer
The ongoing communication between the flying drone and the Ground Control Station
operates through a secure, TCP-based communication tunnel established over the internet.
The Raspberry Pi maintains this continuous connection using an external USB internet
dongle. The TCP protocol was specifically chosen because it creates a highly reliable and
connection-oriented digital pipeline between the two systems. This ensures that every piece
of mission data, live telemetry, and critical command is delivered accurately and in the
correct order, which is absolutely vital for maintaining safe autonomous operations over
long distances.

3.4.3 Network Layer
The network environment shifts depending on the stage of the project. During early devel-
opment, the Raspberry Pi 5 was simply connected to a local, private Wi-Fi network. This
local setup permitted direct access using its assigned local IPv4 address, which made it
incredibly easy to use SSH for uploading code and rapid testing. However, during actual
real-world delivery flights, the Raspberry Pi cannot rely on local Wi-Fi. Instead, it must
communicate dynamically with the Ground Control System over public cellular networks
by continuously routing data through the established cloud Communication Tunnel.

System Design 79

3.4.4 Data Link and Physical Layer
The bottom layers handle the actual physical and wireless connections that carry data
between devices. This includes the hardware parts like antennas, wireless adapters, and
cables, which decide how the digital information practically travels through the air. A
complete visual representation of these network connections across the system is shown in
the Network Diagram in Figure 3.3.

3.4.4.a. Internet:

The main connection between the flying drone and the Ground Control System (GCS) is
made using a standard cellular network. A USB internet dongle carrying a SIM card with
an active data package is connected directly to the Raspberry Pi. This gives the drone
wide-area internet access, ensuring it stays securely connected to the central system over
long distances, no matter where the delivery takes it.

3.4.4.b. Wi-Fi:

During the early development and testing phases, a mobile hotspot was used as the primary
connection method. Both the development laptop and the drone’s Raspberry Pi were
connected to this same local Wi-Fi network. This simple setup was highly advantageous
because the hotspot assigned a consistent IP address to the Raspberry Pi every time it
connected. This reliability allowed the team to easily establish a secure SSH connection,
making it incredibly convenient to wirelessly upload new code, monitor live system logs,
and execute commands in a safe test environment before eventually upgrading to the wider
cellular network.

Figure 3.3: Network Diagram
System Design 80

3.5 Data Flow Diagram / Flowchart
A Data Flow Diagram (DFD) shows how data moves through a system [19]. It highlights the
sources and destinations of data, the processes involved, and the storage points. This helps
in understanding how different parts of the system communicate with each other. DFDs are
useful for identifying how data is transformed from input to output and for ensuring that all
system requirements are being met.

In ADDS, the DFD explains how user input (such as delivery requests) flows from the
frontend to the backend, how it gets processed, and how it eventually triggers a delivery
mission. It includes external entities like the user and the administrator, data stores like
Firestore, Realtime Database, and Firebase Authentication, and processes like “Place Order”,
“Authenticate User”, “Trigger Mission”, and “Execute Mission”.

This DFD also clarifies the role of the Ground Control System (GCS), which acts as an
intermediary between the Firebase backend and the drone. It continuously listens for new
missions from the Realtime Database and assigns them to available drones.

The Raspberry Pi onboard the drone receives the mission, controls the Pixhawk for naviga-
tion, and updates the mission progress back to Firebase through the GCS.

By mapping out these continuous interactions, the Data Flow Diagram provides a crystal-
clear overview of exactly how information is routed and processed during every single
delivery. It highlights the importance of real-time communication within the architecture,
showing how a simple user click smoothly translates into robust database updates, automated
cloud function triggers, and eventually physical drone movements, all while keeping the
operator and user fully updated with live status reports.

The components in this DFD include:

External Entities: User, GCS, Firebase
Processes : Sign In/ Sign Up, Place Order, Trigger Cloud Function, Update Drone
Location on Map, Update Location, Listen to RTDB, Update Drone Location, Send
Misions to Drone.
Data Stores : Firebase Authentication, Firestore, Realtime Database
System : Raspberry Pi and Pixhawk (within the drone)
The data flow diagram for the system is shown in Figure 3.4, which clearly illustrates how
each component interacts during the lifecycle of a delivery mission.

System Design 81

Figure 3.4: Data Flow Diagram
3.6 Entity Relationship Diagram
The Entity Relationship Diagram (ERD) provides a conceptual view of how data is structured
within the system. Although this project uses a NoSQL database (Firestore), which does
not rely on strict table relationships like traditional relational databases, the collections and
subcollections can still be visually represented to better understand data organization.

The ERD created for this system illustrates the main collections such as users, orders,
delivery jobs, and drones, and how they relate to each other. Each collection is represented
as a rectangle, and arrows or connecting lines are used to indicate associations, such as a user
placing multiple orders, or a delivery job being assigned to a drone. These relationships help
visualize the structure of the stored data even in a document-based database like Firestore.

This diagram does not use relational keys (like foreign keys), but instead reflects references
through document IDs or nested fields within Firestore documents. The main purpose of

System Design 82

the diagram is to communicate how different data entities are logically related and how
information flows between them in the database.

By clearly mapping out these connections, the development team can easily see how infor-
mation like user details, drone statuses, and delivery routes are linked together. This makes
it much simpler to plan new features in the future, as developers already know exactly where
the data comes from and where it needs to go. Having this simple visual guide helps prevent
mistakes and keeps the entire database neat and organized as the system gradually grows to
handle more users and drones. The ERD is shown in Figure 3.5.

Figure 3.5: Entity Relationship Diagram
3.7 Database Schema
A database schema represents the logical structure of the data stored in a system. While this
project uses Google Firestore, which is a NoSQL document-based database, a relational-
style schema was created to help visualize the data organization and improve understanding,
especially for readers familiar with SQL-based databases.

This schema presents each Firestore collection as a table, where fields represent document
attributes. Primary keys are represented using the unique document IDs automatically
generated by Firestore or assigned manually. Where needed, foreign key-like references
are shown to indicate dependencies between collections, such as linking orders to users or
delivery jobs to drones. This approach provides a familiar structure while still accurately
describing the Firestore-based implementation.

Although Firestore does not enforce these relationships as traditional relational databases
do, this schema offers a clear and standardized view of how different parts of the system
relate logically. The visual representation of the schema is shown in Figure 3.6.

System Design 83

Figure 3.6: Database Schema
3.8 Chapter Summary
This chapter presented the detailed system design of the Autonomous Drone Delivery Sys-
tem. It covered the overall system architecture, explaining how the frontend, backend,
Ground Control Station, and drone subsystem interact with each other through Firebase,
WebSocket, and secure cloud tunnels. The communication protocols and data flow between
each component were described in detail. The chapter also presented the database design,
including the Entity Relationship Diagram and the database schema, which together define
how the system organises and manages its data using Google Firestore. The next chapter dis-
cusses the software development process, including coding standards, key implementation
details, and code snippets from each subsystem.

84
Chapter 4
4 Software Development
This chapter explains how the system was built in real code. In the last chapter (System
Design), it was explained how the system should work, what components are connected,
and how the data flows. Now in this chapter, it is explained how those designs were turned
into real software. This part of the report focuses on implementation. That means the
actual software development process, the programming, and the logic used in the system
are described.

The tools, languages, and technologies used are also mentioned. The project is not made
in a single file. Instead, it is modular, written in different parts using different tools. These
parts work together as one complete system. Some parts were developed using ROS2. This
was run in Gazebo and RViz simulators during development and in Raspberry Pi in the final
version. Other parts were developed in Python, ReactJS, and Firebase. All these were used
based on the job they needed to perform.

This chapter also discusses any problems faced during coding. Sometimes, errors occurred
due to missing packages, version issues, or complex software stacks (especially in ROS2).
These problems slowed down progress, but different methods and tools were tried to solve
them.

In the rest of this chapter:

The coding standards followed are explained
The development tools and environment are described
The main modules and logic are explained
And finally, some code snippets from important parts of the project are included
This chapter helps connect the design ideas with the actual working code.

4.1 Coding Standards
In the project, proper coding standards were followed to make the code clean, readable,
and easy to understand. These standards were informed by widely accepted style guides,

Software Development 85

including the official Python Enhancement Proposal PEP 8 [20]. These standards also
helped avoid confusion, debug faster, and maintain consistency across different parts of the
system.

Below are the main coding standards that were followed:

4.1.1 Naming Conventions
Different naming styles were used for different parts of the project based on what is com-
monly used for that language or framework:

camelCase : Used for most variable and function names in both Python and JavaScript
PascalCase : Used for naming React components (e.g., OrderModel.jsx,
MapView.jsx)
snakecase : Used in ROS2 for naming launch files and some utility files (e.g.,
dronesystem.launch.py)
4.1.2 Indentation
Code was kept properly indented to make the structure clear:

Python files (GCS backend, ROS2 nodes) : used 4 spaces for each indentation level
React code (JavaScript/JSX) : used 2 spaces
Indentation helped show which lines of code were inside functions, loops, or conditionals,
and made the code easier to read.

4.1.3 File and Folder Naming
Some files used camelCase naming (e.g., firebaseConfig.py, googleMaps.js). Most files
including ROS2-related files (like launch files or config files) used snakecase (e.g.,
dronesystem.launch.py) Folders were named clearly based on their function, for exam-
ple:

gcs: services, installer, etc
web: hooks, context, lib, etc
adds: launch, test, dronecontrol, etc
Software Development 86

4.1.4 Code Organization
Code is divided into separate folders and modules based on functionality:

Frontend code (React) : organized by components, pages, and services
Backend code (Firebase & GCS Python) : organized by listeners, handlers, and
utilities
ROS2 code : placed in separate ROS packages like nav2control, delivery
jobcommander, and dronecore
This structure made it easier to work on specific parts of the project without affecting other
parts.

4.1.5 Project Directory Structure
The project followed a monorepo directory structure, meaning all the code for different parts
of the system was kept in a single repository. This approach made it easier to collaborate,
track changes, and manage the entire project from one place. The repository was organized
into the following main folders, where each folder represented a separate and complete
project module:

adds : This directory contained the ROS2 architecture code that ran on the Raspberry
Pi. It served as the core software for the drone’s companion computer.
docs : This folder stored both user-written and AI-generated documentation files in
Markdown (.md) format.
gcs : This directory contained the Ground Control Station software, which was written
using the Flask framework.
latex : The detailed documentation and report for the project were written here using
LaTeX. This source code was used to generate the final PDF report.
web : The React Frontend code was located here. This provided the web interface for
users to interact with the system.
readme.md : The main documentation file at the root of the repository, providing an
overview of the project.
To keep the project well-documented and organized, a ‘docs‘ folder was included in the root
directory as well as in each subdirectory. These folders contained important information to
aid development and future reference:

Software Development 87

notes : This folder contained files and notes written by the developers during the
development process. It facilitated easy collaboration and provided a history of
design decisions.
ai : This folder stored AI-generated files that were used for quick reference and
assistance during coding.
General Documents : Some essential documentation files were placed directly inside
the ‘docs‘ folder for immediate access.
All documentation files were maintained in Markdown (.md) format. This structure ensured
that the code remained clean, well-documented, and cleanly organized across different
folders.

4.1.6 Commenting Style
Inline comments (# in Python, // in JavaScript) were used to explain important lines of code.
In many Python files, docstrings were used to describe what a function or module does,
using triple quotes (””” ””””). Comments were especially important in ROS2 nodes, where
the purpose of publishers, subscribers, and service calls had to be explained.

4.1.7 Code Formatting Tools
Automatic code formatting tools were used to keep the code neat:

Prettier (figure 4.1) was used for both Python and React code formatting.
React files were also formatted using React Formatter (VS Code Extension), which
automatically fixes indentation and structure.
These tools helped maintain consistency across the whole project.

Figure 4.1: Prettier VS Code extension
Software Development 88

4.2 Development Environment
This section explains all the tools, technologies, and platforms we used to build our project.
It also describes why we chose them, how they helped us, and where each one was used.
Our system involves many different parts, so we used a combination of tools for robotics,
frontend, backend, simulation, and deployment.

4.2.1 Operating System
Ubuntu 22.04 LTS (Long-Term Support) was used as the main operating system for software
development. Ubuntu is a Linux-based OS and is known for being stable, fast, and free.
The reason Ubuntu was chosen was because it is the recommended and supported operating
system for ROS2 Humble. ROS2 (Robot Operating System) is not fully supported in
Windows, and many ROS packages and tools run better on Linux. Ubuntu also comes
with a built-in terminal, Python pre-installed, and makes it easy to install robotics tools like
Gazebo, RViz, and colcon for building ROS2 packages, all using the terminal.

4.2.2 Code Editor / IDE
For writing code, Visual Studio Code (VS Code) was used. It is a lightweight and powerful
code editor that supports many programming languages and frameworks through extensions.
The following important extensions were installed in VS Code:

Python Extension: Helped write and run Python code with syntax highlighting, error
detection, and code suggestions.
ROS Extension: Helped manage ROS2 packages, launch files, and auto-complete
ROS messages and topics.
Prettier & React Formatter: These tools automatically cleaned and formatted the code
in both Python and JavaScript, making it easy to read and debug.
VS Code also allowed working with multiple folders at the same time, which was useful
because the project has a ROS2 workspace, and a React frontend.

4.2.3 Programming Languages Used
The project uses more than one programming language because it has different parts:

Python was used for:
Software Development 89

- Writing ROS2 nodes
- Writing backend scripts for the Ground Control System (GCS)
- Reading and processing delivery job data from Firebase
- Interacting with Pixhawk using MAVLink

JavaScript / JSX was used for:
- Creating the frontend of the project using ReactJS
- Building interactive forms and dashboards for the user
- Connecting the frontend to Firebase using Firebase SDK
Each language was used for a specific role and chosen because it is the best fit for that part
of the system.

4.2.4 Libraries and Frameworks
Several frameworks and libraries were used to help build the system faster and in a more
structured way. These tools also allowed avoiding writing everything from scratch.

Table 4.1: Libraries and Frameworks Used
Library / Framework Why We Used It
ROS2 Humble Main robotics framework for communi-
cation between software and drone hard-
ware
Firebase (Realtime DB) For storing and syncing delivery job data
between users and the Ground Control
System
Firestore NoSQL Database provided by Firebase
used for user profiles and other informa-
tion.
Firebase Authentication For allowing users to create accounts and
log in securely
ReactJS For building a modern and fast web-based
user interface
Flask The GCS was built using flask
Software Development 90

All of these tools are open-source or free to use and supported by large communities, which
was helpful in searching for documentation or tutorials.

4.2.5 Simulation Tools
To test the system before using real hardware, simulation tools were used that allowed
observation of how the drone behaves in a virtual environment.

4.2.5.a. Gazebo

A 3D simulation environment where the drone can be seen flying inside a virtual world
with buildings and obstacles. Gazebo is an open-source multi-robot simulator that has been
widely adopted in the robotics research community for testing and validation [21]. This
helped test navigation and movement.

4.2.5.b. ArduPilot SITL

Software In The Loop (SITL) is a powerful testing tool provided by ArduPilot. It allows
the exact same autopilot software that controls the real physical drone to run virtually on
a computer. This helped the team safely test complex flight logic, automatic takeoff, and
landing routines without risking any physical hardware.

4.2.5.c. MAVProxy

MAVProxy is a lightweight command-line tool used to manage communication networks
during testing. It effectively acts as a digital router, forwarding MAVLink messages back
and forth between the SITL simulation, the ROS2 nodes, and the Ground Control System.
This made it incredibly easy to connect all the separate software modules together during
the development phase.

4.2.5.d. Teleop (Keyboard Control)

Before automatic navigation worked, keyboard teleoperation was used to move the robot
manually using arrow keys. This helped test if basic movement was working.

These simulation tools helped test safely without crashing a real drone and saved time during
development.

Software Development 91

4.2.6 Hosting and Deployment
After writing and testing the software, it was necessary to host the frontend and make the
system available online for users.

Hostinger : The ReactJS frontend was hosted here. The user can:
- Visit the website
- Sign up or log in
- Submit a delivery request (delivery job)
Firebase : This platform was used for backend tasks, including:
- Authentication (user accounts and login)
- Realtime Database (storing delivery delivery jobs and system data)
- SDKs for React and Python to easily connect the frontend and backend
Firebase also allowed the system to listen to database changes in real time, so the Ground
Control System could immediately start a delivery job when a new delivery was added.

4.3 Software Description
This section explains in detail the software parts built for the drone delivery system. It
describes what each module does and shows how different technologies work together to
make the delivery process possible.

4.3.1 About the delivery job Flow
In this part of the report, the main software modules that make the system work are described.
But instead of listing all the modules first and then describing how the delivery job works, a
different approach is followed. Each module is explained in the exact order it is used during
a normal delivery job. This way, it becomes easier to clearly understand how one module
triggers the next, and how the complete delivery process flows step by step. Every module
will be explained in a separate section. In each section:

What the module does is described
Where it runs is explained (e.g., in the drone, in the Ground Control System, on
Firebase, or on the web server)
Software Development 92
How it fits into the delivery job flow is shown
Later, code snippets are added to show the important logic behind each module. By
following this structure, it becomes easier to understand not only what each module does,
but also how they are connected and how they work together to make the drone complete a
delivery delivery job from start to end.
4.3.2 React Frontend (User Interface)
This module runs in the web browser and is hosted on Hostinger. The React frontend is
the first step in the drone delivery system. It provides a simple and interactive interface for
users to sign up, log in, and place delivery orders, and it also includes a front landing page
with the information about the project. This module is responsible for collecting user input
and passing it to the backend for processing. The frontend was developed using ReactJS,
a modern JavaScript framework that helps build fast and responsive web applications [22].
React allows the webpage to be divided into small components like forms, maps, and tracking
sections, which makes the code more organized and easier to manage.
4.3.2.a. Firebase Authentication with Email Verification
When the user opens the website and selects the login option, the system displays a form to
either create an account or sign in. This is managed using Firebase Authentication, which
securely handles email/password login and also ensures the user’s email is verified before
allowing access to critical features. Cloud-based authentication services like Firebase
Authentication provide a scalable and secure mechanism for managing user identity in
RESTful API systems [23].
Code Snippet 1: Login Function
1 const login = async (email, password) => {
2 try {
3 const userCred = await signInWithEmailAndPassword(auth, email, password
↩→ );
4 const user = userCred.user;
5 if (!user.emailVerified) {
6 await signOut(auth);
7 await sendEmailVerification(user); // Send new verification email
8 setUser(null);
9 return { success: false, error: "email_not_verified" };
10 }
11 return { success: true, user };
12 } catch (error) {

Software Development 93
13 return { success: false, error: error.message };
14 }};

This logic verifies the user’s credentials using Firebase Auth. After successful login, it
checks if the user’s email is verified. If not, access is blocked, an error is shown and a new
email verification link is sent to users email.
4.3.2.b. Capturing Coordinates from Map Click
Once logged in, the system loads the user dashboard. From here, the user can begin the
order placement process. The user clicks on a location on the map, which captures the
latitude and longitude of the selected area. These coordinates are stored in the system for
that specific delivery.
Code Snippet 2: Handle Map Click Function
1
2 const handleMapClick = useCallback((location, noFlyZones) => {
3 const isInNoFlyZone = noFlyZones.some(zone => {
4 const R = 6371e3; // metres
5 const phi1 = location.lat * Math.PI / 180;
6 const phi2 = zone.lat * Math.PI / 180;
7 const deltaPhi = (zone.lat - location.lat) * Math.PI / 180;
8 const deltaLambda = (zone.lng - location.lng) * Math.PI / 180;
9 const a = Math.sin(deltaPhi / 2) * Math.sin(deltaPhi / 2) + Math.
↩→ cos(phi1) * Math.cos(phi2) * Math.sin(deltaLambda / 2) * Math.sin(
↩→ deltaLambda / 2);
10
11 const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
12 const d = R * c;
13 return d < zone.radius;
14 });
15
16 if (isInNoFlyZone) {
17 toast({
18 title: "No-Fly Zone Detected",
19 description: "This location is in a restricted area. Please select
↩→ another location.",
20 variant: "warning",
21 });
22 return;
23 }

Software Development 94
24
25 setSelectedLocation(location);
26 setIsModalOpen(true);
27 }, [toast]);

This code listens for user clicks on the map. When clicked, it extracts the coordinates and
stores them in the component’s state. These coordinates are used as the delivery destination.
This code uses the Haversine formula to calculate the distance 𝑑 (in meters) between the
user’s selected location and the center of a no-fly zone.
𝑅 is the radius of the Earth in meters.
𝜑 1 and 𝜑 2 represent the latitudes of the selected point and the zone center, converted
to radians.
Δ𝜑 and Δ𝜆 are the differences in latitude and longitude, also in radians.
The variable 𝑎 is an intermediate step that helps compute the central angle between
the two points.
𝑐 is the angular distance in radians.
Finally, 𝑑 = 𝑅× 𝑐 gives the actual surface distance between the two coordinates.
If this distance 𝑑 is less than the radius of the no-fly zone (e.g., 1500 meters), the location
is considered inside a restricted area, and the system displays a warning toast to the user.
4.3.2.c. Order Validation and subdelivery job
The user is then shown an order form, where the following information must be filled:
Receiver’s name
Type of package
Option to save location as “Home”, “Office” or other
Basic form validation is performed before submitting the data to the backend.
Code Snippet 3: Order Subdelivery job
1
2 try {
3 const ordersRef = collection(db, ’orders’);
Software Development 95
4
5 const newOrder = {
6 userId: user?.uid || ’anonymous’,
7 receiverName: orderData.receiverName,
8 packageType: orderData.packageType,
9 location: orderData.location,
10 locationName: orderData.customLocationName || orderData.savedAs ||
↩→ ’Unnamed’,
11 status: ’pending’,
12 createdAt: serverTimestamp(),
13 updatedAt: serverTimestamp(),
14 };
15
16 // 1. Add order to Firestore
17 const docRef = await addDoc(ordersRef, newOrder);
18 const orderId = docRef.id;
19 } catch (error) {
20 console.error(’Error placing order:’, error);
21 toast({
22 title: "Error",
23 description: "Failed to place the order. Please try again.",
24 variant: ’destructive’,
25 });
26 }

This snippet shows how the system writes order data to Firestore. It encloses the logic in
try catch block to handle errors gracefully.
4.3.2.d. Saving Location
If the user chose to save the location (like “Home” or “Office”), that information is stored
under the user’s document in Firestore.
Code Snippet 4: Saving Location
1
2 if (orderData.savedAs && orderData.customLocationName) {
3 const userRef = doc(db, ’users’, user?.uid);
4 const userSnap = await getDoc(userRef);
5 const userData = userSnap.data();
6
7 const newLocation = {
8 name: orderData.customLocationName,
Software Development 96
9 type: orderData.savedAs.toLowerCase(), // home | office | other
10 lat: orderData.location.lat,
11 lng: orderData.location.lng,
12 };
13
14 await updateDoc(userRef, {
15 savedLocations: [...(userData?.savedLocations || []), newLocation]
16 });
17 }

This snippet adds the selected location under the user’s saved locations array. It uses
Firestore’s arrayUnion to append without removing older entries.
4.3.2.e. Showing a toast notification
After the order is successfully submitted, the system shows a toast notification to confirm
the action.
Code Snippet 5: Toast Notification
1
2 toast({
3 title: "Order Placed Successfully!",
4 description: ‘Your ${orderData.packageType} delivery to
5 ${orderData.location.name || ’custom location’} is scheduled.‘,
6 variant: ’success’,
7 });
This code triggers a toast notification of type success when a user successfully places an
order. The toast() function is part of a reusable notification system implemented in the
frontend. It accepts different options, such as:
title: A short heading for the message
description: A longer explanation or detail
variant: Defines the type of message, e.g., ”success”, ”destructive”, ”info”, or ”warn-
ing”
In the context of the system, this toast provides immediate feedback that the user action was
successful. If something went wrong (e.g., invalid data or network failure), a ”destructive”
toast would instead be shown.
Software Development 97

4.3.2.f. Map Integration

One of the key features of the frontend is the use of a Maps API as shown in figure 4-2.
The Google Maps API has been widely used in IoT and web-based tracking applications to
provide interactive geolocation services [24]. This allows the user to:

Select the delivery location by clicking on the map
View the real-time drone location during the delivery job
The drone location is continuously updated by reading position data from the Realtime
Database.
Figure 4.2: Map integration
4.3.2.g. Role in delivery job Flow

This module starts the delivery job flow. Without this, no delivery can be requested. Once
the data is sent to Firebase, the next part of the system, Firebase backend processing, is
triggered.

4.3.3 Firebase Integration (Firestore + Realtime Database)
This part runs in the cloud, managed by Firebase. After the frontend collects the order
information from the user, the next step is to store and manage that data using Firebase
services. Firebase acts as the bridge between the frontend and the Ground Control System
(GCS). It also stores all important system data such as user accounts, orders, and drone
status. Firebase provides two different types of databases, and both are used in this project:

Software Development 98
4.3.3.a. Firestore (Database for Records)
Firestore is a cloud-based NoSQL database provided by Firebase as shown in figure 4.3. It
is used to store and manage structured data such as:
User details (name, email, UID)
All past and current orders
Drone details and settings
Figure 4.3: Firestore Database
Each user’s orders are saved with reference to their uid. This allows for easy order history,
admin review, and record-keeping. Firestore also supports complex queries and is ideal
for general data storage and reporting. To ensure only authorized users can read or write
specific data, Firestore security rules were implemented. These rules restrict access based
on user authentication status and email verification. For example, users can only read or
write their own data if they are logged in and their email is verified. This adds a critical
layer of security to the system.
Code Snippet 6: Firestore Rules
1
2 rules_version = ’2’;
3 service cloud.firestore {
4 match /databases/{database}/documents {
5

Software Development 99
6 // Allow each user to read/write their own document
7 match /users/{userId} {
8 // Allow creating your own document even if email is NOT verified
9 allow create: if request.auth != null &&
10 request.auth.uid == userId;
11
12 // Allow reading/updating only if email IS verified
13 allow read, update: if request.auth != null &&
14 request.auth.uid == userId &&
15 request.auth.token.email_verified == true;
16 }
17
18 // Allow read/write to orders if user is authenticated
19 match /orders/{orderId} {
20 allow read, write: if request.auth != null &&
21 request.auth.token.email_verified == true;
22 }
23
24 // Allow read/write to logs only for admins
25 match /logs/{logId} {
26 allow read, write: if request.auth != null &&
27 request.auth.token.admin == true &&
28 request.auth.token.email_verified == true;
29 }
30
31 // Default fallback rule: block everything else
32 match /{document=**} {
33 allow read, write: if false;
34 }
35 }
36 }

These Firestore rules ensure that users can only access their own profiles and order data if
they are logged in and their email is verified. Admin-only sections, like logs, are restricted
to users with a special admin token claim. This helps maintain privacy, integrity, and
role-based access control across the platform.
4.3.3.b. Realtime Database (delivery job Triggering)
While Firestore stores full records, Realtime Database (RTDB) is used for fast updates and
triggering actions. As soon as an order is verified by the frontend, a simplified version of it
Software Development 100
is added to a special path in the RTDB, for example, /jobs/pending, as shown in figure 4.4.
Figure 4.4: Realtime Database Interface
This RTDB path is monitored by a Python script running in the GCS. As soon as a new
delivery job appears here, the GCS reads the data, verifies it again, and begins delivery job
execution. The Realtime Database is ideal for this purpose because it supports real-time
listening, meaning it immediately notifies the GCS of any new entries without delay.
4.3.3.c. Cloud Functions
Firebase also allowed backend Cloud Functions to be written. These are small pieces
of server-side code that run automatically in response to events such as database writes,
updates, or user signups. Cloud Functions help perform backend logic without the need to
manage any servers.
In this system, Firebase Cloud Functions were added to handle important tasks like:
Listening for new orders in Firestore
Automatically creating a matching delivery job entry in the Realtime Database
This automation ensures that whenever a user places an order, the backend immediately
reacts by preparing the delivery job.
Code Snippet 7: Firebase Cloud Function
1
2 exports.createdelivery jobOnOrder = functions.firestore
3 .document(’orders/{orderId}’)

Software Development 101
4 .onCreate(async (snap, context) => {
5 const order = snap.data();
6 const delivery jobId = context.params.orderId;
7 const delivery job = {
8 orderId: delivery jobId,
9 userId: order.userId,
10 droneId: null,
11 deliveryCoords: order.location,
12 status: ’waiting’,
13 assignedAt: null,
14 completedAt: null,
15 message: ’Awaiting assignment’,
16 };
17
18 await admin.database()
19 .ref(‘delivery jobs/pending/${delivery jobId}‘).set(delivery job);
20 });

This function is automatically triggered whenever a new order is added to the orders col-
lection in Firestore. It reads the order details and uses them to create a new delivery job
in the jobs/pending path of the Realtime Database. The delivery job is given a status of
waiting and includes key details such as location, Order ID, and a message for the operator.
This allows the Ground Control System (GCS) to detect the new delivery job and begin
processing it without delay.
4.3.3.d. Role in delivery job Flow
Firebase plays a central role in the delivery job flow. It handles the storage, authentication,
and real-time communication between the frontend and the backend. After an entry is added
in the Realtime Database, the GCS becomes active, which we will explain next.
4.3.4 Ground Control System (GCS)
This module runs on the Ground Control System (GCS), usually a laptop, PC or dedicated
server connected to the drone. The GCS was built using Flask, a lightweight Python web
framework that provides flexible routing and extension support for building RESTful APIs
[25]. Once a new delivery job entry is added to the Realtime Database, the GCS becomes
active. It runs a Python script that is continuously listening to Firebase for new delivery
jobs. This script is the main controller that connects the database to the drone. The script
acts like a bridge between cloud and drone, it listens, verifies, and then forwards delivery
Software Development 102
job commands to the drone when ready.
4.3.4.a. Listening for New delivery jobs
The script is connected to Firebase using the Firebase Admin SDK in Python. It listens to a
special path e.g., /delivery jobs/pending, in the Realtime Database. Whenever a new entry
appears, the script automatically reads the following:
Delivery coordinates (latitude, longitude)
delivery job details
Code Snippet 8: Firebase Listener (Python)
1 def start_monitoring(self):
2 """Start listening for pending jobs in Realtime Database."""
3 self.pending_ref = self.rtdb.child(’jobs’).child(’pending’)
4 self.pending_ref.listen(self._on_job_change)
5
6 def _on_job_change(self, event):
7 """Callback triggered when new jobs appear."""
8 if not event.data:
9 return
10
11 # Extract job ID and job data
12 job_id = os.path.basename(event.path)
13 job_data = event.data
14
15 # Notify the GCS application to process the job
16 if self.on_new_job_callback:
17 self.on_new_job_callback(job_id, job_data)

This Python code uses the Firebase Admin SDK to connect to the Realtime Database. The
startmonitoring function sets up a listener on the jobs/pending path. Whenever a
new delivery job is added, the onjobchange callback is triggered automatically. This
function extracts the job ID and data, then notifies the main GCS application to begin the
approval and assignment process.
4.3.4.b. Validating the delivery job
Before assigning the delivery job to a drone, the GCS performs a few checks:
Are the coordinates valid? (within bounds, not empty)
Software Development 103
Is the location inside a No-Fly Zone? (a list of zones is loaded from local config)
Is a drone available and ready? (checked from a status table)
If the delivery job passes all checks, the script marks it as ”approved” and prepares it for
execution.
4.3.4.c. Assigning the delivery job to Drone
After approval, the GCS script sends the delivery job details to the Raspberry Pi on the
drone, which handles autonomous navigation. The communication happens via a secure
HTTP request, where the job data is serialized into JSON format.
Code Snippet 9: Sending Job to Drone
1 def send_job(self, job_data):
2 """Send job to drone via HTTP POST."""
3 if not self.connected:
4 return False
5
6 url = f"{self.api_url}/control"
7 payload = {
8 "command_type": "add_job",
9 "payload": job_data
10 }
11
12 try:
13 response = requests.post(url, json=payload, timeout=5)
14 return response.status_code == 200
15 except requests.exceptions.RequestException:
16 return False

It sends:
GPS coordinates of the delivery location
delivery job ID
This communication happened over Wi-Fi during development and via long-range telemetry
in real deployment.
4.3.4.d. Role in delivery job Flow
This is one of the most important modules in the system. It connects the cloud (Firebase) to
Software Development 104
the physical drone. Without this component, the drone cannot receive or start any delivery
job. Once the data reaches the Raspberry Pi, the next module, Drone Navigation Handler,
takes over.
4.3.5 ROS2 Architecture
This module runs on the drone’s Raspberry Pi. The Raspberry Pi runs the ROS2 architecture,
which is a system made of many small programs called nodes. ROS2 builds on the Data
Distribution Service (DDS) standard for its communication middleware, providing a reliable,
real-time publish-subscribe transport layer [26]. All these nodes stay inside one ROS2
package, and each node has its own job. ROS2 helps these nodes talk to each other by
publishing and subscribing to different topics. This makes the drone software modular and
easy to understand. If one node does something important, another node can listen to it and
act on it. This structure helps the drone work in an organized way without mixing up tasks.
Figure 4.5 illustrates the node architecture and their interconnections.
Figure 4.5: ROS2 node architecture on the Raspberry Pi.
4.3.5.a. gcsclientnode
The gcsclientnode is the part of the software that talks directly to the Ground Control
Station (GCS). It sends telemetry data from the drone, such as position, speed, and battery
level. It also receives new delivery jobs from the GCS. When the gcsclientnode gets a new
delivery job, it publishes the delivery job details on a ROS2 topic. This allows the other
nodes, especially the main node, to know that a new delivery job is ready. In simple words,
this node works like a messenger between the drone and the GCS.
Code Snippet 10: Processing GCS Commands (gcsclientnode)
1 def handle_add_job(self, payload):
2 """Handle incoming ’add_job’ JSON command."""
3 # 1. Parse JSON payload

Software Development 105
4 if ’waypoints’ in payload:
5 target_waypoints = self.parse_waypoints(payload[’waypoints’])
6 else:
7 return self.create_error("Invalid payload")
8
9 # 2. Call ROS2 Service
10 req = SubmitJob.Request()
11 req.job_id = str(uuid.uuid4())
12 req.waypoints = target_waypoints
13
14 future = self.submit_job_client.call_async(req)
15 return {"status": "request_sent", "job_id": req.job_id}

Description:
This function acts as the entry point for new missions. It receives the JSON payload from
the GCS over HTTP, parses the waypoints, and then forwards the request to the main node
using a ROS2 service call. This bridges the gap between the web-based GCS and the ROS2
system.
4.3.5.b. mainnode
The main node is responsible for controlling the whole delivery job. When it receives the
delivery job details, it prepares the drone for flight and then performs the takeoff. After
takeoff, it runs the path planning algorithm, which helps the drone avoid no-fly zones and
choose a safe route. The main node then flies the drone toward the target location. When
the drone reaches the destination, it lowers its altitude, lands to deliver the package, and then
takes off again. Finally, it brings the drone back to the launch position. This node handles
all major flight actions step by step.
Code Snippet 11: Job Verification Logic (mainnode)
1 def job_upload_callback(self, request, response):
2 """Handle new job upload request from GCS Client."""
3 self.get_logger().info(f"Received job: {request.job_id}")
4
5 try:
6 # Validate input
7 if not request.job_id:
8 raise ValueError("Missing job_id")
9
10 # Store mission data

Software Development 106
11 self.mission_plan = request.waypoints
12 self.current_job_id = request.job_id
13 self.state = "READY_TO_START"
14
15 response.success = True
16 response.message = f"Job {request.job_id} accepted"
17
18 except Exception as e:
19 response.success = False
20 response.message = str(e)
21 self.get_logger().error(f"Job upload failed: {e}")
22
23 return response

The main node receives the job request through this callback. It validates the job ID and
waypoints, updates the internal state to ’READYTOSTART’, and sends a success response
back to the GCS client node. This ensures that the drone only accepts valid delivery jobs.
4.3.5.c. Delivery State Machine
The most critical part of the main node is the delivery state machine. After the main node
accepts a valid delivery job, the execution of that job is managed entirely by a finite state
machine. The state machine defines every step the drone must go through, from arming
and takeoff to landing at the destination, waiting for the package to be collected, and then
returning home. Each step is represented by a state, and the drone transitions from one state
to the next as each action is completed successfully.
The states are defined using a Python Enum class called MissionState. The complete list
of states is shown in the code snippet below.
Code Snippet 12: Mission State Definitions (mainnode)
1 class MissionState(Enum):
2 """Mission execution states."""
3 IDLE = "IDLE"
4 ARM_OUTBOUND = "ARM_OUTBOUND"
5 TAKEOFF_OUTBOUND = "TAKEOFF_OUTBOUND"
6 UPLOAD_OUTBOUND = "UPLOAD_OUTBOUND"
7 EXECUTE_OUTBOUND = "EXECUTE_OUTBOUND"
8 LAND_DESTINATION = "LAND_DESTINATION"
9 DISARM_DESTINATION = "DISARM_DESTINATION"
10 WAIT_DESTINATION = "WAIT_DESTINATION"
11 ARM_RETURN = "ARM_RETURN"

Software Development 107
12 TAKEOFF_RETURN = "TAKEOFF_RETURN"
13 UPLOAD_RETURN = "UPLOAD_RETURN"
14 EXECUTE_RETURN = "EXECUTE_RETURN"
15 LAND_HOME = "LAND_HOME"
16 DISARM_HOME = "DISARM_HOME"
17 COMPLETE = "COMPLETE"
18 ABORT = "ABORT"

The state machine has 16 states in total. The delivery lifecycle is divided into two main
phases: the outbound phase and the return phase. During the outbound phase, the drone
arms its motors, takes off to the configured mission altitude, loads the destination waypoints,
flies to the delivery location, lands, disarms, and waits for a configurable period (default 120
seconds) so that the receiver can collect the package. During the return phase, the drone
re-arms, takes off again, constructs a return path by reversing the outbound waypoints and
appending the home position, flies back, lands at home, disarms, and marks the mission
as complete. If any critical failure or unexpected condition is detected at any point, the
state machine transitions to the ABORT state, which triggers a 30-second cooldown before
resetting to IDLE.
The state machine runs inside a timer callback that executes at a fixed interval. On every
cycle, it first performs global safety checks before calling the handler for the current state.
For example, if the flight controller triggers a Return-to-Launch (RTL) failsafe, or if the pilot
manually switches the drone to LOITER mode during an active mission, the state machine
immediately aborts the mission regardless of which state it is in. This ensures that the drone
always responds to external safety events.
Each state has a dedicated handler function. The handlers are responsible for perform-
ing the action associated with that state. For example, handlearmoutbound() calls
performarming() which checks GPS lock, sends the arming command to the flight con-
troller via MOVROS, and waits for confirmation before transitioning to the next state. Sim-
ilarly, handletakeoffoutbound() calls performtakeoff() which sends the takeoff
command and monitors the drone’s altitude until it reaches the target height. This modular
approach keeps each handler focused on a single task and makes the code easier to maintain
and debug.
The state transitions are managed by a transition() method that logs the state change,
resets the retry counter, records the entry time, and clears any transient flags. This method
is called by each handler when it determines that its task is complete. The code snippet
below shows how the state machine dispatcher routes control to the correct handler based
on the current state.
Code Snippet 13: State Machine Dispatcher (mainnode)
Software Development 108
1 def mission_state_machine(self):
2 """Execute state machine logic."""
3
4 # === Global Safety Checks ===
5 if self.mavros_state and self.current_state not in [
6 MissionState.IDLE, MissionState.COMPLETE, MissionState.ABORT
7 ]:
8 # RTL triggered by flight controller
9 if self.mavros_state.mode == ’RTL’:
10 self.abort_mission("RTL triggered by flight controller")
11 return
12 # Pilot switched to LOITER during active state
13 if self.mavros_state.mode == ’LOITER’
14 and self.current_state != MissionState.ARM_OUTBOUND:
15 self.abort_mission("Pilot switched to LOITER")
16 return
17
18 # === State Handlers ===
19 if self.current_state == MissionState.IDLE:
20 self.handle_idle()
21 elif self.current_state == MissionState.ARM_OUTBOUND:
22 self.handle_arm_outbound()
23 elif self.current_state == MissionState.TAKEOFF_OUTBOUND:
24 self.handle_takeoff_outbound()
25 elif self.current_state == MissionState.UPLOAD_OUTBOUND:
26 self.handle_upload_outbound()
27 elif self.current_state == MissionState.EXECUTE_OUTBOUND:
28 self.handle_execute_outbound()
29 elif self.current_state == MissionState.LAND_DESTINATION:
30 self.handle_land_destination()
31 elif self.current_state == MissionState.DISARM_DESTINATION:
32 self.handle_disarm_destination()
33 elif self.current_state == MissionState.WAIT_DESTINATION:
34 self.handle_wait_destination()
35 elif self.current_state == MissionState.ARM_RETURN:
36 self.handle_arm_return()
37 elif self.current_state == MissionState.TAKEOFF_RETURN:
38 self.handle_takeoff_return()
39 elif self.current_state == MissionState.UPLOAD_RETURN:
40 self.handle_upload_return()
41 elif self.current_state == MissionState.EXECUTE_RETURN:

Software Development 109
42 self.handle_execute_return()
43 elif self.current_state == MissionState.LAND_HOME:
44 self.handle_land_home()
45 elif self.current_state == MissionState.DISARM_HOME:
46 self.handle_disarm_home()
47 elif self.current_state == MissionState.COMPLETE:
48 self.handle_complete()
49 elif self.current_state == MissionState.ABORT:
50 self.handle_abort()

This method is the central dispatcher of the state machine. It is called periodically by a
ROS2 timer. Before processing the current state, the method checks for critical flight mode
changes such as RTL or LOITER that would indicate a safety issue. If no safety issue is
detected, it delegates control to the handler function that corresponds to the current mission
state. Each handler either performs an action (such as arming or commanding takeoff) or
monitors a condition (such as checking whether the drone has reached its target altitude).
When the action is completed, the handler calls transition() to move to the next state,
and the next timer cycle will execute the new handler.
4.3.5.d. movrosnode
MOVROS is a special node that we have custom developed as a replacement for MAVROS.
It works like a bridge between the main node and the Pixhawk. The main node talks to
MOVROS using ROS2 methods like topics, services, and actions. MOVROS then takes
these messages, converts them into the MAVLink protocol, and sends them to the Pixhawk.
In this process, the main node gives MOVROS the waypoints that the drone should follow,
and MOVROS makes sure the Pixhawk receives them correctly.
Code Snippet 14: MAVLink Command Translation (movrosnode)
1 def takeoff_callback(self, request, response):
2 """Handle ROS2 takeoff service request."""
3 if not self.mav: return
4
5 # Send MAVLink Takeoff Command to Pixhawk
6 def send_takeoff():
7 self.mav.mav.command_long_send(
8 self.mav.target_system, self.mav.target_component,
9 mavutil.mavlink.MAV_CMD_NAV_TAKEOFF,
10 0, 0, 0, 0, 0, 0, 0,
11 request.altitude
12 )

Software Development 110
13
14 # Wait for Acknowledgment from FCU
15 success = self._send_command_with_ack(
16 send_takeoff,
17 mavutil.mavlink.MAV_CMD_NAV_TAKEOFF
18 )
19
20 response.success = success
21 return response

This function translates a high-level ROS2 service call (Takeoff) into a low-level MAVLink
command understood by the flight controller (Pixhawk). It waits for an acknowledgment
from the flight controller to ensure the command was received successfully before reporting
success back to the ROS2 system.
4.3.5.e. Telemetry Pipeline
A critical aspect of the system is the real-time telemetry pipeline that carries live flight data
from the flight controller all the way to the operator’s browser. The pipeline spans five
stages, each operating at a deliberately chosen rate that balances freshness against resource
consumption. Figure 4.6 summarises the flow.
Figure 4.6: Telemetry pipeline from the flight controller to the operator’s browser.
Software Development 111
Stage 1 — FCU to movrosnode. The Pixhawk flight controller streams MAVLink
messages over the serial (or UDP) link. On start-up, movrosnode requests the
standard ArduPilot data streams (position, battery, attitude, extended status) at 4 Hz
via REQUESTDATASTREAM. A background thread continuously calls pymavlink’s
recvmatch() and dispatches each message to the appropriate handler. Handlers such
as handleglobalposition and handlesysstatus store the decoded values in in-
stance variables. A separate 10 Hz ROS2 timer (publishstate) then packages those val-
ues into standard ROS2 messages (NavSatFix, BatteryState, TwistStamped, Float64)
and publishes them on the same topic names that MAVROS uses, making movrosnode a
drop-in replacement.
Stage 2 — movrosnode to mainnode (ROS2 topics). mainnode subscribes to the same
MAVROS-compatible topics and stores every incoming message in instance variables via
lightweight callbacks (gpscallback, batterycallback, velocitycallback, etc.).
Because the subscriber callbacks fire at the publisher rate (10 Hz), the main node always
holds the most recent sensor reading without needing to poll.
Stage 3 — mainnode to SQLite database. A dedicated ROS2 timer fires
logtelemetry() at a configurable rate (default 1 Hz). This function assembles a dic-
tionary of the latest sensor values and writes a single row to the telemetrylogs table.
Code Snippet 15: Telemetry Database Write (mainnode)
1 def log_telemetry(self):
2 if self.gps_position:
3 data = {
4 ’latitude’: self.gps_position.latitude,
5 ’longitude’: self.gps_position.longitude,
6 ’altitude_msl’: self.gps_position.altitude,
7 ’battery_voltage’: self.battery_state.voltage
8 if self.battery_state else 0.0,
9 ’velocity_x’: self.velocity.twist.linear.x
10 if self.velocity else 0.0,
11 ’velocity_y’: self.velocity.twist.linear.y
12 if self.velocity else 0.0,
13 ’velocity_z’: self.velocity.twist.linear.z
14 if self.velocity else 0.0,
15 ’heading’: self.heading.data
16 if self.heading else 0.0,
17 ’satellite_count’: self.get_satellites(),
18 ’flight_mode’: self.mavros_state.mode
19 if self.mavros_state else "UNKNOWN",
20 ’mission_id’: (self.current_job[’job_id’])

Software Development 112
21 if self.current_job else None
22 }
23 self.db.log_telemetry(data)

The function is called once per second by a ROS2 timer. It collects the most recent sensor
values that were updated continuously at 10 Hz by the subscriber callbacks and writes them
as a single row into the SQLite database. This down-sampling from 10 Hz to 1 Hz is
intentional: it provides sufficient temporal resolution for the ground operator while keeping
the database size manageable.
Stage 4 — SQLite to gcsclientnode (database poll). gcsclientnode runs a 2 Hz
ROS2 timer that calls updatetelemetrystate(), which queries the most recent row
from telemetrylogs and stores it in the latesttelemetry dictionary. This database-
mediated handoff decouples the writer (mainnode) from the reader (gcsclientnode)
and allows both nodes to run at independent rates.
Code Snippet 16: Telemetry Database Read (gcsclientnode)
1 def update_telemetry_state(self):
2 """Fetch latest telemetry from DB."""
3 cursor = self.db.conn.cursor()
4 cursor.execute("""
5 SELECT * FROM telemetry_logs
6 ORDER BY timestamp DESC LIMIT 1
7 """)
8 row = cursor.fetchone()
9 if row:
10 self.latest_telemetry = {
11 ’gps’: {
12 ’lat’: row[’latitude’],
13 ’lon’: row[’longitude’],
14 ’alt’: row[’altitude_msl’]
15 },
16 ’battery’: row[’battery_voltage’],
17 ’velocity’: {
18 ’x’: row[’velocity_x’],
19 ’y’: row[’velocity_y’],
20 ’z’: row[’velocity_z’]
21 },
22 ’heading’: row[’heading’],
23 ’mode’: row[’flight_mode’],
24 ’armed’: self.mavros_state.armed
25 if self.mavros_state else False,

Software Development 113
26 ’satellite_count’: row[’satellite_count’],
27 }

This function is called at 2 Hz by the gcsclientnode. It reads the single most recent
telemetry row from the SQLite database and reshapes it into the JSON-friendly dictionary
that is later streamed to the GCS. The armed field is obtained directly from the MAVROS
state subscription rather than the database, because it changes instantaneously and must not
be delayed by the 1 Hz write cadence.
Stage 5 — gcsclientnode to GCS frontend (WebSocket). A FastAPI WebSocket end-
point streams the latesttelemetry dictionary to all connected GCS clients at 1 Hz. In
addition, event-driven messages such as FCU status texts are pushed instantly via the same
WebSocket channel.
Code Snippet 17: WebSocket Telemetry Stream (gcsclientnode)
1 @self.app.websocket("/telemetry")
2 async def telemetry_endpoint(websocket: WebSocket):
3 await websocket.accept()
4 self.connected_clients.append(websocket)
5 try:
6 while True:
7 if self.latest_telemetry:
8 t = self.latest_telemetry
9 data = {
10 ’gps’: t.get(’gps’),
11 ’battery’: t.get(’battery’),
12 ’velocity’: t.get(’velocity’),
13 ’heading’: t.get(’heading’),
14 ’mode’: t.get(’mode’, ’UNKNOWN’),
15 ’armed’: t.get(’armed’, False),
16 ’satellite_count’:
17 t.get(’satellite_count’, 0),
18 }
19 if self.latest_mission_state is not None:
20 data[’mission’] =
21 self.latest_mission_state
22 await websocket.send_json({
23 ’type’: ’mission’
24 if data.get(’mission’)
25 else ’telemetry’,
26 ’timestamp’: time.time(),
27 ’data’: data

Software Development 114
28 })
29 await asyncio.sleep(1.0)
30 except WebSocketDisconnect:
31 pass
32 finally:
33 self.connected_clients.remove(websocket)

This is the WebSocket endpoint hosted by the gcsclientnode FastAPI server. When
a GCS connects to /telemetry, the endpoint enters an infinite loop that sends the
latest telemetry snapshot every second. Each message is a typed JSON object: ei-
ther {"type":"telemetry",...} for standard telemetry, or {"type":"mission",...}
when an active mission is in progress. The GCS DroneControlService connects to this
WebSocket, receives each message, and forwards it via Flask-SocketIO to the browser. On
the browser side, app.js feeds the data into a JavaScript Proxy-based reactive state object
(drone). Any HTML element with a data-bind attribute is automatically updated, giving
the operator a live dashboard without manual DOM manipulation.
4.3.5.f. Rate decoupling rationale.
The rates at each stage are deliberately different. The FCU produces data at
4 Hz, movrosnode republishes at 10 Hz, mainnode writes to the database at 1 Hz,
gcsclientnode reads at 2 Hz, and the WebSocket streams at 1 Hz. This layered ap-
proach ensures that the high-frequency inner loop (flight control) is never blocked by the
comparatively slow outer loop (network I/O to the GCS). The SQLite database acts as the
decoupling boundary: it absorbs differences between the write rate and the read rate, and
it also provides a persistent telemetry log that survives node restarts and can be analysed
offline.
4.4 Chapter Summary
This chapter described the software development process for each component of the Au-
tonomous Drone Delivery System. It began by establishing the coding conventions and
standards followed across the project. The chapter then presented the development of the
React frontend, covering user authentication, order placement, and real-time tracking. The
Firebase backend configuration, including Firestore security rules and Cloud Functions, was
also discussed. The Ground Control Station development was covered in detail, including
how it monitors pending jobs from Firebase, communicates with the drone via WebSocket,
and provides manual control capabilities. Finally, the drone software development was pre-
sented, explaining the ROS2 node architecture, MAVLink integration, autonomous mission
Software Development 115

execution, the state machine that governs the delivery lifecycle, and the end-to-end telemetry
pipeline that carries live flight data from the Pixhawk to the operator’s browser. The next
chapter covers the software testing methodology and presents the detailed test cases used to
validate the system.

116
Chapter 5
5 Software Testing
Software testing is one of the most important stages in the software development process
[27]. It helps in checking how the system behaves, identifying any bugs, and making sure
everything works as expected. Testing is done by running the system in different situations
to find problems or missing features when compared to the original requirements. This
chapter explains the testing methods, the environment used for testing, and actual test cases
that were performed during the development of the drone delivery system.

5.1 Testing Methodology
Several testing techniques were used to ensure that each part of the system worked properly
and that the complete mission flow remained smooth and reliable. Since this project involved
multiple interconnected modules, React frontend, Firebase backend, and a Python-based
Ground Control System (GCS), a combination of testing methods was applied:

5.1.1 Unit Testing
Unit tests were carried out on individual logic blocks such as form validation in the React
frontend, toast notifications, and helper functions for map interaction. Each function was
tested in isolation using different inputs to confirm correct behavior. This level of testing
ensures that the smallest testable parts of the application perform as designed before they
are integrated with other components [28].

5.1.2 Component Testing
Each major component of the React application was tested separately. For example, the order
form component was tested to verify that it properly handled form input, error messages,
and submission when all required data was entered.

Software Testing 117

5.1.3 Integration Testing
Integration testing focused on ensuring that different parts of the system communicated and
worked together without issues. The most important integration tested was between the
frontend and Firebase, specifically the flow of order data being saved to Firestore and a
mission being triggered in the Realtime Database. Additionally, the GCS (Ground Control
System) integration with Firebase was tested by simulating new missions appearing in
the Realtime Database and observing how the GCS picked up those missions, processed
them, and moved them to the in-progress path. This confirmed that the backend and the
Python-based control system were correctly integrated.

5.1.4 System Testing
Complete end-to-end testing was done to simulate the full process from user login, order
placement, and mission creation to GCS detection and simulated mission execution. This
helped ensure that all modules worked as a single, connected system and fulfilled the
functional requirements. These testing techniques allowed for step-by-step validation of
both individual modules and the overall system workflow. Early detection of bugs during
unit testing reduced the chances of critical failures during later stages.

5.2 Testing Environment
The testing was performed in a local development environment with real-time connections
to Firebase services. The following tools and platforms were used during testing:

5.2.1 Web Browser (Opera)
All frontend components were tested using Opera Browser which is chromium based. The
developer tools were used to monitor network requests, console logs, and inspect React
component states. Modern browser automation frameworks such as Selenium, Cypress, and
Playwright can also be employed for systematic and repeatable web testing [29].

5.2.2 Firebase Console
Firebase was used to check Firestore and Realtime Database entries during and after order
placement. Firebase Authentication logs were also used to verify user registration and login
functionality.

Software Testing 118

5.2.3 VS Code (Visual Studio Code)
The code editor used for development and testing. It allowed debugging React code, Firebase
functions, and Python scripts easily.

5.2.4 Node.js Development Server
The React app was tested locally using the Vite development server, which helped in quickly
testing frontend changes.

5.2.5 Python Environment (GCS)
The Ground Control System script was run in a local Python environment using the Firebase
Admin SDK. It was used to test if the GCS could listen to Firebase Realtime Database updates
and respond properly by simulating drone behavior.

5.2.6 Map APIs
The map integration was tested using live map services to ensure accurate location capture
and updates.

This environment was chosen because it closely matched the actual deployment environment.
Real Firebase services were used instead of emulators to ensure that the results were realistic
and reflected the behavior of the system when deployed.

5.3 Test Cases
After setting up the full system architecture, test cases were designed to confirm that every
feature of the drone delivery system behaved as intended. The test case format used was
guided by the IEEE 829 standard for software and system test documentation [30]. These
test cases not only validated the accuracy of data storage and retrieval but also checked the
real-time interaction between various modules such as the React frontend, Firebase backend
(Firestore, Realtime Database, and Authentication), and the Python-based Ground Control
System (GCS).

5.3.1 User Signup with Valid Email
To ensure that new users are properly registered, this test checks if Firebase Authentication
creates a new user with a unique identifier (UID) upon valid signup. It verifies successful

Software Testing 119

communication between the frontend and Firebase Authentication, as shown in table 5.1.

Table 5.1: User Signup with Valid Email
Date: 12th June, 2025
System: React + Firebase Auth
Objective: Verify user is registered with
Firebase and a UID is generated.
Test ID: TC-01
Version: 1 Test Type: Unit Testing
Input:
Email: logicalhammad@gmail.com
Password: 123456789
Expected Result: Firebase creates a new user with a valid UID and stores it.
Actual Result: Passed. UID generated successfully.
5.3.2 Email Verification Blocking on Login
This test ensures that unverified email users are not allowed to access the system. Both the
frontend and Firebase rules are tested for proper blocking behavior, as shown in table 5.2.

Table 5.2: Email Verification Blocking on Login
Date: 12th June, 2025
System: React + Firebase Auth
Objective: Ensure unverified users are
blocked and login fails.
Test ID: TC-02
Version: 1 Test Type: Unit Testing
Input:
Email: logicalhammad@gmail.com (unverified email)
Password: 123456789
Expected Result: Access denied. Login fails and user is shown a relevant error.
Actual Result: Passed. Login blocked as expected.
Software Testing 120

5.3.3 Firebase Auth Email Verification Triggered
This test confirms that Firebase triggers an email verification message upon user registration.
It ensures the backend mechanism works without requiring manual setup, as shown in table
5.3.

Table 5.3: Firebase Auth Email Verification Triggered
Date: 12th June, 2025
System: Firebase Auth
Objective: Verify that Firebase sends
email verification.
Test ID: TC-03
Version: 1 Test Type: Unit Testing
Input:
Name: Zunaira Manzoor
Email: gleamyzuni@gmail.com
Password: test1234
Confirm Password: test1234
Expected Result: Firebase sends a verification email to the user.
Actual Result: Passed. Email verification received.
5.3.4 Saving User to Firestore on Signup
This test validates that a Firestore document is created under /users/uid with correct fields
after successful signup, ensuring proper backend recordkeeping, as shown in table 5.4.

Table 5.4: Saving User to Firestore on Signup
Date: 12th June, 2025
System: React + Firestore
Objective: Confirm user document is
created in Firestore with details
Test ID: TC-04
Version: 1 Test Type: Integration Testing
Software Testing 121

Input:
UID: auto-generated
Email: gleamyzuni@gmail.com
Name: Zunaira Manzoor
Expected Result: Document /users/{uid} created with fields: name, email, role =
”user”
Actual Result: Passed. Document created as expected.
5.3.5 Map Click Captures Coordinates
This test confirms that the frontend map component correctly captures latitude and longitude
when the user clicks a location, as shown in table 5.5.

Table 5.5: Map Click Captures Coordinates
Date: 12th June, 2025
System: React Map Component
Objective: Verify map click captures ac-
curate coordinates
Test ID: TC-05
Version: 1 Test Type: Unit Testing
Input:
User clicks on CUST on map
Expected Result: State updates with lat/lng of clicked location
Actual Result: latitude: 33.5468, longitude: 73.1840
5.3.6 No-Fly Zone Distance Check (Haversine Formula)
This test verifies whether the system correctly calculates the distance using the Haversine
formula and detects if the location is in a no-fly zone, as shown in table 5.6.

Table 5.6: No-Fly Zone Distance Check (Haversine Formula)
Date: 12th June, 2025
System: React Logic
Software Testing 122

Objective: Ensure math formula detects
no-fly zone within restricted radius
Test ID: TC-06
Version: 1 Test Type: Unit Testing
Input:
Location: { lat: 33.7300, lng: 73.0850 }
Red zone radius: 1500m
Expected Result: Warning shown. Location is inside restricted red zone.
Actual Result: Passed. No-fly zone warning triggered.
5.3.7 Toast Notification for No-Fly Zone
This test checks that a toast UI notification is displayed when a user selects a restricted
delivery location on the map, as shown in table 5.7.

Table 5.7: Toast Notification for No-Fly Zone
Date: 12th June, 2025
System: React UI
Objective: Confirm toast appears when
selecting no-fly zone
Test ID: TC-07
Version: 1 Test Type: Unit Testing
Input:
User selects { lat: 33.7300, lng: 73.0850 } inside no-fly zone
Expected Result: Toast with ”No-Fly Zone Detected” message is shown
Actual Result: Passed. Toast displayed correctly.
5.3.8 Order Submission: Valid Input
This test ensures that when valid order data is submitted, it is properly stored in Firestore
under /orders/orderId, as shown in table 5.8.

Table 5.8: Order Submission: Valid Input
Date: 12th June, 2025
Software Testing 123

System: React + Firebase Firestore
Objective: Confirm valid order is sub-
mitted and saved in Firestore
Test ID: TC-08
Version: 1 Test Type: Integration Testing
Input:
Receiver: Hammad Mustafa
Package: Clothing
Location: { lat: 33.5922, lng: 73.0179 }
Expected Result: Document added to /orders/{orderId} with correct structure
Actual Result: Passed. Order saved correctly.
5.3.9 Conditional Saving to Saved Locations
This test checks that saved locations (like Home or Office) are only saved in the user’s
savedLocations field if a name is selected, as shown in table 5.9.

Table 5.9: Conditional Saving to Saved Locations
Date: 12th June, 2025
System: React + Firestore
Objective: Confirm saved location is
stored only when a name is given
Test ID: TC-09
Version: 1 Test Type: Integration Testing
Input:
Location: { lat: 33.67, lng: 73.07 }
SavedAs: home
CustomName: My Home
Expected Result: Location saved in /users/{uid}/savedLocations
Actual Result: Passed. Entry added to saved locations.
Software Testing 124

5.3.10 Firestore Security: Only Authenticated Writes Allowed
This test verifies the Firestore rules for authentication. It confirms that unauthenticated
users are blocked from reading or writing to sensitive paths such as /orders, as shown in
table 5.10. Effective access control mechanisms are critical for NoSQL databases, where
fine-grained security policies must be explicitly defined to prevent unauthorised data access
[31].

Table 5.10: Firestore Security: Only Authenticated Writes Allowed
Date: 12th June, 2025
System: Firestore Rules
Objective: Ensure unauthenticated users
cannot read/write orders
Test ID: TC-10
Version: 1 Test Type: Unit Testing
Input:
Attempt write to /orders without login
Expected Result: Access denied. Firebase rules block the request.
Actual Result: Passed. Operation was denied.
5.3.11 RTDB Mission Path Auth Access
This test checks if the Realtime Database security rules correctly restrict unauthorized writes
to the /missions/pending path. It is essential for maintaining security of the backend, as
shown in table 5.11.

Table 5.11: RTDB Mission Path Auth Access
Date: 12th June, 2025
System: Realtime DB Rules
Objective: Validate that only authenti-
cated users/services can write missions
Test ID: TC-11
Version: 1 Test Type: Unit Testing
Input:
Attempt to push data to /jobs/pending anonymously
Software Testing 125

Expected Result: Firebase denies write access with permission error.
Actual Result: Passed. Permission denied as expected.
5.3.12 GCS Listens to /jobs/pending Path
This test confirms the functionality of the Ground Control System (GCS) Python script,
which listens for new entries under /missions/pending in the Realtime Database. It validates
real-time connectivity and readiness of the backend service, as shown in table 5.12.

Table 5.12: GCS Listens to /jobs/pending Path
Date: 12th June, 2025
System: Python GCS
Objective: Detect new mission entry in
RTDB through listener
Test ID: TC-12
Version: 1 Test Type: System Testing
Input:
Insert a mission at /jobs/pending/
Expected Result: Listener detects new mission and logs “New mission received”.
Actual Result: Passed. Mission was picked by the script.
5.3.13 GCS Assigns Available Drone
This test checks the logic inside the Python-based GCS system that selects an available
drone and assigns it to the mission. It ensures that drone assignment is only made if a drone
is idle and ready, as shown in table 5.13.

Table 5.13: GCS Assigns Available Drone
Date: 12th June, 2025
System: Python GCS Logic
Objective: Assign available drone to
mission
Test ID: TC-13
Version: 1 Test Type: System Testing
Software Testing 126

Input:
Available Drone ID: DRONE-01
New mission in /pending
Expected Result: Mission is updated with droneId: DRONE-01
Actual Result: Passed. Drone assigned and mission updated.
5.3.14 GCS Moves Mission to /jobs/inprogress
This test validates whether the GCS correctly moves a mission from /jobs/pending to
/missions/inprogress after assignment. It ensures smooth mission transition and avoids
duplication, as shown in table 5.14.

Table 5.14: GCS Moves Mission to /jobs/inprogress
Date: 12th June, 2025
System: Python GCS Logic
Objective: Confirm mission is moved to
/inprogress with proper metadata
Test ID: TC-14
Version: 1 Test Type: System Testing
Input:
Assigned mission from /jobs/pending
Expected Result: Moved to /jobs/inprogress/{id} with timestamp and droneId
Actual Result: Passed. Mission path moved and updated.
5.3.15 GCS Pauses Job If No Drone Is Available
This test ensures the system’s stability by verifying that the GCS pausses new jobs when all
drones are already busy. It checks that no crash or unwanted behavior occurs, as shown in
table 5.15.

Table 5.15: GCS Pauses Job If No Drone Is Available
Date: 12th June, 2025
System: Python GCS
Software Testing 127

Objective: Ensure job is paused grace-
fully when no drones are available
Test ID: TC-15
Version: 1 Test Type: System Testing
Input:
All drones status = ”busy”
New job added
Expected Result: Job remains in /jobs/pending, no action is taken
Actual Result: Passed. Job not assigned, system stable.
5.3.16 Drone Connection Heartbeat
This test verifies that the Ground Control System (GCS) can successfully establish a heart-
beat connection with the drone’s API. The service is expected to ping the root endpoint and
receive an ”online” status json before attempting any further communication, ensuring the
drone is reachable, as shown in table 5.16.

Table 5.16: Drone Connection Heartbeat
Date: 20th January, 2026
System: GCS Drone Service
Objective: Verify GCS establishes heart-
beat with Drone API
Test ID: TC-16
Version: 1 Test Type: Unit Testing
Input:
GCS Start, API URL: nldrone.space
Expected Result: Heartbeat received, System marks as Connected.
Actual Result: Passed. ”[DRONE SERVICE]✓ Heartbeat received”.
5.3.17 WebSocket Telemetry Stream
Upon successful heartbeat connection, this test confirms that the GCS initiates a WebSocket
connection for real-time telemetry. WebSocket provides full-duplex communication over
a single TCP connection, making it well suited for low-latency IoT telemetry streaming
compared to traditional polling approaches [32]. This ensures that the system receives live

Software Testing 128

data updates such as location, battery, and attitude without polling overhead, as shown in
table 5.17.

Table 5.17: WebSocket Telemetry Stream
Date: 20th January, 2026
System: GCS Drone Service
Objective: Confirm WebSocket connects
after heartbeat
Test ID: TC-17
Version: 1 Test Type: Integration Testing
Input:
Active Heartbeat Connection
Expected Result: WebSocket connection established, telemetry data received.
Actual Result: Passed. Telemetry stream active.
5.3.18 Job Assignment & Acceptance
This test validates the GCS ability to send a job payload (waypoints and order details) to
the drone via HTTP POST. It checks if the drone API correctly accepts the job and returns
a success message, confirming the mission upload capability. This ensures the drone is
fully ready to execute the delivery without manual setup, making the whole process much
smoother, as shown in table 5.18.

Table 5.18: Job Assignment & Acceptance
Date: 20th January, 2026
System: GCS Drone Service
Objective: Verify drone API accepts new
job assignment
Test ID: TC-18
Version: 1 Test Type: System Testing
Input:
Job Payload: { commandtype: ”addjob”, ... }
Expected Result: API responds with ”jobaccepted”.
Actual Result: Passed. Job successfully assigned.
Software Testing 129

5.3.19 Manual Control Command
This test ensures that manual commands, such as arming, taking off, or changing modes,
can be sent from the GCS to the drone. It verifies that the ’sendmanualcontrol’ function
correctly formats the request and receives a success response, as shown in table 5.19.

Table 5.19: Manual Control Command
Date: 20th January, 2026
System: GCS Drone Service
Objective: Test sending manual control
(e.g., ARM)
Test ID: TC-19
Version: 1 Test Type: Unit Testing
Input:
Command: ”ARM”, Params: {}
Expected Result: API returns success status for command.
Actual Result: Passed. Command executed successfully.
5.3.20 Firebase Job Monitoring
This test checks the Firebase Service’s ability to detect new jobs added to the Realtime
Database. It confirms that the listener callback is triggered immediately when a new entry
appears in the ’/jobs/pending/’ path, enabling real-time job processing. This guarantees that
customer orders are caught instantly so the drone can be deployed without delay, as shown
in table 5.20.

Table 5.20: Firebase Job Monitoring
Date: 20th January, 2026
System: GCS Firebase Service
Objective: Ensure new pending jobs trig-
ger callback
Test ID: TC-20
Version: 1 Test Type: Integration Testing
Input:
New JSON entry in /jobs/pending in RTDB
Software Testing 130

Expected Result: Listener triggers ’processjob’ and notifies GCS.
Actual Result: Passed. New job detected immediately.
5.3.21 Job Status Transition
This test verifies the transactional integrity of moving a job from ”pending” to ”inprogress”.
It ensures that the job is atomically removed from the pending queue and added to the active
jobs list with updated metadata (start time, drone ID) in the Realtime Database, as shown
in table 5.21.

Table 5.21: Job Status Transition
Date: 20th January, 2026
System: GCS Firebase Service
Objective: Move job from Pending to In
Progress
Test ID: TC-21
Version: 1 Test Type: Integration Testing
Input:
Job ID, Drone ID: ”DRONE-01”
Expected Result: Job moved to /jobs/inprogress, removed from pending.
Actual Result: Passed. RTDB and Firestore updated correctly.
5.3.22 Drone Status & Location Broadcast
This test confirms that the GCS correctly broadcasts the drone’s live status and GPS coordi-
nates to the Firebase Realtime Database. This data is critical for the frontend map to track
the drone’s movement in real-time, as shown in table 5.22.

Table 5.22: Drone Status & Location Broadcast
Date: 20th January, 2026
System: GCS Firebase Service
Objective: Update Drone Status and Lo-
cation in RTDB
Test ID: TC-22
Software Testing 131

Version: 1 Test Type: Unit Testing
Input:
Status: ”flying”, Coords: {lat: 33.6, lng: 73.0}
Expected Result: /dronesStatus/{id} updated with new location.
Actual Result: Passed. Live tracking updated in DB.
5.3.23 Complete Job Workflow
This test validates the final stage of a delivery mission. It checks that when a job is marked
as completed, it is moved to the history (completed) path in RTDB, and the corresponding
order in Firestore is updated to ”delivered”, ensuring data consistency across databases, as
shown in table 5.23.

Table 5.23: Complete Job Workflow
Date: 20th January, 2026
System: GCS Firebase Service
Objective: Finalize job and update order
status
Test ID: TC-23
Version: 1 Test Type: System Testing
Input:
Job ID for active job
Expected Result: Job moved to /jobs/completed, Order status: delivered.
Actual Result: Passed. Job completed and archived.
5.3.24 Movros FCU Connection & Heartbeat
This test verifies the low-level communication between the Companion Computer and the
Flight Controller (FCU) via MAVLink. The ’MovrosNode’ attempts to establish a serial or
UDP connection and waits for a heartbeat message. Successful reception of the heartbeat
indicates the FCU is online and ready for commands. This strong link is essential for safe
flights, as it prevents unexpected disconnections mid-air, as shown in table 5.24.

Software Testing 132

Table 5.24: Movros FCU Connection & Heartbeat
Date: 20th January, 2026
System: Movros Node (Companion)
Objective: Establish MAVLink connec-
tion with FCU
Test ID: TC-24
Version: 1 Test Type: Unit Testing
Input:
Connection string: serial:///dev/ttyACM0:57600
Expected Result: Heartbeat received from System 1, Component 1.
Actual Result: Passed. Connected to FCU (sys:1, comp:1).
5.3.25 Telemetry Propagation (FCU→ ROS)
This test validates the flow of telemetry data from the FCU to the ROS 2 ecosystem. It checks
if the ’MovrosNode’ correctly parses ’GLOBALPOSITIONINT’ MAVLink messages and
republishes them as ’sensormsgs/NavSatFix’ on the ’/mavros/globalposition/global’ topic,
making GPS data available to high-level nodes, as shown in table 5.25.

Table 5.25: Telemetry Propagation (FCU → ROS)
Date: 20th January, 2026
System: Movros Node
Objective: Verify GPS data publishing
to ROS topic
Test ID: TC-25
Version: 1 Test Type: Integration Testing
Input:
FCU sends GLOBALPOSITIONINT (lat=33.6, lon=73.0)
Expected Result: Topic /mavros/globalposition/global updates with correct coords.
Actual Result: Passed. ROS topic matches FCU data.
Software Testing 133

5.3.26 Service-based Arming (ROS→ FCU)
This test confirms that the drone can be armed via a ROS 2 service call. The ’MainN-
ode’ calls the ’/mavros/cmd/arming’ service, and ’MovrosNode’ translates this into a
’MAVCMDCOMPONENTARMDISARM’ command. The test passes if the FCU ac-
knowledges the command with ’MAVRESULTACCEPTED’, as shown in table 5.26.

Table 5.26: Service-based Arming (ROS → FCU)
Date: 20th January, 2026
System: ROS Service Layer
Objective: Arm drone using ROS service
call
Test ID: TC-26
Version: 1 Test Type: Integration Testing
Input:
Service Call: /mavros/cmd/arming (value=True)
Expected Result: FCU motors spin/arm, returns ACK.
Actual Result: Passed. Arming succeeded.
5.3.27 GCS Job Submission (HTTP→ ROS)
This test ensures that the ’GCSClientNode’ correctly handles job submissions from the
external GCS. It verifies that a JSON payload containing waypoints sent to the ’/control’
endpoint is parsed, validated, and forwarded to the ’MainNode’ via the ’job/upload’ ROS
service, as shown in table 5.27.

Table 5.27: GCS Job Submission (HTTP → ROS)
Date: 20th January, 2026
System: GCS Client Node
Objective: Receive job from GCS and
call ROS service
Test ID: TC-27
Version: 1 Test Type: System Testing
Input:
HTTP POST /control with ”addjob” and waypoints
Software Testing 134

Expected Result: Calls SubmitJob service, returns ”jobaccepted”.
Actual Result: Passed. Job forwarded to MainNode.
5.3.28 MainNode Job Validation
This test checks the ’MainNode”s logic for accepting or rejecting jobs. It verifies that the
node rejects a new job if the system is already ”BUSY” (e.g., in ’ARMOUTBOUND’ state)
and accepts it only when ’IDLE’. This prevents conflicting mission overrides during flight,
as shown in table 5.28.

Table 5.28: MainNode Job Validation
Date: 20th January, 2026
System: Main Node Logic
Objective: Reject job if system is BUSY Test ID: TC-28
Version: 1 Test Type: Unit Testing
Input:
State=EXECUTEOUTBOUND, New Job Request
Expected Result: Rejects job with ”System busy” message.
Actual Result: Passed. Concurrent job rejected.
5.3.29 Mission Waypoint Upload Protocol
This test validates the robust mission upload sequence managed by ’MovrosNode’. It
confirms that the node correctly executes the sequence: Clear Mission→ Send Count→
Handle Waypoint Requests. This handshake ensures reliable transfer of mission plans over
potentially lossy links, as shown in table 5.29.

Table 5.29: Mission Waypoint Upload Protocol
Date: 20th January, 2026
System: Movros Mission Handler
Objective: Upload 5 waypoints with
handshake
Test ID: TC-29
Software Testing 135

Version: 1 Test Type: Integration Testing
Input:
Service Call: /mavros/mission/push (5 items)
Expected Result: All 5 items requested by FCU and sent.
Actual Result: Passed. Mission upload complete.
5.3.30 Mission State Machine Transition
This test verifies the sequential logic of the ’MainNode’ state machine. It checks that
after a job is started, the system transitions automatically from ’ARMOUTBOUND’ to
’TAKEOFFOUTBOUND’ upon successful arming, and then to ’UPLOADOUTBOUND’
once the takeoff altitude is reached, as shown in table 5.30.

Table 5.30: Mission State Machine Transition
Date: 20th January, 2026
System: Main Node State Machine
Objective: Auto-transition Arm→ Take-
off→ Upload
Test ID: TC-30
Version: 1 Test Type: System Testing
Input:
Job Started, Arming Success
Expected Result: State changes to TAKEOFFOUTBOUND.
Actual Result: Passed. Correct state progression.
5.3.31 Waypoint Reached Event Handling
This test confirms that the system correctly tracks mission progress. It validates that when the
FCU sends a ’MISSIONITEMREACHED’ message, ’MovrosNode’ publishes it to ROS,
and ’MainNode’ updates its internal tracking to determine when the mission execution is
complete. This constant monitoring helps the system know exactly where the drone is at
any given time, providing peace of mind and better overall control, as shown in table 5.31.

Software Testing 136

Table 5.31: Waypoint Reached Event Handling
Date: 20th January, 2026
System: Mission Monitoring
Objective: Detect arrival at destination
waypoint
Test ID: TC-31
Version: 1 Test Type: Integration Testing
Input:
FCU message: MISSIONITEMREACHED (seq: 4)
Expected Result: MainNode logs ”Mission Execution Complete” (if last WP).
Actual Result: Passed. Destination arrival detected.
5.3.32 Manual Nudge Control
This test verifies the ”Nudge” functionality, which allows the operator to manually adjust
the drone’s position by small increments. It checks that a ”move forward” command results
in a velocity setpoint being sent to the drone for a calculated duration, effectively shifting
its position, as shown in table 5.32.

Table 5.32: Manual Nudge Control
Date: 20th January, 2026
System: Main Node Manual Control
Objective: Execute manual position
nudge
Test ID: TC-32
Version: 1 Test Type: Unit Testing
Input:
Command: move, direction: ”forward”, dist: 2m
Expected Result: Sends 2m/s velocity command for 1 second.
Actual Result: Passed. Velocity profile transmitted.
Software Testing 137

5.3.33 Crash Recovery & State Restoration
This test ensures system resilience by recovering the state after an unexpected shutdown.
It verifies that ’MainNode’ scans the database on startup for ”inprogress” missions and
safely resets them to ”pending” to prevent uncommanded resumption or inconsistent states,
as shown in table 5.33.

Table 5.33: Crash Recovery & State Restoration
Date: 20th January, 2026
System: Main Node Recovery
Objective: Recover from crash during
active mission
Test ID: TC-33
Version: 1 Test Type: System Testing
Input:
Restart Node with DB showing active mission
Expected Result: Mission reset to Pending, Home Position restored.
Actual Result: Passed. State consistency restored.
5.3.34 RTL Failsafe Detection & Mission Abort
This test validates the global safety mechanism within the mission state machine. During
any active mission state, if the flight controller autonomously triggered a Return-to-Launch
(RTL) mode due to a failsafe condition such as low battery or geofence breach, the system
was expected to detect this mode change and immediately abort the current mission. Safe
return-to-launch path mapping is a critical safety feature in autonomous drone operations,
ensuring that the vehicle can navigate back to its home position even when the primary
mission is interrupted [33]. This behaviour was critical for preventing the state machine
from continuing to issue commands that conflicted with the safety override imposed by
ArduPilot, as shown in table 5.34.

Table 5.34: RTL Failsafe Detection & Mission Abort
Date: 21st January, 2026
System: Main Node State Machine
Software Testing 138

Objective: Detect RTL failsafe and abort
mission
Test ID: TC-34
Version: 1 Test Type: System Testing
Input:
Mission active in EXECUTEOUTBOUND state, FCU triggers RTL due to low battery
Expected Result: State machine detects RTL mode and transitions to ABORT with a
30s cooldown.
Actual Result: Passed. Mission aborted immediately upon RTL detection.
5.3.35 GUIDED Mode Gate Before Arming
This test verifies the safety gate implemented in the arming handler for the outbound leg of a
mission. Before the system was allowed to arm the drone, the flight controller was required
to be in GUIDED mode. If the pilot had not yet switched to GUIDED, the state machine was
expected to pause and wait without sending arming commands. This mechanism ensured
that the operator maintained full control over when the autonomous mission actually began,
as shown in table 5.35.

Table 5.35: GUIDED Mode Gate Before Arming
Date: 21st January, 2026
System: Main Node Arming Logic
Objective: Verify arming is blocked until
GUIDED mode is active
Test ID: TC-35
Version: 1 Test Type: Unit Testing
Input:
Job started, state = ARMOUTBOUND, flight mode = STABILIZE
Expected Result: Arming is paused. Log message: “Waiting for GUIDED mode
before arming.”
Actual Result: Passed. Arming was held until the pilot switched to GUIDED.
Software Testing 139

5.3.36 Takeoff Failure Retry Logic
This test exposes a known defect in the takeoff recovery logic. When the initial takeoff
command failed and ArduPilot automatically disarmed the drone, the performtakeoff
function detected the disarmed state and fell back to the ARM state. The arming handler then
successfully re-armed the drone and transitioned back to the TAKEOFF state. However,
because the underlying cause of the takeoff failure was not resolved, the takeoff failed again,
triggering the same fallback. This created an infinite loop between the ARM and TAKEOFF
states with no retry limit or circuit breaker to halt the cycle. The expected behaviour was
for the system to succeed on the second takeoff attempt or, failing that, to abort the mission
after a limited number of retries, as shown in table 5.36.

Table 5.36: Takeoff Failure Retry Logic
Date: 21st January, 2026
System: Main Node State Machine
Objective: Verify recovery after takeoff
failure
Test ID: TC-36
Version: 1 Test Type: System Testing
Input:
State = TAKEOFFOUTBOUND, takeoff command sent, ArduPilot auto-disarms after
failure
Expected Result: Drone should takeoff on second attempt or abort after a retry limit.
Actual Result: Failed. The state machine entered an infinite cycle between
ARMOUTBOUND and TAKEOFFOUTBOUND. No retry counter or maximum at-
tempt limit was implemented in the fallback logic, causing the system to never halt or
abort.
5.3.37 Manual ARM Command ACK Timeout
This test documents a known issue in the manual control pipeline for the ARM com-
mand. When the GCS operator sent an ARM command through manual control, MainNode
forwarded the request to MovrosNode via the /mavros/cmd/arming ROS2 service.
MovrosNode successfully executed the command and the flight controller armed the drone.
However, MainNode was unable to receive the service response (ACK) within the 10-second
timeout window. As a result, the system reported “confirmation timed out” even though the
command had been executed successfully on the hardware. The expected behaviour was for

Software Testing 140

the ACK to propagate back through the ROS2 service call so that MainNode could confirm
execution and relay the result to the GCS, as shown in table 5.37.

Table 5.37: Manual ARM Command ACK Timeout
Date: 21st January, 2026
System: Main Node Manual Control
Objective: Confirm ARM command ex-
ecution via service ACK
Test ID: TC-37
Version: 1 Test Type: Integration Testing
Input:
GCS sends manual ARM command, MovrosNode executes it, drone arms successfully
Expected Result: MainNode receives ACK from MovrosNode and responds to GCS
with “ARM successful.”
Actual Result: Failed. The drone armed successfully at the hardware level, but
the ROS2 service future never completed within the 10-second timeout. MainNode
reported “ARM command sent but confirmation timed out” to the GCS. The command
executed correctly, but confirmation could not be delivered.
5.4 Chapter Summary
This chapter presented the software testing methodology and results for the Autonomous
Drone Delivery System. A total of 37 test cases were designed and executed across all major
subsystems, including the React frontend, Firebase backend, Ground Control Station, and the
drone software. The testing covered unit, integration, and system-level scenarios, validating
core functionality such as user authentication, order placement, real-time telemetry, mission
state progression, failsafe handling, and manual control. The majority of test cases passed
successfully, while two known defects were identified and documented: an infinite retry
loop in the takeoff failure recovery logic and an ACK timeout issue in the manual ARM
command pipeline. These findings provide a clear picture of the system’s current reliability
and highlight areas for future improvement. The next chapter describes how the complete
system was deployed, covering frontend hosting, GCS installation, and drone software
containerisation.

141
Chapter 6
6 Software Deployment
This chapter explains how the software of the Autonomous Drone Delivery System is
installed, set up, and made ready to run in the real world. Software deployment is a critical
phase of the software engineering lifecycle, transforming developed code into an operational
system [34]. The system is not just one program. It has multiple parts that work together,
and each part needs its own deployment process. This chapter explains how each part is
deployed, why it is deployed that way, and how all parts stay connected and work together
after deployment.

6.1 Deployment Overview
To make everything work smoothly, the system is broken down and deployed as three main
software components. Each part has its own specific role and requires a different setup
process to function correctly in the real world. These components are:

the React frontend
the Ground Control System (GCS)
the drone onboard system (ROS2 running on Raspberry Pi)
Each component runs in a different environment and has a different purpose, so they cannot
be deployed in the same way. This section gives a high-level view of how the system is
deployed and helps understand the detailed deployment steps of each component in the
following sections.

6.1.1 Deployment Architecture
The deployment architecture is designed to keep the system modular, flexible, and easy to
manage. This modular approach aligns with modern microservices deployment practices,
where independent components are containerised and deployed separately to improve scal-
ability and fault isolation [35]. The frontend is deployed as a web application so users can
access it from anywhere. The GCS is deployed as a local application so the operator can

Software Deployment 142

directly control and monitor the drone. The drone software is deployed inside a Docker
container on the Raspberry Pi so it runs automatically and reliably.

This architecture separates user interaction, system control, and drone execution into three
independent layers. This makes the system easier to update, debug, and scale. The next
sections will explain how each layer is deployed in detail.

6.1.2 Component Independence and Communication Flow
Each component in the system works independently, but they stay connected through secure
communication channels. The frontend communicates with the backend services and GCS
through Firebase and web APIs. The GCS communicates with the drone through a secure
cloud tunnel, following zero-trust networking principles that verify every connection request
regardless of network location [36]. The drone sends telemetry and status updates back to
the GCS and frontend in real time.

This design ensures that if one component is updated or restarted, the other components
can continue working without interruption. The following sections will explain how this
communication is maintained after deployment and how data flows between the deployed
components.

6.2 Frontend Deployment (React Web Application)
This subsection explains the complete process used to deploy the React-based front-end of
the system. It starts from generating a production build, then selecting a suitable hosting
provider, configuring a domain or subdomain, uploading the files to the server, and finally
verifying successful deployment. Each step is described in a clear and structured manner to
allow future developers to repeat or extend the deployment process.

6.2.1 Production Build Process
The React web application was first prepared for deployment by generating a production-
ready build. This process compiles all JavaScript files, optimizes assets, and bundles the
project into a format suitable for hosting. The command executed for this purpose was npm
run build. As shown in Figure 6.1, the build process completed successfully, generating
a dist folder containing all required files for deployment.

Software Deployment 143

Figure 6.1: Executing npm run build to generate production files.
The dist folder includes HTML, CSS, JavaScript, and other assets needed to run the
application in a browser. Figure 6.2 shows the contents of the generated dist folder.

Figure 6.2: Dist folder containing compiled and optimized React files.
Once the production files were ready, the next step was to select a suitable hosting provider
for public access.

6.2.2 Hosting Provider Selection
To make the React front-end accessible globally, a hosting service was required. Hosting
allows users to access the web application, register accounts, and place delivery orders. The
selection of a suitable cloud service provider for hosting web applications is an important
decision that impacts performance, availability, and cost [37]. Typically, hosting services
require paid plans to obtain adequate performance, uptime, and security. For this project,
Nelston Technologies provided free hosting from hostinger along with a subdomain, which
enabled deployment without additional cost.

Hostinger (figure 6.3) is one of the most reliable and widely used web hosting platforms. It
offers fast servers, strong uptime guarantees, user-friendly management tools, and affordable
plans for students, startups, and developers.

Software Deployment 144

Figure 6.3: Hostinger Logo.
For general reference, the hosting plans offered by Hostinger are shown in Figure 6.4. These
plans include Single, Premium, Business, and Cloud Startup. Premium is highlighted as the
most popular option due to its balance between cost and performance. Future developers
can select one of these plans if they choose to deploy the system independently.

Figure 6.4: Available Hostinger hosting plans for paid deployment.
Additionally, domains can be purchased through services such as Namecheap. Figure 6.5
shows a domain management dashboard, which provides options to search for new domains
and manage purchased domains.

Software Deployment 145

Figure 6.5: Namecheap dashboard
With the hosting provider selected and domain options understood, the next step involved
configuring the actual domain and subdomain settings required to make the application
accessible on the web.

6.2.3 Domain and Subdomain Configuration
A subdomain drone.nelston.com was created for hosting the React application. Fig-
ure 6.6 shows the subdomain creation interface, where a custom folder named drone was
specified to store the project files. This ensures organized file management and prevents
conflicts with other hosted projects.

Figure 6.6: Creating the subdomain drone.nelston.com with a custom folder
The hosting dashboard also provides access to the file manager (Figure 6.7), which is used

Software Deployment 146

for uploading and managing project files.

Figure 6.7: Hostinger dashboard showing the file manager button.
The hosting dashboard also provides a built-in file manager, which is used to upload and
manage the deployment files.

6.2.4 File Upload and Deployment
The deployment process involved uploading the production build files to the hosting server.
The dist folder was transferred to the drone folder inside the publichtml directory.
Figures 6.8 and 6.9 illustrate the directory structure and folder selection in the online file
manager.

Figure 6.8: File manager displaying the publichtml directory as the web root.
Software Deployment 147

This image (figure 6.9) shows the created drone folder where build files were uploaded.

Figure 6.9: Selected drone folder for uploading build files.
After uploading, the contents of the folder were verified to ensure successful transfer
(Figure 6.10).

Figure 6.10: Uploaded build files inside the drone folder on the hosting server.
Once the files were confirmed to be correctly uploaded, the next step was to verify that the
application was accessible and functioning as expected.

Software Deployment 148

6.2.5 Deployment Verification and Accessibility Testing
After completing the upload, the accessibility of the React front-end was verified by opening
the subdomain URL in a web browser. Figure 6.11 highlights the subdomain link, confirming
correct deployment. The dashboard of the hosted React application is shown in Figure 6.12.

Figure 6.11: React front-end opened with subdomain URL visible.
The React front-end dashboard hosted on drone.nelston.com is shown in Figure 6.12
below.

Figure 6.12: React front-end dashboard hosted on drone.nelston.com.
6.2.6 Why This Deployment Approach?
This deployment approach was chosen to achieve the following:

Ensure global accessibility of the application for users to register accounts and place
delivery orders.
Maintain a clear file structure using a dedicated subdomain and custom folder.
Software Deployment 149

Utilize free hosting provided by Nelston Technologies while also showing alternatives
for paid hosting and custom domains.
Enable future developers to replicate or expand deployment by following a structured
step-by-step process.
This method provides reliability, simplicity, and maintainability while keeping deployment
cost-effective. It also ensures that any updates to the application can be easily re-deployed
by uploading new production files to the server.

6.3 Ground Control Station (GCS) Deployment
The Ground Control Station (GCS) is a critical component of the system because it acts
as the control and monitoring interface between the user and the drone. Unlike the front-
end web application, which is deployed on a public hosting server, the GCS was designed
to run locally on the operator’s system. This deployment approach ensures low latency,
reliable control, and secure handling of telemetry and mission commands. The following
subsections describe, in a clear and structured way, how the GCS was packaged, installed,
launched, and managed on a Windows system.

6.3.1 Local Deployment Strategy
The GCS was deployed as a local desktop application rather than as a cloud-hosted service.
This decision was made because the GCS directly interacts with the drone through a secure
communication tunnel and must operate with minimal delay. Hosting it locally ensures
faster response times and greater reliability during mission execution.

In addition, local deployment allows the operator to:

Run the system without depending on external servers.
Maintain direct control over system updates and configurations.
Operate the GCS even in environments with limited or unstable internet connectivity,
as long as the secure tunnel is active.
To support this local deployment, the GCS was packaged as a professional Windows installer,
which simplifies installation, updates, and system setup. This packaging approach naturally
leads to the design of the installer itself, which is discussed next.

Software Deployment 150

6.3.2 Installer Design and Packaging
A custom installer creation system was developed using Python and Inno Setup to generate a
reusable and updatable Windows installer for the GCS. The installer creator script is shown
in Figure 6.13, where the script is opened in the gcs/installer directory and documented
clearly at the top of the file.

Figure 6.13: Create Installer Script Code
This script was designed to:

Package all required GCS files into a staging directory.
Generate an Inno Setup configuration file automatically.
Compile a professional Windows installer (.exe file).
Support versioning and clean updates when the installer is re-run.
When executed, the script produces a complete installer file, as shown in Figure 6.14. The
generated installer file is then visible in the output directory, as shown in Figure 6.15.

Software Deployment 151

Figure 6.14: Installer Script Run successfully and Installer Created
Figure 6.15: Installer Shown in Files
This packaging process ensures that the GCS can be distributed easily and installed consis-
tently on any compatible Windows system. Once the installer is generated, the next step is
the actual installation process, which is described below.

6.3.3 Installation Process
The installation process begins when the user runs the generated installer. At startup, the
installer prompts the user to choose whether to install the application for all users or only
for the current user. Selecting installation for all users requires administrator permission,
as shown in Figure 6.16. This ensures that the application can be installed in the system’s
Program Files directory.

Software Deployment 152

Figure 6.16: Installer Asking for Admin Permission
After permission is granted, the installer guides the user through a series of configuration
steps:

Selecting the installation directory, as shown in Figure 6.17. The default path is
C:\Program Files (x86)\Drone GCS.
Choosing whether to create a desktop icon, as shown in Figure 6.18.
Figure 6.17: Installer Asking for Install Location
Software Deployment 153

Figure 6.18: Installer Asking for Desktop Icon
Once all options are confirmed, the installer presents a summary of the selected settings, as
shown in Figure 6.19. After confirmation, the installation process begins, and progress is
displayed using a standard progress bar, as shown in Figure 6.20.

Figure 6.19: Installer Ready to Install
Software Deployment 154

Figure 6.20: Installer Installing
After successful installation, the final screen confirms completion and provides an option to
launch the GCS immediately, as shown in Figure 6.21.

Figure 6.21: Installation Complete
With the installation complete, the system is now ready for operation. The next subsection
explains how the GCS is launched and used after installation.

Software Deployment 155

6.3.4 GCS Launch and Operation
After installation, the GCS can be launched using the desktop shortcut, which is automati-
cally created if the corresponding option was selected during installation. The presence of
this shortcut on the desktop is shown in Figure 6.22.

Figure 6.22: Desktop Icon
When the shortcut is clicked, a launcher script is executed in the background. This script:

Verifies that the Python virtual environment exists.
Starts the Flask server silently using pythonw.exe, without opening a console win-
dow.
Automatically opens the default web browser and navigates to
http://localhost:5000.
This process ensures that the GCS behaves like a normal desktop application while internally
running a web-based control interface. Once launched, the operator can access all GCS
features through the browser interface without needing to manually start any server pro-
cesses. The following subsection explains how system files and dependencies are managed
to support this operation.

6.3.5 System Resource and Dependency Management
During installation, all GCS files are placed in the designated installation directory, as shown
in Figure 6.23. The folder structure ensures a clean separation between application code,
configuration files, and runtime dependencies.

Software Deployment 156

Figure 6.23: GCS Installed in GCS Folder
Opening this directory reveals all application files, including the main Flask application,
service modules, templates, static assets, and helper scripts, as shown in Figure 6.24.

Figure 6.24: GCS Files in Program Files Folder
The installer also creates a Python virtual environment within the installation directory.
This environment isolates the GCS dependencies from the system-wide Python installation,
ensuring:

Consistent package versions across installations.
Reduced risk of conflicts with other Python applications.
Clean updates by recreating the environment when a new version is installed.
Additionally, log files are generated during installation, launching, and operation. These logs
support troubleshooting and maintenance without requiring direct access to the application

Software Deployment 157

source code. With resource management established, the final subsection explains why this
deployment approach was selected.

6.3.6 Why This Deployment Approach?
This deployment approach was selected because it balances reliability, usability, and tech-
nical robustness. Packaging the GCS as a Windows installer:

Simplifies installation for non-technical users.
Ensures consistent system setup across different machines.
Supports clean updates without manual reconfiguration.
Enables secure installation in protected system directories.
Local deployment ensures low-latency communication with the drone and maintains oper-
ational independence from external servers. At the same time, the installer-based model
supports future scalability, such as version upgrades, feature extensions, and deployment to
additional operator systems.

With the GCS deployment complete, the next section focuses on the deployment of the drone-
side system, where ROS2 nodes and containerized services are prepared for autonomous
operation on the onboard computing platform.

6.4 Drone System Deployment (ROS2 via Docker)
This subsection describes how the drone-side system was deployed on the Raspberry Pi using
ROS2 and Docker. The goal of this deployment was to ensure that the onboard software
was portable, reliable, restartable, and easy to update without manual reconfiguration.

6.4.1 Code Transfer to Raspberry Pi
The project source code was transferred from the development machine to the Raspberry
Pi using an automated deployment script. This script used Secure Copy Protocol (scp) in
the background to transfer all required files. SCP operates over the SSH transport layer
protocol, providing encrypted and authenticated file transfer between hosts [38].

To ensure consistent network connectivity, both the Raspberry Pi and the development
laptop were connected to the same network, typically a mobile phone hotspot. Mobile
hotspots assign predictable IP addresses, and the Raspberry Pi consistently received the IP

Software Deployment 158

address 192.168.43.155. This predictability allowed the transfer scripts to run reliably
without requiring manual IP detection or reconfiguration.

The use of automated scripts reduced human error, ensured consistent deployment, and
allowed rapid updates whenever code changes were made.

6.4.2 Environment Setup on Drone
Before running the system, the Raspberry Pi environment was prepared to support con-
tainerized ROS2 applications. Docker and Docker Compose were installed and configured
on the Raspberry Pi to enable container-based deployment.

In addition, a critical environment variable named PIXHAWKUSB was defined in the .bashrc
file of the Raspberry Pi. This variable stored the device path of the Pixhawk flight controller,
such as /dev/serial/by-id/.... Defining this variable allowed the system to adapt
automatically to different drones, each of which may expose the Pixhawk device under a
different path.

By using environment variables instead of hardcoded device paths, the system remained
portable and reusable across multiple drone platforms without modifying the application
code.

6.4.3 Docker Image Build Process
After transferring the code, a second built-in script was executed on the Raspberry Pi
to build the Docker image locally. Docker provides operating-system-level virtualisation
through lightweight Linux containers, enabling consistent development and deployment
environments across different platforms [39]. The image was built directly on the Raspberry
Pi to match the drone’s ARM architecture and ensure binary compatibility.

The Docker image was based on the ROS2 Humble base image for ARM64, which al-
ready included ROS2 and its core dependencies. Additional dependencies such as Python
packages, MAVLink libraries, web framework components, and system tools were installed
during the build process.

The project source code was copied into a ROS2 workspace inside the image, and the
workspace was built using colcon. This ensured that all ROS2 nodes, interfaces, and
dependencies were compiled and ready for execution within the container environment.

Software Deployment 159

6.4.4 Container Deployment Using Docker Compose
Once the Docker image was built, the system was deployed using Docker Compose.
Docker Compose is a widely adopted orchestration tool that enables multi-container ap-
plication deployment through declarative YAML configuration files [40]. A dedicated
docker-compose.yml file was used to define the container configuration, device map-
pings, environment variables, volumes, and network settings.

The Pixhawk device from the host system was mapped into the container using the
PIXHAWKUSB environment variable, with a fallback to /dev/ttyACM0 if the variable was
not defined. This allowed flexible device mapping without modifying the container config-
uration.

Persistent storage directories were mounted into the container to retain logs and database
files across restarts. Required ports were exposed to allow communication with the Ground
Control Station and remote services.

Using Docker Compose simplified deployment by allowing the entire system to be launched
with a single command while maintaining a clear, declarative configuration.

6.4.5 Auto-Start, Restart Policies, and Fault Recovery
The Docker Compose configuration included a restart policy set to unless-stopped. This
ensured that the container automatically restarted if it crashed, encountered an error, or if
the Raspberry Pi rebooted.

As a result, the system became fault-tolerant and self-recovering. No manual intervention
was required to restore operation after power loss, software failure, or unexpected shutdowns.

This auto-start and auto-recovery mechanism ensured continuous operation, which is critical
for autonomous drone systems deployed in real-world environments.

6.4.6 Why This Deployment Approach?
This deployment approach was selected for the following reasons:

It ensured consistent behavior across different hardware platforms.
It reduced setup complexity by encapsulating all dependencies inside containers.
It enabled fast redeployment and updates using automated scripts.
It provided fault tolerance through automatic restart policies.
It supported portability by using environment variables instead of hardcoded paths.
Software Deployment 160

Overall, the approach improved reliability, scalability, maintainability, and operational sta-
bility of the drone system.

6.5 Security and Configuration Management
This subsection describes how sensitive data, configuration values, and system settings were
managed securely and flexibly throughout the deployment.

6.5.1 Credential Management and API Keys
Sensitive credentials such as tunnel tokens, API keys, and access tokens were not hardcoded
into the application source code. Instead, these values were injected at runtime using
environment variables. Research has shown that the use of environment variables is one
of the most widely recommended practices for managing secrets in software artifacts, as it
prevents accidental exposure in version control systems [41].

This approach prevented accidental exposure of secrets in version control systems and
reduced the risk of credential leakage. It also allowed credentials to be changed without
rebuilding the application or modifying source files.

Where required, credentials were stored securely on the Raspberry Pi and loaded automati-
cally during system startup.

6.5.2 Environment Variables and Configuration Files
System configuration values such as device paths, tunnel tokens, and ROS domain identifiers
were managed using environment variables and configuration files.

This design enabled:

Separation of code and configuration.
Easy adaptation to new hardware platforms.
Reuse of the same software image across different drones.
Simplified debugging and testing in multiple environments.
Using environment-based configuration ensured that deployment remained flexible,
portable, and maintainable over time.

Software Deployment 161

6.6 Deployment Verification and Validation
This subsection describes how the deployment was tested to confirm correct operation,
system stability, and readiness for real-world use.

6.6.1 End-to-End System Testing
After deployment, end-to-end testing was performed to verify that all system components
operated correctly together. The following aspects were validated:

Successful startup of the Docker container on boot.
Correct detection and communication with the Pixhawk flight controller.
Proper launch of ROS2 nodes and services.
Reliable operation of the web APIs and WebSocket interfaces.
Stable communication between the drone system and the Ground Control Station.
These tests confirmed that the system functioned as designed under real operating conditions.

6.6.2 Operational Readiness Checklist
Before final deployment, an operational readiness checklist was followed:

All required environment variables were defined correctly.
Docker and Docker Compose were installed and functioning.
The Docker image was successfully built on the Raspberry Pi.
The container launched automatically on boot.
The Pixhawk device was correctly detected and mapped.
Communication with external systems was verified.
Completion of this checklist confirmed that the system was fully deployed, stable, and ready
for operational use.

Software Deployment 162

6.7 Chapter Summary
This chapter described the deployment process for each component of the Autonomous
Drone Delivery System. The React frontend was built and hosted on a cloud web server,
making the application accessible to users globally. The Ground Control Station was
packaged as a Windows installer with automated dependency management and desktop
shortcut integration. The drone software was containerised using Docker and deployed
on the Raspberry Pi using Docker Compose, with automated startup on boot and secure
environment-based configuration. Secure communication between the GCS and the drone
was established through an encrypted cloud tunnel. Finally, end-to-end system testing and
an operational readiness checklist confirmed that all components were fully deployed and
functioning correctly. The next chapter presents the overall conclusions of the project,
discusses limitations, and proposes directions for future work.

163
Chapter 7
7 Conclusion & Future Work
This chapter concludes the project by summarising the work that was done across all stages
of the Autonomous Drone Delivery System. It reviews the objectives that were set at
the beginning of the project and checks whether each one was achieved. The chapter also
discusses the limitations that were found during development and testing, and suggests ideas
for future improvements that can make the system better and more capable.

7.1 Project Summary
The Autonomous Drone Delivery System (ADDS) was designed and developed as a com-
plete solution for automated package delivery using a quadcopter drone. The project covered
all stages of the software and hardware development lifecycle, from initial research and de-
sign to final deployment and testing.

The system was divided into four main components. The first component was the React-
based web frontend, which allowed users to register accounts, place delivery orders, select
delivery locations on a map, and track the drone in real time. The second component was
the Firebase cloud backend, which handled user authentication, stored order and delivery
data in Firestore, and used the Realtime Database to trigger delivery jobs for the Ground
Control Station. The third component was the Ground Control Station (GCS), which was
built using Flask and provided the drone operator with live telemetry, manual drone control,
job approval, and mission monitoring through a web-based interface. The fourth component
was the drone software, which ran on a Raspberry Pi 5 inside a Docker container and used
ROS2 and MAVLink to communicate with the Pixhawk flight controller for autonomous
mission execution.

The system design was presented in Chapter 3 through architecture diagrams, communica-
tion flow descriptions, and database schemas. Chapter 4 covered the software development
of each component in detail, including code snippets and explanations. Chapter 5 docu-
mented the testing process, where 37 test cases were designed and executed to validate the
system across all subsystems. Chapter 6 explained how each component was deployed,
including frontend hosting, the GCS Windows installer, and Docker-based deployment on
the Raspberry Pi.

The project successfully demonstrated that a low-cost, autonomous drone delivery system

Conclusion & Future Work 164

could be built using open-source tools and affordable hardware. The drone was able to
receive a delivery job from the web interface, take off autonomously, fly to the destination,
land, and return to its home position without any manual control during the flight.

7.2 Objectives Achieved
The objectives defined in Chapter 1 are revisited below, along with the evidence of their
achievement throughout the project.

OB-1. To design and build a quadcopter drone capable of autonomous flight using
ArduPilot and a Pixhawk flight controller.
This objective was achieved. The drone was assembled using an F450 frame,
1400KV brushless motors, 40A ESCs, a 4S 5200mAh LiPo battery, and a Pix-
hawk 2.4.8 flight controller running ArduPilot firmware. The drone was cal-
ibrated, tuned, and tested for stable autonomous flight in GUIDED mode, as
described in Chapter 1.
OB-2. To develop a companion computer system using Raspberry Pi 5 and ROS2
that can control the drone, execute delivery missions, and communicate with
the ground station.
This objective was achieved. A Raspberry Pi 5 was mounted on the drone and
ran the custom drone software built on ROS2 Humble. The system included two
main nodes: MainNode, which managed the delivery state machine and mission
logic, and MovrosNode, which handled all MAVLink communication with the
Pixhawk flight controller. These nodes were described in detail in Chapter 4.
OB-3. To create a web-based frontend using ReactJS and Firebase that allows users
to register, place delivery orders, and track deliveries in real time.
This objective was achieved. A React web application was built and deployed,
providing user registration with email verification, an order placement interface
with map-based location selection, and real-time drone tracking on an interac-
tive map. The frontend was validated through test cases TC-01 to TC-12, as
documented in Chapter 5.
OB-4. To develop a Ground Control Station (GCS) that enables operators to mon-
itor drone telemetry, approve delivery jobs, and manually control the drone
when needed.
This objective was achieved. The GCS was built as a Flask web application with
a dashboard showing live telemetry data, a pending jobs queue for job approval, a
manual control interface for sending direct commands to the drone, and a history
Conclusion & Future Work 165

tab for reviewing completed missions. The GCS was tested through test cases
TC-13 to TC-22, as documented in Chapter 5.
OB-5. To implement a secure communication architecture between all system com-
ponents using Firebase, WebSocket, and encrypted cloud tunnels.
This objective was achieved. The frontend communicated with Firebase for
data storage and authentication. The GCS communicated with the drone system
through WebSocket over a Cloudflare encrypted tunnel, which followed zero-
trust networking principles. This architecture was described in Chapter 3 and
validated during deployment in Chapter 6.
OB-6. To containerise the drone software using Docker for consistent and reliable
deployment on the Raspberry Pi.
This objective was achieved. The drone software was packaged into a Docker
image and deployed using Docker Compose on the Raspberry Pi. The container
was configured to start automatically on boot and included all required depen-
dencies, environment variables, and device mappings. The deployment process
was described in Chapter 6.
OB-7. To test the complete system through structured test cases covering unit,
integration, and system-level scenarios.
This objective was achieved. A total of 37 test cases were designed and executed
across four subsystems: the React frontend, the Firebase backend, the Ground
Control Station, and the drone software. The test results showed that the majority
of test cases passed. Two known defects were identified and documented (TC-36
and TC-37), as presented in Chapter 5.
OB-8. To deploy the full system and verify its operational readiness through end-
to-end testing.
This objective was achieved. All system components were deployed to their
target environments. The frontend was hosted on a cloud web server, the GCS
was packaged as a Windows installer, and the drone software was deployed inside
a Docker container on the Raspberry Pi. End-to-end testing and an operational
readiness checklist confirmed that the system was fully functional, as described
in Chapter 6.
All eight project objectives were successfully achieved. The system was designed, devel-
oped, tested, and deployed as a working autonomous drone delivery platform.

Conclusion & Future Work 166

7.3 Limitations
Although the system met all of its defined objectives, several limitations were identified
during the development and testing phases. These limitations are discussed below.

7.3.1 Landing Mechanism
The current system requires the drone to land at the delivery destination to drop off the
package. This means the drone must find a safe and flat area at the destination, which
may not always be available. In urban areas, landing on the ground can be risky due to
obstacles, people, or uneven surfaces. A hovering mechanism that lowers the package using
a zipline or winch system would be more practical, but this was not implemented in the
current version of the project.

7.3.2 Obstacle Awareness
The drone does not have any sensors for detecting obstacles in its path. During flight, it
follows GPS waypoints and trusts that the path is clear. If there is a building, tree, or
any other obstacle along the route, the drone has no way to detect or avoid it. This limits
the system to operating only in open areas where the flight path is known to be free of
obstructions.

7.3.3 Altitude Measurement for Landing
The drone relies on the barometer and GPS for altitude estimation. These sensors provide a
general idea of height, but they are not accurate enough for precise landing operations. The
barometer can be affected by weather changes, and GPS altitude can have errors of several
metres. Without a dedicated downward-facing sensor, such as a point LiDAR or ultrasonic
rangefinder, the drone cannot measure its exact height above the ground during the final
approach and landing phase.

7.3.4 GCS Architecture
The Ground Control Station was developed as a standalone Flask application that runs
locally on the operator’s Windows machine. While this approach worked for the current
single-operator setup, it is an architectural limitation. Since the drone is accessed through
a web domain linked via a Cloudflare tunnel, the GCS functionality could be integrated
directly into the React frontend with Role-Based Access Control (RBAC). This would allow
operators to access the GCS from any device without installing a separate application.

Conclusion & Future Work 167

7.3.5 Map-Based Location Selection
The current map interface in the React frontend uses a standard map view for selecting
delivery locations. Users place a marker on the map to choose where the drone should
deliver the package. However, in practice, it is difficult to select an exact location using a
flat map view because the user cannot see buildings, houses, or ground features clearly. A
satellite or 3D view, such as Google Earth, would make it much easier for users to identify
specific houses or landing spots.

7.3.6 Single Drone Operation
The system was designed and tested for operation with a single drone only. The database
architecture, GCS interface, and mission state machine all assume that only one drone is
active at a time. Supporting multiple drones simultaneously would require changes to the
database schema, a more advanced job scheduling system, and a fleet management interface
for operators.

7.3.7 Known Software Defects
Two software defects were discovered and documented during testing. The first defect
(TC-36) was an infinite retry loop in the takeoff failure recovery logic, where the state
machine kept cycling between the ARM and TAKEOFF states without any retry limit when
the takeoff command failed. The second defect (TC-37) was an ACK timeout issue in the
manual ARM command pipeline, where the ROS2 service call completed successfully at the
hardware level but the response was not received by MainNode within the timeout window.
Both defects were documented in Chapter 5 and remain unresolved in the current version.

7.3.8 Battery and Flight Time
The drone is powered by a single 4S 5200mAh LiPo battery, which limits the total flight time
to approximately 15 to 20 minutes depending on payload weight and wind conditions. This
restricts the delivery range and does not allow for long-distance deliveries. The system also
does not include advanced battery monitoring edge cases, such as dynamic return-to-home
calculations based on remaining battery and distance from the launch point.

7.3.9 Safety Mechanisms
The drone does not include any physical safety mechanisms for emergency situations. If a
critical failure occurs mid-flight, such as a motor failure or complete power loss, the drone

Conclusion & Future Work 168

would fall to the ground without any protection. A parachute recovery system would reduce
the risk of damage to the drone and potential harm to people or property on the ground, but
this was not part of the current project scope.

7.4 Future Work
Based on the limitations identified in the previous section and the experience gained during
the development of this project, several improvements and extensions are proposed for future
versions of the system. Each suggestion is discussed in detail below.

7.4.1 Package Delivery via Hovering and Zipline
As discussed in the landing mechanism limitation, the drone must currently land at the
destination to drop off the package. A more practical approach would be to keep the drone
hovering at a safe altitude and lower the package to the ground using a motorised zipline or
winch mechanism. This method is already used by commercial drone delivery companies
such as Zipline. The drone would hover above the destination, release the package on a
cable, and once the package reaches the ground, the cable would detach or retract. This
would remove the need for a landing zone and make the system safer for both the drone and
the people on the ground.

7.4.2 Basic Obstacle Avoidance
To address the obstacle awareness limitation, a basic obstacle avoidance system could be
added by mounting ultrasonic sensors on the front, sides, and bottom of the drone [42].
These sensors can detect objects within a short range (typically 2 to 4 metres) and alert
the flight software. When an obstacle is detected, the drone could slow down, stop, or
adjust its path slightly to avoid a collision. While this would not replace a full computer
vision-based avoidance system, it would add an important safety layer that prevents the
drone from crashing into nearby objects during low-altitude flight or landing.

7.4.3 Precision Landing with LiDAR and Camera
To overcome the altitude measurement limitation discussed earlier, a downward-facing
point LiDAR sensor could be added to measure the exact distance between the drone and
the ground in real time. This would allow the drone to make smoother and more accurate
landings. Additionally, a downward-facing camera could be used to analyse the ground
surface below the drone [43]. Using basic image processing, the system could identify

Conclusion & Future Work 169

a suitable flat area for landing and avoid landing on obstacles, water, or uneven terrain.
Together, these two sensors would greatly improve the safety and accuracy of the landing
process.

7.4.4 GCS Integration into the React Frontend
As noted in the GCS architecture limitation, the standalone Flask-based GCS could be
replaced by integrating its functionality directly into the existing React frontend as a set
of protected pages. Role-Based Access Control (RBAC) [44] could be implemented using
Firebase custom claims, where regular users can only access the order placement and
tracking features, while authenticated operators can access the GCS dashboard, telemetry,
manual control, and job management pages. This change would eliminate the need for a
separate desktop application, allow operators to control the drone from any device with a
web browser, and simplify the overall system architecture.

7.4.5 Enhanced Map View with Satellite Imagery
To improve the map-based location selection discussed in the limitations, satellite or 3D
imagery such as Google Earth or Google Maps satellite view could be integrated into the
map component. This would allow users to see actual buildings, rooftops, roads, and open
areas from above, making it much easier to select a precise delivery location. Users could
identify a specific house, garden, or open area for the drone to land in. This change would
improve the accuracy of location selection and reduce the chances of the drone being sent
to an unsafe or inaccessible location.

7.4.6 Multi-Drone Fleet Management
To scale the system beyond the single-drone limitation, support for multiple drones oper-
ating simultaneously would need to be added [45]. This would require several changes.
First, the database schema would need to be updated to store information about multiple
drones, including each drone’s status, location, battery level, and assigned jobs. Second, a
job scheduling and assignment system would be needed to automatically assign incoming
delivery jobs to the most suitable available drone based on factors such as proximity, battery
level, and payload capacity. Third, the GCS interface would need to be redesigned to display
information about all active drones simultaneously, with the ability to switch between differ-
ent drones for monitoring and manual control. Fourth, the backend communication system
would need to support multiple WebSocket connections, one for each active drone. These
changes would transform the system from a single-drone prototype into a fleet management
platform capable of handling multiple deliveries at the same time.

Conclusion & Future Work 170

7.4.7 Parachute Recovery and Battery Safety
To address the safety and battery limitations, two key improvements are proposed. The first
is a parachute recovery system that deploys automatically when the flight controller detects
a loss of control, such as a motor failure or complete power loss [46]. The parachute would
slow down the descent and protect the drone hardware from serious damage while reducing
the risk of injury to people or damage to property on the ground. The deployment could be
managed by the flight controller directly or by a dedicated safety module that continuously
monitors the drone’s behaviour.

The second improvement involves more advanced battery-related safety logic in the software.
For example, the system could dynamically calculate the return-to-home distance based on
the current battery level, wind speed, and payload weight, and automatically trigger a return-
to-home command before the battery reaches a critical level. This would prevent situations
where the drone runs out of battery mid-flight.

7.4.8 Resolution of Known Software Defects
The two software defects identified during testing (TC-36 and TC-37) should be fixed in
future versions. For TC-36, a maximum retry counter should be added to the takeoff
recovery logic in the state machine. If the drone fails to take off after a defined number
of attempts (for example, three), the mission should be aborted and the operator should
be notified through the GCS. This would prevent the infinite retry loop that was observed
during testing. For TC-37, the ACK timeout issue in the manual ARM command pipeline
needs to be investigated at the ROS2 service layer. The root cause may be related to how
the ROS2 service future is handled when the MAVLink command completes faster than
expected. A possible fix would be to implement a callback-based acknowledgment system
instead of relying on the synchronous service response timeout.

7.5 Closing Statement
The Autonomous Drone Delivery System was successfully designed, developed, tested, and
deployed as a fully working prototype. The project demonstrated that autonomous drone
delivery is achievable using affordable, open-source hardware and software tools. From user
order placement on the web interface to autonomous flight execution and real-time monitor-
ing on the Ground Control Station, the complete delivery workflow was implemented and
validated through structured testing. While several limitations and areas for improvement
were identified, the system serves as a strong foundation for future development towards a
commercially viable drone delivery platform.

171
Bibliography
[1] A. Goodchild and J. Toy, “Delivery by drone: An evaluation of unmanned aerial
vehicle technology in reducing co2 emissions in the delivery service industry,” Trans-
portation Research Part D , vol. 61, pp. 1–10, 2018.
[2] C. Thiels and J. Aho, “Use of unmanned aerial vehicles for medical product transport,”
Journal of Air Medical Transport , vol. 34, no. 2, pp. 1–5, 2015.
[3] T. Amukele, “Using drones to deliver blood products in rwanda,” The Lancet Global
Health , vol. 10, no. 4, pp. 1–2, 2019.
[4] H. Eißfeldt, “Acceptance of drone delivery is limited (not only) by noise concerns,”
in First International Conference on Quiet Drones , 2020, pp. 1–12.
[5] J.-P. Aurambout, K. Gkoumas, and B. Ciuffo, “Last mile delivery by drones: An
estimation of viable market potential and access to citizens across european cities,”
European Transport Research Review , vol. 11, no. 1, pp. 1–21, 2019.
[6] A. Koubaa, A. Allouch, M. Alajlan, and Y. Javed, “Micro air vehicle link (mavlink)
in a nutshell: A survey,” IEEE Access , vol. 1, no. 1, pp. 1–23, 2019.
[7] C. Khawas and P. Shah, “Application of firebase in android app development — a
study,” International Journal of Computer Applications , vol. 179, no. 46, pp. 49–53,
2018, https://doi.org/10.5120/ijca2018917200.
[8] G. Macrina, L. Di Puglia Pugliese, F. Guerriero, and G. Laporte, “Drone-aided rout-
ing: A literature review,” Transportation Research Part C: Emerging Technologies ,
vol. 120, p. 102 762, 2020, https://doi.org/10.1016/j.trc.2020.102762.
[9] I. Sommerville, Software Engineering , 10th. Boston, MA, USA: Pearson Education,
2016.
[10] R. Loh, Y. Bian, and T. Roe, “Safety requirements for unmanned aerial vehicles
(uav) in future civil airspace,” in IEEE International Conference on Communications
Workshops (ICC Workshops) , Dublin, Ireland, 2006, pp. 11–20.

[11] G. Booch, J. Rumbaugh, and I. Jacobson, The Unified Modeling Language User
Guide , 2nd. Addison-Wesley Professional, 2005.

[12] H. Koc ̧, A. M. Erdogan, Y. Barjakly, and S. Peker, “Uml diagrams in software ̆
engineering research: A systematic literature review,” Proceedings , vol. 74, no. 1,
p. 13, 2021, https://doi.org/10.3390/proceedings2021074013.

BIBLIOGRAPHY 172
[13] C. Cheng, Y. Adulyasak, L.-M. Rousseau, and M. Sim, “Robust drone delivery
with weather information,” Transportation Research Part B: Methodological , 2020,
https://doi.org/10.1016/j.trb.2020.02.009.

[14] M. Friedrich and J. Lieb, “A novel human machine interface to support supervision
and guidance of multiple highly automated unmanned aircraft,” in 2019 IEEE/AIAA
38th Digital Avionics Systems Conference (DASC) , https://doi.org/10.1109/
DASC43569.2019.9081654, San Diego, CA, USA, 2019, pp. 1–10.

[15] R. Laigner, M. Kalinowski, P. Diniz, L. Barber, M. A. Casanova, and M. Lemos,
“From a monolithic big data system to a microservices event-driven architecture,”
in 2020 46th Euromicro Conference on Software Engineering and Advanced Appli-
cations (SEAA) , https://doi.org/10.1109/SEAA51224.2020.00045, 2020,
pp. 213–220.

[16] W. Giernacki, M. Skwierczynski, W. Witwicki, P. Wro ́ nski, and P. Kozierski, “A ́
survey on open-source flight control platforms of unmanned aerial vehicle,” in 2017
Euromicro Conference on Digital System Design (DSD) , https://doi.org/10.
1109/DSD.2017.30, Vienna, Austria, 2017, pp. 396–403.

[17] M. Quigley, K. Conley, B. P. Gerkey, and J. Faust, “Ros: An open-source robot
operating system,” in ICRA Workshop on Open Source Software , vol. III, 2009,
pp. 1–6.

[18] L. Meier, D. Honegger, and M. Pollefeys, “Px4: A node-based multithreaded open
source robotics framework for deeply embedded platforms,” in 2015 IEEE Interna-
tional Conference on Robotics and Automation (ICRA) , https://doi.org/10.
1109/ICRA.2015.7140074, 2015, pp. 6235–6240.

[19] R. S. Pressman, Software Engineering: A Practitioner’s Approach , 9th. McGraw-Hill
Education, 2019.

[20] G. van Rossum, B. Warsaw, and N. Coghlan, PEP 8 – style guide for Python code ,
https://peps.python.org/pep-0008/, 2001.

[21] N. Koenig and A. Howard, “Design and use paradigms for Gazebo, an open-source
multi-robot simulator,” in 2004 IEEE/RSJ International Conference on Intelligent
Robots and Systems (IROS) , https://doi.org/10.1109/IROS.2004.1389727,
vol. 3, 2004, pp. 2149–2154.

[22] S. Aggarwal and J. Singh, “A comparative study of modern web development frame-
works: ReactJS vs Angular vs Vue.js,” International Journal of Research and Ana-
lytical Reviews (IJRAR) , vol. 8, no. 1, pp. 327–333, 2021.

BIBLIOGRAPHY 173
[23] S. S. Mustafa and K. Hasan, “Firebase Authentication cloud service for RESTful
API security on employee presence system,” in 2019 22nd International Multitopic
Conference (INMIC) , https://doi.org/10.1109/INMIC48123.2019.9022766,
2019, pp. 1–6.

[24] A. M. Luthfi, E. Sugiarto, and D. Anggraini, “Google Maps API implementation
on IoT platform for tracking an object using GPS,” in 2019 IEEE Asia Pacific Con-
ference on Wireless and Mobile (APWiMob) , https://doi.org/10.1109/
APWiMob48441.2019.8964139, 2019, pp. 126–130.

[25] M. Grinberg, Flask Web Development: Developing Web Applications with Python ,
2nd. O’Reilly Media, 2018.

[26] Y. Maruyama, S. Kato, and T. Azumi, “Exploring the performance of ROS2,” in 2016
International Conference on Embedded Software (EMSOFT) , https://doi.org/
10.1145/2968478.2968502, 2016, pp. 1–10.

[27] G. J. Myers, C. Sandler, and T. Badgett, The Art of Software Testing , 3rd. John Wiley
& Sons, 2011.

[28] K. Naik and P. Tripathy, Software Testing and Quality Assurance: Theory and Prac-
tice. John Wiley & Sons, 2008.

[29] G. Pinto, A. Rastogi, and E. T. Barr, “Exploring browser automation: A comparative
study of Selenium, Cypress, Puppeteer, and Playwright,” Empirical Software Engi-
neering , vol. 26, no. 5, p. 105, 2021, https://doi.org/10.1007/s10664-021-
09975-3.

[30] IEEE, IEEE 829-2008 – standard for software and system test documentation , https:
//doi.org/10.1109/IEEESTD.2008.4578383, 2008.

[31] A. Sallam and E. Bertino, “Attribute-based access control for NoSQL databases,”
ACM Transactions on Privacy and Security , vol. 24, no. 3, pp. 1–27, 2021, https:
//doi.org/10.1145/3450516.

[32] P. Cika, P. Masek, A. Muthanna, and N. Sedova, “Comparison between MQTT and
WebSocket protocols for IoT applications using ESP8266,” in 2019 II Workshop on
Metrology for Industry 4.0 and IoT (MetroInd4.0 & IoT) , https://doi.org/10.
1109/METROI4.2019.8792855, 2019, pp. 346–350.

[33] A. Morais, T. Sanguino, and P. Sebastiao, “Safe return path mapping for drone ̃
applications,” in 2019 IEEE International Workshop on Metrology for AeroSpace
(MetroAeroSpace) , Turin, Italy, 2019, pp. 388–393.

[34] I. Sommerville, Software Engineering , 10th. Pearson Education, 2015.

BIBLIOGRAPHY 174
[35] G. Liu, B. Huang, Z. Liang, M. Qin, H. Zhou, and Z. Li, “Microservices: Architecture,
container, and challenges,” in 2020 IEEE 20th International Conference on Software
Quality, Reliability and Security Companion (QRS-C) , https://doi.org/10.
1109/QRS-C51114.2020.00107, 2020, pp. 629–635.

[36] M. Saied and S. Guirguis, “Securing IoT devices using zero trust and blockchain,”
Journal of Organizational Computing and Electronic Commerce , vol. 31, no. 1,
pp. 50–67, 2021, https://doi.org/10.1080/10919392.2020.1831870.

[37] A. Minnich, S. Garg, and X. Guo, “Selection of cloud service providers for hosting
web applications in a multi-cloud environment,” in 2020 IEEE International Con-
ference on Services Computing (SCC) , https://doi.org/10.1109/SCC49832.
2020.00034, 2020, pp. 226–233.

[38] T. Ylonen and C. Lonvick, The Secure Shell (SSH) transport layer protocol , RFC
4253, IETF, https://doi.org/10.17487/RFC4253, 2006.

[39] D. Merkel, “Docker: Lightweight Linux containers for consistent development and
deployment,” Linux Journal , vol. 2014, no. 239, p. 2, 2014.

[40] M. Moravcik, “Overview of Docker container orchestration tools,” in 2020 18th
International Conference on Emerging eLearning Technologies and Applications
(ICETA) , https://doi.org/10.1109/ICETA51985.2020.9379236, 2020,
pp. 475–480.

[41] S. Basak, L. Neil, and L. Williams, “What are the practices for secret management
in software artifacts?” In 2022 IEEE Secure Development Conference (SecDev) ,
https://doi.org/10.1109/SecDev53368.2022.00020, 2022, pp. 69–76.

[42] N. Gageik, P. Benz, and S. Montenegro, “Obstacle detection and collision avoidance
for a UAV with complementary low-cost sensors,” in IEEE Access , https://doi.
org/10.1109/ACCESS.2015.2432455, vol. 3, 2015, pp. 599–609.

[43] W. Kong, D. Zhou, D. Zhang, and J. Zhang, “Vision-based autonomous landing
system for unmanned aerial vehicle: A survey,” in 2014 International Conference
on Multisensor Fusion and Information Integration for Intelligent Systems (MFI) ,
https://doi.org/10.1109/MFI.2014.6997750, 2014, pp. 1–8.

[44] R. S. Sandhu, E. J. Coyne, H. L. Feinstein, and C. E. Youman, “Role-based access
control models,” IEEE Computer , vol. 29, no. 2, pp. 38–47, 1996, https://doi.
org/10.1109/2.485845.

[45] S. H. Chung, B. Sah, and J. Lee, “Optimization for drone and drone-truck combined
operations: A review of the state of the art and future directions,” Computers and
Operations Research , vol. 123, p. 105 004, 2020, https://doi.org/10.1016/j.
cor.2020.105004.

BIBLIOGRAPHY 175
[46] T. Wyllie, “Parachute recovery for UAV systems,” in Aircraft Engineering and
Aerospace Technology , vol. 73, 2001, pp. 542–551.

176
Plagiarism Report
The following pages contain the plagiarism report generated for this document. The report
was obtained from the university library using Turnitin plagiarism detection tool. The
overall similarity index recorded was 3% , which falls well within the acceptable threshold
defined by the Department of Software Engineering at Capital University of Science &
Technology.

Plagiarism Report 177

Plagiarism Report 178

Plagiarism Report 179

180
Appendix
This appendix provides a summary of the key configuration parameters and environment
variables used across the different components of the Autonomous Drone Delivery System
(ADDS). These values were required for the system to function correctly during development
and deployment.

Appendix A: GCS Configuration Reference
The Ground Control Station application relied on a .env file to store sensitive and config-
urable values. These variables were loaded at runtime using the python-dotenv library.
Table 7.1 lists the environment variables used by the GCS.

Table 7.1: GCS Environment Variables
Variable Description Example Value
FIREBASECREDENTIALSPATH Path to the
Firebase ser-
vice account
JSON file used
for server-side
authentication.
./firebase.json
DRONEAPIURL The base URL of
the drone server,
accessed through
the Cloudflare
tunnel.
https://nldrone.space
GCSDATABASEPATH Path to the local
SQLite database
file used for stor-
ing GCS opera-
tional data.
./gcsdata.db
Appendix 181

Variable Description Example Value
DRONEID A unique identi-
fier assigned to
each drone in the
fleet.
DRONE-01
DRONEAPIKEY A secret key used
to authenticate
HTTP requests
sent from the
GCS to the drone
server.
5350d937...
Appendix B: Drone System Configuration Reference
The drone-side application ran inside a Docker container on the Raspberry Pi. Environment
variables were passed to the container through the docker-compose.yml file. Table 7.2
lists the environment variables used by the drone system.

Table 7.2: Drone System Environment Variables
Variable Description Example Value
ROSDOMAINID The ROS2 domain identifier used to isolate
communication between ROS2 nodes.
0
TUNNELTOKEN The Cloudflare tunnel authentication token
used to establish a secure reverse tunnel from
the drone to the internet.
(secret token)
DRONEAPIKEY A shared secret key used to verify incoming
HTTP requests from the GCS.
5350d937...
PIXHAWKUSB The host-side device path of the Pixhawk
flight controller connected via USB. Used for
device mapping into the Docker container.
/dev/ttyACM0
PIXHAWKDEVICE The container-side device path of the Pix-
hawk. This value remained constant regard-
less of the host device path.
/dev/ttyACM0
Appendix 182
Appendix C: Docker Compose Configuration
The drone-side ROS2 application was deployed using Docker Compose on the Raspberry
Pi. The following listing shows the docker-compose.yml file that was used to define and
run the drone control container.
Listing 7.1: Docker Compose configuration for the drone system
1 services:
2 drone_control:
3 image: drone_ros2:latest
4 container_name: drone_ros2
5 privileged: true
6 devices:
7 - ${PIXHAWK_USB:-/dev/ttyACM0}:/dev/ttyACM0
8 volumes:
9 - ./data:/data
10 - /dev:/dev
11 ports:
12 - "8000:8000"
13 environment:
14 - ROS_DOMAIN_ID=0
15 - TUNNEL_TOKEN=${TUNNEL_TOKEN}
16 - DRONE_API_KEY=${DRONE_API_KEY}
17 - PIXHAWK_DEVICE=/dev/ttyACM0
18 restart: unless-stopped

The key aspects of this configuration are explained below:
Privileged Mode: The container was run in privileged mode to allow direct access
to USB hardware devices, which was necessary for serial communication with the
Pixhawk flight controller.
Device Mapping: The Pixhawk USB device from the host was mapped into the
container at a fixed path (/dev/ttyACM0). The PIXHAWKUSB environment variable
allowed flexibility in specifying the host device path.
Port Exposure: Port 8000 was exposed for the HTTP and WebSocket server running
inside the container, which the GCS connected to through the Cloudflare tunnel.
Restart Policy: The unless-stopped restart policy ensured that the container auto-
matically restarted after a crash or system reboot, improving overall system reliability.
Appendix 183
Data Volume: A persistent data volume (./data:/data) was mounted to retain logs
and operational data across container restarts.
Appendix D: Project Repository Structure
The entire project was organized as a monorepo, meaning all components of the system were
stored within a single repository. This approach simplified version control, dependency
management, and coordination between the different modules. The high-level directory
structure is shown below.
Listing 7.2: Project directory structure
1 Drone/
2 |-- adds/ # ROS2 drone control system
3 | |-- src/ # ROS2 package source code
4 | | |-- gcs_client/ # GCS communication node
5 | | |-- main_control/ # Flight logic & state machine
6 | | |-- movros/ # MAVLink communication node
7 | |-- data/ # Persistent data volume
8 | |-- docker-compose.yml # Container orchestration
9 | |-- Dockerfile # Docker image definition
10 |
11 |-- gcs/ # Ground Control Station
12 | |-- app.py # Flask application entry point
13 | |-- services/ # Backend service modules
14 | |-- templates/ # HTML templates
15 | |-- static/ # CSS and JavaScript assets
16 | |-- installer/ # Windows installer scripts
17 | |-- firebase.json # Firebase credentials
18 | |-- requirements.txt # Python dependencies
19 | |-- .env # Environment variables
20 |
21 |-- web/ # React Web Dashboard
22 | |-- src/ # React source code
23 | | |-- components/ # Reusable UI components
24 | | |-- pages/ # Application pages
25 | | |-- services/ # Firebase service modules
26 | |-- public/ # Static assets
27 | |-- package.json # Node.js dependencies
28 |
29 |-- docs/ # Project documentation

Appendix 184
30 |-- latex/ # LaTeX report source files
31 |-- readme.md # Project overview

Each major directory represented one of the four main modules of the system. The adds/
directory contained all ROS2 packages and Docker configuration for the drone. The gcs/
directory held the Flask-based Ground Control Station. The web/ directory contained the
React frontend application. Supporting files such as documentation and the LaTeX report
source were stored in docs/ and latex/, respectively.
Appendix E: User Manual
This section provides a simple and clear guide on how to use the Autonomous Drone
Delivery System. The system is designed with two main roles in mind: the User, who is the
customer requesting the delivery, and the Operator, who is the person managing the drone
and the Ground Control Station (GCS). Both roles have their own specific set of tools and
responsibilities to ensure that deliveries are carried out smoothly and safely.
User Guide
The user experience focuses on requesting a drone delivery in a quick and secure manner.
To start using the system, the user is required to visit the official application website hosted
at https://drone.nelston.com and create a new account. Since security is important,
the user must verify their email address through an automated email link before they are
allowed to log into the platform.
Once successfully logged in, the user will be greeted by the main dashboard. To request a
delivery, the user needs to zoom into the interactive map to find the exact location where
they want the package to be dropped off. It is very important to make sure that the selected
map area is a clear and open space, free from obstacles like tall trees or power lines. After
confirming the spot, the user clicks precisely on the target position to place a digital marker.
As soon as the marker is placed, a popup form will appear on the screen, as shown in Figure
7.1. In this form, the user must enter the Receiver’s name and clearly specify the Package
type. After filling out the information, the user simply clicks the “Confirm and Place Order”
button to finalize the process. At this point, the user’s side of the task is complete.
Appendix 185

Figure 7.1: Order placement form popping up after marker selection
In addition to ordering, users have full control over their personal information. They can
navigate to the profile management page, where they are able to view their specific details
and manage their personal account settings effortlessly, as illustrated in Figure 7.2.

Figure 7.2: User account management interface
Appendix 186

Operator Guide
The operator is responsible for actively managing the drone flights and interacting with the
Ground Control Station (GCS) software. The process begins with the operator opening the
GCS application on their system, which loads the main dashboard shown in Figure 7.3.

Figure 7.3: Ground Control Station main dashboard
Under the “Job Control” section found on the dashboard, a new active job will automatically
pop up as soon as a user finalizes a delivery order. By design, this specific view focuses only
on displaying the most recent delivery request. If the operator wishes to view all incoming
jobs, they can navigate to the dedicated “Jobs” panel from the side navigation menu, as
shown in Figure 7.4.

Figure 7.4: Pending jobs queue showing all active orders in GCS
When a delivery is ready to be fulfilled, the operator takes the physical package from the

Appendix 187

inventory and securely places it into the drone’s designated delivery payload box. Once the
item is secured, the operator turns on the power supply to the drone. Back on the GCS
interface, the operator waits until the drone’s connection status updates to “Connected”.
At this point, the mission is ready to begin, and the operator clicks the “Approve & Start”
button. Before this step, the operator is strictly required to verify the drone’s current battery
level to ensure it has enough power for the entire round trip.

As the mission is approved, the system takes over and performs a series of automatic safety
checks. It first calculates the distance to ensure that the user’s requested delivery target is
within a safe 5-kilometer radius from the current home location. If the destination exceeds
this range, the system will automatically reject the mission to prevent battery exhaustion or
range-related failures. If the distance check passes, the drone will wait on the ground until
it secures a solid GPS lock from at least 4 satellites. Once sufficient satellite connection is
established, the drone will take off instantly and navigate towards the destination.

During the active flight, the operator can continuously track the drone’s status, real-time
mission states, live GPS location, and exact remaining distance from the destination directly
on the GCS dashboard which refreshes every 1 second. Upon reaching the desired coordi-
nates autonomously, the drone will safely descend and land. It is programmed to wait on
the ground for exactly 2 minutes, which provides the user with plenty of time to approach
the drone and retrieve their package if they act immediately. After this 2-minute period
ends, the drone will automatically arm its motors, take off again, navigate its way back to
the original home location, and perform an autonomous landing. Once landed, it enters a
standby state, fully ready for its next mission.

Failsafes and Emergency Actions
While the system operates highly autonomously, it is equipped with strict safety rules to
handle any unexpected problems during the flight.

If anything goes wrong, such as a loss of communication link, software failure, or severe
signal degradation, the drone automatically triggers a built-in RTL (Return to Launch)
sequence. This causes the drone to immediately abort the current delivery job and fly back
to the home location safely on its own without needing operator input.

Additionally, the operator always maintains the ability to intervene. If the operator spots a
hazard, unpredicted obstacle, or simply feels the need to take manual control for safety, they
can pick up the physical remote controller and switch the drone’s flight mode into LOITER
or ALT HOLD. The moment the mode is changed, the ongoing delivery mission is instantly
aborted. The drone will stop its autonomous navigation, stabilize its position in the air, and
purely follow the manual stick commands given by the operator from the remote control.

Appendix 188

By following these simple operational guidelines and relying on the built-in safety mech-
anisms, both the users and the operators can interact with the system confidently. These
careful design choices ensure that every delivery mission is executed smoothly, and if any
emergency arises, the system will always prioritize a safe and immediate recovery.

189
Report Approval Certificate
The report of the project, ”Autonomous Drone Delivery System” has been approved based
on the following evaluation guideline.

Project Evaluation Guidelines
Artifacts Guidelines
Analysis and Design artifacts are syntactically correct (use-case model,
SSDs, domain model, class diagram, SDs, ERDs, Flow charts, Activity
Diagram, DFDs).
Consistency and traceability have been maintained among different
artifacts.
General Guidelines
Formatting (font style, indentation) is according to the FYP template and
consistent throughout the document.
Captions are added to all the figures and tables. Figure captions must be
placed below each figure, and table captions must be provided above the
table.
Each figure or table is followed by some text describing what it represents.
Syed Awais Haider
(Supervisor)