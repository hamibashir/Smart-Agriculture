-- ============================================
-- Sample Data for Hamza Bashir (user_id = 5)
-- ============================================

USE smart_agriculture;

-- ============================================
-- Sample Fields for Hamza
-- ============================================
INSERT INTO fields (user_id, field_name, location_latitude, location_longitude, area_size, area_unit, soil_type, current_crop, planting_date, expected_harvest_date, is_active) VALUES
(5, 'Main Field - Wheat', 33.5651, 73.0169, 8.5, 'acres', 'Loamy', 'Wheat', '2024-11-01', '2025-04-20', TRUE),
(5, 'South Field - Rice', 33.5640, 73.0180, 5.2, 'acres', 'Clay Loam', 'Rice', '2024-06-15', '2024-11-30', TRUE),
(5, 'East Field - Vegetables', 33.5660, 73.0190, 2.8, 'acres', 'Sandy Loam', 'Mixed Vegetables', '2024-10-01', '2025-01-15', TRUE),
(5, 'North Field - Cotton', 33.5670, 73.0160, 6.0, 'acres', 'Loamy', 'Cotton', '2024-05-01', '2024-12-15', TRUE);

-- ============================================
-- Sample Sensors for Hamza's Fields
-- ============================================
INSERT INTO sensors (field_id, sensor_type, device_id, sensor_model, installation_date, is_active, battery_level, firmware_version, location_description) VALUES
-- Main Field sensors
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'Main Field - Wheat'), 'combined', 'ESP32-HAMZA-001', 'DHT22 + Soil Moisture', '2024-11-01', TRUE, 85.5, 'v1.2.0', 'Center of main field'),
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'Main Field - Wheat'), 'soil_moisture', 'ESP32-HAMZA-002', 'Capacitive Soil Sensor', '2024-11-01', TRUE, 78.2, 'v1.2.0', 'North section'),

-- South Field sensors
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'South Field - Rice'), 'combined', 'ESP32-HAMZA-003', 'DHT22 + Soil Moisture', '2024-06-15', TRUE, 92.0, 'v1.2.0', 'Center of south field'),
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'South Field - Rice'), 'water_flow', 'ESP32-HAMZA-004', 'YF-S201 Flow Sensor', '2024-06-15', TRUE, 88.5, 'v1.2.0', 'Irrigation inlet'),

-- East Field sensors
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'East Field - Vegetables'), 'combined', 'ESP32-HAMZA-005', 'DHT22 + Soil Moisture', '2024-10-01', TRUE, 95.0, 'v1.2.0', 'Center of east field'),

-- North Field sensors
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'North Field - Cotton'), 'combined', 'ESP32-HAMZA-006', 'DHT22 + Soil Moisture', '2024-05-01', TRUE, 72.5, 'v1.2.0', 'Center of north field'),
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'North Field - Cotton'), 'temperature', 'ESP32-HAMZA-007', 'DS18B20', '2024-05-01', TRUE, 81.0, 'v1.2.0', 'South corner');

-- ============================================
-- Sample Sensor Readings (Recent data)
-- ============================================
-- Main Field - Wheat readings
INSERT INTO sensor_readings (sensor_id, soil_moisture, temperature, humidity, light_intensity, battery_voltage, signal_strength, reading_timestamp) VALUES
((SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-001'), 45.2, 22.5, 62.3, 48000, 3.8, -45, NOW() - INTERVAL 5 MINUTE),
((SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-001'), 44.8, 23.1, 61.5, 52000, 3.8, -43, NOW() - INTERVAL 10 MINUTE),
((SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-001'), 46.1, 21.8, 63.2, 45000, 3.8, -46, NOW() - INTERVAL 15 MINUTE),
((SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-002'), 43.5, NULL, NULL, NULL, 3.7, -48, NOW() - INTERVAL 5 MINUTE),
((SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-002'), 44.2, NULL, NULL, NULL, 3.7, -47, NOW() - INTERVAL 10 MINUTE),

-- South Field - Rice readings
((SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-003'), 68.5, 28.2, 75.8, 55000, 3.9, -42, NOW() - INTERVAL 5 MINUTE),
((SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-003'), 67.8, 28.5, 76.2, 56000, 3.9, -41, NOW() - INTERVAL 10 MINUTE),
((SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-004'), NULL, NULL, NULL, NULL, 3.8, -44, NOW() - INTERVAL 5 MINUTE),

-- East Field - Vegetables readings
((SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-005'), 52.3, 24.8, 68.5, 50000, 3.9, -40, NOW() - INTERVAL 5 MINUTE),
((SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-005'), 51.8, 25.2, 67.8, 51000, 3.9, -39, NOW() - INTERVAL 10 MINUTE),

-- North Field - Cotton readings
((SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-006'), 38.2, 26.5, 58.3, 58000, 3.6, -50, NOW() - INTERVAL 5 MINUTE),
((SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-006'), 37.8, 27.1, 57.5, 59000, 3.6, -51, NOW() - INTERVAL 10 MINUTE),
((SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-007'), NULL, 26.8, NULL, NULL, 3.7, -49, NOW() - INTERVAL 5 MINUTE);

-- ============================================
-- Sample Irrigation Logs
-- ============================================
INSERT INTO irrigation_logs (field_id, sensor_id, irrigation_type, start_time, end_time, duration_minutes, water_used_liters, trigger_reason, soil_moisture_before, soil_moisture_after, pump_status, initiated_by) VALUES
-- Main Field irrigation
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'Main Field - Wheat'), (SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-001'), 'automatic', NOW() - INTERVAL 2 DAY, NOW() - INTERVAL 2 DAY + INTERVAL 45 MINUTE, 45, 3200, 'Soil moisture below 35%', 32.5, 48.2, 'off', 5),
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'Main Field - Wheat'), (SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-001'), 'scheduled', NOW() - INTERVAL 4 DAY, NOW() - INTERVAL 4 DAY + INTERVAL 40 MINUTE, 40, 2850, 'Scheduled irrigation - Morning', 38.2, 52.5, 'off', 5),
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'Main Field - Wheat'), (SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-001'), 'manual', NOW() - INTERVAL 6 DAY, NOW() - INTERVAL 6 DAY + INTERVAL 50 MINUTE, 50, 3500, 'Manual irrigation by farmer', 35.8, 50.2, 'off', 5),

-- South Field irrigation
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'South Field - Rice'), (SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-003'), 'automatic', NOW() - INTERVAL 1 DAY, NOW() - INTERVAL 1 DAY + INTERVAL 60 MINUTE, 60, 4200, 'Soil moisture below 60%', 58.5, 72.8, 'off', 5),
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'South Field - Rice'), (SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-003'), 'scheduled', NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 3 DAY + INTERVAL 55 MINUTE, 55, 3850, 'Scheduled irrigation - Evening', 62.2, 75.5, 'off', 5),

-- East Field irrigation
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'East Field - Vegetables'), (SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-005'), 'manual', NOW() - INTERVAL 1 DAY, NOW() - INTERVAL 1 DAY + INTERVAL 30 MINUTE, 30, 1800, 'Manual watering for vegetables', 48.5, 58.2, 'off', 5),

-- North Field irrigation
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'North Field - Cotton'), (SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-006'), 'automatic', NOW() - INTERVAL 3 DAY, NOW() - INTERVAL 3 DAY + INTERVAL 35 MINUTE, 35, 2450, 'Soil moisture below 30%', 28.5, 42.8, 'off', 5);

-- ============================================
-- Sample Alerts
-- ============================================
INSERT INTO alerts (user_id, field_id, sensor_id, alert_type, alert_category, title, message, threshold_value, current_value, is_read, is_resolved, created_at) VALUES
-- Critical alerts
(5, (SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'North Field - Cotton'), (SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-006'), 'critical', 'soil_moisture', 'Critical: Low Soil Moisture', 'Soil moisture in North Field - Cotton has dropped to 38.2%. Immediate irrigation recommended.', 40.0, 38.2, FALSE, FALSE, NOW() - INTERVAL 30 MINUTE),

-- Warning alerts
(5, (SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'Main Field - Wheat'), (SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-001'), 'warning', 'temperature', 'High Temperature Warning', 'Temperature in Main Field - Wheat is 23.1°C. Monitor crop health.', 25.0, 23.1, FALSE, FALSE, NOW() - INTERVAL 1 HOUR),
(5, (SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'South Field - Rice'), (SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-003'), 'warning', 'humidity', 'High Humidity Alert', 'Humidity in South Field - Rice is 76.2%. Risk of fungal growth.', 75.0, 76.2, FALSE, FALSE, NOW() - INTERVAL 2 HOUR),

-- Info alerts
(5, (SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'Main Field - Wheat'), NULL, 'info', 'irrigation', 'Irrigation Completed', 'Automatic irrigation completed successfully. Duration: 45 minutes, Water used: 3200 liters.', NULL, NULL, TRUE, TRUE, NOW() - INTERVAL 2 DAY),
(5, (SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'East Field - Vegetables'), (SELECT sensor_id FROM sensors WHERE device_id = 'ESP32-HAMZA-005'), 'info', 'sensor_offline', 'Sensor Back Online', 'Sensor ESP32-HAMZA-005 is back online after maintenance.', NULL, NULL, TRUE, TRUE, NOW() - INTERVAL 3 DAY),

-- Success alerts
(5, (SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'South Field - Rice'), NULL, 'success', 'crop_health', 'Optimal Growing Conditions', 'All parameters in South Field - Rice are within ideal range for rice cultivation.', NULL, NULL, TRUE, TRUE, NOW() - INTERVAL 1 DAY);

-- ============================================
-- Sample Crop Recommendations
-- ============================================
INSERT INTO crop_recommendations (field_id, recommended_crop, confidence_score, soil_moisture_avg, temperature_avg, humidity_avg, soil_type, season, expected_yield, water_requirement, growth_duration_days, recommendation_reason, is_accepted, created_at) VALUES
-- For Main Field
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'Main Field - Wheat'), 'Wheat', 94.5, 45.2, 22.5, 62.0, 'Loamy', 'Rabi', 3200, 'Medium', 150, 'Excellent soil conditions and optimal temperature for wheat cultivation. Loamy soil provides good drainage and nutrient retention.', TRUE, NOW() - INTERVAL 5 DAY),

-- For South Field
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'South Field - Rice'), 'Basmati Rice', 96.8, 68.0, 28.2, 75.5, 'Clay Loam', 'Kharif', 2800, 'High', 120, 'Perfect conditions for Basmati rice. High humidity and clay loam soil ideal for paddy cultivation. Water retention excellent.', TRUE, NOW() - INTERVAL 10 DAY),

-- For East Field
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'East Field - Vegetables'), 'Tomatoes', 88.5, 52.0, 24.8, 68.0, 'Sandy Loam', 'All Season', 1500, 'Medium', 90, 'Sandy loam soil with good drainage perfect for tomato cultivation. Temperature and moisture levels optimal.', FALSE, NOW() - INTERVAL 2 DAY),
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'East Field - Vegetables'), 'Bell Peppers', 85.2, 52.0, 24.8, 68.0, 'Sandy Loam', 'All Season', 1200, 'Medium', 75, 'Alternative recommendation: Bell peppers thrive in similar conditions. Good market value and shorter growth cycle.', FALSE, NOW() - INTERVAL 2 DAY),

-- For North Field
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'North Field - Cotton'), 'Cotton', 92.3, 38.0, 26.5, 58.0, 'Loamy', 'Kharif', 1800, 'Medium-High', 180, 'Ideal conditions for cotton. Moderate moisture and warm temperature perfect for fiber development. Loamy soil supports deep root growth.', TRUE, NOW() - INTERVAL 15 DAY);

-- ============================================
-- Sample Irrigation Schedules
-- ============================================
INSERT INTO irrigation_schedules (field_id, schedule_name, start_date, end_date, time_of_day, duration_minutes, frequency, custom_days, is_active, created_by) VALUES
-- Main Field schedule
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'Main Field - Wheat'), 'Morning Irrigation - Wheat', '2024-11-01', '2025-04-20', '06:00:00', 40, 'alternate_days', NULL, TRUE, 5),
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'Main Field - Wheat'), 'Evening Irrigation - Wheat', '2024-11-01', '2025-04-20', '18:00:00', 35, 'weekly', 'Sunday,Wednesday', TRUE, 5),

-- South Field schedule
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'South Field - Rice'), 'Daily Irrigation - Rice', '2024-06-15', '2024-11-30', '07:00:00', 60, 'daily', NULL, TRUE, 5),

-- East Field schedule
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'East Field - Vegetables'), 'Morning Watering - Vegetables', '2024-10-01', '2025-01-15', '06:30:00', 25, 'daily', NULL, TRUE, 5),

-- North Field schedule
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'North Field - Cotton'), 'Weekly Irrigation - Cotton', '2024-05-01', '2024-12-15', '08:00:00', 45, 'weekly', 'Monday,Thursday', TRUE, 5);

-- ============================================
-- Sample Weather Data
-- ============================================
INSERT INTO weather_data (field_id, temperature, humidity, rainfall, wind_speed, cloud_cover, weather_condition, forecast_date, is_forecast) VALUES
-- Current weather for all fields (same location)
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'Main Field - Wheat'), 23.5, 62.0, 0.0, 8.5, 25, 'Partly Cloudy', CURDATE(), FALSE),
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'South Field - Rice'), 23.5, 62.0, 0.0, 8.5, 25, 'Partly Cloudy', CURDATE(), FALSE),
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'East Field - Vegetables'), 23.5, 62.0, 0.0, 8.5, 25, 'Partly Cloudy', CURDATE(), FALSE),
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'North Field - Cotton'), 23.5, 62.0, 0.0, 8.5, 25, 'Partly Cloudy', CURDATE(), FALSE),

-- Forecast for next 3 days
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'Main Field - Wheat'), 24.0, 58.0, 0.0, 10.0, 30, 'Sunny', CURDATE() + INTERVAL 1 DAY, TRUE),
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'Main Field - Wheat'), 22.5, 65.0, 2.5, 12.0, 60, 'Light Rain', CURDATE() + INTERVAL 2 DAY, TRUE),
((SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'Main Field - Wheat'), 21.0, 70.0, 5.0, 15.0, 80, 'Rainy', CURDATE() + INTERVAL 3 DAY, TRUE);

-- ============================================
-- Sample Audit Logs
-- ============================================
INSERT INTO audit_logs (user_id, action_type, table_name, record_id, old_value, new_value, ip_address, user_agent) VALUES
(5, 'LOGIN', NULL, NULL, NULL, NULL, '192.168.1.150', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0'),
(5, 'CREATE', 'fields', (SELECT field_id FROM fields WHERE user_id = 5 AND field_name = 'Main Field - Wheat'), NULL, '{"field_name": "Main Field - Wheat", "area_size": 8.5}', '192.168.1.150', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0'),
(5, 'CREATE', 'irrigation_logs', NULL, NULL, '{"irrigation_type": "automatic", "duration_minutes": 45}', '192.168.1.150', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0'),
(5, 'UPDATE', 'alerts', NULL, '{"is_read": false}', '{"is_read": true}', '192.168.1.150', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0');

-- ============================================
-- End of Sample Data for Hamza Bashir
-- ============================================

SELECT 'Sample data for Hamza Bashir created successfully!' AS Status;
SELECT COUNT(*) AS 'Fields Created' FROM fields WHERE user_id = 5;
SELECT COUNT(*) AS 'Sensors Created' FROM sensors WHERE field_id IN (SELECT field_id FROM fields WHERE user_id = 5);
SELECT COUNT(*) AS 'Alerts Created' FROM alerts WHERE user_id = 5;
SELECT COUNT(*) AS 'Recommendations Created' FROM crop_recommendations WHERE field_id IN (SELECT field_id FROM fields WHERE user_id = 5);
