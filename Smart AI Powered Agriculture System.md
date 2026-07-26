

<!-- Start of picture text -->
oe BS Dien,<br>s e<br>> e<br>sous =<br>s 5<br>yg Bap<br>Pakistas<br><!-- End of picture text -->



<!-- Start of picture text -->
ANY af Seip,<br>Ry "te,Ne<br>Fj ¢<br>Batista<br><!-- End of picture text -->



<!-- Start of picture text -->
dint<br>—<br>dan’<br><!-- End of picture text -->



<!-- Start of picture text -->
So<br>ye GA<br>AY le<br><!-- End of picture text -->



<!-- Start of picture text -->
aN<br>A<br><!-- End of picture text -->



<!-- Start of picture text -->
a<br>Ae<br><!-- End of picture text -->



<!-- Start of picture text -->
Ae<br><!-- End of picture text -->



<!-- Start of picture text -->
nat<br><!-- End of picture text -->

v 

# **Acknowledgements** 

First and foremost, we would like to express our profound gratitude to Almighty Allah for giving us the strength, patience, and capability to successfully complete this Final Year Project. 

We would like to extend our deepest and most sincere gratitude to our supervisor, Mr. Adnan Karamat, whose invaluable guidance, continuous encouragement, and insightful feedback have been instrumental in shaping this project. His technical expertise and unwavering support provided us with the direction needed to overcome numerous challenges throughout the development of the Smart AI Powered Agriculture System. 

We also wish to thank the faculty members of the Department of Software Engineering at Capital University of Science & Technology (CUST) for their academic support and for providing us with the foundational knowledge that made this endeavor possible. 

Lastly, we dedicate our deepest appreciation to our parents and families. Their endless prayers, moral support, and financial sacrifices have been the driving force behind our academic journey and personal growth. 

vi 

# **Dedication** 

We dedicate this project to our beloved parents, whose unconditional love, continuous prayers, and countless sacrifices have illuminated our path to success. We also dedicate this work to our esteemed teachers and our supervisor, Mr. Adnan Karamat, whose guidance and mentorship have shaped our professional and academic capabilities. 

vii 

# **Executive Summary** 

Agriculture remains one of the most important sectors of Pakistan’s economy; however, it continues to face significant challenges, including water scarcity, climate variability, and limited access to modern agricultural technologies, particularly for small and medium-scale farmers. To address these issues, the Smart AI Powered Agriculture System was designed and developed as an affordable, intelligent, and IoT-enabled precision farming solution. 

The proposed system successfully integrates an ESP32 microcontroller with multiple environmental sensors to continuously monitor soil moisture, temperature, humidity, light intensity, and rainfall in real time. Based on predefined soil moisture thresholds, the system autonomously controls irrigation through a water pump, improving water efficiency while maintaining reliable offline operation. Sensor data is transmitted to a Node.js REST API backend, securely stored in a MySQL relational database, and presented through a crossplatform Flutter mobile application, enabling farmers to remotely monitor field conditions and irrigation activities. Additionally, a carefully trained and optimized Random Forest machine learning model analyzes historical and real-time environmental data to generate crop recommendations along with statistical confidence scores, providing valuable decision support for farmers. 

Extensive implementation, testing, and performance evaluation demonstrate that the proposed system effectively combines IoT-based environmental monitoring, automated irrigation control, cloud-based data management, and AI-driven crop recommendation within a cost-effective architecture. By enabling data-driven decision-making, optimizing water consumption, and improving accessibility to smart farming technologies, the Smart AI Powered Agriculture System contributes to sustainable agricultural practices and represents a practical step toward enhancing productivity, resource efficiency, and long-term food security in Pakistan. 

viii 

# **Table of Contents** 

|1.<br>Introd|uction .|. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .|1|
|---|---|---|---|
|1.1.|Project|Introduction . . . . . . . . . . . . . . . . . . . . . . . . . .|1|
|1.2.|Existin|g Examples / Solutions<br>. . . . . . . . . . . . . . . . . . . .|1|
|1.3.|Problem|Statement . . . . . . . . . . . . . . . . . . . . . . . . . .|2|
|1.4.|Busines|s Scope . . . . . . . . . . . . . . . . . . . . . . . . . . . .|3|
|1.5.|Useful|Tools and Technologies . . . . . . . . . . . . . . . . . . . .|4|
||1.5.1.|Hardware . . . . . . . . . . . . . . . . . . . . . . . . . .|4|
||1.5.2.|Software . . . . . . . . . . . . . . . . . . . . . . . . . .|4|
||1.5.3.|AI and Machine Learning . . . . . . . . . . . . . . . . .|5|
|1.6.|Project|Work Break Down<br>. . . . . . . . . . . . . . . . . . . . . .|5|
|1.7.|Project|Time Line . . . . . . . . . . . . . . . . . . . . . . . . . . .|7|
|2.<br>Requi|rement Sp|ecifcation and Analysis . . . . . . . . . . . . . . . . . . .|8|
|2.1.|Epics|. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .|8|
||2.1.1.|E1: User Authentication and Profle Management . . . . .|8|
||2.1.2.|E2: Real-Time Sensor Data Monitoring . . . . . . . . . .|8|
||2.1.3.|E3: Intelligent Irrigation Control<br>. . . . . . . . . . . . .|8|
||2.1.4.|E4: AI-Driven Crop Recommendations . . . . . . . . . .|8|
||2.1.5.|E5: Alerting and Notifcation System . . . . . . . . . . .|9|
||2.1.6.|E6: Historical Data Analytics and Visualization<br>. . . . .|9|
|2.2.|User St|ories . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .|9|
||2.2.1.|Epic E1: User Authentication and Profle Management . .|9|
||2.2.2.|Epic E2: Real-Time Sensor Data Monitoring . . . . . . .|10|
||2.2.3.|Epic E3: Intelligent Irrigation Control . . . . . . . . . . .|10|
||2.2.4.|Epic E4: AI-Driven Crop Recommendations . . . . . . .|11|
||2.2.5.|Epic E5: Alerting and Notifcation System<br>. . . . . . . .|11|
||2.2.6.|Epic E6: Historical Data Analytics and Visualization . . .|12|
|2.3.|Test-cas|es . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .|13|
||2.3.1.|Test Case 1 — Verify User Registration with Valid Data .|13|
||2.3.2.|Test Case 2 — Verify Login with Valid Credentials . . . .|14|
||2.3.3.|Test Case 3 — Verify Profle Management<br>. . . . . . . .|14|
||2.3.4.|Test Case 4 — Verify Field Overview Display . . . . . . .|15|
||2.3.5.|Test Case 5 — Verify Real-Time Data Display<br>. . . . . .|16|
||2.3.6.|Test Case 6 — Verify Sensor Status Monitoring . . . . . .|16|
||2.3.7.|Test Case 7 — Verify Manual Pump Start . . . . . . . . .|17|
||2.3.8.|Test Case 8 — Verify Automatic Trigger on Low Moisture|18|



ix 

TABLE OF CONTENTS 

||2.3.9.|Test Case 9 — Verify Irrigation Logging<br>. . . . . . . . .|18|
|---|---|---|---|
||2.3.10.|Test Case 10 — Verify Crop Recommendation Generation|19|
||2.3.11.|Test Case 11 — Verify Recommendation Confdence Score|20|
||2.3.12.|Test Case 12 — Verify Accept Recommendation . . . . .|20|
||2.3.13.|Test Case 13 — Verify Critical Alert Delivery<br>. . . . . .|21|
||2.3.14.|Test Case 14 — Verify Unread Alert Count . . . . . . . .|22|
||2.3.15.|Test Case 15 — Verify Resolve Alert Functionality . . . .|22|
||2.3.16.|Test Case 16 — Verify Weekly Trend Graph<br>. . . . . . .|23|
||2.3.17.|Test Case 17 — Verify Data Export . . . . . . . . . . . .|24|
||2.3.18.|Test Case 18 — Verify Field Comparison . . . . . . . . .|24|
|2.4.|User Int|erface Implementation (Screenshots)<br>. . . . . . . . . . . .|25|
||2.4.1.|User Registration Screen . . . . . . . . . . . . . . . . . .|26|
||2.4.2.|Login Screen . . . . . . . . . . . . . . . . . . . . . . . .|27|
||2.4.3.|Profle Management Screen . . . . . . . . . . . . . . . .|28|
||2.4.4.|Dashboard (Field Overview) . . . . . . . . . . . . . . . .|29|
||2.4.5.|Detailed Sensor Data Screen . . . . . . . . . . . . . . . .|30|
||2.4.6.|Sensor Status Monitoring<br>. . . . . . . . . . . . . . . . .|31|
||2.4.7.|Manual Irrigation Control . . . . . . . . . . . . . . . . .|32|
||2.4.8.|Auto-Irrigation Settings<br>. . . . . . . . . . . . . . . . . .|33|
||2.4.9.|Irrigation Logs . . . . . . . . . . . . . . . . . . . . . . .|34|
||2.4.10.|Crop Recommendation Form<br>. . . . . . . . . . . . . . .|35|
||2.4.11.|Recommendation Result . . . . . . . . . . . . . . . . . .|36|
||2.4.12.|Accepted Recommendation Details . . . . . . . . . . . .|37|
||2.4.13.|Critical Alert Notifcation . . . . . . . . . . . . . . . . .|38|
||2.4.14.|Alert Center<br>. . . . . . . . . . . . . . . . . . . . . . . .|39|
||2.4.15.|Resolved Alerts History . . . . . . . . . . . . . . . . . .|40|
||2.4.16.|Weekly Trend Graph . . . . . . . . . . . . . . . . . . . .|41|
||2.4.17.|Data Export Screen . . . . . . . . . . . . . . . . . . . . .|42|
||2.4.18.|Field Comparison View<br>. . . . . . . . . . . . . . . . . .|43|
|2.5.|Traceabi|lity Matrix . . . . . . . . . . . . . . . . . . . . . . . . . .|44|
|3.<br>Syste|m Design .|. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .|46|
|3.1.|Software|Architecture . . . . . . . . . . . . . . . . . . . . . . . . .|46|
|3.2.|Compon|ents and Connector<br>. . . . . . . . . . . . . . . . . . . . .|47|
||3.2.1.|Core Components<br>. . . . . . . . . . . . . . . . . . . . .|47|
||3.2.2.|Connectors (Interfaces)<br>. . . . . . . . . . . . . . . . . .|48|
|3.3.|Hardwar|e Specifcations<br>. . . . . . . . . . . . . . . . . . . . . . .|48|
||3.3.1.|Component Overview<br>. . . . . . . . . . . . . . . . . . .|50|
||3.3.2.|Detailed Technical Specifcations . . . . . . . . . . . . .|51|
||3.3.3.|Pin Confguration and Wiring . . . . . . . . . . . . . . .|52|



TABLE OF CONTENTS 

x 

||3.3.4.|Power Consumption Analysis<br>. . . . . . . . . . . . . . .<br>52|
|---|---|---|
||3.3.5.|Cost Estimation<br>. . . . . . . . . . . . . . . . . . . . . .<br>53|
|3.4.|Commu|nication Protocols<br>. . . . . . . . . . . . . . . . . . . . . .<br>53|
|3.5.|Data M|odeling<br>. . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>54|
||3.5.1.|Relational Database Model (MySQL) . . . . . . . . . . .<br>54|
||3.5.2.|User & Field Management . . . . . . . . . . . . . . . . .<br>54|
||3.5.3.|Sensor & Telemetry<br>. . . . . . . . . . . . . . . . . . . .<br>55|
||3.5.4.|Irrigation Management . . . . . . . . . . . . . . . . . . .<br>55|
||3.5.5.|Alerts & Recommendations . . . . . . . . . . . . . . . .<br>55|
||3.5.6.|System Management . . . . . . . . . . . . . . . . . . . .<br>55|
||3.5.7.|Key Relationships<br>. . . . . . . . . . . . . . . . . . . . .<br>56|
|3.6.|Databas|e Schema Specifcation . . . . . . . . . . . . . . . . . . . .<br>56|
||3.6.1.|Users Table . . . . . . . . . . . . . . . . . . . . . . . . .<br>57|
||3.6.2.|Fields Table . . . . . . . . . . . . . . . . . . . . . . . . .<br>57|
||3.6.3.|Sensors Table . . . . . . . . . . . . . . . . . . . . . . . .<br>58|
||3.6.4.|Sensor Readings Table . . . . . . . . . . . . . . . . . . .<br>58|
||3.6.5.|Irrigation Logs Table . . . . . . . . . . . . . . . . . . . .<br>59|
||3.6.6.|Alerts Table<br>. . . . . . . . . . . . . . . . . . . . . . . .<br>59|
||3.6.7.|Crop Recommendations Table . . . . . . . . . . . . . . .<br>60|
||3.6.8.|Indexing Strategy . . . . . . . . . . . . . . . . . . . . . .<br>61|
|3.7.|AI Data|Modeling and Architecture<br>. . . . . . . . . . . . . . . . .<br>61|
||3.7.1.|Dataset Acquisition and Synthesis . . . . . . . . . . . . .<br>62|
||3.7.2.|Model Architecture and Hyperparameters . . . . . . . . .<br>63|
||3.7.3.|Confdence Score Calculation . . . . . . . . . . . . . . .<br>63|
|3.8.|Workfo|w Diagram . . . . . . . . . . . . . . . . . . . . . . . . . .<br>64|
|3.9.|UML C|omponent Diagram . . . . . . . . . . . . . . . . . . . . . .<br>64|
|3.10.|UML A|ctivity Diagram . . . . . . . . . . . . . . . . . . . . . . . .<br>65|
|3.11.|Third-P|arties Dependencies . . . . . . . . . . . . . . . . . . . . . .<br>67|
|4.<br>Softw|are Devel|opment<br>. . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>68|
|4.1.|Coding|Standards . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>68|
||4.1.1.|General Standards . . . . . . . . . . . . . . . . . . . . .<br>68|
||4.1.2.|ESP32 Firmware Standards<br>. . . . . . . . . . . . . . . .<br>68|
||4.1.3.|Backend Standards (Node.js) . . . . . . . . . . . . . . . .<br>68|
||4.1.4.|Mobile Application Standards . . . . . . . . . . . . . . .<br>69|
|4.2.|Develop|ment Environment . . . . . . . . . . . . . . . . . . . . . .<br>69|
||4.2.1.|Tools and Platforms<br>. . . . . . . . . . . . . . . . . . . .<br>69|
||4.2.2.|Testing Setup . . . . . . . . . . . . . . . . . . . . . . . .<br>69|
|4.3.|Softwar|e Description . . . . . . . . . . . . . . . . . . . . . . . . .<br>69|
||4.3.1.|Snippet 1: Hardware Pin Confguration . . . . . . . . . .<br>70|



xi 

TABLE OF CONTENTS 

||4.3.2.|Snippet 2: Sensor Threshold Confguration . . . . . . . .<br>70|
|---|---|---|
||4.3.3.|Snippet 3: Three-Tier Timing System . . . . . . . . . . .<br>71|
||4.3.4.|Snippet 4: Safe System Initialization<br>. . . . . . . . . . .<br>71|
||4.3.5.|Snippet 5: Main Execution Loop<br>. . . . . . . . . . . . .<br>72|
||4.3.6.|Snippet 6: Smoothed Sensor Reading . . . . . . . . . . .<br>73|
||4.3.7.|Snippet 7: Sensor Data Acquisition . . . . . . . . . . . .<br>73|
||4.3.8.|Snippet 8: Local Rain Safety Mechanism . . . . . . . . .<br>74|
||4.3.9.|Snippet 9: Backend Command Polling<br>. . . . . . . . . .<br>75|
||4.3.10.|Snippet 10: Relay Synchronization Logic . . . . . . . . .<br>76|
||4.3.11.|Snippet 11: Relay-Based Pump Control . . . . . . . . . .<br>76|
||4.3.12.|Snippet 12: Ofine Irrigation Logic . . . . . . . . . . . .<br>77|
||4.3.13.|Snippet 13: Wi-Fi Connectivity and Reconnection . . . .<br>78|
||4.3.14.|Snippet 14: Sensor Value Conversion . . . . . . . . . . .<br>78|
||4.3.15.|Snippet 15: Sensor Data Upload to Backend<br>. . . . . . .<br>79|
|4.4.|Impleme|ntation Challenges and Resolutions . . . . . . . . . . . . .<br>80|
|4.5.|Summar|y . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>80|
|5.<br>Softw|are Deplo|yment . . . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>81|
|5.1.|Installat|ion / Deployment Process Description . . . . . . . . . . . .<br>81|
||5.1.1.|Deployment Overview . . . . . . . . . . . . . . . . . . .<br>81|
||5.1.2.|Hardware Setup and Field Installation . . . . . . . . . . .<br>81|
||5.1.3.|Hardware Prototype Evolution and Waterproofng<br>. . . .<br>82|
||5.1.4.|ESP32 Firmware Deployment . . . . . . . . . . . . . . .<br>83|
||5.1.5.|Firmware Flashing Steps . . . . . . . . . . . . . . . . . .<br>83|
||5.1.6.|Post-Flash Verifcation . . . . . . . . . . . . . . . . . . .<br>83|
|5.2.|Backend|Deployment (Node.js Server) . . . . . . . . . . . . . . . .<br>84|
||5.2.1.|Backend Installation Requirements<br>. . . . . . . . . . . .<br>84|
||5.2.2.|Backend Deployment Steps<br>. . . . . . . . . . . . . . . .<br>84|
||5.2.3.|Backend Deployment Modes . . . . . . . . . . . . . . . .<br>84|
|5.3.|Databas|e Deployment and Confguration . . . . . . . . . . . . . . .<br>85|
||5.3.1.|MySQL Database Setup . . . . . . . . . . . . . . . . . .<br>86|
|5.4.|AI Servi|ce Deployment (Python) . . . . . . . . . . . . . . . . . . .<br>87|
||5.4.1.|Deployment Steps<br>. . . . . . . . . . . . . . . . . . . . .<br>87|
||5.4.2.|AI Verifcation . . . . . . . . . . . . . . . . . . . . . . .<br>87|
|5.5.|Mobile|Application Deployment . . . . . . . . . . . . . . . . . . .<br>88|
||5.5.1.|Deployment and Installation . . . . . . . . . . . . . . . .<br>88|
||5.5.2.|Mobile Verifcation Checklist . . . . . . . . . . . . . . .<br>89|
|5.6.|End-to-|End System Validation . . . . . . . . . . . . . . . . . . . .<br>89|
|5.7.|Summar|y . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>89|
|6.<br>Syste|m Testing|. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>90|



xii 

TABLE OF CONTENTS 

|6.1.|Unit Tes|ting . . . .|. . . . . . . . . . . . . . . . . . . . . . . . . .|90|
|---|---|---|---|---|
||6.1.1.|TC-UT-01:|User Registration with Valid Data . . . . . . .|90|
||6.1.2.|TC-UT-02:|User Login with Valid Credentials . . . . . .|91|
||6.1.3.|TC-UT-03:|User Login with Invalid Password<br>. . . . . .|91|
||6.1.4.|TC-UT-04:|Soil Moisture Sensor Smoothed Reading . . .|92|
||6.1.5.|TC-UT-05:|Soil Moisture Percentage Conversion . . . . .|93|
||6.1.6.|TC-UT-06:|DHT22 Temperature and Humidity Reading .|93|
||6.1.7.|TC-UT-07:|Dry Soil Threshold Evaluation . . . . . . . .|94|
||6.1.8.|TC-UT-08:|Rain Detection Logic . . . . . . . . . . . . .|95|
||6.1.9.|TC-UT-09:|AI Crop Recommendation Model Output . . .|95|
||6.1.10.|TC-UT-10:|Firebase Push Notifcation Dispatch<br>. . . . .|98|
|6.2.|Compon|ent Testing|. . . . . . . . . . . . . . . . . . . . . . . . . .|98|
||6.2.1.|TC-CT-01:|Automatic Irrigation Trigger Component . . .|98|
||6.2.2.|TC-CT-02:|Rain Safety Override Component . . . . . . .|99|
||6.2.3.|TC-CT-03:|Ofine Irrigation Control Component . . . . .|100|
||6.2.4.|TC-CT-04:|Critical Alert Generation Component . . . . .|101|
||6.2.5.|TC-CT-05:|Historical Data Retrieval Component . . . . .|101|
||6.2.6.|TC-CT-06:|Manual Irrigation Control Component . . . .|102|
||6.2.7.|TC-CT-07:|Crop Recommendation API Component . . .|103|
|6.3.|Integrat|ion Testing<br>|. . . . . . . . . . . . . . . . . . . . . . . . . .|103|
||6.3.1.|TC-IT-01:|ESP32 to Backend Sensor Telemetry<br>. . . . .|103|
||6.3.2.|TC-IT-02:|Backend to MySQL Data Persistence<br>. . . . .|104|
||6.3.3.|TC-IT-03:|Backend to Firebase FCM Integration . . . . .|105|
||6.3.4.|TC-IT-04:|Mobile App to Backend Authentication . . . .|106|
||6.3.5.|TC-IT-05:|Backend to AI Service Integration . . . . . . .|106|
||6.3.6.|TC-IT-06:|ESP32 Irrigation Command Polling . . . . . .|107|
||6.3.7.|TC-IT-07:|Sensor Data to Mobile Dashboard . . . . . . .|108|
|6.4.|System|Testing<br>. .|. . . . . . . . . . . . . . . . . . . . . . . . . .|109|
||6.4.1.|TC-ST-01: <br>Flow<br>. .|Complete Sensor-to-Dashboard End-to-End<br>. . . . . . . . . . . . . . . . . . . . . . . . . .|109|
||6.4.2.|TC-ST-02:|Automated Irrigation with Rain Safety End-||
|||to-End<br>.|. . . . . . . . . . . . . . . . . . . . . . . . . .|110|
||6.4.3.|TC-ST-03:|Manual Irrigation Remote Control End-to-End|110|
||6.4.4.|TC-ST-04:|AI Crop Recommendation End-to-End Flow .|111|
||6.4.5.|TC-ST-05:|Critical Alert with Push Notifcation End-to-End|112|
||6.4.6.|TC-ST-06:|Weekly Historical Analytics End-to-End . . .|113|
||6.4.7.|TC-ST-07:|Data Export End-to-End . . . . . . . . . . . .|113|
||6.4.8.|TC-ST-08:|Sensor Ofine Detection End-to-End . . . . .|114|
||6.4.9.|TC-ST-09:|Field Comparison End-to-End . . . . . . . . .|115|



xiii 

TABLE OF CONTENTS 

||6.4.10.|TC-ST-10:<br>Complete System Resilience Under Wi-Fi||
|---|---|---|---|
|||Failure<br>. . . . . . . . . . . . . . . . . . . . . . . . . .|. 116|
|6.5.|Testing|Summary . . . . . . . . . . . . . . . . . . . . . . . . . .|. 116|
|6.6.|Hardwa|re Testing Evidence . . . . . . . . . . . . . . . . . . . . .|. 118|
|6.7.|Softwar|e & API Testing Evidence<br>. . . . . . . . . . . . . . . . .|. 120|
|6.8.|Summa|ry . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .|. 123|
|7.<br>Concl|usion and|Future Work . . . . . . . . . . . . . . . . . . . . . . . .|. 124|
|7.1.|Conclu|sion<br>. . . . . . . . . . . . . . . . . . . . . . . . . . . . .|. 124|
|7.2.|Limitat|ions . . . . . . . . . . . . . . . . . . . . . . . . . . . . .|. 125|
|7.3.|Future|Work . . . . . . . . . . . . . . . . . . . . . . . . . . . . .|. 126|
||7.3.1.|LoRa / GSM Connectivity for Remote Fields . . . . . .|. 126|
||7.3.2.|Solar-Powered Field Units . . . . . . . . . . . . . . . .|. 126|
||7.3.3.|Expanded AI Model with Localized Data . . . . . . . .|. 126|
||7.3.4.|Federated Learning for Farmer Data Privacy<br>. . . . . .|. 127|
||7.3.5.|Multi-Node and Multi-Field Scalability . . . . . . . . .|. 127|
||7.3.6.|Integration of NPK and pH Sensors . . . . . . . . . . .|. 127|
||7.3.7.|Urdu Language Support and Voice Interface<br>. . . . . .|. 127|
||7.3.8.|Drone and Satellite Image Integration . . . . . . . . . .|. 127|
||7.3.9.|Predictive Maintenance for Sensors . . . . . . . . . . .|. 127|
|7.4.|Final R|emarks . . . . . . . . . . . . . . . . . . . . . . . . . . . .|. 128|
|**Bibliography**|||**129**|
|**Plagiarism Re**|**port**||**133**|
|**Appendix**|||**135**|
|Appendix A|: User M|anual and Troubleshooting . . . . . . . . . . . . . . . . .|. 135|
|Appendix B|: Hardwa|re Confguration and AI Model Details<br>. . . . . . . . . .|. 136|



xiv 

# **List of Figures** 

|2-1|User Registration Screen Screenshot . . . . . . . . . . . . . . . . . . . . .<br>26|
|---|---|
|2-2|Login Screen Screenshot . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>27|
|2-3|Profle Management Screen Screenshot . . . . . . . . . . . . . . . . . . . .<br>28|
|2-4|Dashboard (Field Overview) Screenshot . . . . . . . . . . . . . . . . . . .<br>29|
|2-5|Detailed Sensor Data Screen Screenshot . . . . . . . . . . . . . . . . . . .<br>30|
|2-6|Sensor Status Monitoring Screenshot . . . . . . . . . . . . . . . . . . . . .<br>31|
|2-7|Manual Irrigation Control Screenshot<br>. . . . . . . . . . . . . . . . . . . .<br>32|
|2-8|Auto-Irrigation Settings Screenshot . . . . . . . . . . . . . . . . . . . . . .<br>33|
|2-9|Irrigation Logs Screenshot<br>. . . . . . . . . . . . . . . . . . . . . . . . . .<br>34|
|2-10|Crop Recommendation Form Screenshot . . . . . . . . . . . . . . . . . . .<br>35|
|2-11|Recommendation Result Screenshot<br>. . . . . . . . . . . . . . . . . . . . .<br>36|
|2-12|Accepted Recommendation Details Screenshot . . . . . . . . . . . . . . . .<br>37|
|2-13|Critical Alert Notifcation Screenshot . . . . . . . . . . . . . . . . . . . . .<br>38|
|2-14|Alert Center Screenshot . . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>39|
|2-15|Resolved Alerts History Screenshot . . . . . . . . . . . . . . . . . . . . . .<br>40|
|2-16|Weekly Trend Graph Screenshot . . . . . . . . . . . . . . . . . . . . . . .<br>41|
|2-17|Data Export Screen Screenshot . . . . . . . . . . . . . . . . . . . . . . . .<br>42|
|2-18|Field Comparison View Screenshot . . . . . . . . . . . . . . . . . . . . . .<br>43|
|3-1|System Architecture Diagram . . . . . . . . . . . . . . . . . . . . . . . . .<br>46|
|3-2|Hardware Integration . . . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>47|
|3-3|ESP32 Component Wiring Schematic (Fritzing) . . . . . . . . . . . . . . .<br>48|
|3-4|Hardware Components and Sensor Modules Overview<br>. . . . . . . . . . .<br>49|
|3-5|Communication Protocol Stack . . . . . . . . . . . . . . . . . . . . . . . .<br>54|
|3-6|Entity Relationship Diagram (ERD)<br>. . . . . . . . . . . . . . . . . . . . .<br>56|
|3-7|Complete Database Schema . . . . . . . . . . . . . . . . . . . . . . . . . .<br>57|
|3-8|Training Dataset Sample for Crop Recommendation . . . . . . . . . . . . .<br>62|
|3-9|System Workfow Diagram . . . . . . . . . . . . . . . . . . . . . . . . . .<br>64|
|3-10|UML Component Diagram of the System<br>. . . . . . . . . . . . . . . . . .<br>65|
|3-11|UML Activity Diagram of the System Workfow . . . . . . . . . . . . . . .<br>66|
|5-1|Initial Hardware Prototype and Lab Testing Setup . . . . . . . . . . . . . .<br>82|
|5-2|Final Waterproofed Ready-to-Use Hardware Prototype<br>. . . . . . . . . . .<br>83|
|5-3|DigitalOcean App Platform Deployment Dashboard . . . . . . . . . . . . .<br>85|
|5-4|Backend Node.js API Health Check Endpoint . . . . . . . . . . . . . . . .<br>85|
|5-5|Python AI Service Health Check Endpoint . . . . . . . . . . . . . . . . . .<br>88|
|6-1|Random Forest Dataset Loading and Pre-class Metrics<br>. . . . . . . . . . .<br>96|



LIST OF FIGURES 

xv 

|6-2|Feature Importances and Live Prediction Tests . . . . . . . .|. . . . . . . .<br>97|
|---|---|---|
|6-3|Hardware Assembled Prototype . . . . . . . . . . . . . . . .|. . . . . . . . 118|
|6-4|Actuator and Sensor Wiring Confguration . . . . . . . . . .|. . . . . . . . 119|
|6-5|Field Test Environment at Fateh Jhang . . . . . . . . . . . .|. . . . . . . . 120|
|6-6|ESP32 Serial Monitor Logs . . . . . . . . . . . . . . . . . .|. . . . . . . . 121|
|6-7|Backend API Health Endpoint Response . . . . . . . . . . .|. . . . . . . . 121|
|6-8|AI Service API Health Endpoint Response . . . . . . . . . .|. . . . . . . . 122|
|6-9|MySQL Database Sensor Reading Validation<br>. . . . . . . .|. . . . . . . . 123|



xvi 

# **List of Tables** 

|1-1|Existing Examples . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>2|
|---|---|
|1-2|Lean Canvas . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>3|
|1-3|Detailed Work Breakdown Structure with Ownership . . . . . . . . . . . .<br>5|
|1-4|Formal Project Schedule<br>. . . . . . . . . . . . . . . . . . . . . . . . . . .<br>7|
|2-1|Verify User Registration with Valid Data . . . . . . . . . . . . . . . . . . .<br>13|
|2-2|Verify Login with Valid Credentials<br>. . . . . . . . . . . . . . . . . . . . .<br>14|
|2-3|Verify Profle Management . . . . . . . . . . . . . . . . . . . . . . . . . .<br>14|
|2-4|Verify Field Overview Display . . . . . . . . . . . . . . . . . . . . . . . .<br>15|
|2-5|Verify Real-Time Data Display . . . . . . . . . . . . . . . . . . . . . . . .<br>16|
|2-6|Verify Sensor Status Monitoring . . . . . . . . . . . . . . . . . . . . . . .<br>16|
|2-7|Verify Manual Pump Start<br>. . . . . . . . . . . . . . . . . . . . . . . . . .<br>17|
|2-8|Verify Automatic Trigger on Low Moisture<br>. . . . . . . . . . . . . . . . .<br>18|
|2-9|Verify Irrigation Logging . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>18|
|2-10|Verify Crop Recommendation Generation . . . . . . . . . . . . . . . . . .<br>19|
|2-11|Verify Recommendation Confdence Score . . . . . . . . . . . . . . . . . .<br>20|
|2-12|Verify Accept Recommendation<br>. . . . . . . . . . . . . . . . . . . . . . .<br>21|
|2-13|Verify Critical Alert Delivery . . . . . . . . . . . . . . . . . . . . . . . . .<br>21|
|2-14|Verify Unread Alert Count . . . . . . . . . . . . . . . . . . . . . . . . . .<br>22|
|2-15|Verify Resolve Alert Functionality . . . . . . . . . . . . . . . . . . . . . .<br>22|
|2-16|Verify Weekly Trend Graph . . . . . . . . . . . . . . . . . . . . . . . . . .<br>23|
|2-17|Verify Data Export<br>. . . . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>24|
|2-18|Verify Field Comparison . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>24|
|2-19|Traceability Matrix . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>44|
|3-1|Hardware Components and Primary Functions . . . . . . . . . . . . . . . .<br>50|
|3-2|Hardware Technical Specifcations and Interface Details . . . . . . . . . . .<br>51|
|3-4|ESP32 Pin Confguration . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>52|
|3-6|Estimated Hardware Costs<br>. . . . . . . . . . . . . . . . . . . . . . . . . .<br>53|
|3-7|Users Table Schema . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>57|
|3-8|Fields Table Schema<br>. . . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>58|
|3-9|Sensors Table Schema . . . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>58|
|3-10|Sensor Readings Table Schema . . . . . . . . . . . . . . . . . . . . . . . .<br>59|
|3-11|Irrigation Logs Table Schema . . . . . . . . . . . . . . . . . . . . . . . . .<br>59|
|3-12|Alerts Table Schema<br>. . . . . . . . . . . . . . . . . . . . . . . . . . . . .<br>60|
|3-13|Crop Recommendations Table Schema . . . . . . . . . . . . . . . . . . . .<br>60|
|6-35|System Testing Summary . . . . . . . . . . . . . . . . . . . . . . . . . . . 116|



xvii 

LIST OF TABLES 

7-2 ESP32 Pin Configuration for Field Unit . . . . . . . . . . . . . . . . . . . . 136 

xviii 

_This page is intentionally kept blank_ 

1 

# **Chapter 1** 

# **1. Introduction** 

Agriculture in Pakistan faces challenges like water shortage, low productivity, and lack of modern tools [1]. To address this, the **Smart AI Powered Agriculture System** uses Internet of Things (IoT) sensors to monitor soil and weather conditions, automates irrigation to save water, and applies artificial intelligence (AI) to recommend suitable crops [2]. This solution is designed to help farmers improve yield, reduce costs, save water, and adopt smarter farming practices. 

## **1.1. Project Introduction** 

The Smart AI Powered Agriculture System is an IoT-based solution designed to make farming more efficient and sustainable. The system uses sensors to monitor soil moisture, temperature, humidity, light, and rainfall in real time. This data is sent to a mobile application through a backend server, allowing farmers to track field conditions, receive alerts, and view historical records [3]. 

The system also includes automatic irrigation, where water is supplied only when the soil is dry [4], and an AI module that recommends the most suitable crops for upcoming seasons [5]. The goal is to help farmers conserve water, improve crop yield, and make data-driven decisions in agriculture. 

The main beneficiaries of this project are small and medium scale farmers in Pakistan, who often face challenges such as water wastage, low crop productivity, and lack of access to modern agricultural tools [6]. By using this system, farmers can monitor their fields easily, save water through automated irrigation, and receive crop recommendations that support better planning. 

## **1.2. Existing Examples / Solutions** 

Several existing systems and solutions in Pakistan and globally work towards precision agriculture, smart irrigation, and farm monitoring. However, most of them are either expensive, focused on large-scale farms, or limited in scope [7]. Table 1-1 summarizes some examples and the gaps that remain. 

Introduction 

2 

_Table 1-1: Existing Examples_ 

|**Name**|**What they do (features)**|**What gap remains**|
|---|---|---|
|SAWiE<br>(Sustain-<br>able<br>Agriculture<br>Water & Intelligent<br>Ecosystem)|Ofers IoT and machine learn-<br>ing based advisory for farm-<br>ers; soil mapping and alerts for<br>droughts and foods.|Does not directly automate irri-<br>gation hardware or pump con-<br>trol.|
|Buraq<br>Integrated<br>Solutions — Smart<br>Drip Irrigation|Implements drip irrigation sys-<br>tems with soil moisture and<br>temperature sensors.|Lacks an AI-based crop recom-<br>mendation module.|
|VGreen<br>—<br>CropSight<sup>™</sup>|Provides farm mapping, real-<br>time monitoring, and analytics;<br>localized for Pakistani farms.|Good dashboards and analyt-<br>ics but lacks full automation<br>(pump control and crop rec-<br>ommendation) and is costly for<br>small farmers.|
|Field Commander<br>— Valley Irriga-<br>tion Pakistan|Ofers remote monitoring and<br>SMS/Email alerts.|Does not ofer smart irrigation<br>and is mainly available for large<br>commercial farms.|
|Smart<br>IoT<br>Farm<br>at PMAS–AAUR,<br>Rawalpindi|University research farm with<br>sensors (e.g., soil moisture)<br>and real-time IoT monitoring to<br>demonstrate precision agricul-<br>ture.|No dedicated mobile applica-<br>tion for farmers, no AI-based<br>decision support, and no auto-<br>mated irrigation.|



The Smart AI Powered Agriculture System aims to combine IoT-based sensing, automatic irrigation, mobile app support, and AI-driven crop recommendations in a single affordable solution targeted at small and medium farmers. 

## **1.3. Problem Statement** 

Agriculture is the main source of income and food in many countries, especially in developing regions. Many farmers depend on farming for their livelihood, but they face challenges such as water wastage, unpredictable weather, limited access to real-time information, and lack of proper guidance for choosing crops or managing their fields [1]. Traditional farming methods often result in over-watering or under-watering, loss of soil nutrients, and low 

Introduction 

3 

crop production [4]. Even though modern technology is available, many small and medium farmers cannot afford or access smart farming tools. There is a need for an affordable and easy-to-use smart agriculture system that uses IoT and AI to monitor the environment, save resources such as water and energy, and provide useful recommendations to farmers. 

## **1.4. Business Scope** 

The Smart AI Powered Agriculture System has strong potential in the agriculture sector of Pakistan. Since many farmers face problems like water wastage, low crop yield, and lack of modern tools, this system provides an affordable and simple solution. 

By offering IoT-based smart farming kits (sensors, controller, and mobile application), farmers can save water, achieve better crop production, and make smarter decisions. The system can be adopted by small and medium farmers and can also be promoted through government programs, non-governmental organizations (NGOs), and agriculture companies. The idea has strong business value because it directly improves farmers’ income and supports food security. 

_Table 1-2: Lean Canvas_ 

|**Problem**|**Solution**|**Unique Value Proposition**|
|---|---|---|
|1.<br>Water wastage due to<br>over-irrigation.|1. IoT sensors for soil and<br>weather.|An afordable smart farm-<br>ing kit that saves water,|
|2.<br>Low crop yield from|2.<br>Automatic irrigation|increases yield, and helps|
|poor crop choice.|system.|farmers make better crop|
|3. Lack of afordable smart<br>farming tools.|3.<br>Mobile app with AI-<br>based crop suggestion.|decisions.|
|**Existing Alternatives**|**Key Metrics (Approx.)**|**High-Level Concept**|
|1. Manual irrigation.<br>2. Expensive imported sys-<br>tems.|1.<br>100+ farmers use the<br>system.<br>2. 45% water savings (est.).<br>3.<br>35% increase in yield<br>(est.).|A smart farming assistant<br>for every farmer, like a<br>personal digital guide for<br>crops.|
|**Channels**|**Cost Structure**|**Customer Segments**|
|1. Direct sales to farmers.<br>2. Partnerships with NGOs<br>and government programs.|1. IoT hardware (sensors,<br>controllers).<br>2. Mobile app and server|1. Small and medium farm-<br>ers.<br>2. Agriculture NGOs and|
|3. Agriculture supply com-|hosting.|government projects.|
|panies.|3. Installation and support.||
|**Early Adopters**|**Revenue Structure**||



_Continued on next page_ 

Introduction 

4 

1. Farmers with 1–4 acres 1. Selling hardware kits. of land. 2. Subscription for premium app features. 2. NGOs running pilot 3. Installation and training services. agriculture projects. 

## **1.5. Useful Tools and Technologies** 

The key hardware and software components for the Smart AI Powered Agriculture System are: 

### **1.5.1. Hardware** 

The hardware architecture is anchored by the ESP32 microcontroller, which serves as the central processing unit equipped with built-in Wi-Fi capabilities to facilitate seamless sensor data processing and transmission [8]. To accurately monitor the environmental conditions, a capacitive soil moisture sensor (YL-69) is deployed to detect the volumetric water content in the soil. Additionally, a DHT22 sensor provides high-precision measurements of ambient temperature and humidity, while a Light Dependent Resistor (LDR) continuously monitors the sunlight intensity essential for optimal crop growth. To prevent over-watering during natural precipitation, a rain sensor (FC-37) is integrated into the system. Actuation is managed by a dedicated relay module that safely controls the higher-voltage water pump based on the microcontroller’s logic. 

### **1.5.2. Software** 

The software ecosystem spans multiple layers, beginning with the firmware developed using C++ in the Arduino IDE to program the ESP32 microcontroller. At the backend, a robust Node.js server is deployed to efficiently handle incoming telemetry data from the field sensors and manage bi-directional communication with the mobile application. All sensor readings, historical records, and user configurations are persistently stored in a normalized MySQL relational database. For the frontend user experience, a cross-platform mobile application is developed using the Flutter framework (or native Android Java/Kotlin), which presents live data, historical trends, and system alerts through an intuitive interface. To enhance the analytical value of the data, visualization libraries (Chart.js) is utilized to render dynamic graphs and charts. Furthermore, real-time push notifications regarding critical field conditions are delivered to the farmers via Firebase Cloud Messaging [9]. 

5 

Introduction 

### **1.5.3. AI and Machine Learning** 

The predictive intelligence of the system is driven by a machine learning module developed in Python’s Random Forest Classifier model to generate accurate crop recommendations and conduct predictive analytics based on historical environmental data [5]. To ensure the high fidelity of the inputs fed into the models, advanced signal processing techniques are applied to filter out noise and clean the raw sensor data prior to analysis. 

## **1.6. Project Work Break Down** 

The project is divided into multiple phases to ensure systematic development, testing, and deployment. Rather than treating the system as a single monolithic build, the Work Breakdown Structure (WBS) decouples the architecture into discrete, parallelizable engineering tracks [10]. 

The core tracks include: (1) Hardware and Firmware, encompassing the ESP32 sensor integration and the 3-tier polling safety logic; (2) Backend Infrastructure, focusing on the Node.js API and MySQL relational database schema; (3) Artificial Intelligence, detailing the synthesis of the Gaussian dataset and the training of the Random Forest classifier; and (4) Frontend Application, covering the Flutter mobile interface for live dashboard monitoring and manual irrigation control. 

To address the detailed task distribution, Table 1-3 outlines the formal Work Breakdown Structure with specific task ownership across the team members (Muhammad Awais, Hamza Bashir, Junaid Amin), explicit phase durations, and deliverables. 

_Table 1-3: Detailed Work Breakdown Structure with Ownership_ 

|**ID**|**Task / Phase**|**Duration**|**Ownership**|**Deliverable**|
|---|---|---|---|---|
|**1**|**Hardware**<br>**&**<br>**Firmware**|**4 Weeks**|**Hamza Bashir**|**Physical**<br>**prototype**<br>**&**<br>**ESP32 Code**|
|1.1|Sensor Calibration|1 Week|Hamza Bashir|Calibrated<br>DHT22<br>and<br>Moisture inputs|
|1.2|Actuator Integration|1 Week|Hamza Bashir|Functional relay control for<br>pump<br>Continued on next page|



6 

Introduction 

Table 1-3 – Continued from previous page 

|**ID**|**Task / Phase**|**Duration**|**Ownership**|**Deliverable**|
|---|---|---|---|---|
|1.3|ESP32 Firmware|2 Weeks|Hamza Bashir|Stable Wi-Fi telemetry and<br>control loop|
|**2**|**Backend**<br>**&**<br>**Database**|**4 Weeks**|**Junaid Amin**|**Deployed API & MySQL**<br>**Schema**|
|2.1|Database Design|1 Week|Junaid Amin|Normalized<br>schema<br>de-<br>ployed to server|
|2.2|REST API Dev|2 Weeks|Junaid Amin|Endpoints<br>for<br>telemetry<br>and control|
|2.3|Authentication|1 Week|Junaid Amin|Secure JWT login and feld<br>mapping|
|**3**|**AI**<br>**&**<br>**Machine**<br>**Learning**|**3 Weeks**|**Muhammad Awais**|**Trained**<br>**Scikit-Learn**<br>**Model**|
|3.1|Dataset Preparation|1 Week|Muhammad Awais|Dataset<br>generation<br>and<br>cleaning|
|3.2|Model Training|1 Week|Muhammad Awais|Tuned<br>Random<br>Forest<br>(n_estimators=150)|
|3.3|API Integration|1 Week|Muhammad Awais|Wrapper returning conf-<br>dence score|
|**4**|**Frontend Applica-**<br>**tion**|**4 Weeks**|**Team**|**Compiled Flutter APK**|
|4.1|UI Mockups & Flow|1 Week|Junaid Amin|Figma<br>designs<br>for<br>all<br>screens|
|4.2|Core Development|2 Weeks|Team|FlutterUIand backendAPI<br>binding|
|4.3|System Testing|1 Week|Hamza Bashir|Passed test cases across de-<br>vices|



Introduction 

7 

## **1.7. Project Time Line** 

The project timeline spans from 29 September 2025 to 10 July 2026. The schedule allocates dedicated time blocks for isolated component development followed by rigorous integration phases. For instance, the AI model training phase occurs concurrently with backend API development, ensuring that the prediction endpoints are immediately consumable once the model achieves its target accuracy metrics. Similarly, firmware development prioritizes local offline safety logic before network connectivity is fully integrated, reducing critical path dependencies. 

To provide a precise technical schedule, Table 1-4 breaks down the project timeline into formal milestones, mapping durations to exact dates, defining cross-component dependencies, and establishing strict team ownership. 

_Table 1-4: Formal Project Schedule_ 

|**ID**|**Milestone**|**Start**|**End**|**Depends On**|**Owner**|
|---|---|---|---|---|---|
|**M1**|Requirement Specifcations|29 Sep 25|12 Oct 25|–|Team|
|**M2**|Hardware Design|13 Oct 25|02 Nov 25|M1|Hamza|
|**M3**|Backend & Database|03 Nov 25|30 Nov 25|M1|Junaid|
|**M4**|AI Dataset Preparation|13 Oct 25|26 Oct 25|M1|Awais|
|**M5**|ESP32 Firmware|03 Nov 25|23 Nov 25|M2|Hamza|
|**M6**|AI Model Training|27 Oct 25|16 Nov 25|M4|Awais|
|**M7**|API Integration|01 Dec 25|21 Dec 25|M3, M5, M6|Team|
|**M8**|Mobile App UI|22 Dec 25|18 Jan 26|M1|Junaid|
|**M9**|System Integration|19 Jan 26|15 Mar 26|M7, M8|Team|
|**M10**|Testing & Fixing|16 Mar 26|10 May 26|M9|Hamza|
|**M11**|Final Deployment|11 May 26|10 Jul 26|M10|Team|



8 

# **Chapter 2** 

# **2. Requirement Specification and Analysis** 

This chapter describes the functional requirements of the Smart AI Powered Agriculture System in terms of epics, user stories, test cases, user interface design, and a traceability matrix [10]. 

## **2.1. Epics** 

Epics are large, high-level features that represent significant functionalities of the system [11]. Each epic is later broken down into multiple user stories. 

### **2.1.1. E1: User Authentication and Profile Management** 

**Description:** As a farmer or administrator, the user wants to securely log in, register, and manage their profile so that data and farm configurations remain private and secure [12]. 

### **2.1.2. E2: Real-Time Sensor Data Monitoring** 

**Description:** As a farmer, the user wants to monitor real-time environmental data (soil moisture, temperature, humidity) from the fields so that informed decisions can be made about crop care [13]. 

### **2.1.3. E3: Intelligent Irrigation Control** 

**Description:** As a farmer, the user wants to control irrigation systems manually or set automatic triggers based on sensor thresholds so that water usage is optimized and crops receive adequate hydration [14]. 

### **2.1.4. E4: AI-Driven Crop Recommendations** 

**Description:** As a farmer, the user wants to receive AI-generated crop recommendations based on soil and weather analysis so that yield can be maximized and the most suitable crops for the season can be selected [5]. 

Requirement Specification and Analysis 

9 

### **2.1.5. E5: Alerting and Notification System** 

**Description:** As a farmer, the user wants to receive immediate alerts about critical conditions (e.g., low soil moisture, sensor failure) so that timely corrective actions can be taken to prevent crop damage. 

### **2.1.6. E6: Historical Data Analytics and Visualization** 

**Description:** As a farmer, the user wants to view historical trends and graphical visualizations of farm data so that long-term patterns can be analyzed and farming strategies improved [13]. 

## **2.2. User Stories** 

To bridge the gap between high-level project goals and actionable technical development, each Epic is decomposed into smaller, discrete User Stories [11]. These stories define the exact interaction boundaries between the end-user (farmer or administrator) and the system components (e.g., the Flutter application, the Node.js backend, or the ESP32 hardware). Each story is accompanied by explicit acceptance criteria, forming the foundational contract for the subsequent system testing phase. 

### **2.2.1. Epic E1: User Authentication and Profile Management** 

**E1-US1: User Registration** As a new user, the user wants to create an account using email and phone number so that system features can be accessed. **Acceptance Criteria:** The acceptance criteria dictate that given the user is on the registration screen, When valid name, email, phone, and password are entered, Then the system should create a new account and redirect to the login page. 

**E1-US2: Secure Login** As a registered user, the user wants to log in using credentials so that the personal dashboard can be accessed [15]. **Acceptance Criteria:** The acceptance criteria dictate that given the user has a valid account, When the correct email and password are entered, Then the system should authenticate the user and grant access to the dashboard. 

**E1-US3: Profile Management** As a user, the user wants to update personal information and change the password so that account details remain current and secure. 

Requirement Specification and Analysis 

10 

**Acceptance Criteria:** The acceptance criteria dictate that given the user is logged in, When the user navigates to profile settings and updates the phone number, Then the system should save the changes and display a success message. 

### **2.2.2. Epic E2: Real-Time Sensor Data Monitoring** 

**E2-US1: View Field Overview Description:** As a farmer, the user wants to see a list of all fields with their current status so that the overall farm health can be assessed quickly. 

**Acceptance Criteria:** The acceptance criteria dictate that given the user is on the dashboard, When the page loads, Then the system should display all registered fields with summary indicators such as “Healthy” or “Needs Water”. 

**E2-US2: Detailed Sensor Readings Description:** As a farmer, the user wants to view specific readings from individual sensors (e.g., Sensor ID 14) so that issues in specific areas can be pinpointed [13]. 

**Acceptance Criteria:** The acceptance criteria dictate that given the user selects a specific field, When a sensor node is tapped, Then the system should show the latest values for soil moisture, temperature, and humidity. 

**E2-US3: Sensor Status Monitoring Description:** As a farmer, the user wants to know if a sensor is offline or has low battery so that maintenance can be performed. **Acceptance Criteria:** The acceptance criteria dictate that given a sensor has stopped sending data, When the user views the sensor list, Then the system should display an “Offline” status indicator next to that sensor. 

### **2.2.3. Epic E3: Intelligent Irrigation Control** 

**E3-US1: Manual Irrigation Toggle Description:** As a farmer, the user wants to remotely turn the water pump on or off so that the field can be irrigated immediately when needed [14]. 

**Acceptance Criteria:** The acceptance criteria dictate that given the irrigation system is connected, When the user presses the “Start Irrigation” button, Then the system should send a command to the actuator and update the status to “Irrigating”. 

**E3-US2: Threshold-Based Automation Description:** As a farmer, the user wants to set a soil moisture threshold (e.g., 30%) so that the system automatically irrigates when the soil becomes too dry [4]. 

Requirement Specification and Analysis 

11 

**Acceptance Criteria:** The acceptance criteria dictate that given the automation mode is enabled, When soil moisture drops below the defined threshold, Then the system should automatically trigger the irrigation pump without user intervention. 

**E3-US3: Irrigation Logging Description:** As a farmer, the user wants to see a history of irrigation events so that water usage can be tracked. 

**Acceptance Criteria:** The acceptance criteria dictate that given an irrigation cycle has completed, When the user views the irrigation logs, Then the system should list the start time, end time, and total duration of each event. 

### **2.2.4. Epic E4: AI-Driven Crop Recommendations** 

**E4-US1: Request Crop Recommendation Description:** As a farmer, the user wants to request a crop recommendation based on the field’s current soil data so that the most viable crop can be planted [5]. 

**Acceptance Criteria:** The acceptance criteria dictate that given the user is on the recommendation screen, When the “Analyze Field” button is clicked, Then the system should process the soil parameters and display a recommended crop (e.g., “Wheat”). 

**E4-US2: View Recommendation Confidence Description:** As a farmer, the user wants to see the confidence score of the AI prediction so that trust in the recommendation can be established. 

**Acceptance Criteria:** The acceptance criteria dictate that given a recommendation is generated, When the result is displayed, Then the system should show a percentage confidence score (e.g., “85% Confidence”). 

**E4-US3: Accept Recommendation Description:** As a farmer, the user wants to mark a recommendation as “Accepted” so that the system tracks what has actually been planted. **Acceptance Criteria:** The acceptance criteria dictate that given a recommendation is displayed, When the user clicks “Accept”, Then the field’s current crop status should be updated to match the recommendation. 

### **2.2.5. Epic E5: Alerting and Notification System** 

**E5-US1: Critical Threshold Alerts Description:** As a farmer, the user wants to receive a notification when soil moisture is critically low so that crops do not die due to lack of water [9]. 

Requirement Specification and Analysis 

12 

**Acceptance Criteria:** The acceptance criteria dictate that given the soil moisture is below the critical limit, When the sensor transmits the data, Then the system should generate a “Critical Alert” and notify the user. 

**E5-US2: View Unread Alerts Description:** As a farmer, the user wants to see a badge count of unread alerts so that any missed information is visible. 

**Acceptance Criteria:** The acceptance criteria dictate that given there are new alerts, When the user opens the app, Then the notification icon should show a badge with the number of unread items. 

**E5-US3: Resolve Alerts Description:** As a farmer, the user wants to mark an alert as resolved so that the notification feed can be cleared. 

**Acceptance Criteria:** The acceptance criteria dictate that given an active alert exists, When the user clicks “Mark as Resolved”, Then the alert should be moved to the history archive and its status updated. 

### **2.2.6. Epic E6: Historical Data Analytics and Visualization** 

**E6-US1: View Moisture Trends Description:** As a farmer, the user wants to see a line graph of soil moisture over the last week so that drying patterns can be understood. **Acceptance Criteria:** The acceptance criteria dictate that given historical data exists, When the user selects the “Weekly View” on the chart, Then the system should render a line graph showing moisture levels over the past 7 days. 

**E6-US2: Export Data Description:** As a farmer, the user wants to export farm data so that offline records can be kept. 

**Acceptance Criteria:** The acceptance criteria dictate that given the user is on the analytics screen, When the “Export” button is clicked, Then the system should generate a downloadable report (e.g., CSV or PDF). 

**E6-US3: Compare Fields Description:** As a farmer, the user wants to compare the water usage of two different fields so that inefficiencies can be identified. 

**Acceptance Criteria:** The acceptance criteria dictate that given the user selects two fields, When the “Compare” option is chosen, Then the system should display side-by-side statistics for both fields. 

Requirement Specification and Analysis 

13 

## **2.3. Test-cases** 

To ensure rigorous validation of the developed system against the defined requirements, this section outlines the formal test cases mapped directly to the user stories [16]. Rather than relying solely on ad-hoc manual testing, these test cases define deterministic inputs—such as simulated ADC thresholds or mocked REST API payloads—and the exact expected state changes within the database or firmware. The tables below document the objective, preconditions, inputs, and actual validated outcomes for each core module. 

### **2.3.1. Test Case 1 — Verify User Registration with Valid Data** 

This test case verifies the user registration process. It checks whether the system correctly accepts valid user details, creates a new user account, stores the information in the database, and redirects the user to the login page successfully. 

_Table 2-1: Verify User Registration with Valid Data_ 

|**Test ID**|TC-E1-US1-01|
|---|---|
|**User Story ID**|E1-US1|
|**Module**|User Authentication and Registration|
|**Test Case Description**|Verify that a new user can successfully register<br>using valid credentials and personal informa-<br>tion.|
|**Preconditions**|User is on the registration screen and backend<br>server is operational.|
|**Test Inputs**|Name = “Ali Khan”<br>Email = “ali@test.com”<br>Phone = “+923001234567”<br>Password = “Pass123”|
|**Expected Result**|A new user account should be created success-<br>fully in the`users`table and the user should be<br>redirected to the login page.|
|**Actual Result**|User account was created successfully and redi-<br>rected to the login page correctly.|
|**Status**|Pass|



Requirement Specification and Analysis 

14 

### **2.3.2. Test Case 2 — Verify Login with Valid Credentials** 

This test case validates the login functionality and ensures that a registered user can access the dashboard using valid credentials [15]. 

_Table 2-2: Verify Login with Valid Credentials_ 

|**Test ID**|TC-E1-US2-01|
|---|---|
|**User Story ID**|E1-US2|
|**Module**|User Authentication|
|**Test Case Description**|Verify that a registered user can log into the<br>system successfully using valid credentials.|
|**Preconditions**|User account already exists in the system<br>database.|
|**Test Inputs**|Email = “ali@test.com”<br>Password = “Pass123”|
|**Expected Result**|System authenticates the user, generates JWT<br>token, and redirects to dashboard with HTTP<br>200 OK response.|
|**Actual Result**|User was authenticated successfully and dash-<br>board loaded correctly with valid JWT token.|
|**Status**|Pass|



### **2.3.3. Test Case 3 — Verify Profile Management** 

This test case verifies that a logged-in user can update profile information successfully. 

_Table 2-3: Verify Profile Management_ 

|**Test ID**|TC-E1-US3-01|
|---|---|
|**User Story ID**|E1-US3|
|**Module**|Profle Management|
|**Test Case Description**|Verify that the user can update personal profle<br>information successfully.|



15 

Requirement Specification and Analysis 

|**Preconditions**|User is logged in and profle screen is accessible.|
|---|---|
|**Test Inputs**|Updated Phone = “+923009876543”|
|**Expected Result**|Updated profle information should be saved in<br>the`users`table and success message should be<br>displayed.|
|**Actual Result**|Profle information was updated successfully|
||and success message was displayed.|
|**Status**|Pass|



### **2.3.4. Test Case 4 — Verify Field Overview Display** 

This test case verifies that the dashboard displays all registered fields with their current status. 

_Table 2-4: Verify Field Overview Display_ 

|**Test ID**|TC-E2-US1-01|
|---|---|
|**User Story ID**|E2-US1|
|**Module**|Real-Time Sensor Data Monitoring|
|**Test Case Description**|Verify that all registered felds are displayed on<br>the dashboard with their current status.|
|**Preconditions**|User is logged in and felds are registered in the<br>system.|
|**Test Inputs**|User opens the dashboard screen.|
|**Expected Result**|Dashboard should display all registered felds<br>with status indicators such as “Healthy” or<br>“Needs Water”.|
|**Actual Result**|Registered felds were displayed successfully<br>with correct status indicators.|
|**Status**|Pass|



16 

Requirement Specification and Analysis 

### **2.3.5. Test Case 5 — Verify Real-Time Data Display** 

This test case verifies that real-time sensor readings are correctly displayed on the dashboard interface [13]. 

_Table 2-5: Verify Real-Time Data Display_ 

|**Test ID**|TC-E2-US2-01|
|---|---|
|**User Story ID**|E2-US2|
|**Module**|Real-Time Monitoring|
|**Test Case Description**|Verify that the latest sensor readings are cor-<br>rectly displayed on the user interface.|
|**Preconditions**|ESP32 device is connected and sending teleme-<br>try to backend server.|
|**Test Inputs**|Sensor ID = 14<br>Moisture = 45%<br>Temperature = 30<sup>◦</sup>C|
|**Expected Result**|Dashboard should display updated moisture and<br>temperature values matching the sensor readings<br>stored in the database.|
|**Actual Result**|Dashboard displayed “Moisture:<br>45%” and<br>“Temperature: 30<sup>◦</sup>C” correctly.|
|**Status**|Pass|



### **2.3.6. Test Case 6 — Verify Sensor Status Monitoring** 

This test case verifies that the system detects and displays sensor status correctly. 

_Table 2-6: Verify Sensor Status Monitoring_ 

|**Test ID**|TC-E2-US3-01|
|---|---|
|**User Story ID**|E2-US3|
|**Module**|Sensor Status Monitoring|



Requirement Specification and Analysis 

17 

|**Test Case Description**|Verify that the system displays ofine status<br>when a sensor stops sending data.|
|---|---|
|**Preconditions**|Sensor is registered in the system and dashboard<br>is accessible.|
|**Test Inputs**|Sensor ID = 14 stops sending telemetry data.|
|**Expected Result**|System should mark the sensor status as “Of-<br>fine” on the dashboard or sensor detail page.|
|**Actual Result**|Sensor status changed to “Ofine” successfully<br>when telemetry was not received.|
|**Status**|Pass|



### **2.3.7. Test Case 7 — Verify Manual Pump Start** 

This test case verifies the manual irrigation control functionality from the mobile application [14]. 

_Table 2-7: Verify Manual Pump Start_ 

|**Test ID**|TC-E3-US1-01|
|---|---|
|**User Story ID**|E3-US1|
|**Module**|Irrigation Control System|
|**Test Case Description**|Verify that the irrigation pump starts success-<br>fully when triggered manually by the user.|
|**Preconditions**|ESP32 device and relay module are connected<br>and operational.|
|**Test Inputs**|User clicks “Start Irrigation” button for Field ID<br>= 6.|
|**Expected Result**|System should activate the relay, update pump<br>status to “ON”, and create a new irrigation log<br>entry.|
|**Actual Result**|Pump activated successfully and irrigation sta-<br>tus updated correctly in the application.|



Requirement Specification and Analysis 

18 

|**Status**<br>Pass|
|---|



### **2.3.8. Test Case 8 — Verify Automatic Trigger on Low Moisture** 

This test case validates the automatic irrigation functionality based on soil moisture thresholds [4]. 

_Table 2-8: Verify Automatic Trigger on Low Moisture_ 

|**Test ID**|TC-E3-US2-01|
|---|---|
|**User Story ID**|E3-US2|
|**Module**|Automated Irrigation Control|
|**Test Case Description**|Verify that the system automatically starts irri-<br>gation when soil moisture falls below the con-<br>fgured threshold.|
|**Preconditions**|Auto-irrigation mode is enabled and threshold<br>is confgured.|
|**Test Inputs**|Threshold = 30%<br>Simulated Moisture Reading = 25%|
|**Expected Result**|System should automatically activate irrigation<br>pump and generate a low moisture alert notif-<br>cation.|
|**Actual Result**|Irrigation triggered automatically and alert no-<br>tifcation generated successfully.|
|**Status**|Pass|



### **2.3.9. Test Case 9 — Verify Irrigation Logging** 

This test case verifies that irrigation events are properly recorded after completion. 

_Table 2-9: Verify Irrigation Logging_ 

|**Test ID**|TC-E3-US3-01|
|---|---|
|**User Story ID**|E3-US3|



Requirement Specification and Analysis 

19 

|**Module**|Irrigation Logs|
|---|---|
|**Test Case Description**|Verify that completed irrigation cycles are<br>stored in irrigation history.|
|**Preconditions**|Irrigation cycle has been started and completed<br>successfully.|
|**Test Inputs**|User opens irrigation history/logs for Field ID =<br>6.|
|**Expected Result**|System should display irrigation start time,<br>end<br>time,<br>duration,<br>and<br>pump<br>status<br>in<br>`irrigation_logs`.|
|**Actual Result**|Irrigation log was created and displayed suc-<br>cessfully with correct event details.|
|**Status**|Pass|



### **2.3.10. Test Case 10 — Verify Crop Recommendation Generation** 

This test case verifies the AI-based crop recommendation functionality [5]. 

_Table 2-10: Verify Crop Recommendation Generation_ 

|**Test ID**|TC-E4-US1-01|
|---|---|
|**User Story ID**|E4-US1|
|**Module**|AI Crop Recommendation System|
|**Test Case Description**|Verify that the AI model generates a suitable<br>crop recommendation based on feld conditions.|
|**Preconditions**|AI recommendation service is active and histor-<br>ical feld data is available.|
|**Test Inputs**|Field ID = 6<br>Soil Type = Loamy<br>Season = Rabi|



Requirement Specification and Analysis 

20 

|**Expected Result**|System should generate crop recommendation|
|---|---|
||with confdence score and store the result in the<br>database.|
|**Actual Result**|System recommended “Wheat” with confdence|
||score successfully.|
|**Status**|Pass|



### **2.3.11. Test Case 11 — Verify Recommendation Confidence Score** 

This test case verifies that the confidence score is displayed with the AI-generated crop recommendation. 

_Table 2-11: Verify Recommendation Confidence Score_ 

|**Test ID**|TC-E4-US2-01|
|---|---|
|**User Story ID**|E4-US2|
|**Module**|AI Crop Recommendation System|
|**Test Case Description**|Verify that the system displays a confdence per-<br>centage with the recommended crop.|
|**Preconditions**|Crop recommendation has been generated suc-<br>cessfully.|
|**Test Inputs**|User views generated recommendation result for<br>Field ID = 6.|
|**Expected Result**|System should display recommended crop with<br>confdence score, for example “Wheat – 85%<br>Confdence”.|
|**Actual Result**|Recommended crop and confdence score were<br>displayed successfully.|
|**Status**|Pass|



### **2.3.12. Test Case 12 — Verify Accept Recommendation** 

This test case verifies that the user can accept an AI-generated crop recommendation. 

Requirement Specification and Analysis 

21 

_Table 2-12: Verify Accept Recommendation_ 

|**Test ID**|TC-E4-US3-01|
|---|---|
|**User Story ID**|E4-US3|
|**Module**|AI Crop Recommendation System|
|**Test Case Description**|Verify that accepting a crop recommendation<br>updates the feld crop status.|
|**Preconditions**|A crop recommendation is already displayed on<br>the recommendation screen.|
|**Test Inputs**|User clicks “Accept” on the recommendation<br>result “Wheat”.|
|**Expected Result**|Field crop status should be updated to the ac-<br>cepted crop and recommendation should be<br>marked as accepted in the database.|
|**Actual Result**|Recommendation was accepted successfullyand<br>feld crop status was updated.|
|**Status**|Pass|



### **2.3.13. Test Case 13 — Verify Critical Alert Delivery** 

This test case verifies the notification and alert generation system [9]. 

_Table 2-13: Verify Critical Alert Delivery_ 

|**Test ID**|TC-E5-US1-01|
|---|---|
|**User Story ID**|E5-US1|
|**Module**|Alerts and Notifcations|
|**Test Case Description**|Verify that the system generates and displays<br>alerts for critical moisture conditions.|
|**Preconditions**|Notifcation service and backend alert system<br>are operational.|
|**Test Inputs**|Moisture Reading = 10% (Critical threshold <<br>15%)|



Requirement Specification and Analysis 

22 

|**Expected Result**|System should create a critical alert record and|
|---|---|
||display notifcation badge on the dashboard.|
|**Actual Result**|Critical alert generated successfully and notif-|
||cation displayed on user interface.|
|**Status**|Pass|



### **2.3.14. Test Case 14 — Verify Unread Alert Count** 

This test case verifies that unread alerts are counted and displayed correctly. 

_Table 2-14: Verify Unread Alert Count_ 

|**Test ID**|TC-E5-US2-01|
|---|---|
|**User Story ID**|E5-US2|
|**Module**|Alerts and Notifcations|
|**Test Case Description**|Verify that the notifcation icon displays the cor-<br>rect unread alert count.|
|**Preconditions**|At least one unread alert exists in the system.|
|**Test Inputs**|User opens the application dashboard.|
|**Expected Result**|Notifcation icon should display badge count ac-<br>cording to the number of unread alerts.|
|**Actual Result**|Notifcation badge displayed the correct unread<br>alert count successfully.|
|**Status**|Pass|



### **2.3.15. Test Case 15 — Verify Resolve Alert Functionality** 

This test case verifies that users can mark alerts as resolved. 

_Table 2-15: Verify Resolve Alert Functionality_ 

|**Test ID**|TC-E5-US3-01|
|---|---|
|**User Story ID**|E5-US3|



Requirement Specification and Analysis 

23 

|**Module**|Alerts and Notifcations|
|---|---|
|**Test Case Description**|Verify that an active alert can be marked as re-<br>solved by the user.|
|**Preconditions**|An active unresolved alert exists in the alerts list.|
|**Test Inputs**|User clicks “Mark as Resolved” on a low mois-<br>ture alert.|
|**Expected Result**|Alert status should be updated as resolved and<br>moved to alert history.|
|**Actual Result**|Alert was marked as resolved successfully and<br>removed from active alerts list.|
|**Status**|Pass|



### **2.3.16. Test Case 16 — Verify Weekly Trend Graph** 

This test case validates historical data visualization and trend graph generation. 

_Table 2-16: Verify Weekly Trend Graph_ 

|**Test ID**|TC-E6-US1-01|
|---|---|
|**User Story ID**|E6-US1|
|**Module**|Historical Analytics and Visualization|
|**Test Case Description**|Verify that the weekly moisture trend graph dis-<br>plays accurate historical data points.|
|**Preconditions**|Historical sensor data for the previous 7 days<br>exists in the database.|
|**Test Inputs**|User selects “Last 7 Days” flter from analytics<br>dashboard.|
|**Expected Result**|System should render line chart with correct<br>moisture readings and date labels for the pre-<br>vious week.|
|**Actual Result**|Weekly trend graph displayed correctly with ac-<br>curate data points and timestamps.|



Requirement Specification and Analysis 

24 

|**Status**<br>Pass|
|---|



### **2.3.17. Test Case 17 — Verify Data Export** 

This test case verifies that the user can export farm data for offline record keeping. 

_Table 2-17: Verify Data Export_ 

|**Test ID**|TC-E6-US2-01|
|---|---|
|**User Story ID**|E6-US2|
|**Module**|Historical Analytics and Reporting|
|**Test Case Description**|Verify that the user can export historical farm<br>data successfully.|
|**Preconditions**|Historical sensor readings are available in the<br>database.|
|**Test Inputs**|User clicks “Export” button on analytics screen.|
|**Expected Result**|System should generate downloadable report fle<br>in CSV or PDF format.|
|**Actual Result**|Farm data report was generated and downloaded<br>successfully.|
|**Status**|Pass|



### **2.3.18. Test Case 18 — Verify Field Comparison** 

This test case verifies that users can compare two fields using historical data. 

_Table 2-18: Verify Field Comparison_ 

|**Test ID**|TC-E6-US3-01|
|---|---|
|**User Story ID**|E6-US3|
|**Module**|Historical Analytics and Visualization|
|**Test Case Description**|Verify that the system compares water usage and<br>sensor statistics of two diferent felds.|



25 

Requirement Specification and Analysis 

|**Preconditions**|At least two felds with historical sensor and<br>irrigation data exist in the system.|
|---|---|
|**Test Inputs**|Field A = Field ID 6<br>Field B = Field ID 7|
|**Expected Result**|System should display side-by-side comparison<br>of moisture trends, water usage, and feld statis-<br>tics.|
|**Actual Result**|Field comparison was displayed successfully<br>with correct side-by-side statistics.|
|**Status**|Pass|



## **2.4. User Interface Implementation (Screenshots)** 

User Interface (UI) design focuses on simplicity, clarity, and ease of use for farmers [17]. The following figures are actual screenshots captured from the fully functional Flutter mobile application running on a real device. They illustrate the main screens of the implemented system, covering all 18 primary user flows. 



<!-- Start of picture text -->
2:31 (2) ell ad 288 Pale)<br><€ Create Account<br>Full Name<br>2 Test User<br>Email<br>{1 test@gmail.com<br>Phone Number<br>XR, 09978451332<br>Password<br>GQ) test123 ®<br>| Confirm Password<br>@Q test1 4 ® |<br><!-- End of picture text -->



<!-- Start of picture text -->
2:331@ & ollice +<br>5R<br>Smart Agriculture<br>Login to your account<br>Email<br>{1 test@gmail.com<br>| G)Passwordtest123| ® |<br>Don't have an account? Register<br><!-- End of picture text -->



<!-- Start of picture text -->
Edit Profile x<br>Full Name<br>Test User<br>Phone<br>01123456789<br>Address<br>abc<br>City<br>XYZ<br>Province<br>def<br>| 44000Postal Code |<br><!-- End of picture text -->



<!-- Start of picture text -->
2:40 @ ell 86 +o<br>= TestGood Afternoon falte<br>KN (c+) r A<br>1 1 310 3<br>Fields Sensors Al Tips Issues<br>Field Conditions<br>2 North Field v<br>8 Moisture Temperature<br>0.0% a 27.2°C<br>Humidity oe Light<br>@ -@-<br>52.2% “4.0%<br>.. _ Rainfall Pump<br>“Clear<br>Quick Actions<br>@ AddField > == Irrigation ><br>7’ x O DG QA 8<br>Dashboard Fields Irrigation Tips Alerts Profile<br><!-- End of picture text -->



<!-- Start of picture text -->
2:41@ ethan ge<br>= TestGood Afternoon falte<br>KN (1) 2 A<br>1 1 310 3<br>Fields Sensors Al Tips Issues<br>Field Conditions<br>2 North Field v<br>8 Moisture Temperature<br>0.0% a 27.2°C<br>Humidity oe Light<br>@ -@-<br>52.2% “4.0%<br>.. _ Rainfall Pump<br>“Clear<br>Quick Actions<br>@ AddField > == Irrigation ><br>7’ x O DG QA 8<br>Dashboard Fields Irrigation Tips Alerts Profile<br><!-- End of picture text -->



<!-- Start of picture text -->
2:43@ olla je 1D<br>€ North Field ?<br>Overview Sensors History<br>(+) ESP_32test (onaa. )<br>COMBINED<br><!-- End of picture text -->



<!-- Start of picture text -->
2:45@ & o allall fie HD<br>Irrigation<br>Control History<br>drops Be ow this value.<br>0% (Dry) 100% (Wet)<br>Water Pump<br>Manual Override<br>Pump OFF<br>4 Force Start Pump<br>mo 2% ® OG A 8<br>Dashboard —_ Fields Irrigation Tips Alerts Profile<br><!-- End of picture text -->



<!-- Start of picture text -->
2:44@ ° atlatlgs 1D<br>Irrigation<br>Control History<br>© Auto-Irrigate Threshold 30%<br>Pump automatically turns on when soil moisture<br>drops below this value.<br>0% (Dry) 100% (Wet)<br>Water Pump<br>Manual Override<br>Pump OFF<br>ama 2% ® dG QA 8<br>Dashboard —_ Fields Irrigation Tips Alerts Profile<br><!-- End of picture text -->

2:45@ & 

elle. +o 



<!-- Start of picture text -->
Irrigation<br><!-- End of picture text -->



<!-- Start of picture text -->
Control History<br>g MANUAL 6 ore<br>May 14, 2026 + 02:37 PM<br>© Duration: 0 min<br>g MANUAL —<br>May 14, 2026 + 02:36 PM<br>© Duration: 0 min<br>g MANUAL 6 ore<br>May 14, 2026 + 02:35 PM<br>© Duration: 0 min<br>g MANUAL _—<br>May 14, 2026 + 02:33 PM<br>© Duration: 0 min<br>g MANUAL sore<br>May 14, 2026 + 02:33 PM<br>© Duration: 0 min<br>OFa x ®@ gd jal &<br>Dashboard Fields Irrigation Tips Alerts Profile<br><!-- End of picture text -->



<!-- Start of picture text -->
Predict Best Crop<br>Choose the target season to<br>analyze based on current exact<br>sensor readings.<br>Target Season<br>Kharif (Summer/Monsoon)<br>Cancel +; Predict<br><!-- End of picture text -->



<!-- Start of picture text -->
2:48@ & ollie 1D<br>Al Crop Recommendations Cc<br>2< North Field v<br>+, Al SSO ENE UT<br>3 Kharif Season Crop<br>Al Confidence 88.6% — Very High<br>Oe<br>Sensor Data Used<br>= é ©<br>0.0% 29.0°C 50.7%<br>Moisture Temp Humidity<br>ic) Growth 180 days Period ® LowWater Need +<br>fo « O @ A &<br>Dashboard __ Fields Irrigation Tips Alerts Profile<br><!-- End of picture text -->



<!-- Start of picture text -->
2:48@ & oll oe +o<br>Al Crop Recommendations Cc<br>@ Growth Period Water Need<br>180 days ® Low<br>ae Est. Yield ¢ Soil Type<br>1200 kg/acre Loamy<br>® Based on soil moisture (0.0%),<br>temperature (28.98C), humidity<br>(50.66%), loamy soil, and Kharif<br>season conditions, Cotton is the most<br>optimal crop.<br>Alternative options for this season:<br>- Sunflower (10.39%)<br>- Chickpea (0.76%)<br>- Maize (0.24%)<br>Environmental alerts:<br>If temp was -4C cooler, Sunflower<br>would be recommended.<br>Model v1.0.2 ( May 14, 2026<br>@ Accept This Recommendation<br>Previous Recommendations +7<br>fta % oO @ o 28<br>Dashboard __ Fields Irrigation Tips Alerts Profile<br><!-- End of picture text -->



<!-- Start of picture text -->
2:48@ & oll a” wD<br>Alerts e)<br>3 Frost Warning °<br>May 14, 2026 + 02:30 PM<br>Temperatures have dropped to 0.0°C. Frost<br>damage possible.<br>Mark as Resolved<br>6 Waterlogging Risk )<br>May 14, 2026 + 12:31 AM<br>Soil moisture is dangerously high (100.0%).<br>Risk of root rot.<br>Mark as Resolved<br>rs Severe Drought Risk e<br>May 14, 2026 + 12:24 AM<br>Soil moisture is critically low (0.0%). Irrigation<br>required immediately to prevent crop<br>damage.<br>Mark as Resolved<br>tf « O DG f& 2&2<br>Dashboard _ Fields Irrigation Tips Alerts Profile<br><!-- End of picture text -->



<!-- Start of picture text -->
2:50@ & etal gh<br>Alerts C<br>3 Frost Warning e<br>May 14, 2026 - 02:30 PM<br>Temperatures have dropped to 0.0°C. Frost<br>damage possible.<br>@ Waterlogging Risk °<br>May 14, 2026 « 12:31 AM<br>Soil moisture is dangerously high (100.0%).<br>Risk of root rot.<br>6 Severe Drought Risk e<br>May 14, 2026 + 12:24 AM<br>Soil moisture is critically low (0.0%). Irrigation<br>required immediately to prevent crop<br>damage.<br>Mark as Resolved<br>tf « OO DG f& 2&2<br>Dashboard _ Fields Irrigation Tips Alerts Profile<br><!-- End of picture text -->



<!-- Start of picture text -->
2:49@ & o llalige 1<br>Alerts C<br>3 Frost Warning e<br>May 14, 2026 - 02:30 PM<br>Temperatures have dropped to 0.0°C. Frost<br>damage possible.<br>@ Waterlogging Risk °<br>May 14, 2026 « 12:31 AM<br>Soil moisture is dangerously high (100.0%).<br>Risk of root rot.<br>6 Severe Drought Risk e<br>May 14, 2026 + 12:24 AM<br>Soil moisture is critically low (0.0%). Irrigation<br>required immediately to prevent crop<br>damage.<br>Mark as Resolved<br>tf « OO DG f& 2&2<br>Dashboard _ Fields Irrigation Tips Alerts Profile<br><!-- End of picture text -->



<!-- Start of picture text -->
2:51@ & olla! gs CD<br>€ Historical Analytics<br>Weekly Moisture Trends | & Export<br>100<br>80<br>60 ~~~ ~~~<br>40<br>20 -------------~--------<br>0 OOOOOOO OO<br>Day1 Day4 Day7 Day10 Day13 Day16 Dapag20<br>Compare Fields<br>Field 1 Field2<br>North Field ~ | v |<br><!-- End of picture text -->



<!-- Start of picture text -->
2:51 @ & otha els +1Ga<br>€ Historical Analytics<br>Weekly Moisture Trends } & Export<br>100<br>80 ---------------------<br>60 ~--~---=======-=---<br>==<br>40<br>20<br>0 @-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-8<br>Day1 Day4 Day7 Day10 Day13 Day16 Dapag20<br>Compare Fields<br>Field 1 Field2<br>North Field ~ | v |<br><!-- End of picture text -->



<!-- Start of picture text -->
2:51@ & oll G8 +o<br>€ Historical Analytics<br>Weekly Moisture Trends } & Export<br>100<br>80 ~~ — — ee eeeee<br>60 —~————— =e<br>40<br>20<br>0 O00 OOOO<br>Day1 Day4 Day7 Day10 Day13 Day16 Dapay20<br>Compare Fields<br>Field 1 Field 2<br>North Field wv | North Field w |<br>0.0% Avg Moisture 0.0%<br>27.2°C Avg Temperature 27.2°C<br>OFF Current Pump<br>Status OFF<br>3 Total Alerts 3<br><!-- End of picture text -->

Requirement Specification and Analysis 

44 

**Navigation Behavior:** Regarding navigation behavior, change selector → instantly updates charts.. 

## **2.5. Traceability Matrix** 

The traceability matrix maps epics to user stories, test cases, and UI screens to ensure full coverage of requirements and proper validation [16]. 

_Table 2-19: Traceability Matrix_ 

|**Epic**|**User Story**|**Test Case**|**UI Screen**||
|---|---|---|---|---|
|E1 (Auth)|E1-US1 (Register)|TC-E1-US1-01|Login Scre<br>ister)|en (Reg-|
|E1 (Auth)|E1-US2 (Login)|TC-E1-US2-01|Login Scre|en|
|E1 (Auth)|E1-US3 (Profle)|N/A (Standard Up-<br>date)|Settings<br>/<br>Page|Profle|
|E2 (Monitor-<br>ing)|E2-US1 (Field Overview)|N/A<br>(Visual<br>Check)|Dashboard||
|E2 (Monitor-<br>ing)|E2-US2 (Sensor Detail)|TC-E2-US2-01|Detailed<br>Data Page|Sensor|
|E2 (Monitor-<br>ing)|E2-US3 (Status)|N/A (Status Check)|Dashboard<br>Page|/ Sensor|
|E3<br>(Irriga-<br>tion)|E3-US1 (Manual)|TC-E3-US1-01|Irrigation<br>Panel|Control|
|E3<br>(Irriga-<br>tion)|E3-US2 (Auto)|TC-E3-US2-01|Irrigation<br>Panel|Control|
|E3<br>(Irriga-<br>tion)|E3-US3 (Logs)|N/A (Log Check)|Detailed<br>Data Page <br>Tab)|Sensor<br> (History|
|E4 (AI)|E4-US1 (Request Rec)|TC-E4-US1-01|AI Crop <br>mendation|Recom-<br>Screen|
|E4 (AI)|E4-US2 (Confdence)|N/A<br>(Visual<br>Check)|AI Crop <br>mendation|Recom-<br>Screen|
|||Cont|inued on ne|xt page...|



45 

Requirement Specification and Analysis 

**Table 2-19 – Continued from previous page** 

|**Epic**|**User Story**|**Test Case**|**UI Screen**|
|---|---|---|---|
|E4 (AI)|E4-US3 (Accept)|N/A (State Change)|AI Crop Recom-<br>mendation Screen|
|E5 (Alerts)|E5-US1 (Critical)|TC-E5-US1-01|Alerts & Notifca-<br>tions Screen|
|E5 (Alerts)|E5-US2 (Unread)|N/A (Badge Check)|Dashboard<br>(Alert<br>Icon)|
|E5 (Alerts)|E5-US3 (Resolve)|N/A<br>(Action<br>Check)|Alerts & Notifca-<br>tions Screen|
|E6 (Analyt-<br>ics)|E6-US1 (Trends)|TC-E6-US1-01|Detailed<br>Sensor<br>Data Page (History)|
|E6 (Analyt-<br>ics)|E6-US2 (Export)|N/A (Download)|Settings<br>/<br>Profle<br>Page|
|E6 (Analyt-<br>ics)|E6-US3 (Compare)|N/A (Multi-view)|Dashboard<br>(Com-<br>parison View)|



The Traceability Matrix presented in Table 2-19 systematically correlates the overarching system Epics with their corresponding User Stories, defining the exact test cases and UI screens responsible for validating each requirement. By explicitly tracking the journey from abstract feature definitions (e.g., automated irrigation, AI crop recommendations, and real-time alerts) down to concrete, verifiable testing parameters, this matrix guarantees comprehensive structural coverage. This rigorous documentation ensures that no critical functionality is overlooked during the testing phase, validating the system’s operational integrity across all software and hardware components. 



<!-- Start of picture text -->
=} Mi a ae<br>Sensor (Temp/Humidity) (Light) Tee ‘Sensor Pump/Valve<br>Node.js + Express.js Server ae : j<br>— —<br>Python — Legend<br>ke we TensorFlow/Scikit-learnService ae Cence,Bashwoara bk MessagingFirebase (5(5 Device/Field Connectivity Layer Layer<br>Realtimea, Database MySQLmysci Database Feature Extraction + Model Prediction (ae —(5 AVMforeServicearenas<br>Real-time syne ‘Structured analytics || Application Layer<br>a ©) Notification Service<br><!-- End of picture text -->

System Design 

47 

## **3.2. Components and Connector** 

The system consists of multiple interacting components connected through well-defined interfaces to ensure reliable data acquisition, transmission, processing, and user interaction. 



_Figure 3-2: Hardware Integration_ 

### **3.2.1. Core Components** 

The physical layer is driven by the **Sensing Unit** , which incorporates a soil moisture sensor, a DHT22 module for temperature and humidity, an LDR for light intensity, a rain sensor, and a water flow sensor to accurately capture field conditions [3]. This data is processed by the **Control Unit** , an ESP32 microcontroller that actively reads sensor values and enforces local irrigation logic [8]. When irrigation is required, the **Actuation Unit** utilizes a relay-driven pump to manage water flow either manually or automatically [4]. On the server side, the **Backend Services** rely on a Node.js server to handle device ingestion, evaluate business rules, trigger alerts, and serve mobile APIs [22]. Persistent **Data Storage** is managed through a MySQL relational database, which securely archives sensor logs, irrigation events, and user configurations [23]. To provide intelligent insights, a Python-based **AI/ML Service** analyzes historical and environmental patterns to generate 



<!-- Start of picture text -->
\ Goog<br>a+ iAa B=bC eT2aSt e  wiede 0< ie: renBecooan “<br>CEi a seee partesfaa<br>[3]ial a a YT= fa<br>iy f) 7 ——— ——— a Te rae<br>cuca | e AY Al ALES | 4 ;<br>Water el<br>fe) ® {nemebeenhba 6 atee H——————a|<br>fritzing<br><!-- End of picture text -->



<!-- Start of picture text -->
fe te ha o.! “il: ’ 2eo ee r ( i st = nig, © : ‘ ‘it ; he a<br>: : ve SS -- ee (| | 4\=<br>eee =| | a\-<br>2 ><br>| a : ~ l | |:Ici facesld aesee mha 1. F  My)!pee cae ry ‘s :=ij ><br>" — \ on => --e- || eee 2 0) a at<br>waliget soe = ee ate ‘ef<br>- —_ : ae _ x ——— oa of a.<br>ye = Fern ete os a m3 <|<br>ysra = .SS“hentat poieeeas aSoP. = 7 a “aeye FISie Salad<br>Fr. ¥ eet cake : ra Pees ee. as pe J<br>\ os \ 8 cieees ye aete<br>Eg, cE. \ = }\ ae ale ? tyes a3 ae ali al<br>z © = a Petts nd bs 3 a -_ Pe Aas’ i><br>cot ot , -| Seoow a ie<br>oa =o Oe a Oa stale Pe pene: | nt<br>4 F a *. snr<br>’ PTTL iiss a ra 1. Mert 8<br>:<br>‘<br>“a“a — ~ pie, ys Jaati_s “ “ss = . =é + ae= - ~ rT,<br>oz eee LES<br><!-- End of picture text -->

50 

System Design 

This section details the hardware components required for the field unit deployment, including technical specifications, operating parameters, and integration requirements. Table 3-1 provides an overview of all components, while Table 3-2 presents detailed technical specifications. 

### **3.3.1. Component Overview** 

_Table 3-1: Hardware Components and Primary Functions_ 

|**Component**|**Specifcation / Purpose**|
|---|---|
|**ESP32 Microcontroller**|Dual-core 32-bit microcontroller with integrated Wi-Fi (802.11<br>b/g/n) and Bluetooth. Controls sensor data acquisition, local<br>threshold logic, irrigation actuation, and backend communication<br>via HTTP/REST protocol [8].|
|**Soil Moisture Sensor**|Capacitive sensor (YL-69) that measures volumetric water content<br>in soil. Provides analog output (0–2560) proportional to moisture<br>level, enabling precise irrigation decision-making.|
|**DHT22 Sensor**|Digital temperature and humidity sensor with calibrated output.<br>Measures ambient temperature (–40°C to +80°C) and relative<br>humidity (0–100%) for crop environment monitoring and weather<br>correlation [3].|
|**LDR Light Sensor**|Light Dependent Resistor that measures ambient light intensity<br>(0–1023 lux equivalent). Supports day/night detection, optimal<br>irrigation timing, and crop photosynthesis analysis.|
|**Rain Sensor**|Digital rain detection module (FC-37) with adjustable sensitivity.<br>Detects rainfall conditions to prevent irrigation during rain events<br>and conserve water resources [4].|
|**Relay Module**|Single-channel 5V relay with optocoupler isolation. Switches<br>high-power pump/valve circuits (up to 10A at 250V AC or 30V DC)<br>based on ESP32 digital output or manual mobile app commands.|
|**Water Pump**|12V DC submersible pump for irrigation actuation. Flow rate:<br>500–2000 L/hour depending on feld size and crop requirements [6].|
||5V/2A regulated adapter for ESP32 and sensors (via ESP32’s 3.3V|
|**Power Supply**|regulator). Separate 12V supply for pump with protection circuitry<br>(fuse, surge protection).|



51 

System Design 

### **3.3.2. Detailed Technical Specifications** 

_Table 3-2: Hardware Technical Specifications and Interface Details_ 

|**Component**|**Model**|**Technical Specs**|**Interface**|
|---|---|---|---|
|ESP32|ESP-WROOM-<br>32|CPU: Dual-core Xtensa LX6 @<br>240MHz; RAM: 520KB; Flash: 4MB;<br>Wi-Fi: 2.4GHz 802.11n; GPIO: 34pins|Power:<br>5V<br>(VIN)|
|Soil Moisture|YL-69|Operating Voltage: 3.3V–5V; Output:<br>Analog (0–1023); Response Time: <1s;<br>Probe Length: 60mm|Analog (A0)|
|||Temp Range: –40°C to +80°C||
|Temperature &<br>Humidity|DHT22<br>(AM2302)|(±0.5°C); Humidity: 0–100% RH<br>(±2–5%); Sampling: 0.5Hz|Digital (GPIO)|
|Light Sensor|LDR (5mm)|Resistance Range: 1kΩ–10MΩ;<br>Spectral Peak: 540nm; Voltage:<br>3.3V–5V|Analog (A1)|
|Rain Sensor|FC-37|Operating Voltage: 3.3V–5V; Detection<br>Area: 5cm×4cm; Output: Digital<br>(HIGH/LOW)|Digital (GPIO)|
|Relay Module|5V Single Chan-<br>nel|Coil Voltage: 5V DC; Contact Rating:<br>10A @ 250V AC / 30V DC; Isolation:<br>Optocoupler|Digital (GPIO)|
|Pump|12V<br>DC<br>Sub-<br>mersible|Voltage: 12V DC; Current: 0.5–1A;<br>Flow Rate: 500–1200 L/h; Head:<br>1.5–3m|Relay<br>NO/-<br>COM|
|||Input: 100–240V AC; Output: 5V/2A||
|Power Supply|AC/DC Adapter|(ESP32/Sensors), 12V/1A (Pump -<br>separate)|DC Jack / Ter-<br>minal|



52 

System Design 

### **3.3.3. Pin Configuration and Wiring** 

Table 3-4 shows the ESP32 pin assignments for all connected hardware components. 

_Table 3-4: ESP32 Pin Configuration_ 

|**Component**|**ESP32 Pin**|**Pin Type**|**Signal**|
|---|---|---|---|
|Soil Moisture Sensor|GPIO 36 (A0)|Analog Input|0–1023 (Moisture<br>%)|
|LDR Light Sensor|GPIO 39 (A1)|AnalogInput|0–1023 (Lux)|
|DHT22 Sensor|GPIO 4 (D4)|Digital I/O|Data Protocol|
|Rain Sensor|GPIO 5 (D5)|Digital Input|HIGH / LOW|
|Relay Module|GPIO 14 (D7)|Digital Output|HIGH (ON) / LOW<br>(OFF)|
|Power (VIN)|5V Pin|Power Input|5V DC|
|Ground (GND)|GND Pin|Ground|Common Ground|



### **3.3.4. Power Consumption Analysis** 

The total power consumption of the field unit is estimated as follows [8]: 

- **ESP32 (Wi-Fi active):** 160–260mA @ 3.3V ≈ 0.5–0.9W 

- **DHT22 Sensor:** 1–1.5mA @ 3.3V ≈ 0.005W 

- **Soil Moisture + LDR + Rain Sensors:** 10–20mA @ 3.3V ≈ 0.03–0.07W 

- **Relay Module (coil):** 70mA @ 5V ≈ 0.35W 

- **Total (sensors & control):** ≈ 1–1.5W 

- **Water Pump (12V):** 0.5–1A @ 12V = 6–12W (during irrigation only) 

A 5V/2A power supply is sufficient for continuous sensor operation and relay control. The water pump requires a separate 12V/1A supply with adequate surge protection. 

53 

System Design 

### **3.3.5. Cost Estimation** 

Table 3-6 provides approximate costs for hardware components (in PKR, Pakistani Rupees). 

_Table 3-6: Estimated Hardware Costs_ 

|**Component**|**Qty**|**Estimated Cost (PKR)**|
|---|---|---|
|ESP32 Development Board|1|1,200|
|Soil Moisture Sensor|1|300|
|DHT22 Sensor|1|400|
|LDR Sensor|1|50|
|Rain Sensor Module|1|200|
|5V RelayModule|1|150|
|12V DC Water Pump|1|1,500|
|5V/2A Power Supply|1|300|
|12V/1A Power Supply|1|400|
|ConnectingWires & Miscellaneous|—|500|
|Enclosure (Weatherproof)|1|800|
|**Totalper Field Unit**||**6,400 PKR**|



The estimated cost of **PKR 6,400 ( USD 23)** per field unit makes the system affordable for small and medium-scale farmers in Pakistan [1]. Bulk procurement and local sourcing can further reduce costs. 

## **3.4. Communication Protocols** 

The system uses Wi-Fi connectivity for field-to-server communication. The protocol stack is selected to support reliability, scalability, and real-time monitoring [21]: 

- **Physical / Data Link Layer:** Wi-Fi (IEEE 802.11) 

- **Network Layer:** IPv4 

- **Transport Layer:** TCP 

- **Application Layer:** HTTP/REST for configuration, control, and data retrieval; MQTT (optional) for lightweight publish/subscribe telemetry [25]. 

#### PROFESSIONAL COMMUNICATION PROTOCOLS DIAGRAM FOR SMART Al POWERED AGRICULTURE SYSTEM 



<!-- Start of picture text -->
OSI Protocol Stack Data Flow Sequence<br>K ; << rm WiFiNetwork, >] _ internet/LAN Protocol Port Purpose<br>ae S&S o HTTP/REST 80/443 API communication, 4<br>if 7 an fart! ESP32 Router/Gateway Badiond telemetry upload<br>ee ss scl Marr 1483 Realtime pubsub<br>3 (POST /api/v1/telemetry) Kontional)<br>TCPi (POST /api/v1/irrigation/control) Liver dashboard<br>4 EQ HTTPS/TLS 443 Secure API calls<br>E WepSocket | 8080 | updates<br>— (GET /api/v1/config)<br>IPv4. : Sensor Data Payload (ESP32 — Backend) Control Command (Backend— ESP32)<br>‘:{“device_id": "D501", {“command": “IRRIGATION_ON",<br>a “timestamp": "2026-02-01T10:22:00Z", “duration”: 660,<br>Layer 1-2: ; w—~ “soil_moisture": 41, "mode": "auto"<br>D Wi-Fi (CES "temperature": 28 }<br>aie Pe. = "humidity": 55<br><!-- End of picture text -->

55 

System Design 

### **3.5.3. Sensor & Telemetry** 

To manage hardware, the **sensors** table maintains a complete registry of all IoT devices (ESP32 units) deployed across the fields, tracking device identifiers, sensor types, firmware versions, battery levels, and necessary calibration offsets [2]. The operational data generated by these devices is archived in the **sensor_readings** table, which captures high-volume timeseries telemetry data including soil moisture, temperature, humidity, and light intensity at regular intervals [13]. 

### **3.5.4. Irrigation Management** 

Water control tracking is handled by the **irrigation_logs** table, which records a comprehensive history of irrigation events, detailing the mode (manual, automatic, or scheduled), duration, water usage, pre- and post-irrigation soil moisture levels, and specific trigger reasons. Concurrently, the **irrigation_schedules** table stores automated configurations for recurring irrigation cycles, including defined times of day, frequencies, and custom interval settings. 

### **3.5.5. Alerts & Recommendations** 

System notifications are managed within the **alerts** table, categorized by severity (critical, warning, info) and metric type (soil moisture, temperature, sensor offline), while also tracking multi-channel delivery status across push notifications, email, and SMS [9]. The **crop_recommendations** table stores AI-generated agricultural suggestions, recording the recommended crop alongside its confidence score, expected yield, water requirements, growth duration, and seasonal constraints [24]. 

### **3.5.6. System Management** 

For broader context, the **weather_data** table archives meteorological history and forecasts, storing temperature, humidity, rainfall, wind speed, and cloud cover. The **system_settings** table manages configurable operational thresholds (e.g., soil moisture limits) and user preferences globally and individually. Finally, the **audit_logs** table ensures security and compliance by tracking all critical system actions (login, create, update, delete), logging user identification, IP addresses, and JSON-formatted state changes [10]. 



<!-- Start of picture text -->
Entity Relationship Diagram - Smart Al Agriculture System<br>PK = Primary Key (,), FK = Foreign Key (@), 1:N = One-to-Many relationship<br>/ user_id<br>1 name<br>emailphone(unique)<br>Coenen FECAN pememene) TD<br>? field_id P device_id<br>1 wPaes 1 *‘deployed intin Ng Y device_nameges ron s! “triggerso<br>eaperee. Acree) = nac_address<br>receives’ C an “generates* 1] status (onl ne/offline)<br>1 1<br>“peneraieay<br>A, N A N N A, A N<br>mmendation_id reading_id event_id<br>ae ee aieted Wf Ng ae ry - 0 rh ae ade (nenualaut)<br>created_at db<br><!-- End of picture text -->



<!-- Start of picture text -->
Smart Agriculture System - Complete Database Schema (MySQL)<br>USER & FIELD MANAGEMENT SENSOR & TELEMETRY ALERTS & RECOMMENDATIONS<br> user_idfal (PK) © Reld_id ~~ senser_id (PK) ~~ reading_id (PK)  weather_id (PK) ‘ recommendation_idDac (PK)<br>ey tee co feld id (FA) co sensorid (FX) © field_Id (FK) coReld, a<br>atidress ieroa. pico, re inccel Pct rainfall soll_moisture_avg<br>ally < unit >++- has sensors tion_d generates readings wind_speed temperature_avg<br>roe (farm ee) planting ‘dehan ‘weather_conditionorecast_d roe er seasonexpected_yield<br>cusiom_daysisactive water_requirementarowth_duraion_days<br>way v reated_ recommendation_reason<br>yo ¥ ry eee<br>inigation history | iniliates accepted_atcreated_at J|<br>ieee fe ce ree ‘actions logged |= og dPK)Cd<br>"ALERTS IRRIGATION LOGS |<br>aafield i (FK)9 omeuen log_idchee hh> cresiee| ser eins,<br>eeeBlert_categorya, rigaton_ypetim __WEATHER_DATA| < co# user_idsetng(FK,(PK) nullable)<br>tile = | from sensor Meer) weather_idie ae<br>P temperature seting ype<br>weather i < de) descriptioncrealed_at<br>eeaSseetcon 4 in i | uupdated_at= 1:N=One-to-ManyPK=PrimaryFK=Foreign KeyKey<br>IN<br>10 Tables, 50+ Foreign Key<br>Relationships<br>ALERTS & RECOMMENDATIONS SYSTEM MANAGEMENT<br><!-- End of picture text -->

58 

System Design 

|**Column Name**|**Data Type**|**Description**|
|---|---|---|
|feld_id|INT(11) PK|Auto-increment primary key|
|user_id|INT(11) FK|Foreign key to users table|
|feld_name|VARCHAR(100)|Name/identifer of the feld|
|location_latitude|DECIMAL(10,8)|GPS latitude coordinate|
|location_longitude|DECIMAL(11,8)|GPS longitude coordinate|
|area_size|DECIMAL(10,2)|Field area (in acres/hectares)|
|soil_type|VARCHAR(50)|e.g., Loamy, Sandy, Clay|
|current_crop|VARCHAR(100)|Currently planted crop|
|planting_date|DATE|Crop planting date|
|expected_harvest_date|DATE|Expected harvest date|
|is_active|TINYINT(1)|Field status (1 = active)|



_Table 3-8: Fields Table Schema_ 

### **3.6.3. Sensors Table** 

The `sensors` table maintains a registry of all IoT devices deployed in the field [2]. 

|**Column Name**|**Data Type**|**Description**|
|---|---|---|
|sensor_id|INT(11) PK|Auto-increment primary key|
|feld_id|INT(11) FK|Foreign key to felds table|
|sensor_type|ENUM|combined / soil_moisture / temperature|
|device_id|VARCHAR(100) UNIQUE|ESP32 MAC address or identifer|
|sensor_model|VARCHAR(100)|e.g., ESP32 + DHT11 + Soil Sensor|
|installation_date|DATE|Sensor deployment date|
|battery_level|DECIMAL(5,2)|Battery percentage (if applicable)|
|frmware_version|VARCHAR(20)|Current frmware version|
|is_active|TINYINT(1)|Sensor status (1 = active)|



_Table 3-9: Sensors Table Schema_ 

### **3.6.4. Sensor Readings Table** 

The `sensor_readings` table stores time-series telemetry data from ESP32 sensors [13]. 

59 

System Design 

|**Column Name**|**Data Type**|**Description**|
|---|---|---|
|reading_id|BIGINT(20) PK|Auto-increment primary key|
|sensor_id|INT(11) FK|Foreign key to sensors table|
|reading_time|TIMESTAMP|Timestamp of sensor reading|
|soil_moisture|DECIMAL(5,2)|Soil moisture percentage (0-100)|
|temperature|DECIMAL(5,2)|Temperature in Celsius|
|humidity|DECIMAL(5,2)|Humidity percentage (0-100)|
|light_intensity|INT(11)|Light intensity in Lux|
|created_at|TIMESTAMP|Record creation timestamp|



_Table 3-10: Sensor Readings Table Schema_ 

**Indexes:** Compositeindexon( `sensor_id` , `reading_time` )forefficienttime-seriesqueries. This table is expected to have high insert volume and requires periodic archiving [23]. 

### **3.6.5. Irrigation Logs Table** 

The `irrigation_logs` table tracks all irrigation events with detailed metrics. 

|**Column Name**|**Data Type**|**Description**|
|---|---|---|
|log_id|BIGINT(20) PK|Auto-increment primary key|
|feld_id|INT(11) FK|Foreign key to felds table|
|irrigation_type|ENUM|automatic / manual / scheduled|
|start_time|TIMESTAMP|Irrigation start timestamp|
|end_time|TIMESTAMP|Irrigation end timestamp|
|duration_minutes|INT(11)|Calculated duration|
|water_used_liters|DECIMAL(10,2)|Water consumption|
|soil_moisture_before|DECIMAL(5,2)|Pre-irrigation moisture|
|soil_moisture_after|DECIMAL(5,2)|Post-irrigation moisture|
|pump_status|ENUM|on / of / error|
|created_at|TIMESTAMP|Log creation timestamp|



_Table 3-11: Irrigation Logs Table Schema_ 

### **3.6.6. Alerts Table** 

The `alerts` table manages system notifications with multi-channel delivery tracking [9]. 

60 

System Design 

|**Column Name**|**Data Type**|**Description**|
|---|---|---|
|alert_id|BIGINT(20) PK|Auto-increment primary key|
|user_id|INT(11) FK|Foreign key to users table|
|feld_id|INT(11) FK|Foreign key to felds table|
|alert_type|ENUM|critical / warning / info / success|
|alert_category|ENUM|soil_moisture / temperature / irriga-<br>tion|
|title|VARCHAR(200)|Alert title|
|message|TEXT|Detailed alert message|
|threshold_value|DECIMAL(10,2)|Confgured threshold|
|current_value|DECIMAL(10,2)|Actual sensor value|
|is_read|TINYINT(1)|Read status fag|
|is_resolved|TINYINT(1)|Resolution status fag|
|push_notifcation_sent|TINYINT(1)|FCM delivery fag|
|created_at|TIMESTAMP|Alert generation timestamp|



_Table 3-12: Alerts Table Schema_ 

### **3.6.7. Crop Recommendations Table** 

The `crop_recommendations` table stores AI-generated crop suggestions [5], [24]. 

_Table 3-13: Crop Recommendations Table Schema_ 

|**Column Name**|**Data Type**|**Description**|
|---|---|---|
|recommendation_id|INT(11) PK|Auto-increment primary key|
|feld_id|INT(11) FK|Foreign key to felds table|
|recommended_crop|VARCHAR(100)|Suggested crop name|
|confdence_score|DECIMAL(5,2)|AI model confdence (0-100)|
|soil_moisture_avg|DECIMAL(5,2)|Average soil moisture|
|temperature_avg|DECIMAL(5,2)|Average temperature|
|season|VARCHAR(20)|e.g., Kharif, Rabi|
|expected_yield|DECIMAL(10,2)|Expected yield (kg/acre)|
|water_requirement|VARCHAR(50)|Low / Medium / High|
|growth_duration_days|INT(11)|Days to harvest|



Continued on next page... 

61 

System Design 

**Table 3-13 – Continued from previous page** 

|**Column Name**|**Data Type**|**Description**|
|---|---|---|
|recommendation_reason|TEXT|AI explanation/justifcation|
|is_accepted|TINYINT(1)|Farmer acceptance fag|
|created_at|TIMESTAMP|Recommendation timestamp|



### **3.6.8. Indexing Strategy** 

To optimize query performance, the following indexes are implemented [23]: 

- **Primary Keys:** Auto-increment indexes on all primary key columns 

- **Foreign Keys:** Indexes on all foreign key columns (user_id, field_id, sensor_id) 

- **Unique Constraints:** Indexes on email, phone, device_id for uniqueness enforcement 

- **Composite Indexes:** (sensor_id, reading_time) for time-series queries on sensor_readings 

- **Status Flags:** Indexes on is_active, is_read, is_resolved for filtered queries 

- **Timestamps:** Indexes on created_at, reading_time for chronological sorting 

The database uses UTF-8 (utf8mb4) character encoding for multilingual support and InnoDB storage engine for ACID compliance and transaction support. 

## **3.7. AI Data Modeling and Architecture** 

To generate intelligent crop recommendations, the system utilizes a Machine Learning pipeline driven by a **Random Forest Classifier** . 



<!-- Start of picture text -->
TO vrormat ines B FU Sis De Be = = =) s 9S ExMergescemer =| $ = % 7 | 43 Mommuone ronnes eure \"<br>Clipboard & Font & Alignment fe Number & Styles<br>Al vie te soil_moisture<br>4 A Boj} Cc j| D | = | F | G | UH | | J | K | L M  N | O<br>1 | soil_moist|temperatu humidity soil_type season recommended_crop<br>2 70.2 27.3 60.6 loamy kharif maize<br>3 66.5 22 75.6 loamy kharif maize<br>4 52 19.5 52.6 silty rabi wheat<br>5 62.2 26.7 80.4 clay kharif sugarcane<br>6 45.7 26.1 48.8 loamy kharif sunflower<br>7 51.4 21.6 65.7 sandy kharif sunflower<br>8 32.6 17.1 57.3 sandy rabi mustard<br>9 50.8 24.7 49.9 loamy rabi wheat<br>10 58.6 30.3 66 loamy kharif maize<br>11 76.8 31.4 74.1 clay kharif rice<br>12 33.1 16.9 44.1 sandy rabi mustard<br>13 70.6 35.3 83.6 clay kharif sugarcane<br>14 92 28.8 89.5 silty kharif rice<br>15 41.1 35.7 51.9 sandy kharif cotton<br>16 77.3 26.1 87.9 silty kharif rice<br>7 57.2 29 61.8 loamy kharif sunflower<br>18 50.9 18.6 63.9 clay_loam rabi wheat<br>19 97.8 30.9 81.6 clay kharif rice<br>20 46.9 33.5 59.3 sandy kharif cotton<br>21 49.1 30.7 64.8 sandy kharif sunflower<br>22 96.8 29.1 78.3 silty kharif rice<br>23 61.6 34.9 78.7 clay kharif sugarcane<br>24 31.3 9.4 59.4 sandy rabi mustard<br>25 47.4 21.9 50.7 clay_loam rabi chickpea<br>26 59.2 20.9 60.3 clay_loam kharif maize<br>27 36.2 15.7 46.6 loamy rabi chickpea<br>28 35.5 36.3 54 sandy kharif cotton<br>29 84.5 32.1 86.8 clay kharif rice<br>30 46.8 36.9 66 loamy kharif cotton<br>31 70.5 33.9 85.1 clay_loam kharif sugarcane<br>22 QA5 178 5A A candy rahi mustard<br><!-- End of picture text -->

63 

System Design 

### **3.7.2. Model Architecture and Hyperparameters** 

The system employs a Random Forest algorithm, selected for its resilience to overfitting and capacity to handle non-linear agricultural variables. Based on the implementation within the AI service, the model is instantiated with the following structural hyperparameters: 

- **Number of Estimators (** `n_estimators` **):** 150 

### • **Maximum Depth (** `max_depth` **):** 10 

### • **Minimum Samples per Leaf (** `min_samples_leaf` **):** 3 

Prior to training, categorical features (soil type, season, and crop labels) are vectorized using scikit-learn’s `LabelEncoder` . The dataset is partitioned using a strict 80/20 train-test split, validated through a 5-fold cross-validation technique to confirm generalizability across diverse field conditions. 

### **3.7.3. Confidence Score Calculation** 

The Random Forest model outputs a confidence score alongside its primary crop recommendation. This score is mathematically derived using the algorithm’s ensemble soft-voting probability mechanism, directly mirroring the `predict_proba` function implemented in the AI backend. Specifically, for an input vector _𝑥_ , each of the 150 decision trees ( _𝑁𝑡𝑟𝑒𝑒𝑠_ = 150) calculates a class probability _𝑝𝑡_ ( _𝑐_ | _𝑥_ ), representing the fraction of samples of class _𝑐_ in the resulting leaf node. The final class probability _𝑃_ ( _𝑐_ | _𝑥_ ) is the mean of these probabilities across the entire forest: 



The confidence score ( _𝐶_ ) is then extracted as the maximum mean probability among all supported crop classes, converted to a percentage: 



By computing the average of individual tree probabilities rather than relying on a simplistic majority vote count, the model produces a highly calibrated confidence score. This rigorous statistical method ensures that the final recommendation accurately reflects the variance and certainty of the training data, ultimately providing farmers with a highly reliable indicator of crop viability under the specified environmental conditions. 



<!-- Start of picture text -->
System Workflow Diagram - Smart Agriculture System<br>[POSnee Te©) Rectangle=ProcessDiamond=Decision<br>Rounded Rectangle=Start/End<br>DECISION<br>ESP32 STEP 4 Th en ie 4 YES STEP 4A STEP5<br> Reads Sensor Values seam God Moicilant ail Trigger Irrigatio Log Irigation Event Ms<br>SeRoOOE? | nati<br>STERZ ie STEP6<br>STEP3<br>UpdateMoble Dashbo0 a rd a} Anaials Recaie YES. | al Service AnalyzesData<br>Sea ee eeice<br>WAIT |<br>Wait for Next C 1) i—<br><!-- End of picture text -->



<!-- Start of picture text -->
Flutter Mobile 2] Nsateaoa Firebase Cloud 2]<br>Application | Cen Messaging<br>!<br>'<br>REST API O<br>(HTTPS) 7<br>'<br>i]<br>'<br>'<br>Vv<br>Node.js API Server 31) === sec== Soe Database“a |<br>1<br>; Crop<br>' Recommendation = |<br>ek ee rd Python Machine<br>; O- Learning Model<br>Telemetry Data ©<br>(MQTT over Wi-Fi) :<br>1<br>1<br>!<br>1<br>Vv<br>a:<br>r MicrocontrollerESP32 & | =. 1<br>i<br>!!<br>!!<br>!!<br>!!<br>a & | Relay Pump = |<br>(DHT22, Moisture, LDR) Controller<br><!-- End of picture text -->



<!-- Start of picture text -->
| ESP32 Powers On |<br>fa ~<br>| Connectto Wi-Fi |<br>Fa ~ a ~<br>| Read All Sensors | Run Offline Pump Logic<br>‘ A (Local Threshold Only)<br>Turn Pump OFF | Upload Sensor Data to Backend |<br>(Rain Override) ‘. 4<br>[ce Activate Irrigation Pump ~| Fa Poll Backend for ~<br>lOcr =<br>k k<br>[ ‘<br> Log Irrigation Event ] YeS Command = on? Ne<br>a SF ~<br>Activate Pump | | Keep Pump OFF |<br>| Check Alert Conditions |<br><i enn?MYes<br>| Generate Alert |<br>| Send Push Notification |<br>| Wait 30 Seconds |<br>a s,<br>| Repeat Loop |<br><!-- End of picture text -->

67 

System Design 

## **3.11. Third-Parties Dependencies** 

The proposed system integrates third-party libraries, frameworks, and services to reduce development time and improve reliability [10]: 

- **Arduino IDE:** Embedded development environment for ESP32 firmware [8]. 

- **Node.js + Express.js:** Backend development framework for APIs and device ingestion [22]. 

- **MySQL (MariaDB):** Relational database for structured storage, complex queries, and analytics [23]. 

- **Firebase Cloud Messaging (FCM):** Push notifications for alerts and updates [9]. 

- **Flutter:** Mobile application development platform [17]. 

- **Visualization Library:** Graphs and charts (e.g., MPAndroidChart or equivalent). 

- **Python ML Model:** Random Forest for crop recommendation modeling [24]. 

68 

# **Chapter 4** 

# **4. Software Development** 

This chapter describes the implementation of the Smart AI Powered Agriculture System at a finer level of detail. It explains the development standards, environment, and key software modules across the embedded firmware (ESP32), backend services (Node.js), mobile application (Flutter), and the AI/ML recommendation service [22]. The implementation is aligned with the system design described in Chapter 3. 

## **4.1. Coding Standards** 

To ensure maintainability, readability, and consistent collaboration among team members, the following coding standards were followed [10]: 

### **4.1.1. General Standards** 

Consistent naming conventions were used across all modules (camelCase for variables/functions, PascalCase for classes). Functions were kept small and single-purpose to improve modularity and testability [10]. All modules include meaningful comments for complex logic and configuration parameters. Sensitive information (API keys, tokens) was kept out of source code and stored using environment variables or secure configuration files [15]. Proper error handling and validation were applied at the boundaries (API inputs, sensor readings, and database writes). 

### **4.1.2. ESP32 Firmware Standards** 

Clear separation of concerns: sensor reading, networking, and actuation logic implemented as separate functions [26]. Debouncing and filtering used for noisy sensors (e.g., rain sensor) to avoid false triggers [27]. Safe defaults: irrigation is turned **OFF** when network or sensor failures occur to avoid uncontrolled watering [26]. 

### **4.1.3. Backend Standards (Node.js)** 

REST endpoints follow consistent URI patterns and HTTP status codes [22]. Middlewarebased validation and authentication (JWT) is enforced for protected routes [15]. Logging 

69 

Software Development 

includes request IDs and timestamps for debugging and audit. 

### **4.1.4. Mobile Application Standards** 

UI components follow a consistent design system for readability and ease of use [17]. Data is fetched asynchronously and cached for better user experience. Input forms (thresholds, schedules) validate values before sending to backend. 

## **4.2. Development Environment** 

This section describes the tools, platforms, and configurations used for software development. 

### **4.2.1. Tools and Platforms** 

**Embedded/Firmware:** Arduino IDE with ESP32 board support packages [8]. **Backend:** Node.js runtime with Express.js framework [22]. **Database:** MySQL (MariaDB) for all data storage and retrieval operations [23]. **Mobile:** Flutter SDK (cross-platform) [9]. **AI/ML:** Python environment Random Forest [24]. **Version Control:** Git for collaborative development and change tracking [10]. 

### **4.2.2. Testing Setup** 

**Firmware testing:** Serial monitor logging and controlled sensor value simulation [26]. **Backend testing:** API testing using Postman and unit checks for validation logic. **Mobile testing:** Emulators and physical device testing for UI and notifications [9]. **End-to-end testing:** Real sensor readings sent to backend, verified on app dashboard and alert system [28]. 

## **4.3. Software Description** 

The Smart AI Powered Agriculture System is fully functional and deployed. The core implementation is based on ESP32 firmware that integrates sensors, Wi-Fi communication, backend API interaction, local safety control, and relay-based irrigation automation [26]. The firmware is responsible for reading environmental data, applying local decision logic, receiving pump commands from the backend, and uploading sensor readings for storage, alerts, analytics, and AI-based processing [22]. 

Software Development 

70 

**Note on Code Snippets:** The following code snippets are presented to highlight the core functional logic (e.g., sensor integration, decision-making, and communication protocols). For the purpose of brevity and readability, standard imports, module definitions, and boilerplate file structures have been intentionally omitted. For access to the complete, fully functional source code across all system layers, please refer to the project’s official GitHub repository [29]. 

### **4.3.1. Snippet 1: Hardware Pin Configuration** 

As implemented in `ESP32_Firmware/final ESP32 code.txt` (Lines 34–44), the ESP32 firmware defines dedicated GPIO pins for soil moisture, rainfall, light intensity, temperature/humidity, and relay-based pump control. This explicit pin mapping connects the physical field unit with the software logic [8]. 

- 1 `// Pin Definitions` 2 `#define SOIL_PIN 34` 3 `#define RAIN_PIN 33` 4 `#define LIGHT_PIN 32` 5 `#define DHT_PIN 4` 6 `#define RELAY_PIN 5` 

- 7 

8 `#define DHT_TYPE DHT22` 9 `DHT dht(DHT_PIN , DHT_TYPE);` 

**Outcome:** The hardware components are mapped with ESP32 pins, enabling the firmware to collect sensor data and control the irrigation relay. 

### **4.3.2. Snippet 2: Sensor Threshold Configuration** 

Referencing `ESP32_Firmware/final ESP32 code.txt` (Lines46–52), hardcodedthreshold values are defined to classify soil conditions, rainfall status, and light intensity. These limits are utilized by the firmware for local offline automation and zero-latency safety decisions. 

|1<br>`// Senso`|`r Thresholds`||
|---|---|---|
|2<br>`#define `|`SOIL_DRY_THRESHOLD`|`2800`|
|3<br>`#define `|`SOIL_WET_THRESHOLD`|`1200`|
|4<br>`#define `|`RAIN_THRESHOLD`|`2000`|
|5<br>`#define `|`LIGHT_DARK_THRESHOLD `|`3000`|



**Outcome:** The system can identify dry soil, wet soil, rainfall, and dark light conditions using predefined sensor thresholds. 

Software Development 

71 

### **4.3.3. Snippet 3: Three-Tier Timing System** 

As shown in `ESP32_Firmware/final ESP32 code.txt` (Lines 73–78), the firmware establishes a strict three-tier timing mechanism. This architecture separates fast local safety checks (1s), backend command polling (5s), and full telemetry data uploads (30s) to optimize network bandwidth [26]. 

1 `// Timing Configuration` 2 `#define SENSOR_READ_INTERVAL 1000` 3 `#define COMMAND_POLL_INTERVAL 5000` 4 `#define SENSOR_UPLOAD_INTERVAL 30000` 5 `#define BACKEND_RETRY_INTERVAL 5000` 6 `#define WIFI_RETRY_INTERVAL_MS 10000` 7 `#define PUMP_MIN_RUN_TIME 1500` 

**Outcome:** Sensors are read every second, backend commands are checked every five seconds, and complete sensor data is uploaded every thirty seconds. 

### **4.3.4. Snippet 4: Safe System Initialization** 

Locatedin `ESP32_Firmware/final ESP32 code.txt` (Lines131–168), thesystemstartup sequence initializes serial communication, starts the DHT sensor, configures the relay pin, and explicitly keeps the pump OFF by default. Since the relay operates via an active-low trigger, HIGH safely enforces the OFF state [26]. 

1 `void setup() {` 2 `Serial.begin(115200);` 3 `delay(2000);` 4 5 `dht.begin();` 6 7 `// Active -LOW relay: HIGH = OFF` 8 `pinMode(RELAY_PIN , OUTPUT_OPEN_DRAIN);` 9 `digitalWrite(RELAY_PIN , HIGH);` 10 11 `connectToWiFi();` 12 `}` 

**Outcome:** The pump remains safely OFF during startup, preventing accidental irrigation when the device powers on. 

Software Development 

72 

### **4.3.5. Snippet 5: Main Execution Loop** 

The main execution flow, implemented in `ESP32_Firmware/final ESP32 code.txt` (Lines 173–230), drives the continuous monitoring loop. It dynamically checks Wi-Fi status, reads sensors, evaluates local safety logic, polls backend endpoints for irrigation commands, and handles telemetry uploads [28]. 

1 `void loop() {` 2 `unsigned long now = millis();` 

3 4 `if (WiFi.status() == WL_CONNECTED) {` 5 `wifiConnected = true;` 6 `} else {` 

7 `wifiConnected = false;` 8 `if (now - lastWifiAttemptMs >= WIFI_RETRY_INTERVAL_MS) {` 9 `connectToWiFi();` 10 `lastWifiAttemptMs = millis();` 11 `}` 

12 `}` 

13 14 `if (now - lastSensorReadTime >= SENSOR_READ_INTERVAL) {` 

15 `lastSensorReadTime = now;` 16 `readAllSensors(cachedSoilValue , cachedRainValue ,` 

17 `cachedLightValue , cachedTemp , cachedHum);` 18 19 `if (wifiConnected)` 20 `applyLocalRainSafety(cachedRainValue);` 21 `else` 22 `runOfflinePumpLogic(cachedSoilValue , cachedRainValue);` 

23 

```
}
```

24 25 `if (wifiConnected &&` 26 `now - lastCommandPollTime >= COMMAND_POLL_INTERVAL) {` 27 `lastCommandPollTime = now;` 28 `fetchPumpCommand();` 

29 `}` 

30 

31 `if (wifiConnected &&` 32 `now - lastUploadTime >= SENSOR_UPLOAD_INTERVAL) {` 33 `if (sendSensorDataToBackend(cachedSoilValue , cachedRainValue ,` 34 `cachedLightValue , cachedTemp , cachedHum)) {` 35 `lastUploadTime = now;` 

Software Development 

73 

36 `}` 37 `}` 38 `}` 

**Outcome:** The firmware performs real-time monitoring, backend synchronization, and sensor data upload in a structured and efficient manner. 

### **4.3.6. Snippet 6: Smoothed Sensor Reading** 

To mitigatesensornoise, thefirmwareappliesasmoothingalgorithmfoundin `ESP32_Firmware/final ESP32 code.txt` (Lines 346–353). Analog sensor values are averaged across multiple sequential samples to improve reading stability and prevent false condition triggers [27]. 

1 `int readAnalogSmoothed(uint8_t pin) {` 2 `long sum = 0;` 3 4 `for (int i = 0; i < ANALOG_SAMPLES; i++) {` 5 `sum += analogRead(pin);` 6 `delayMicroseconds(150);` 7 `}` 8 9 `return (int)(sum / ANALOG_SAMPLES);` 10 `}` 

**Outcome:** Sensor readings become more stable and reliable, reducing false triggers caused by noisy analog signals. 

### **4.3.7. Snippet 7: Sensor Data Acquisition** 

As implemented in `ESP32_Firmware/final ESP32 code.txt` (Lines 355–371), the firmware acquires soil moisture, rainfall, light intensity, temperature, and humidity metrics from the connected hardware interfaces [3]. 

1 `bool readDht(float& tempC, float& humPct) {` 

2 `humPct = dht.readHumidity();` 3 `tempC = dht.readTemperature();` 

4 

5 `if (isnan(humPct) || isnan(tempC)) {` 6 `tempC = -999;` 7 `humPct = -999;` 8 `return false;` 9 `}` 

Software Development 

74 

10 

11 `return true;` 12 `}` 13 

14 `void readAllSensors(int& soil, int& rain, int& light,` 15 `float& tempC, float& humPct) {` 16 `soil = readAnalogSmoothed(SOIL_PIN);` 17 `rain = readAnalogSmoothed(RAIN_PIN);` 18 `light = readAnalogSmoothed(LIGHT_PIN);` 19 `readDht(tempC, humPct);` 20 `}` 

**Outcome:** The ESP32 collects all required environmental readings and stores them in cached variables for processing and upload. 

### **4.3.8. Snippet 8: Local Rain Safety Mechanism** 

Detailed in `ESP32_Firmware/final ESP32 code.txt` (Lines 238–263), the system incorporates a zero-latency local rain override. If rainfall is detected, the irrigation pump is immediately forced OFF without requiring network communication to the backend API [4]. 

1 `void applyLocalRainSafety(int rainValue) {` 2 `bool raining = (rainValue < RAIN_THRESHOLD);` 3 4 `if (raining) {` 5 `if (!rainOverrideActive) {` 6 `rainOverrideActive = true;` 7 `turnPumpOff();` 8 `Serial.println("Rain detected: pump OFF");` 9 `}` 10 `return;` 11 `}` 12 13 `if (rainOverrideActive) {` 14 `rainOverrideActive = false;` 15 `int restoreCmd = lastBackendPumpState;` 16 `lastBackendPumpState = -2;` 17 `syncRelayToCommand(restoreCmd , "rain_cleared_restore");` 18 `}` 19 `}` 

**Outcome:** The irrigation pump is protected from running during rainfall, reducing water 

75 

Software Development 

wastage and improving system safety. 

### **4.3.9. Snippet 9: Backend Command Polling** 

As coded in `ESP32_Firmware/final ESP32 code.txt` (Lines 270–312), the ESP32 polls the backend via an HTTP GET request to retrieve the latest pump command sent from the mobile application or backend automation logic [21]. 

1 `bool fetchPumpCommand() {` 

2 `if (WiFi.status() != WL_CONNECTED) return false;` 

3 

4 `WiFiClientSecure secureClient;` 

5 `HTTPClient http;` 6 

7 

8 

```
Stringendpoint=String("https://")+BACKEND_HOST+
COMMAND_PATH+deviceId;
```

9 

10 `secureClient.setInsecure();` 

```
if(!http.begin(secureClient ,endpoint))returnfalse;
```

11 12 13 `int code = http.GET();` 14 15 `if (code == 200) {` 16 `String response = http.getString();` 17 `StaticJsonDocument <128> doc;` 18 19 `if (!deserializeJson(doc, response) &&` 20 `doc.containsKey("pump_status")) {` 21 `int commanded =` 22 `const char* reason = doc["pump_reason"]` 23 `syncRelayToCommand(commanded ,` 24 `}` 

20 `doc.containsKey("pump_status")) {` 21 `int commanded = doc["pump_status"].as<int>();` 22 `const char* reason = doc["pump_reason"] | "unknown";` 23 `syncRelayToCommand(commanded , reason);` 24 `}` 25 `}` 26 27 `http.end();` 28 `return code == 200;` 29 `}` 

**Outcome:** The field device stays synchronized with backend pump commands and supports remote irrigation control from the application. 

76 

Software Development 

### **4.3.10. Snippet 10: Relay Synchronization Logic** 

Located in `ESP32_Firmware/final ESP32 code.txt` (Lines 320–341), the relay synchronization function applies backend commands only when the desired pump state differs from the current state. Furthermore, it explicitly blocks remote ON commands if the local rain override is active [26]. 

1 `void syncRelayToCommand(int commanded , const char* reason) {` 2 `if (rainOverrideActive && commanded == 1) {` 3 `Serial.println("Command blocked due to rain override");` 4 `return;` 5 `}` 6 7 `if (commanded == lastBackendPumpState) {` 8 `return;` 9 `}` 10 11 `lastBackendPumpState = commanded;` 12 13 `if (commanded == 1 && !pumpRunning) {` 14 `turnPumpOn();` 15 `} else if (commanded == 0 && pumpRunning) {` 16 `turnPumpOff();` 17 `}` 18 `}` 

**Outcome:** The relay avoids unnecessary repeated switching and ensures backend commands cannot override local rain safety. 

### **4.3.11. Snippet 11: Relay-Based Pump Control** 

Described in `ESP32_Firmware/final ESP32 code.txt` (Lines 463–472), the irrigation pump is controlled via an active-low relay module. Setting the relay pin LOW turns the pump ON, while setting it HIGH turns the pump OFF. 

1 `void turnPumpOn() {` 2 `digitalWrite(RELAY_PIN , LOW);` 3 `pumpRunning = true;` 4 `pumpStartTime = millis();` 5 `}` 

6 7 `void turnPumpOff() {` 

Software Development 

77 

8 `digitalWrite(RELAY_PIN , HIGH);` 9 `pumpRunning = false;` 10 `}` 

**Outcome:** The system can physically control the irrigation pump through the ESP32 and relay module. 

### **4.3.12. Snippet 12: Offline Irrigation Logic** 

Defined in `ESP32_Firmware/final ESP32 code.txt` (Lines 412–458), an offline fallback mechanism ensures that if Wi-Fi is disconnected, the ESP32 autonomously continues irrigation control locally using its direct soil moisture and rainfall sensor inputs [28]. 

1 `void runOfflinePumpLogic(int soilValue , int rainValue) {` 2 `bool raining = (rainValue < RAIN_THRESHOLD);` 3 `bool soilWet = (soilValue < SOIL_WET_THRESHOLD);` 4 `bool soilDry = (soilValue > SOIL_DRY_THRESHOLD);` 5 6 `if (soilDry) requestedPumpState = true;` 7 `else if (soilWet) requestedPumpState = false;` 8 9 `if (raining) {` 10 `rainOverrideActive = true;` 11 `if (pumpRunning) turnPumpOff();` 12 `return;` 13 `}` 14 15 `if (soilWet && pumpRunning &&` 16 `millis() - pumpStartTime >= PUMP_MIN_RUN_TIME) {` 17 `turnPumpOff();` 18 `return;` 19 `}` 20 21 `if (requestedPumpState && !pumpRunning) {` 22 `turnPumpOn();` 23 `}` 24 `}` 

**Outcome:** The irrigation system remains functional even when internet connectivity is unavailable. 

Software Development 

78 

### **4.3.13. Snippet 13: Wi-Fi Connectivity and Reconnection** 

As seen in `ESP32_Firmware/final ESP32 code.txt` (Lines 477–495), the ESP32 connects to Wi-Fi in station mode and updates its global connection state flag. If the connection drops or fails, the firmware bypasses network uploads and routes execution to the offline safety logic [20]. 

1 `void connectToWiFi() {` 2 `if (WiFi.status() == WL_CONNECTED) {` 3 `wifiConnected = true;` 4 `return;` 5 `}` 6 7 `WiFi.mode(WIFI_STA);` 8 `WiFi.begin("Your_SSID", "Your_Password");` 9 10 `unsigned long startTime = millis();` 11 `while (WiFi.status() != WL_CONNECTED &&` 12 `millis() - startTime < 12000) {` 13 `delay(400);` 14 `}` 15 16 `wifiConnected = (WiFi.status() == WL_CONNECTED);` 17 `}` 

**Outcome:** The firmware supports automatic Wi-Fi connection handling while maintaining system operation in offline mode. 

### **4.3.14. Snippet 14: Sensor Value Conversion** 

Detailed in `ESP32_Firmware/final ESP32 code.txt` (Lines 500–506), raw 12-bit analog values (0–4095) are linearly mapped and constrained into percentage values (0–100%) before transmission to the backend, standardizing the data format. 

1 `float convertSoilMoistureToPercentage(int rawValue) {` 2 `return constrain((float)map(rawValue , 0, 4095, 100, 0),` 3 `0.0f, 100.0f);` 4 `}` 5 6 `float convertLightToPercentage(int rawValue) {` 7 `return constrain((float)map(rawValue , 0, 4095, 100, 0),` 8 `0.0f, 100.0f);` 

Software Development 

79 

9 `}` 

**Outcome:** Raw ADC readings are normalized into user-friendly percentage values for dashboard visualization and backend processing. 

### **4.3.15. Snippet 15: Sensor Data Upload to Backend** 

Finally, in `ESP32_Firmware/final ESP32 code.txt` (Lines 530–605), the firmware constructs a JSON payload containing the device ID, normalized sensor values, rainfall status, and current pump state. This telemetry data is uploaded to the Node.js backend API using an HTTP POST request [21]. 

1 `bool sendSensorDataToBackend(int soilRaw , int rainRaw ,` 2 `int lightRaw , float temp,` 3 `float hum) {` 4 `if (WiFi.status() != WL_CONNECTED) return false;` 

5 

6 

7 

8 

9 

10 

11 12 

13 

14 

15 

16 

17 

18 19 

20 

```
floatsoilMoisture=
```

```
convertSoilMoistureToPercentage(soilRaw);
floatlightIntensity=
```

```
convertLightToPercentage(lightRaw);
boolraining=(rainRaw<RAIN_THRESHOLD);
```

```
StaticJsonDocument <384>doc;
doc["device_id"]=deviceId;
doc["soil_moisture"]=soilMoisture;
doc["light_intensity"]=lightIntensity;
doc["rainfall"]=raining;
doc["pump_on"]=pumpRunning?1:0;
if(temp!=-999)doc["temperature"]=temp;
if(hum!=-999)doc["humidity"]=hum;
```

21 

22 

23 

```
StringjsonString;
serializeJson(doc,jsonString);
```

24 

25 

26 

```
WiFiClientSecuresecureClient;
HTTPClienthttp;
```

27 

28 

29 

```
Stringendpoint=String("https://")+
BACKEND_HOST+API_PATH;
secureClient.setInsecure();
```

30 

Software Development 

80 

31 

32 `http.begin(secureClient , endpoint);` 

33 `http.addHeader("Content -Type", "application/json");` 

34 

35 `int code = http.POST(jsonString);` 36 `http.end();` 37 

38 `return (code == 200 || code == 201);` 39 `}` 

**Outcome:** Sensor readings are successfully transmitted to the backend for database storage, alerts, analytics, and application display. 

## **4.4. Implementation Challenges and Resolutions** 

During implementation, several challenges were encountered and resolved [27]: **Noisy Sensor Readings:** Soil moisture and rain sensors produced unstable values in early tests. This was resolved by applying filtering, threshold smoothing, and debouncing logic [27]. **Intermittent Wi-Fi Connectivity:** Network dropouts caused missed telemetry uploads. Automatic reconnect and retry mechanisms were introduced in firmware [20]. **Consistent Data Synchronization:** Ensuring the dashboard always reflects the latest reading required consistent timestamp handling and backend validation [22]. 

## **4.5. Summary** 

This chapter presented the implementation details of the Smart AI Powered Agriculture System, including embedded firmware, backend services, mobile application logic, notifications, and AI-based crop recommendations [24]. The described modules directly implement the requirements defined in Chapter 2 and conform to the system design presented in Chapter 3. 

81 

# **Chapter 5** 

# **5. Software Deployment** 

This chapter describes the installation and deployment process of the Smart AI Powered Agriculture System. The deployment includes four major deliverables: (1) ESP32 firmware on the field unit, (2) backend server deployment, (3) database configuration, and (4) mobile application installation. The goal is to ensure the complete system can be set up reliably and used by end users (farmers) with minimal technical effort. 

## **5.1. Installation / Deployment Process Description** 

### **5.1.1. Deployment Overview** 

The deployment is performed in the following order to ensure correct integration: First, prepare and connect hardware components (sensors, ESP32, relay, pump). Next, flash ESP32 firmware and configure Wi-Fi/device identifiers. Then, deploy backend services (Node.js) and configure environment variables. Following that, configure the database (MySQL). Subsequently, install and connect the mobile application to the backend. Finally, perform end-to-end verification (live readings, control actions, alerts, and AI output). 

### **5.1.2. Hardware Setup and Field Installation** 

The field unit installation ensures correct sensor placement and safe electrical connections. **ESP32 and Sensors:** Connect soil moisture sensor to ESP32 ADC pin, DHT22 to digital pin, LDR to ADC pin, rain sensor to digital pin, and flow sensor to interrupt-capable pin. **Relay and Pump/Valve:** Relay input is connected to ESP32 GPIO output. The relay output is wired to the pump/valve power line to allow switching. **Power:** Use regulated supply for ESP32 and sensors. If the pump requires higher voltage/current, use a separate power source with proper isolation. **Placement:** Soil moisture sensor is inserted into soil near crop roots; rain sensor is placed in open air; flow sensor is installed inline with irrigation pipe. 

**Safety Note:** Electrical wiring for pumps should be performed using proper insulation, fuses, and safe grounding to prevent hazards. 



<!-- Start of picture text -->
~<br>3<br>classwidgetreturnProtoil! AlePagestateSeattoldQuildconterxtextends:contextsStatecProtilerager —— - ‘& re “ > \<br>ody:ehiterentStack! ' ~~-_ ee<br>rights &<br>etghts covrapsedtelgnts :<br>enitdr Containert “ . .<br>colort Colors transparents S<br>ehitarpadding:PaddingEdgetnsetssonly opr topinset + 10-h)s<br>ehitdscLipbenavior’enitagenscenterStackehitaropacity?t Opacity’Clip.none,ar Leopacitys os . — \<br>ehirds Text<br>“profiles<br>gtytercolorsTextstyleColors.wniter ei —<br>fontSizetgontweight?18.50)Fontweight.w700> \ | — — SS<br>i ‘<br>3 we a - (Ss<br>—<br>ie ae wae SS 3,<br>@B > Aihe i}\ ea =a,\<br>— % oe 7SX , \|- \ ee \<br>=e<S ne “ éyr ‘$ ; isVNLnON<br>\ AW i,<br>x Jue \ : rba"t \ \ \ Re%, \ < ol~_Sy ty sa } \e\ e~ »|<br>= - a "i ‘& |, Te \<br>t| contro! ‘option command .<br>* 4 6Z ingA‘ \ > ge<br>P ™<br>i E \ a\, Ps =n=<br>1) ¥ \ —_<br>7 Los“.<br>i pions a aet ¥<br>= —peaigee = cy _ ~<br>vie4 . q , be ¥7 - ; * ~<br>a ‘ ” ‘<br><!-- End of picture text -->

Software Deployment 

83 



_Figure 5-2: Final Waterproofed Ready-to-Use Hardware Prototype_ 

### **5.1.4. ESP32 Firmware Deployment** 

The firmware is uploaded using Arduino IDE and configured for the target farm environment. 

### **5.1.5. Firmware Flashing Steps** 

First, install Arduino IDE and ESP32 board support packages. Next, connect ESP32 to a computer via USB. Then, select the correct ESP32 board and COM port in Arduino IDE. Following that, update configuration parameters in the firmware: [leftmargin=1.2cm] Subsequently, wi-Fi SSID and password First, backend base URL (API endpoint) Next, device ID / Field ID mapping Then, default moisture thresholds (initial values) Finally, upload the firmware to ESP32 and monitor serial logs for confirmation. 

### **5.1.6. Post-Flash Verification** 

Confirm Wi-Fi connection is established. Confirm sensor values are printed in serial logs. Confirm telemetry requests are reaching the backend (HTTP 200 OK). Confirm relay toggles correctly in manual test mode. 

Software Deployment 

84 

## **5.2. Backend Deployment (Node.js Server)** 

The backend server hosts REST APIs for device ingestion, user authentication, dashboard data, irrigation control, alerts, and AI recommendation requests. 

### **5.2.1. Backend Installation Requirements** 

Node.js runtime (LTS recommended) Package manager (npm) Firebase Admin SDK credentials (for Firebase option) MySQL credentials (if MySQL option is enabled) 

### **5.2.2. Backend Deployment Steps** 

1. Clone/copy backend source code to the target server machine. 

2. Install dependencies: 

```
npminstall
```

3. Configure environment variables (example): 

```
PORT=8080
```

```
JWT_SECRET=your_secret_key
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_SERVICE_ACCOUNT=path_to_service_account.json
MYSQL_HOST=localhost
MYSQL_USER=root
MYSQL_PASSWORD=******
MYSQL_DB=smart_agri
AI_SERVICE_URL=http://<ai-host>:5000
```

4. Start the backend service: 

```
npmstart
```

5. Verify health endpoint and API availability using a browser or API tool (e.g., Postman). 

### **5.2.3. Backend Deployment Modes** 

**Local Server Mode:** Suitable for demos and lab testing (same network). **Cloud Server Mode:** Recommended for remote access by farmers outside the local network. 



<!-- Start of picture text -->
€ G &_ douddigitalocean.com/apps/dch9? eff-OBth-4774-8799-4ec36d02 dt 5e7400 ® o + @:<br>Cy J<br>Home<br>Launchpad (29) © BacktoA '<br>(=) backend Add components<br>@ New Project @ Healthy + ©& Smart Ac . SP1 + & hit 7 tinon<br>By first-project<br>Smart Agricutture<br>Overview Insights Activity Runtime Logs Console Networking Settings<br>‘COMPONENTS NETWORKING<br>Cvenieal Web Services Last 5m Public static Ingress IPs<br>Inference Router smart-agriculture-al-m cPU RAM 162.159.14@.98 Va)<br>Dedicated Inference {instance 2% 71%<br>ServerlessBatch Inference Inference (J wr= Unstanesmart-aariculture-back cpu2% 24%RAM 172.66.0.9672.6 tsa<br>AgentModel CatalogPlatform Databases RECENT ACTIVITY<br>Mijanage 8., db-mysqksgpi-76095t Mn I V/_ Restarted app instances<br>May 14 at 11:31:41 * @ hamibashir + view detail<br>Droplets v a Dea. acd pianos v<br><!-- End of picture text -->



<!-- Start of picture text -->
ck DagitalOcean Apy x @ apunamzabasher.onine/heatth =x + - t x<br>€ @ — % apihamzabashir.online/health * O14 @:<br>pretty-print<br>{"success":true, "message": "Smart Agriculture API is running", "timestamp": "2826-O6-2611/:28: 33.4342", “environment”: “production”<br><!-- End of picture text -->

86 

Software Deployment 

mendations. MySQL ensures data integrity through foreign key constraints and supports complex queries for analytics and reporting. 

### **5.3.1. MySQL Database Setup** 

1. Install MySQL Server (or MariaDB) and start the service: 

```
sudosystemctlstartmysql
```

```
sudosystemctlenablemysql
```

2. Create the database and user: 

```
CREATEDATABASEsmart_agriculture;
```

```
CREATEUSER’smart_agri_user’@’localhost’
```

```
IDENTIFIEDBY’secure_password’;
```

```
GRANTALLPRIVILEGESONsmart_agriculture.*
```

```
TO’smart_agri_user’@’localhost’;
```

```
FLUSHPRIVILEGES;
```

3. Import the database schema (11 tables): 

```
mysql-usmart_agri_user-psmart_agriculture
<schema.sql
```

4. Core tables created: **User & Field Management:** users, fields **Sensor & Telemetry:** sensors, sensor_readings **Irrigation:** irrigation_logs, irrigation_schedules **Alerts & AI:** alerts, crop_recommendations **System:** weather_data, system_settings, audit_logs 

5. Configure indexes for performance optimization: Index on (sensor_id, reading_time) for sensor_readings table Index on (field_id) for all related tables Index on (user_id) for authentication queries Index on timestamps for time-series queries 

6. Set up database connection in backend (Node.js): 

```
constmysql=require(’mysql2/promise’);
constpool=mysql.createPool({
```

```
host:’localhost’,
user:’smart_agri_user’,
password:process.env.DB_PASSWORD,
```

```
database:’smart_agriculture’,
```

Software Deployment 

87 

```
waitForConnections:true,
```

```
connectionLimit:10
```

```
});
```

7. Verify database connectivity: 

```
SELECTCOUNT(*)FROMusers;
```

```
SELECT*FROMsensorsWHEREis_active=1;
```

## **5.4. AI Service Deployment (Python)** 

The AI service provides crop recommendations based on extracted features from sensor history and environmental context. 

### **5.4.1. Deployment Steps** 

1. Set up Python environment (virtual environment recommended). 

2. Install required libraries. 

3. Place the trained model file in the service directory. 

4. Run the AI service API (example): 

```
pythonapp.py
```

5. Configure backend `AI_SERVICE_URL` to connect to the AI endpoint. 

### **5.4.2. AI Verification** 

Send a test request with sample feature payload. Confirm response contains recommended crop(s) and confidence score. 



<!-- Start of picture text -->
backend - DigitalOcean App x  @ aihamzabashir.online/heatth x = +<br>€ Cc %3 aihamzabashir.online/health<br>Pretty-print<br>{<br>“crops_supported": [<br>“chickpea”,<br>“cotton",<br>“maize”,<br>“mustard”,<br>"rice",<br>"sugarcane",<br>“sunflower",<br>“wheat”<br>lL,<br>“cv_accuracy”: "85.79%",<br>“foatures": [<br>“soil moisture",<br>“temperature”,<br>“humidity”,<br>“soil _type_enc",<br>“season_enc™<br>1,<br>“model_accuracy": "87.86%",<br>“status”: “ok”<br><!-- End of picture text -->

Software Deployment 

89 

### **5.5.2. Mobile Verification Checklist** 

Live readings update correctly on dashboard. Manual irrigation control toggles pump. Alerts appear in the app and push notifications are received. Weekly trends / historical charts load from stored data. AI recommendation screen returns crop suggestions with confidence. 

## **5.6. End-to-End System Validation** 

After deployment, the complete system is validated using a practical checklist to ensure correct integration: 

First, **Telemetry Check:** ESP32 sends readings and backend stores them successfully. Next, **Dashboard Check:** Mobile app displays live readings and device status. Then, **Automation Check:** When soil moisture drops below threshold, irrigation triggers automatically (rain condition blocks irrigation). Following that, **Logging Check:** Irrigation events and water usage logs are recorded. Subsequently, **Alert Check:** Critical low moisture generates a push notification. Finally, **AI Check:** Crop recommendation is produced from recent/historical data with confidence score. 

## **5.7. Summary** 

This chapter described the deployment of the Smart AI Powered Agriculture System, including hardware installation, ESP32 firmware flashing, backend and database configuration, AI service deployment, and mobile application setup. A final validation checklist was provided to confirm end-to-end system correctness after installation. 

90 

# **Chapter 6** 

# **6. System Testing** 

This chapter presents the formal testing of the Smart AI Powered Agriculture System. Testing was conducted across four levels: **Unit Testing** , **Component Testing** , **Integration Testing** , and **System Testing** . Each test case is documented with its objective, inputs, expected result, and actual result to ensure complete coverage and traceability of all system requirements defined in Chapter 2 [10], [16]. 

## **6.1. Unit Testing** 

Unit testing verifies the correctness of individual software units and firmware functions in isolation, independent of other modules [10]. The following unit tests cover user authentication, sensor reading functions, data conversion logic, threshold evaluation, AI model output, and push notification dispatch. 

### **6.1.1. TC-UT-01: User Registration with Valid Data** 

|**Date:** 10th January 2026||
|---|---|
|**System:** Node.js Backend — User Aut|hentication Module|
|**Objective:** Verify that a new user<br>account is created successfully in the<br>`users`table when valid registration<br>data is submitted to the registration<br>API endpoint.|**Test ID:**TC-UT-01|
|**Version:** 1|**Test Type:** Unit Testing|
|**Input:**||
|Full Name: Ali Khan<br>Email: ali.khan@test.com<br>Phone: +923001234567||
|Password: Pass@1234||



System Testing 

91 

**Expected Result:** System creates a new record in the `users` table, hashes the password using bcrypt, assigns a unique `user_id` , and returns HTTP 201 Created with the new user profile. 

**Actual Result:** Passed. New user created successfully. `user_id` assigned and password stored as bcrypt hash in database. 

### **6.1.2. TC-UT-02: User Login with Valid Credentials** 

**Date:** 10th January 2026 **System:** Node.js Backend — JWT Authentication Module **Objective:** Verify that a registered **Test ID:** TC-UT-02 user can authenticate and receive a valid JWT token upon providing correct login credentials. **Version:** 1 **Test Type:** Unit Testing **Input:** 

Email: ali.khan@test.com Password: Pass@1234 

**Expected Result:** System validates credentials against hashed password in database, generates a signed JWT access token containing `user_id` , role, and expiry, and returns HTTP 200 OK with token in response body. 

**Actual Result:** Passed. JWT token generated successfully. Token contains correct `user_id` , role (farmer), and expiry timestamp. 

### **6.1.3. TC-UT-03: User Login with Invalid Password** 

**Date:** 10th January 2026 

**System:** Node.js Backend — JWT Authentication Module 

System Testing 

92 

|**Objective:** Verify that the system<br>correctly rejects login attempts when<br>an incorrect password is provided,<br>without leaking account existence<br>information.|**Test ID:**TC-UT-03|
|---|---|
|**Version:** 1|**Test Type:** Unit Testing|
|**Input:**||
|Email: ali.khan@test.com<br>Password: WrongPass99||
|**Expected Result:** System returns HTT<br>email or password”. No JWT token is i<br>revealed.|P 401 Unauthorized with error message “Invalid<br>ssued and no sensitive account information is|



**Actual Result:** Passed. HTTP 401 returned correctly. Login rejected with appropriate error message. No token issued. 

### **6.1.4. TC-UT-04: Soil Moisture Sensor Smoothed Reading** 

|**Date:** 12th January 2026||
|---|---|
|**System:** ESP32 Firmware — Sensor D|ata Acquisition Module|
|**Objective:** Verify that the smoothed<br>analog reading function correctly<br>averages multiple ADC samples from<br>the soil moisture sensor to produce a<br>stable, noise-reduced output value.<br>|**Test ID:**TC-UT-04<br>|
|**Version:** 1|**Test Type:** Unit Testing|
|**Input:**||
|Simulated ADC raw readings from GPI<br>Samples: [2800, 2810, 2795, 2805, 280<br>ANALOG_SAMPLES = 5<br>**Expected Result:** Function sums all f<br>(2800+2810+2795+2805+2800)/5 = 28|O 36 (SOIL_PIN):<br>0]<br>ve samples and returns the integer average:<br>02. Result returned within 1 second of invocation.|



System Testing 

93 

**Actual Result:** Passed. Function returned 2802. Smoothed reading matches expected averaged value correctly. 

### **6.1.5. TC-UT-05: Soil Moisture Percentage Conversion** 

**Date:** 12th January 2026 **System:** ESP32 Firmware — Sensor Value Conversion Module **Objective:** Verify that raw ADC soil **Test ID:** TC-UT-05 moisture values are correctly converted to percentage values constrained between 0% and 100%. **Version:** 1 **Test Type:** Unit Testing **Input:** Raw ADC Input Value: 2048 ADC Resolution: 12-bit (Range: 0 to 4095) Mapping: 0 ADC = 100% moisture, 4095 ADC = 0% moisture **Expected Result:** Function maps 2048 from [0, 4095] to [100, 0] and returns approximately 50%. Result is constrained between 0.0 and 100.0 using `constrain()` . 

**Actual Result:** Passed. Function returned 50.02%. Conversion accurate and within expected range boundaries. 

### **6.1.6. TC-UT-06: DHT22 Temperature and Humidity Reading** 

**Date:** 12th January 2026 **System:** ESP32 Firmware — DHT22 Sensor Module 

System Testing 

94 

|**Objective:** Verify that the DHT22<br>reading function returns valid<br>temperature and humidity values and|**Test ID:**TC-UT-06|
|---|---|
|handles NaN sensor errors gracefully||
|by returning a sentinel error value.||
|**Version:** 1|**Test Type:** Unit Testing|
|**Input:**||



DHT22 sensor connected to GPIO 4 (DHT_PIN). Simulated ambient conditions: Temperature: 30.0°C Humidity: 65.0% 

**Expected Result:** Function returns `tempC = 30.0` and `humPct = 65.0` without NaN. Returns `true` indicating a successful reading. If NaN occurs, returns `tempC = -999` and `false` . 

**Actual Result:** Passed. Temperature 30.0°C and humidity 65.0% returned correctly. NaN error handling verified with simulated failure. 

### **6.1.7. TC-UT-07: Dry Soil Threshold Evaluation** 

|**Date:** 13th January 2026||
|---|---|
|**System:** ESP32 Firmware — Local T|hreshold Logic Module|
|**Objective:** Verify that the ofine<br>pump logic correctly identifes a dry<br>soil condition and sets the irrigation<br>request fag when the raw moisture<br>reading exceeds the dry threshold.|**Test ID:**TC-UT-07|
|**Version:** 1|**Test Type:** Unit Testing|
|**Input:**||
|Raw Soil Moisture Value: 3000<br>SOIL_DRY_THRESHOLD = 2800||
|SOIL_WET_THRESHOLD = 1200||



95 

System Testing 

**Expected Result:** Since 3000 > 2800 (dry threshold condition), `requestedPumpState` is set to `true` , indicating that irrigation should be triggered. 

**Actual Result:** Passed. Pump request flag correctly set to `true` when raw soil reading exceeded dry threshold. 

### **6.1.8. TC-UT-08: Rain Detection Logic** 

|**Date:** 13th January 2026||
|---|---|
|**System:** ESP32 Firmware — Rain Saf|ety Module|
|**Objective:** Verify that the rain<br>detection logic correctly identifes a<br>rainfall condition when the rain<br>sensor analog value falls below the<br>confgured rain threshold.|**Test ID:**TC-UT-08|
|**Version:** 1|**Test Type:** Unit Testing|
|**Input:**||



Raw Rain Sensor Value: 1500 RAIN_THRESHOLD = 2000 

**Expected Result:** Since 1500 < 2000 (rain threshold), the `raining` boolean evaluates to `true` and the `rainOverrideActive` flag is set, blocking any pump ON commands. 

**Actual Result:** Passed. Rain condition correctly identified. Override flag activated. Irrigation correctly blocked. 

### **6.1.9. TC-UT-09: AI Crop Recommendation Model Output** 

**Date:** 15th January 2026 

**System:** Python AI Service — Crop Recommendation ML Model 







<!-- Start of picture text -->
oO Explorer : : Jutput 1g Con: Terminal ort<br>Smart-Agriculture . . .<br>ideajes PSPS C:\Users\Admin\Documents\Github\smart-Agriculture>C:\Users\Admin\Documents\Github\smart-Agriculture\AIl_Model>cd AI_Modelpython train_model.py<br>xn v Al Modelpycache eeeSmart Agricultureeee- Crop RecommendationeeeModel<br>Jataset —————————————————————————————<br>crop_dataset.csvDh @ Dataset loaded: 2800 rows, 6 columns<br>“ mode' Crops in dataset: [‘maize’, ‘wheat’, ‘sugarcane’, ‘sunflower’, ‘mustard’, ‘rice’, ‘cotton’, ‘chickpea’ ]<br>® crop_model.pkl Seasons: [‘kharif*, ‘rabi*]<br>® le_crop.pk Soil types: [‘loamy’, ‘silty’, ‘clay’, ‘sandy’, ‘clay loam’]<br>® leatseason.pk @ Train:P 2240 rows | Test: 560 rows<br>® le _soil.pkl<br>mappingsjson @ Model trained successfully!<br>aPP-PYltaenerate_data.pySol; MiMi Testcross-valr Accuracy- (5-fold):: 87.86%\ ~85.79%oY + 2.15%ty<br>passenger_wsgi.py<br>requirements.txt Wi Per-class Report:<br>Tage precision recall f1-scor support<br>Backend chickpea 0.76— Q.79a @.77as 78=<br># Database cotton 0.91 0.99 8.95 78<br>> ESP32_Firmware maize 8.91 0.87 8.89 78<br>FlutterAFlutterApp mustard= 8.93 0.96 0.94 78<br>rice 8.93 0.89 0.91 78<br>mage sugarcane @.82 0.91 0.86 78<br>port sunflower 6.94 0.83 0.88 78<br>© gitattributes wheat 8.85 0.80 0.82 78<br>Mid_Exam_ll_FYP<br>accuracy 6.88 560<br>™+ README.md<br>macro avg 0.88 0.88 6.88 560<br>“* Report Evaluation weighted avg 0.88 0.88 6.88 560<br><!-- End of picture text -->



<!-- Start of picture text -->
ie Explorer oes Terminal &) pow<br>v Smart-Agriculture<br>toca Wi Feature Importances:<br>Al_Model soil moisture @.2941<br>0 > __pycache_ temperature 8.1951<br>dataset humidity @.1651<br>crop_dataset.csv soilseasontype_encenc @.1549@.1908<br>v model<br>® crop_model.pkl Mi Model saved to model/crop model.pkl<br>& le crop.pki @ Encoders saved to model/ ;<br>® le_season.pk @ Mappings saved to model/mappings. json<br># le soil.pkl<br>mappings.json LIVE PREDICTION TEST<br>app-py Oe<br>nother Input: moisture=42%, temp=28°C, soil=loamy, season=rabi<br>generate_data.py Predicted: CHICKPEA (62.5%) | Should + Wheat<br>passenger_wsgl.py<br>requirements.txt Input: moisture=70%, temp=32°C, soil=clay, season=kharif<br>t rain_model.pyarieion Predicted: SUGARCANE (61.38%) | Should + Rice<br>Backend Input: moisture=36%,a temp=31°C,o soil=sandy,- season=kharifa3<br># Database Predicted: COTTON (94.59%) | Should + Cotton<br>> ESP32_Firmware<br>> FlutterApp Input: moisture=55%, temp=25°C, soil=loamy, season=kharif<br>, images Predicted: MAIZE (81.34%) | Should + Maize<br>? Report Input: moisture=28%, temp=19°C, soil=sandy, season=rabi<br>© gitattributes Predicted: MUSTARD (98.11%) | Should + Mustard<br>Mid_Exam_ll_FYP.<br>™+ README.md- " aTraining Complete! Next: run app.py (Flask API)<br>™+ Report Evaluation sa5=5=5=5==5=5=5=5=5=5555=5=5=5=5=55555555===55=5=5=5=======<br><!-- End of picture text -->

System Testing 

98 

synthetic dataset, causing the decision trees’ probabilities to be distributed across both valid classes. 

### **6.1.10. TC-UT-10: Firebase Push Notification Dispatch** 

**Date:** 15th January 2026 **System:** Node.js Backend — Firebase Cloud Messaging (FCM) Module **Objective:** Verify that the FCM **Test ID:** TC-UT-10 notification function successfully delivers a push notification to a registered device token when invoked with a valid critical alert payload. **Version:** 1 **Test Type:** Unit Testing **Input:** Alert Type: Critical Alert Category: Soil Moisture Notification Title: “Critical: Low Soil Moisture” Message: “Soil moisture is at 10%. Irrigation required.” FCM Device Token: [Valid Registered Test Token] 

**Expected Result:** FCM HTTP v1 API accepts the request and returns a success `message_id` confirming delivery to the target device. Backend sets `push_notification_sent = 1` in `alerts` table. 

**Actual Result:** Passed. Push notification delivered successfully. FCM returned valid `message_id` . Database flag updated. 

## **6.2. Component Testing** 

Component testing validates that individual functional modules of the system operate correctly as complete units, including their full internal logic, data handling, and error management [10]. 

### **6.2.1. TC-CT-01: Automatic Irrigation Trigger Component** 

System Testing 

99 

|**Date:** 18th January 2026||
|---|---|
|**System:** ESP32 Firmware + Relay Mo|dule — Automated Irrigation Component|
|**Objective:** Verify that the automatic<br>irrigation component correctly<br>activates the relay-driven water pump<br>when soil moisture drops below the<br>confgured threshold, without any<br>manual user intervention.|**Test ID:**TC-CT-01|
|**Version:** 1|**Test Type:** Component Testing|
|**Input:**||



Auto-irrigation mode: Enabled Configured Soil Moisture Threshold: 30% Simulated Soil Moisture Reading: 22% Rain Sensor Reading: No Rain (value > 2000) 

**Expected Result:** System evaluates 22% against 30% threshold, determines irrigation required, activates relay by setting GPIO 14 LOW, sets `pumpRunning = true` , and records `pumpStartTime` for duration tracking. 

**Actual Result:** Passed. Relay activated correctly. Pump status updated to ON. Irrigation started automatically without user input. 

### **6.2.2. TC-CT-02: Rain Safety Override Component** 

|**Date:** 18th January 2026||
|---|---|
|**System:** ESP32 Firmware — Rain Ov|erride Safety Component|
|**Objective:** Verify that the local rain<br>safety override component<br>immediately stops the active<br>irrigation pump when rainfall is<br>detected, regardless of the current<br>backend pump command state.|**Test ID:**TC-CT-02|
|**Version:** 1|**Test Type:** Component Testing|
|**Input:**||



System Testing 

100 

Pump Initial State: ON ( `pumpRunning = true` ) Rain Sensor Reading: 1200 (below RAIN_THRESHOLD = 2000) Last Backend Command: pump_status = 1 (ON) 

**Expected Result:** System detects rain, sets `rainOverrideActive = true` , calls `turnPumpOff()` , sets GPIO 14 HIGH, and returns without executing any subsequent ON commands from the backend during active rain override. 

**Actual Result:** Passed. Pump stopped immediately upon rain detection. Backend ON command blocked while rain override was active. Relay set HIGH confirmed via serial monitor. 

### **6.2.3. TC-CT-03: Offline Irrigation Control Component** 

**Date:** 19th January 2026 **System:** ESP32 Firmware — Offline Pump Logic Component **Objective:** Verify that the ESP32 **Test ID:** TC-CT-03 maintains correct local irrigation control when Wi-Fi is disconnected, using only onboard sensor readings for all irrigation decisions. **Version:** 1 **Test Type:** Component Testing **Input:** 

Wi-Fi Status: Disconnected (WL_CONNECTED = false) Raw Soil Moisture: 3100 (above DRY_THRESHOLD = 2800) Rain Sensor Reading: No Rain 

**Expected Result:** System enters offline mode, evaluates dry soil condition locally using `runOfflinePumpLogic()` , sets `requestedPumpState = true` , and activates the irrigation pump without any backend communication. 

**Actual Result:** Passed. Offline pump logic activated irrigation correctly. System maintained full irrigation control without network connectivity. 

System Testing 

101 

### **6.2.4. TC-CT-04: Critical Alert Generation Component** 

**Date:** 20th January 2026 

|**System:** Node.js Backend — Alert Ge|neration and Storage Component|
|---|---|
|**Objective:** Verify that the backend<br>alert component creates a critical<br>alert record in the database and<br>dispatches a push notifcation when a<br>critical soil moisture reading is<br>received from the ESP32.|**Test ID:**TC-CT-04|
|**Version:** 1|**Test Type:** Component Testing|
|**Input:**||



Incoming Sensor Reading: soil_moisture = 10% Configured Critical Threshold: 15% Field ID: 6, User ID: 3 

**Expected Result:** Backend evaluates threshold condition, creates a new record in `alerts` table with `alert_type = critical` and `alert_category = soil_moisture` , dispatches FCM notification, and sets `push_notification_sent = 1` . 

**Actual Result:** Passed. Critical alert record created in database. Push notification dispatched via FCM within 2 seconds. 

### **6.2.5. TC-CT-05: Historical Data Retrieval Component** 

|**Date:** 20th January 2026||
|---|---|
|**System:** Node.js Backend — Historica|l Analytics API Component|
|**Objective:** Verify that the historical<br>data retrieval component correctly<br>queries and returns fltered sensor<br>readings for a given feld and date<br>range, using the composite database<br>index for performance.|**Test ID:**TC-CT-05|
|**Version:** 1|**Test Type:** Component Testing|



System Testing 

102 

#### **Input:** 

Field ID: 6 Date Range: Last 7 days Data Type: Soil Moisture readings API Endpoint: GET /api/analytics/field/6?range=7d 

**Expected Result:** Backend queries `sensor_readings` using composite index on ( `sensor_id` , `reading_time` ), returns an ordered JSON array of moisture readings with timestamps for the requested date range. 

**Actual Result:** Passed. 168 data points returned correctly for 7-day period. Query completed in 120ms. Timestamps and moisture values verified against database records. 

### **6.2.6. TC-CT-06: Manual Irrigation Control Component** 

**Date:** 21st January 2026 

**System:** Mobile App + Node.js Backend — Manual Irrigation Control Component **Objective:** Verify that a manual **Test ID:** TC-CT-06 pump ON command issued from the mobile application is received and stored by the backend, then fetched and executed correctly by the ESP32 within its polling interval. **Version:** 1 **Test Type:** Component Testing **Input:** 

User Action: Tap “Start Irrigation” for Field ID 6 Pump Command Sent: {pump_status: 1, pump_reason: “manual”} ESP32 Command Poll Interval: 5 seconds 

**Expected Result:** Backend stores pump command record. ESP32 fetches at next `=` 5-second poll, calls `syncRelayToCommand(1)` , activates relay, sets `pumpRunning true` , and creates irrigation log entry with `start_time` . 

**Actual Result:** Passed. Manual command received and stored. Relay activated within 

5-second polling cycle. Irrigation log entry created with correct timestamps. 

System Testing 

103 

### **6.2.7. TC-CT-07: Crop Recommendation API Component** 

**Date:** 22nd January 2026 

**System:** Node.js Backend + Python AI Service — Crop Recommendation API Component 

**Objective:** Verify that the backend **Test ID:** TC-CT-07 recommendation component correctly aggregates sensor data, forwards it to the AI service, receives a crop recommendation, and stores the result in the `crop_recommendations` table. **Version:** 1 **Test Type:** Component Testing **Input:** Field ID: 6 Sensor Averages (last 7 days): Soil Moisture: 38%, Temperature: 21.0°C Season: Rabi, Soil Type: Loamy 

**Expected Result:** Backend calls AI service REST endpoint, receives JSON with `recommended_crop` , `confidence_score` , `water_requirement` , and stores result in `crop_recommendations` . Returns HTTP 200 to mobile app. 

**Actual Result:** Passed. “Wheat” with 84% confidence stored in database. API returned correct response to mobile app within 1.2 seconds. 

## **6.3. Integration Testing** 

Integration testing verifies the correct interaction and data flow between two or more connected modules or subsystems [10], [22]. 

### **6.3.1. TC-IT-01: ESP32 to Backend Sensor Telemetry** 

**Date:** 25th January 2026 

System Testing 

104 

**System:** ESP32 Firmware + Node.js Backend — Sensor Telemetry Integration **Objective:** Verify that the ESP32 **Test ID:** TC-IT-01 correctly packages sensor readings into a JSON payload and transmits them to the backend REST API, which validates the device, stores the reading, and returns a success response. **Version:** 1 **Test Type:** Integration Testing **Input:** 

ESP32 sends HTTP POST to /api/sensor-data: device_id: “ESP32-FIELD-006” soil_moisture: 45.2, temperature: 29.5 humidity: 62.1, rainfall: false, pump_on: 0 

**Expected Result:** Backend validates device_id against `sensors` table, inserts reading into `sensor_readings` , and returns HTTP 201 Created with generated `reading_id` . 

**Actual Result:** Passed. Payload received and stored. HTTP 201 returned with valid `reading_id = 14782` . Data verified in database. 

### **6.3.2. TC-IT-02: Backend to MySQL Data Persistence** 

**Date:** 25th January 2026 **System:** Node.js Backend + MySQL Database — Data Persistence Integration **Objective:** Verify that sensor **Test ID:** TC-IT-02 readings received at the backend API are correctly and completely persisted in the MySQL `sensor_readings` table with accurate values and timestamps. **Version:** 1 **Test Type:** Integration Testing **Input:** 

105 

System Testing 

Backend inserts sensor reading: sensor_id: 14, soil_moisture: 45.2 temperature: 29.5, humidity: 62.1 reading_time: 2026-01-25 10:30:00 

**Expected Result:** Record is inserted correctly. SQL query `SELECT * FROM sensor_readings WHERE sensor_id=14 ORDER BY reading_time DESC LIMIT 1` returns the matching record with exact values. 

**Actual Result:** Passed. Record persisted correctly. Database query returned exact values with correct timestamp and auto-generated `reading_id` . 

### **6.3.3. TC-IT-03: Backend to Firebase FCM Integration** 

**Date:** 26th January 2026 

**System:** Node.js Backend + Firebase Cloud Messaging — Push Notification Integration **Objective:** Verify that the backend **Test ID:** TC-IT-03 alert module successfully integrates with FCM to deliver push notifications to the farmer’s registered mobile device when a critical threshold condition is detected. **Version:** 1 **Test Type:** Integration Testing **Input:** 

Critical Condition: soil_moisture = 9% Critical Threshold: 15% Field ID: 6, User ID: 3 FCM Device Token: [Registered Test Device Token] 

**Expected Result:** Backend creates alert in `alerts` table and calls FCM HTTP v1 API with notification payload. FCM returns `name: projects/project-id/messages/message-id` confirming successful delivery. 

**Actual Result:** Passed. Alert stored in database. FCM returned valid message ID. Push notification received on test Android device within 3 seconds. 

106 

System Testing 

### **6.3.4. TC-IT-04: Mobile App to Backend Authentication** 

|**Date:** 26th January 2026||
|---|---|
|**System:** Android Mobile App + Node|.js Backend — Authentication Integration|
|**Objective:** Verify that the mobile<br>application correctly sends login<br>credentials to the backend, stores the<br>returned JWT token securely, and<br>uses it as a Bearer token for all<br>subsequent protected API calls.|**Test ID:**TC-IT-04|
|**Version:** 1|**Test Type:** Integration Testing|
|**Input:**||



User enters in mobile app: Email: ali.khan@test.com Password: Pass@1234 App calls: POST /api/auth/login 

**Expected Result:** Backend validates credentials and returns JWT token. Mobile app stores token in secure local storage and attaches it as `Authorization: Bearer {token}` header for all subsequent API requests. Protected endpoints return HTTP 200 with correct data. 

**Actual Result:** Passed. JWT received, stored, and used correctly. All protected API calls returned HTTP 200 with correct user data. Expired token correctly returned HTTP 401. 

### **6.3.5. TC-IT-05: Backend to AI Service Integration** 

**Date:** 27th January 2026 

**System:** Node.js Backend + Python AI Service — Crop Recommendation Integration 

System Testing 

107 

|**Objective:** Verify that the backend<br>correctly forwards aggregated soil<br>feature data to the deployed Python<br>AI service REST endpoint and<br>receives a valid crop recommendation<br>response.|**Test ID:**TC-IT-05|
|---|---|
|**Version:** 1|**Test Type:** Integration Testing|
|**Input:**||



Backend calls POST http://ai-host:5000/predict: soil_moisture: 38.0, temperature: 21.0 humidity: 58.0, season: “Rabi” soil_type: “Loamy” 

**Expected Result:** AI service returns JSON: {“crop”: “Wheat”, “confidence”: 84.5, “water_requirement”: “Medium”, “growth_duration_days”: 120}. Backend stores result in `crop_recommendations` table. 

**Actual Result:** Passed. AI service responded correctly within 0.9 seconds. Recommendation stored in database. Full JSON response returned to mobile app. 

### **6.3.6. TC-IT-06: ESP32 Irrigation Command Polling** 

|**Date:** 27th January 2026||
|---|---|
|**System:** Mobile App + Node.js Backen|d + ESP32 — Irrigation Command Integration|
|**Objective:** Verify the complete<br>command propagation fow: user<br>triggers manual irrigation on the<br>mobile app, backend stores the<br>command, and ESP32 polls, receives,<br>and executes the command within its<br>defned polling interval.|**Test ID:**TC-IT-06|
|**Version:** 1|**Test Type:** Integration Testing|
|**Input:**||



System Testing 

108 

Step 1: User taps “Start Irrigation” in mobile app Step 2: App calls PUT /api/irrigation/command {field_id: 6, pump_status: 1, pump_reason: “manual”} Step 3: ESP32 polls GET /api/pump-command/ESP32-FIELD-006 

**Expected Result:** Backend stores command. ESP32 polls at next 5-second interval, receives {pump_status: 1, pump_reason: “manual”}, calls `syncRelayToCommand(1)` , activates relay, and creates a new irrigation log entry with `start_time` . 

**Actual Result:** Passed. Full command flow completed. Pump activated within the 5-second polling window. Irrigation log entry created with correct field_id and trigger type “manual”. 

**Physical Validation of 3-Tier Polling:** The integration test successfully validated the hardware implementation of the 3-Tier timing system. The ESP32 consistently executed local sensor safety loops every 1 second, completed lightweight HTTP GET command polls every 5 seconds without blocking the loop, and securely posted full sensor payloads every 30 seconds. This physical verification confirms that the asynchronous polling architecture effectively decouples heavy uploads from time-sensitive irrigation commands. 

### **6.3.7. TC-IT-07: Sensor Data to Mobile Dashboard** 

|**Date:** 28th January 2026||
|---|---|
|**System:** ESP32 + Node.js Backend +|Mobile App — Live Dashboard Data Integration|
|**Objective:** Verify that sensor<br>readings uploaded by the ESP32 are<br>stored in the backend database and<br>correctly displayed on the farmer’s<br>mobile application dashboard within<br>the expected refresh interval.|**Test ID:**TC-IT-07|
|**Version:** 1|**Test Type:** Integration Testing|
|**Input:**||



ESP32 uploads: soil_moisture = 47%, temperature = 28°C, humidity = 64% Mobile app dashboard auto-refresh interval: 30 seconds API: GET /api/dashboard/field/6 

System Testing 

109 

**Expected Result:** Backend stores reading from ESP32. Mobile app calls dashboard API within 30 seconds, receives latest sensor values, and renders them on the dashboard with matching `reading_time` timestamp. 

**Actual Result:** Passed. Dashboard updated within 30 seconds. All displayed values matched ESP32 transmitted values exactly. Timestamp matched database record. 

## **6.4. System Testing** 

System testing evaluates the complete integrated system against the defined functional requirements in realistic end-to-end operational scenarios [10], [30]. 

### **6.4.1. TC-ST-01: Complete Sensor-to-Dashboard End-to-End Flow** 

|**Date:** 1st February 2026||
|---|---|
|**System:** Complete System — Sensor t|o Dashboard End-to-End Test|
|**Objective:** Verify the complete data<br>pipeline from physical sensor reading<br>on the ESP32 feld unit through<br>backend storage to live display on the<br>farmer’s mobile application<br>dashboard.|**Test ID:**TC-ST-01|
|**Version:** 1|**Test Type:** System Testing|
|**Input:**||



ESP32 field unit powered on and connected to Wi-Fi. 

Sensors attached: Soil Moisture (GPIO 36), DHT22 (GPIO 4), LDR (GPIO 39), Rain (GPIO 33). Farmer opens mobile app dashboard for Field ID 6. 

**Expected Result:** ESP32 reads all sensors every 30 seconds, uploads JSON payload to backend via HTTP POST, backend validates and stores reading, dashboard API serves latest values. Mobile app displays live soil moisture, temperature, humidity, and light with correct timestamps within 30 seconds. 

System Testing 

110 

**Actual Result:** Passed. Live sensor readings appeared on dashboard within 30 seconds. All values matched serial monitor output from ESP32 exactly. 

### **6.4.2. TC-ST-02: Automated Irrigation with Rain Safety End-to-End** 

**Date:** 2nd February 2026 

**System:** Complete System — Automated Irrigation with Rain Override End-to-End Test **Objective:** Verify that the system **Test ID:** TC-ST-02 autonomously detects dry soil, triggers irrigation, and then correctly stops irrigation when rainfall is detected, all without any manual user intervention. **Version:** 1 **Test Type:** System Testing **Input:** 

Auto-irrigation: Enabled, Threshold: 30% 

Phase 1: Simulated soil moisture = 20% (below threshold) 

Phase 2: Rain sensor triggered after 60 seconds of active irrigation 

**Expected Result:** Phase 1: Pump activates automatically, irrigation log entry created with trigger type “automatic”. Phase 2: Rain detected, pump stops immediately, `rainOverrideActive` flag blocks all subsequent ON commands. Alert generated for rain event. 

**Actual Result:** Passed. Automatic irrigation triggered correctly in Phase 1. Pump stopped within 1 second of rain detection in Phase 2. Full irrigation log recorded with start, end, and duration. 

### **6.4.3. TC-ST-03: Manual Irrigation Remote Control End-to-End** 

**Date:** 2nd February 2026 

**System:** Complete System — Mobile App to Field Pump Control End-to-End Test 

System Testing 

111 

|**Objective:** Verify the complete fow<br>of a farmer remotely starting and<br>stopping irrigation from the mobile<br>application, with correct real-time<br>status updates refected on the<br>dashboard and irrigation logs.|**Test ID:**TC-ST-03|
|---|---|
|**Version:** 1|**Test Type:** System Testing|
|**Input:**||



Farmer logged in on mobile app. Field ID 6 registered with Device ID: ESP32-FIELD-006. 

ESP32 online, polling every 5 seconds. 

**Expected Result:** Tap “Start Irrigation” → Backend stores pump_status=1 → ESP32 fetches within 5s → Relay activates → Dashboard shows “Irrigating”. Tap “Stop Irrigation” → Reverse flow. Log records start time, end time, duration, and water usage. 

**Actual Result:** Passed. Pump started and stopped remotely. Dashboard reflected status changes in real time. Irrigation log recorded 2 minutes 14 seconds duration correctly. 

### **6.4.4. TC-ST-04: AI Crop Recommendation End-to-End Flow** 

|**Date:** 3rd February 2026||
|---|---|
|**System:** Complete System — AI Crop|Recommendation End-to-End Test|
|**Objective:** Verify the complete AI<br>recommendation fow from farmer<br>input on the mobile app, through the<br>backend, AI service, database<br>storage, and result display with<br>confdence score and accept/reject<br>functionality.|**Test ID:**TC-ST-04|
|**Version:** 1|**Test Type:** System Testing|
|**Input:**||



System Testing 

112 

Farmer selects on mobile app: Field: Field 6, Soil Type: Loamy, Season: Rabi Taps “Analyze Field” button. 

**Expected Result:** App calls backend recommendation API → Backend fetches sensor averages → Calls AI service → AI returns crop + confidence → Backend stores in `crop_recommendations` → Mobile app displays result with confidence circle and Accept/Reject options. 

**Actual Result:** Passed. “Wheat” recommended with 87% confidence. Result stored in database. Farmer accepted recommendation. Field crop status updated to “Wheat” correctly. 

### **6.4.5. TC-ST-05: Critical Alert with Push Notification End-to-End** 

**Date:** 3rd February 2026 

**System:** Complete System — Critical Alert and Push Notification End-to-End Test **Objective:** Verify that a critical soil **Test ID:** TC-ST-05 moisture condition detected by the ESP32 results in a database alert record, a push notification delivered to the farmer’s device, and a visible alert in the mobile application with correct badge count. **Version:** 1 **Test Type:** System Testing **Input:** 

ESP32 transmits: soil_moisture = 8% Critical threshold configured: 15% FCM token registered for User ID 3 on Field ID 6. Mobile app running in background on test Android device. 

**Expected Result:** Backend detects threshold breach → Creates critical alert in `alerts` table → Dispatches FCM notification → Device receives push with title “Critical: Low Soil Moisture” → Alert badge increments on app icon → Alert visible in Alert Center with resolve option. 

System Testing 

113 

**Actual Result:** Passed. Push notification received within 3 seconds. Alert badge showed count of 1. Alert resolved successfully and moved to history archive. 

### **6.4.6. TC-ST-06: Weekly Historical Analytics End-to-End** 

|**Date:** 4th February 2026||
|---|---|
|**System:** Complete System — Historic|al Analytics End-to-End Test|
|**Objective:** Verify that the analytics<br>module correctly retrieves and<br>renders a 7-day soil moisture trend<br>line chart on the mobile application<br>with accurate data points and<br>interactive tooltips.|**Test ID:**TC-ST-06|
|**Version:** 1|**Test Type:** System Testing|
|**Input:**||



7 days of sensor readings exist for Field ID 6 in `sensor_readings` table. Farmer selects “Last 7 Days” on Analytics screen. API: GET /api/analytics/field/6?range=7d 

**Expected Result:** Backend queries database using composite index on (sensor_id, reading_time), returns ordered data array. Mobile app renders line chart with correct date labels, moisture values, and interactive data point tooltips. 

**Actual Result:** Passed. Line chart rendered 168 data points for 7 days correctly. Data matched database records. Chart tooltips showed accurate moisture values on tap. 

### **6.4.7. TC-ST-07: Data Export End-to-End** 

**Date:** 4th February 2026 

**System:** Complete System — Data Export End-to-End Test 

System Testing 

114 

|**Objective:** Verify that a farmer can<br>successfully confgure and export<br>historical farm data as a<br>downloadable report from the mobile<br>application containing all selected<br>sensor readings and irrigation events.<br>|**Test ID:**TC-ST-07<br>|
|---|---|
|**Version:** 1|**Test Type:** System Testing|
|**Input:**||
|Date range: 1st Jan 2026 to 31st Jan 20|26|
|Data types selected: Soil Moisture + Ir<br>Format: CSV|rigation Events|
|Farmer taps “Export” button on Analyt|ics screen.|



**Expected Result:** Backend generates CSV report containing all sensor readings and irrigation log entries for the specified date range and selected data types. File is returned as a downloadable attachment. 

**Actual Result:** Passed. CSV file downloaded successfully containing 744 moisture readings and 18 irrigation events for January 2026. All values accurate. 

### **6.4.8. TC-ST-08: Sensor Offline Detection End-to-End** 

|**Date:** 5th February 2026||
|---|---|
|**System:** Complete System — Sensor|Ofine Detection End-to-End Test|
|**Objective:** Verify that the system<br>correctly detects when an ESP32<br>sensor node stops transmitting<br>telemetry and marks its status as<br>“Ofine” on the mobile application<br>dashboard after the confgured<br>timeout period.|**Test ID:**TC-ST-08|
|**Version:** 1|**Test Type:** System Testing|
|**Input:**||



115 

System Testing 

Device: ESP32-FIELD-006 (Sensor ID 14) Normal upload interval: 30 seconds ESP32 powered off to simulate failure. Offline timeout threshold: 120 seconds (2 missed cycles) 

**Expected Result:** Backend monitors last upload timestamp. After 120 seconds without data, marks sensor as “Offline” in `sensors` table. Mobile app dashboard displays red “Offline” indicator next to Sensor ID 14. 

**Actual Result:** Passed. Sensor status updated to “Offline” after 2 minutes of no telemetry. Dashboard displayed red “Offline” indicator correctly. Status restored to “Online” when ESP32 was powered back on. 

### **6.4.9. TC-ST-09: Field Comparison End-to-End** 

**Date:** 5th February 2026 **System:** Complete System — Field Comparison End-to-End Test **Objective:** Verify that the system **Test ID:** TC-ST-09 correctly retrieves and displays side-by-side statistics for two different fields, enabling the farmer to compare soil moisture trends and water usage across multiple farm plots. **Version:** 1 **Test Type:** System Testing **Input:** 

Field A: Field ID 6 (Wheat, Loamy soil) Field B: Field ID 7 (Cotton, Sandy soil) Farmer selects both fields in Comparison View screen. 

**Expected Result:** Backend queries sensor readings and irrigation logs for both fields and returns comparative data as parallel JSON arrays. Mobile app renders side-by-side bar charts for moisture averages, total water usage, and irrigation event counts. 

**Actual Result:** Passed. Comparative charts displayed correctly. Field 6: 45% average moisture, 320 litres water used. Field 7: 28% average moisture, 510 litres water used. Values matched database records. 

116 

System Testing 

### **6.4.10. TC-ST-10: Complete System Resilience Under Wi-Fi Failure** 

|**Date:** 6th February 2026||
|---|---|
|**System:** Complete System — Networ|k Failure Resilience Test|
|**Objective:** Verify that the complete<br>system maintains correct local<br>irrigation control during a Wi-Fi<br>outage and automatically recovers<br>full backend synchronisation when<br>connectivity is restored.|**Test ID:**TC-ST-10|
|**Version:** 1|**Test Type:** System Testing|
|**Input:**||
|System running normally with live bac<br>Wi-Fi router powered of to simulate n<br>Simulated Soil Moisture: 3100 (dry co<br>Wi-Fi restored after 5 minutes.<br>**Expected Result:** During outage: ESP<br>logic, activates pump for dry soil, rain<br>After restoration: ESP32 reconnects a<br>sync, uploads latest sensor state, dashb|kend sync.<br>etwork failure.<br>ndition).<br>32 switches to ofine mode, applies local threshold<br>safety remains active.<br>utomatically within 12 seconds, resumes backend<br>oard refects correct current values.|



**Actual Result:** Passed. Offline irrigation logic operated correctly for the full 5-minute outage. Auto-reconnection completed within 12 seconds. Backend sync resumed. Dashboard updated correctly after reconnection. 

## **6.5. Testing Summary** 

Table 6-35 provides a consolidated summary of all test cases executed across the four testing levels, confirming complete system coverage. 

_Table 6-35: System Testing Summary_ 

|**Test Level**|**Test ID**|**Description**|**Result**|
|---|---|---|---|
|Unit Testing|TC-UT-01|User Registration with Valid Data|Pass✓|



_Continued on next page. . ._ 

System Testing 

117 

Table 6-35 — _Continued from previous page_ 

|**Test Level**|**Test ID**|**Description**|**Result**|
|---|---|---|---|
|Unit Testing|TC-UT-02|User Login with Valid Credentials|Pass✓|
|Unit Testing|TC-UT-03|User Login with Invalid Password|Pass✓|
|Unit Testing|TC-UT-04|Soil Moisture Smoothed Reading|Pass✓|
|Unit Testing|TC-UT-05|Moisture Percentage Conversion|Pass✓|
|Unit Testing|TC-UT-06|DHT22 Temperature and Humidity|Pass✓|
|Unit Testing|TC-UT-07|Dry Soil Threshold Evaluation|Pass✓|
|Unit Testing|TC-UT-08|Rain Detection Logic|Pass✓|
|Unit Testing|TC-UT-09|AI Crop Recommendation Output|Pass✓|
|Unit Testing|TC-UT-10|Firebase Push Notifcation|Pass✓|
|Component|TC-CT-01|Auto Irrigation Trigger Component|Pass✓|
|Component|TC-CT-02|Rain Safety Override Component|Pass✓|
|Component|TC-CT-03|Ofine Irrigation Logic Component|Pass✓|
|Component|TC-CT-04|Critical Alert Generation Component|Pass✓|
|Component|TC-CT-05|Historical Data Retrieval Component|Pass✓|
|Component|TC-CT-06|Manual Irrigation Control Component|Pass✓|
|Component|TC-CT-07|Crop Recommendation API<br>Component|Pass✓|
|Integration|TC-IT-01|ESP32 to Backend Telemetry|Pass✓|
|Integration|TC-IT-02|Backend to MySQL Persistence|Pass✓|
|Integration|TC-IT-03|Backend to Firebase FCM|Pass✓|
|Integration|TC-IT-04|Mobile App Authentication|Pass✓|
|Integration|TC-IT-05|Backend to AI Service|Pass✓|
|Integration|TC-IT-06|ESP32 Command Polling|Pass✓|
|Integration|TC-IT-07|Sensor Data to Dashboard|Pass✓|
|System|TC-ST-01|Sensor-to-Dashboard End-to-End|Pass✓|
|System|TC-ST-02|Auto Irrigation + Rain Override|Pass✓|
|System|TC-ST-03|Manual Remote Irrigation Control|Pass✓|
|System|TC-ST-04|AI Recommendation End-to-End|Pass✓|



_Continued on next page. . ._ 

System Testing 

118 

Table 6-35 — _Continued from previous page_ 

|**Test Level**|**Test ID**|**Description**|**Result**|
|---|---|---|---|
|System|TC-ST-05|Critical Alert + Push Notifcation|Pass✓|
|System|TC-ST-06|Weekly Historical Analytics|Pass✓|
|System|TC-ST-07|Data Export|Pass✓|
|System|TC-ST-08|Sensor Ofine Detection|Pass✓|
|System|TC-ST-09|Field Comparison|Pass✓|
|System|TC-ST-10|Wi-Fi Failure Resilience|Pass✓|
|**Total Test C**|**ases: 31**|**All Modules Covered**|**31/31**|



## **6.6. Hardware Testing Evidence** 

To validate the physical performance and robustness of the field unit under actual operating conditions, several hardware tests were conducted. The following figures present the physical ESP32 setup and sensor deployment used to achieve the results documented in the preceding test cases. 



_Figure 6-3: Hardware Assembled Prototype_ 

System Testing 

119 

Figure 6-3 provides concrete evidence of the rigorous hardware testing phase. This image showcases the fully assembled prototype during active testing, confirming that all components—including the ESP32 microcontroller, sensors, and power modules—were properly integrated and verified for operational stability. By evaluating the hardware in its assembled state, the team ensured that real-world sensor data acquisition and component interactions functioned flawlessly before the final field deployment. 



_Figure 6-4: Actuator and Sensor Wiring Configuration_ 

To validate the integration between the sensing layer and the actuation layer, Figure 6-4 presents a close-up angle of the LDR and relay module configuration. This setup confirms the physical data pathways responsible for triggering the automated irrigation system. By isolating these specific connections, the testing phase verified that the ESP32 correctly translates logical software commands into physical electrical signals capable of safely driving the external water pump. 

System Testing 

120 



_Figure 6-5: Field Test Environment at Fateh Jhang_ 

To validate the system’s performance in a real-world scenario, the team conducted comprehensive field testing at an agricultural site located in Fateh Jhang. As depicted in Figure 6-5, a group member is holding the final waterproofed hardware unit against the backdrop of actual crop fields. This on-site testing was crucial to ensure the sensors, hardware casing, and wireless communication remained completely stable under true environmental conditions, thereby confirming the system’s readiness for practical deployment. 

## **6.7. Software & API Testing Evidence** 

To validate the software components, including the Node.js backend API, the ESP32 firmware telemetry, and the AI model outputs, rigorous software testing was conducted. The following figures provide direct visual evidence of the system’s operational logs, API responses, and accurate data handling mechanisms. 



<!-- Start of picture text -->
© com3 - im x<br>Send<br>[WiFi] Connecting to SmartAgri_Net...<br>[WiFi] Connected! IP Address: 192.168.1.105<br>[MQTT] Connected to broker successfully.<br>--- Sensor Data Reading ---<br>Temperature: 28.5 °C | Humidity: 45.2 %<br>Soil Moisture (ADC): 2340 (Dry)<br>Light Intensity (LDR): 1024 (Sunny)<br>[Action] Soil is dry. Activating Water Pump...<br>Pump Status: ON<br>--- Data Sent to Server ---<br>Autoscroll [ff Show timestamp Newline vy 115200 baud Vv Clear output<br><!-- End of picture text -->



<!-- Start of picture text -->
apihamzabashir.online.. + vironmer<br>Params Heade Auth Body / Request GET Response 200<br>> 200 OK (17 headers<br>v{<br>"message": "Smart Agriculture API is running",<br>"timestamp": "2026-06-28T16:03:58.1492",<br>"environment" roduction<br><!-- End of picture text -->



<!-- Start of picture text -->
aihamzabashir.online/_. x<br>Params e aE Response 20<br>> 200 OK e<br>“cov_accuracy" 5.7<br>’ “features”: [<br>"model_accuracy”<br><!-- End of picture text -->



<!-- Start of picture text -->
BB M50 Workbench<br>fe Smartigricuture x<br>File Edit View Query Database Server Tools Scripting Help<br>SH GHhAAaA Re<br>Navigator J sensor_readings x |<br>SCHEMAS© ° SEF £RO'\B!\Ofields umgaton_logsOB)alertsvim‘sudit_logs-\ %/¥crop_recommendabons Q iw system_setings detaultdb” sensor_readings: users senso ¢ +) sqadd<><br>> Fitter objects ae pevect * FROM defaultdb.sensor_readings; Aut<br>¥ @> defauttabbidefaulteb® disatAut<br>v@& Tables mat<br>> B alerts curr<br>> BB audit_logs to<br>> BD crop_recommendations es<br>>> BBBD icrigation_logsfields | ResuitGrid | IE] 4) Fiter Rows: Edt: gc Bh7 | exportiimpoct:ey Gy | wrap calContent:<br>oe lerigation_schedues reading_id sensor_id reeding_tme sol_moisture temperature humidity light_ntensity reinfel pump_onHE created_at a|<br>7 3337 9 2026-05-14 14:54:38 0.00 25.40 45.20 0.00 0 0 2026-05-14 14:54:38 {<br>> BE indexes 3338 9 2026-05-14 14:54:40 0.00 25.40 45.20 0.00 ° 1 2026-05-14 14:54:40<br>> Gib Foreiga keys 3339 8 2026-05-14 14:54:41 0.00 25.0 45.20 0.00 ° 1 2026-05-14 14:54:41<br>> Bt Tigges 0 9 2026-05-14 14:54:41 0.00 25.40 45.20 © 0.00 ° 1 2026-05-14 14:54:41<br>> Bi sensos 3341 8 2025-05-14 14:54:44 0.00 25.40 45.20 39.00 ° 1 2026-05-14 14:54:44<br>> BE system _settings 3342 rey 2026-05-14 14:54:44 0.00 25.40 45.20 39.00 o 1 2026-05-14 14:54:44<br>> © users 3343 18 2026-05-14 14:54:47 0.00 25.40 45.40 38.00 ° 1 2026-05-14 14:54:47<br>> [ weather_data 334 rey 2026-05-14 14:54:47 0.00 25.40 45. 38.00 ° 1 2026-05-14 14:54:47<br>BS Views 3345 8 2026-05-14 14:54:49 0.00 25.40 45.40 38.00 ° 1 2026-05-14 14:54:49<br>BS sored Procedures 3346 rey 2026-05-14 14:54:49 0.00 25.40 45.40 38.00 ° 1 2026-05-14 14:54:49<br>> 'B Functions 3347 8 2026-05-14 14:54:52 0.00 25.40 45.4 38.00 ° 1 2026-05-14 14:54:52<br>Days 348 19 2026-05-14 14:54:52 0.00 25.40 45.4 38.00 ° 1 2026-05-14 14:54:52<br>3349 19 2025-05-14 14:54:53 0.00 25.40 45.42 38.00 o o 2026-05-14 14:54:53<br>= om om os os = OM a a) |<br>AdministrationInformation Schemas sor_readings1 x Apply Rever Context<br>Output<br>Table: sensor_readings CF hatin Outout hd<br>knee. bigint AI PK © * 1. 22:48:48Time usereSELECTAction Mewage<br>sensor_id Soca © = .2:- 22.50.09 sensor_readings* FROM defautdo sensor seadings Emror Code:Emor Code: 1064. 1064. You haveYou have an an emorin enor in your your SQLSQL syntax;syntax; checkcheck thethe manualmanual that that comesponds comesponds toto yoyor<br>temperaturesol_mosture  decrmak5,2) © 3: 2250.18 usersSELECT* FROM defautdb sensor_readings Error Code: 1064. You have an ernorin your SQL syntax; check the manual that comespends to yor<br>homany de cimar a k'S,2)ts.>} © — 4: 2250:28_; SELECT .* FROM defautdb<br>ightrani ntensty decrra3,2) © 5 225039 SELECT" FROM defautdh crop_recommendationsusers LIMIT 0, 1000  LIMIT0. 1000 1  row(s)54 row(s) retumedretumed<br>purrp_oncreated at t inyint{1)nyint(1)imestamo © 6 225049 SELECT FROM defautd sensor readings LIMIT 0, 1000 769 rows) retumed<br><!-- End of picture text -->

124 

# **Chapter 7** 

# **7. Conclusion and Future Work** 

This chapter summarizes the outcomes of the Smart AI Powered Agriculture System, reflects on the objectives achieved, discusses limitations encountered during the project, and outlines directions for future improvement and research. 

## **7.1. Conclusion** 

Agriculture in Pakistan continues to face serious challenges including water scarcity, unpredictable weather patterns, and limited access to modern farming tools, particularly for small and medium-scale farmers [1]. The Smart AI Powered Agriculture System was developed to address these challenges by combining Internet of Things (IoT) based sensing, automated irrigation, mobile application support, and Artificial Intelligence (AI) driven crop recommendations into a single, affordable, and deployable solution [2]. 

The system was designed and implemented across six well-defined phases: requirement analysis, system design, software development, hardware integration, deployment, and testing. The following objectives were successfully achieved: 

**Real-Time Environmental Monitoring:** The ESP32 microcontroller successfully collected soil moisture, temperature, humidity, light intensity, and rainfall readings at 30-second intervals and transmitted them to the backend server over Wi-Fi. 

**Automated Irrigation Control:** A relay-driven water pump was integrated with thresholdbased automation. The system automatically activates irrigation when soil moisture drops below the configured threshold and intelligently blocks irrigation during detected rainfall, reducing water wastage [4]. 

**Offline Resilience:** The embedded firmware maintained local irrigation control when Wi-Fi connectivity was unavailable, ensuring uninterrupted field operation [26]. 

**Backend and Data Management:** A Node.js REST API backend with a relational MySQL database was successfully deployed. The backend handles sensor ingestion, business rule evaluation, alert generation, and mobile API serving across 11 database tables [22]. 

**Mobile Application:** A mobile application was developed to provide farmers with live field monitoring, irrigation control, historical analytics, alert management, and AI crop recommendation access from a single interface [17]. 

125 

Conclusion and Future Work 

**Push Notification and Alerting:** Firebase Cloud Messaging was integrated to deliver realtime push notifications to farmers whenever critical soil moisture or sensor failure conditions were detected [9]. 

**AI-Based Crop Recommendations:** A Python-based machine learning service was trained and deployed to generate crop recommendations with confidence scores based on soil conditions, temperature, humidity, and season [5]. 

**Affordability:** The estimated hardware cost of PKR 6,400 (approximately USD 23) per field unit makes the system accessible to small and medium farmers in Pakistan, which is a key differentiator from expensive commercial solutions already available in the market [6]. 

All six epics defined in Chapter 2 were implemented and verified through 18 test cases, each of which passed during end-to-end testing. The traceability matrix confirmed full coverage of requirements across user stories, test cases, and UI screens [16]. 

The system successfully bridges the gap identified in Table 1.1 of Chapter 1, where existing solutions such as SAWiE, Buraq Smart Drip Irrigation, VGreen CropSight, Valley Field Commander, and the PMAS-AAUR Smart IoT Farm each addressed only a subset of the required features. The proposed system uniquely combines IoT sensing, automated actuation, real-time mobile monitoring, push alerting, and AI-driven decision support in a single affordable platform [7]. 

In summary, the Smart AI Powered Agriculture System demonstrates that a low-cost, integrated, and intelligent farming solution can be practically designed, built, and deployed for real-world use by Pakistani farmers, contributing meaningfully to the goals of food security and sustainable agriculture. 

## **7.2. Limitations** 

While the system meets its defined objectives, several limitations were identified during development and testing: 

**Wi-Fi Dependency:** The current implementation relies on Wi-Fi for cloud connectivity. In rural areas of Pakistan where Wi-Fi infrastructure is limited, remote field deployment may be restricted [31]. 

**Single Field Unit Prototype:** The hardware prototype was built and tested for a single field unit. Multi-node deployment across large farms has not been validated at scale. 

**AI Model Training Data:** The crop recommendation model was trained on synthetically generated datasets. Performance may vary for highly localized Pakistani soil conditions without region-specific training data [24]. 

126 

Conclusion and Future Work 

**Power Supply:** The system relies on mains electricity for the ESP32 and pump. Areas without reliable power supply require an alternative energy source, which was not implemented in this prototype [32]. 

**Weather API Integration:** Weather forecasts are not yet integrated; decisions are based solely on real-time sensor readings without future weather context. 

**Urdu Language Support:** The mobile application currently supports English only. Urdu language support would significantly improve accessibility for farmers in Pakistan. 

## **7.3. Future Work** 

Based on the outcomes of this project and the identified limitations, the following enhancements and research directions are proposed for future work: 

### **7.3.1. LoRa / GSM Connectivity for Remote Fields** 

The current system requires Wi-Fi connectivity for cloud communication. Integrating LoRaWAN or GSM-based communication modules (e.g., SIM800L) would extend the system’s usability to remote agricultural fields in rural Pakistan where Wi-Fi is unavailable [31]. LoRa-based long-range, low-power communication is particularly suitable for widearea farm monitoring with minimal power consumption [33]. 

### **7.3.2. Solar-Powered Field Units** 

To overcome the dependency on mains electricity, future iterations of the system should integrate solar panels with battery backup for powering ESP32 units and sensors. Solar-powered IoT deployments have been demonstrated to significantly extend field unit operational lifetime and reduce infrastructure costs in precision agriculture [32]. 

### **7.3.3. Expanded AI Model with Localized Data** 

The crop recommendation model should be retrained using region-specific Pakistani agricultural datasets, covering local soil compositions, climate patterns, and crop varieties such as wheat, rice, sugarcane, and cotton (Kharif and Rabi seasons). Incorporating weather forecast data from open APIs would further improve recommendation accuracy. 

Conclusion and Future Work 

127 

### **7.3.4. Federated Learning for Farmer Data Privacy** 

As the system scales to multiple farms, privacy-preserving machine learning through Federated Learning (FL) could allow collaborative model training across distributed farm nodes without sharing raw sensor data [34]. This approach enables the AI model to improve over time using data from multiple farms while maintaining data privacy and ownership for individual farmers. 

### **7.3.5. Multi-Node and Multi-Field Scalability** 

Future work should extend the current single-node prototype to a multi-node architecture where multiple ESP32 field units across different fields or farm sections report to a centralized backend. This would enable zone-based irrigation and field comparison at scale [19]. 

### **7.3.6. Integration of NPK and pH Sensors** 

Incorporating additional soil quality sensors such as NPK (Nitrogen, Phosphorus, Potassium) and pH sensors would provide a more complete soil profile for the AI recommendation engine, improving crop and fertilizer recommendation accuracy [31]. 

### **7.3.7. Urdu Language Support and Voice Interface** 

Adding Urdu language support to the mobile application would make the system more accessible to Pakistani farmers with limited English literacy. Future work could also explore a voice-based interface (e.g., using speech-to-text) for farmers who face challenges with text-based interfaces [17]. 

### **7.3.8. Drone and Satellite Image Integration** 

For large-scale farms, integrating UAV (drone) imagery or satellite-based crop health indices (e.g., NDVI) with the existing IoT sensor data would provide a more comprehensive view of crop health and field variability, enabling precision zone-based management [31]. 

### **7.3.9. Predictive Maintenance for Sensors** 

AI-driven predictive maintenance algorithms could be developed to detect sensor drift, calibration errors, or hardware failures before they impact system performance, ensuring continuous and reliable field monitoring [28]. 

Conclusion and Future Work 

128 

## **7.4. Final Remarks** 

The Smart AI Powered Agriculture System represents a meaningful step towards making precision agriculture accessible to small and medium farmers in Pakistan. By bringing together IoT sensing, automated irrigation, mobile application support, real-time alerting, and AI-powered crop recommendations in a single affordable platform, the project demonstrates the practical feasibility of technology-driven farming at low cost. 

The modular architecture of the system ensures that individual components, whether the firmware, backend, database, mobile application, or AI service, can be independently improved, replaced, or extended as the project evolves [10]. The growing body of research in IoT-based precision agriculture, low-power wireless communications, and federated machine learning provides a strong foundation for the future enhancements proposed in this chapter [2]. 

It is hoped that this system, and the research experience gained through its development, will contribute to the broader mission of modernizing Pakistani agriculture and improving the livelihoods of the millions of farmers who depend on it [1]. 

129 

# **Bibliography** 

- [1] U. Shafi, R. Mumtaz, J. García-Nieto, S. A. Hassan, S. A. R. Zaidi, and N. Iqbal, “Precision agriculture techniques and practices: From considerations to applications,” _Sensors_ , vol. 19, no. 17, p. 3796, 2019. doi: `10.3390/s19173796` 

- [2] M. S. Farooq, S. Riaz, A. Abid, K. Abid, and M. A. Naeem, “A survey on the role of IoT in agriculture for the implementation of smart farming,” _IEEE Access_ , vol. 7, pp. 156 237–156 271, 2019. doi: `10.1109/ACCESS.2019.2949703` 

- [3] I. Mohanraj, K. Ashokumar, and J. Naren, “Field monitoring and automation using IoT in agriculture domain,” _Procedia Computer Science_ , vol. 93, pp. 931–939, 2016. doi: `10.1016/j.procs.2016.07.275` 

- [4] L. García, L. Parra, J. M. Jimenez, J. Lloret, and P. Lorenz, “IoT-based smart irrigation systems: An overview on the recent trends on sensors and IoT systems for irrigation in precision agriculture,” _Sensors_ , vol. 20, no. 4, p. 1042, 2020. doi: `10.3390/ s20041042` 

- [5] C. Musanase, A. Vodacek, D. Hanyurwimfura, A. Uwitonze, and I. Kabandana, “Data-driven analysis and machine learning-based crop and fertilizer recommendation system for revolutionizing farming practices,” _Agriculture_ , vol. 13, no. 11, p. 2141, 2023. doi: `10.3390/agriculture13112141` 

- [6] H. Zia, A. Rehman, N. R. Harris, S. Fatima, and M. Khurram, “An experimental comparison of IoT-based and traditional irrigation scheduling on a flood-irrigated subtropical lemon farm,” _Sensors_ , vol. 21, no. 12, p. 4175, 2021. doi: `10.3390/ s21124175` 

- [7] A. Khanna and S. Kaur, “Evolution of Internet of Things (IoT) and its significant impact in the field of precision agriculture,” _Computers and Electronics in Agriculture_ , vol. 157, pp. 218–231, 2019. doi: `10.1016/j.compag.2018.12.039` 

- [8] J. S. Raj and J. Vijitha Ananthi, “Automation using IoT in greenhouse environment,” _Journal of Information Technology_ , vol. 1, no. 1, pp. 38–47, 2019. doi: `10.36548/ jitdw.2019.1.005` 

- [9] C. Khawas and P. Shah, “Application of Firebase in Android app development — a study,” _International Journal of Computer Applications_ , vol. 179, no. 46, pp. 49–53, 2018. doi: `10.5120/ijca2018917200` 

- [10] I. Sommerville, _Software Engineering_ , 10th. Boston, MA, USA: Pearson Education, 2016, isbn: 978-0133943030. 

BIBLIOGRAPHY 

130 

- [11] A. M. S. Ferreira, A. Rodrigues da Silva, and A. C. R. Paiva, “Towards the art of writing agile requirements with user stories, acceptance criteria, and related constructs,” in _Proceedings of the 17th International Conference on Evaluation of Novel Approaches to Software Engineering (ENASE 2022)_ , 2022, pp. 477–484. doi: `10.5220/0011082000003176` 

- [12] K. Shingala, “JSON web token (JWT) based client authentication in message queuing telemetry transport (MQTT),” _arXiv preprint arXiv:1903.02895_ , 2019. doi: `10 . 48550/arXiv.1903.02895` 

- [13] Y. Wu, Z. Yang, and Y. Liu, “Internet-of-things-based multiple-sensor monitoring system for soil information diagnosis using a smartphone,” _Micromachines_ , vol. 14, no. 7, p. 1395, 2023. doi: `10.3390/mi14071395` 

- [14] A. Morchid et al., “Iot-enabled smart agriculture for improving water management: A smart irrigation control using embedded systems and server-sent events,” _Scientific African_ , vol. 27, e02527, 2025. doi: `10.1016/j.sciaf.2024.e02527` 

- [15] O. Ethelbert, F. Fatemi Moghaddam, P. Wieder, and R. Yahyapour, “A json tokenbased authentication and access management schema for cloud SaaS applications,” _arXiv preprint arXiv:1710.08281_ , 2017. doi: `10.48550/arXiv.1710.08281` 

- [16] S. Jeong, H. Cho, and S. Lee, “Agile requirement traceability matrix,” in _Proceedings of the 40th International Conference on Software Engineering: Companion Proceedings (ICSE Companion ’18)_ , 2018, pp. 187–188. doi: `10.1145/3183440.3195089` 

- [17] M. J. Osman, N. H. Idris, Z. B. Majid, and M. R. M. Salleh, “Mobile user interface design for smallholder agriculture to be a smart farmer: A scoping review,” _Journal of Information System and Technology Management_ , vol. 7, no. 25, pp. 92–101, 2022. [Online]. Available: `https://www.researchgate.net/publication/359901065_ MOBILE_USER_INTERFACE_DESIGN_FOR_SMALLHOLDER_AGRICULTURE_TO_BE_ A_SMART_FARMER_A_SCOPING_REVIEW` 

- [18] A. M. Patokar and V. V. Gohokar, “Design and development of an intuitive android application for smart farming,” _Current Agriculture Research Journal_ , vol. 12, no. 1, 2024. doi: `10.12944/CARJ.12.1.33` 

- [19] A. Tzounis, N. Katsoulas, T. Bartzanas, and C. Kittas, “Internet of things in agriculture, recent activities and future challenges,” _Biosystems Engineering_ , vol. 164, pp. 31–48, 2017. doi: `10.1016/j.biosystemseng.2017.09.007` 

- [20] L. Farhan, R. Kharel, O. Kaiwartya, M. Quiroz-Castellanos, A. Alissa, and M. Abdulsalam, “A concise review on internet of things (IoT)-problems, challenges and opportunities,” _2018 11th International Symposium on Communication Systems, Networks & Digital Signal Processing (CSNDSP)_ , pp. 1–6, 2018. doi: `10.1109/CSNDSP. 2018.8471762` 

BIBLIOGRAPHY 

131 

- [21] T. Yokotani and Y. Sasaki, “Comparison with HTTP and MQTT on required network resources for IoT,” in _2016 International Conference on Control, Electronics, Renewable Energy and Communications (ICCEREC)_ , 2016, pp. 1–6. doi: `10.1109/ ICCEREC.2016.7814989` 

- [22] N. N. Thilakarathne, M. S. Abu Bakar, P. E. Abas, and H. Yassin, “Towards making the fields talks: A real-time cloud enabled IoT crop management platform for smart agriculture,” _Frontiers in Plant Science_ , vol. 13, p. 1 030 168, 2023. doi: `10.3389/ fpls.2022.1030168` 

- [23] P. Grzesik and D. Mrozek, “Comparative analysis of time series databases in the context of edge computing for low power sensor networks,” in _Computational Science – ICCS 2020_ , ser. Lecture Notes in Computer Science, vol. 12141, 2020, pp. 371–383. doi: `10.1007/978-3-030-50426-7_28` 

- [24] H. Afzal et al., “Incorporating soil information with machine learning for crop recommendation to improve agricultural output,” _Scientific Reports_ , vol. 15, p. 8560, 2025. [Online]. Available: `https://www.nature.com/articles/s41598-02588676-z` 

- [25] N. Naik, “Choice of effective messaging protocols for IoT systems: MQTT, CoAP, AMQP and HTTP,” in _2017 IEEE International Systems Engineering Symposium (ISSE)_ , 2017, pp. 1–7. doi: `10.1109/SysEng.2017.8088251` 

- [26] A. D. Hassebo, K. B. Montes, and M. M. Hasan, “Arduino-ESP32 based smart irrigation system,” _CUNY Academic Works_ , 2024. [Online]. Available: `https:// academicworks.cuny.edu/ny_pubs/1245/` 

- [27] J. Martín, J. A. Sáez, and E. Corchado, “Tackling the problem of noisy IoT sensor data in smart agriculture: Regression noise filters for enhanced evapotranspiration prediction,” _Expert Systems with Applications_ , vol. 237, p. 121 608, 2024. doi: `10. 1016/j.eswa.2023.121608` 

- [28] M. J. H. Emon, S. M. Hussain, A. Islam, and S. S. Ahmed, “Integration of IoT, machine learning, and sensors for intelligent environmental monitoring and agricultural development,” _Journal of Computer Networks and Communications_ , vol. 2025, p. 6 611 890, 2025. doi: `10.1155/jcnc/6611890` 

- [29] H. Bashir, _Smart agriculture system source code repository_ , 2026. [Online]. Available: `https://github.com/hamibashir/Smart-Agriculture` 

- [30] N. Jaliyagoda et al., “Internet of things (IoT) for smart agriculture: Assembling and assessment of a low-cost IoT system for polytunnels,” _PLOS ONE_ , vol. 18, no. 5, e0278440, 2023. doi: `10.1371/journal.pone.0278440` 

BIBLIOGRAPHY 

132 

- [31] S. Mansoor, S. Iqbal, S. M. Popescu, S. L. Kim, Y. S. Chung, and J.-H. Baek, “Integration of smart sensors and IoT in precision agriculture: Trends, challenges and future prospectives,” _Frontiers in Plant Science_ , vol. 16, p. 1 587 869, 2025. doi: `10.3389/fpls.2025.1587869` 

- [32] M. R. A. Mamun, A. K. Ahmed, S. M. Upoma, M. M. Haque, and M. AshikE-Rabbani, “IoT-enabled solar-powered smart irrigation for precision agriculture,” _Smart Agricultural Technology_ , vol. 10, p. 100 773, 2025. doi: `10.1016/j.atech. 2025.100773` 

- [33] L. Aldhaheri et al., “LoRa communication for agriculture 4.0: Opportunities, challenges, and future directions,” _arXiv preprint arXiv:2409.11200_ , 2024. doi: `10. 48550/arXiv.2409.11200` 

- [34] A. Dwarampudi and M. K. Yogi, “Application of federated learning for smart agriculture system,” _International Journal of Information Technology & Computer Engineering_ , vol. 4, no. 3, pp. 36–48, 2024. doi: `10.55529/ijitc.43.36.48` 



<!-- Start of picture text -->
7] turnitin Page 2 of 166 - Integrity Overview<br><!-- End of picture text -->



<!-- Start of picture text -->
Submission ID trn:oid:::3618:144422480<br><!-- End of picture text -->



<!-- Start of picture text -->
re) . . .<br>7% Overall Similarity<br><!-- End of picture text -->



<!-- Start of picture text -->
The combined total of all matches, including overlapping sources, for each database.<br><!-- End of picture text -->



<!-- Start of picture text -->
Filtered from the Report<br>» Bibliography<br>+ Quoted Text<br>» Small Matches (less than 10 words)<br><!-- End of picture text -->



<!-- Start of picture text -->
Match Groups Top Sources<br>oo 125 Not Cited or Quoted 7% 2% @ Internet sources<br>Matches with neither in-text citation nor quotation marks 1% RA Publications<br>co 15 Missing Quotations 1% 7% & Submitted works (Student Papers)<br>Matches that are still very similar to source material<br>= 0 Missing Citation 0%<br>Matches that have quotation marks, but no in-text citation<br>@ 0 Cited and Quoted 0%<br>Matches with in-text citation present, but no quotation marks<br>Integrity Flags<br>0 Integrity Flags for Review Our system's algorithms look deeply at a document for any inconsistencies that<br>would set it apart from a normal submission. If we notice something strange, we flag<br>it for you to review.<br>A Flag is not necessarily an indicator of a problem. However, we'd recommend you<br>focus your attention there for further review.<br><!-- End of picture text -->

> <sup>of 166- Integrity Overview</sup> a. turnitin Page<sup>2</sup> 

Submission ID_ trn:oid::3618:144422480 



<!-- Start of picture text -->
ALE<br><!-- End of picture text -->

135 

# **Appendix** 

The following appendices provide supplementary technical documentation for the Smart Agriculture System, including the user manual for the mobile application, hardware setup instructions, dataset parameters, AI model details, and troubleshooting guidelines. 

# **Appendix A: User Manual and Troubleshooting** 

## **A.1 Mobile Application User Manual** 

The Smart Agriculture mobile application is designed for ease of use and real-time monitoring. **Account Registration:** Open the application and navigate to the ‘Register’ screen. Provide your full name, email address, phone number, and a secure password. 

**Field Management:** Upon logging in, the Dashboard displays your registered agricultural fields. To add a new field, tap the ‘+’ floating action button and enter the field details (such as crop type and area). 

**Sensor Monitoring:** Tap on a specific field to view real-time telemetry. The detailed dashboard displays a live moisture gauge chart, temperature and humidity readouts, and the latest update timestamp. 

**Irrigation Control:** Navigate to the ‘Irrigation’ tab to toggle the water pump manually or set up automated scheduling based on predetermined soil moisture thresholds. 

**AI Recommendations:** Navigate to the ‘Recommendations’ tab to view crop suggestions generated by the AI model based on your field’s historical environmental data. 

## **A.2 Troubleshooting Guide** 

**ESP32 Offline Status:** Check the Wi-Fi connection in the field. Ensure the power supply (battery or adapter) is properly connected and providing adequate voltage. Restart the microcontroller if necessary. 

**Inaccurate Sensor Readings:** For the DHT22 sensor, ensure it is not exposed to direct sunlight or rain. For the soil moisture sensor, ensure the probes are fully inserted into the soil and periodically clean off any corrosive buildup on the metal contacts. 

**Pump Not Activating:** Check the relay module indicator light. Verify that the 12V power 

136 

Appendix 

supply for the pump is active and that the GPIO signal wires are securely connected to the ESP32. 

# **Appendix B: Hardware Configuration and AI Model Details** 

## **B.1 Hardware Setup and Pin Configuration** 

The Field Unit is centered around an ESP32 microcontroller. The sensors and actuators are connected to the following GPIO pins to ensure reliable data acquisition and control: 

|**Component**|**Pin Type**|**ESP32 GPIO Pin**|
|---|---|---|
|Soil Moisture Sensor|Analog Input|GPIO 34|
|DHT22 (Temperature/Humidity)|Digital Input|GPIO 4|
|LDR (Light Sensor)|Analog Input|GPIO 35|
|Rain Sensor|Digital Input|GPIO 15|
|Water Flow Sensor|Digital Input|GPIO 2|
|Relay Module (Pump Control)|Digital Output|GPIO 5|



_Table 7-2: ESP32 Pin Configuration for Field Unit_ 

Ensure all common ground connections are shared between the ESP32, the sensor modules, and the relay module. The relay typically requires a separate 5V logic supply to safely isolate the pump’s higher voltage circuit from the microcontroller. 

## **B.2 Dataset and AI Model Parameters** 

The crop recommendation engine is powered by a machine learning model developed in Python using the Scikit-Learn library. The core details are as follows: **Dataset Features:** Soil Moisture (%), Temperature (<sup>◦</sup> C), Humidity (%), Soil Type (encoded via LabelEncoder), and Season (encoded via LabelEncoder). 

**Model Type:** Random Forest Classifier. 

**Hyperparameters:** `n_estimators` = 150, `max_depth` = 10, `min_samples_leaf` = 3. 

**Validation and Confidence Score:** The model achieved robust accuracy during 5-fold cross-validation on an 80/20 train-test split. The confidence score returned by the API is calculated mathematically by determining the percentage of the 150 decision trees that voted 

Appendix 

137 

for the majority crop class ( _𝐶_ = max _𝑐 𝑃_ ( _𝑐_ | _𝑥_ ) × 100%). 

