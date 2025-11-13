-- ============================================
-- Smart AI-Powered Agriculture System
-- Sample Data for Testing
-- ============================================
-- Description: Sample INSERT statements to populate the database with test data
-- ============================================

USE smart_agriculture;

-- ============================================
-- Sample Users (Farmers)
-- ============================================
-- Note: Password hashes are bcrypt hashes of 'password123'
INSERT INTO users (full_name, email, phone, password_hash, address, city, province, postal_code, role, is_active, email_verified, phone_verified) VALUES
('Ahmed Ali', 'ahmed.ali@example.com', '+92-300-1234567', '$2b$10$rZ5qJ5YvZ5YvZ5YvZ5YvZOqJ5YvZ5YvZ5YvZ5YvZ5YvZ5YvZ5Yv', 'Village Chak 123, GT Road', 'Faisalabad', 'Punjab', '38000', 'farmer', TRUE, TRUE, TRUE),
('Fatima Khan', 'fatima.khan@example.com', '+92-301-2345678', '$2b$10$rZ5qJ5YvZ5YvZ5YvZ5YvZOqJ5YvZ5YvZ5YvZ5YvZ5YvZ5YvZ5Yv', 'Mohalla Islamabad, Main Road', 'Multan', 'Punjab', '60000', 'farmer', TRUE, TRUE, TRUE),
('Hassan Raza', 'hassan.raza@example.com', '+92-302-3456789', '$2b$10$rZ5qJ5YvZ5YvZ5YvZ5YvZOqJ5YvZ5YvZ5YvZ5YvZ5YvZ5YvZ5Yv', 'Village Kot Addu', 'Muzaffargarh', 'Punjab', '34000', 'farmer', TRUE, FALSE, TRUE),
('Admin User', 'admin@gmail.com', '+92-321-9999999', '$2a$12$JQvJjbsM1U5HHycsMb770eUe138Gzogi/r6unr.dh3gqBcHvq08Hu', 'Smart Agri HQ, I-9', 'Islamabad', 'Islamabad Capital Territory', '44000', 'admin', TRUE, TRUE, TRUE);

-- ============================================
-- Sample Fields
-- ============================================
INSERT INTO fields (user_id, field_name, location_latitude, location_longitude, area_size, area_unit, soil_type, current_crop, planting_date, expected_harvest_date, is_active) VALUES
(1, 'North Field - Wheat', 31.4504, 73.1350, 5.5, 'acres', 'Loamy', 'Wheat', '2024-11-01', '2025-04-15', TRUE),
(1, 'South Field - Cotton', 31.4490, 73.1340, 3.2, 'acres', 'Sandy Loam', 'Cotton', '2024-05-15', '2024-11-30', TRUE),
(2, 'Main Field - Rice', 30.1575, 71.5249, 8.0, 'acres', 'Clay', 'Rice', '2024-06-01', '2024-10-30', TRUE),
(2, 'East Field - Sugarcane', 30.1580, 71.5260, 4.5, 'acres', 'Loamy', 'Sugarcane', '2024-03-01', '2025-02-28', TRUE),
(3, 'Test Field', 30.0668, 70.6403, 2.0, 'acres', 'Sandy', NULL, NULL, NULL, TRUE);

-- ============================================
-- Sample Sensors
-- ============================================
INSERT INTO sensors (field_id, sensor_type, device_id, sensor_model, installation_date, location_description, is_active, battery_level, firmware_version) VALUES
(1, 'combined', 'ESP32-A1B2C3D4E5F6', 'ESP32-DevKit', '2024-10-15', 'Center of North Field', TRUE, 87.5, 'v1.2.3'),
(1, 'soil_moisture', 'ESP32-B2C3D4E5F6A1', 'YL-69', '2024-10-15', 'Northwest corner', TRUE, 92.0, 'v1.2.3'),
(2, 'combined', 'ESP32-C3D4E5F6A1B2', 'ESP32-DevKit', '2024-10-20', 'Center of South Field', TRUE, 78.3, 'v1.2.3'),
(3, 'combined', 'ESP32-D4E5F6A1B2C3', 'ESP32-DevKit', '2024-09-10', 'Main Field Center', TRUE, 95.2, 'v1.2.2'),
(4, 'soil_moisture', 'ESP32-E5F6A1B2C3D4', 'Capacitive v1.2', '2024-08-05', 'East Field Entry Point', TRUE, 88.7, 'v1.2.1'),
(5, 'combined', 'ESP32-F6A1B2C3D4E5', 'ESP32-DevKit', '2024-11-01', 'Test Field', TRUE, 100.0, 'v1.2.3');

-- ============================================
-- Sample Sensor Readings (Recent Data)
-- ============================================
INSERT INTO sensor_readings (sensor_id, soil_moisture, temperature, humidity, light_intensity, rainfall, water_flow_rate, battery_voltage, signal_strength, reading_timestamp) VALUES
-- Sensor 1 readings (last 24 hours)
(1, 45.2, 22.5, 65.3, 45000, 0, NULL, 3.7, -45, DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(1, 44.8, 23.1, 64.8, 48000, 0, NULL, 3.7, -44, DATE_SUB(NOW(), INTERVAL 2 HOUR)),
(1, 43.5, 24.2, 63.2, 52000, 0, NULL, 3.7, -46, DATE_SUB(NOW(), INTERVAL 3 HOUR)),
(1, 42.1, 25.8, 61.5, 58000, 0, NULL, 3.7, -45, DATE_SUB(NOW(), INTERVAL 4 HOUR)),

-- Sensor 2 readings
(2, 28.5, 23.5, 66.0, 46000, 0, NULL, 3.8, -42, DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(2, 27.2, 24.0, 65.5, 49000, 0, NULL, 3.8, -43, DATE_SUB(NOW(), INTERVAL 2 HOUR)),

-- Sensor 3 readings
(3, 52.3, 21.8, 68.5, 42000, 0, NULL, 3.6, -48, DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(3, 51.9, 22.3, 67.8, 44000, 0, NULL, 3.6, -47, DATE_SUB(NOW(), INTERVAL 2 HOUR)),

-- Sensor 4 readings
(4, 38.7, 26.5, 58.3, 55000, 0, NULL, 3.9, -40, DATE_SUB(NOW(), INTERVAL 1 HOUR)),
(4, 37.5, 27.2, 57.1, 58000, 0, NULL, 3.9, -41, DATE_SUB(NOW(), INTERVAL 2 HOUR)),

-- Sensor 5 readings
(5, 32.1, 24.8, 62.5, 50000, 0, NULL, 3.7, -44, DATE_SUB(NOW(), INTERVAL 1 HOUR)),

-- Sensor 6 readings
(6, 55.8, 20.5, 72.3, 38000, 0, NULL, 4.0, -38, DATE_SUB(NOW(), INTERVAL 30 MINUTE));

-- ============================================
-- Sample Irrigation Logs
-- ============================================
INSERT INTO irrigation_logs (field_id, sensor_id, irrigation_type, start_time, end_time, duration_minutes, water_used_liters, trigger_reason, soil_moisture_before, soil_moisture_after, pump_status, initiated_by) VALUES
(1, 1, 'automatic', DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY) + INTERVAL 45 MINUTE, 45, 2250, 'Soil moisture below 30%', 28.5, 45.2, 'off', NULL),
(1, 1, 'manual', DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY) + INTERVAL 60 MINUTE, 60, 3000, 'Manual irrigation by farmer', 35.2, 52.8, 'off', 1),
(2, 3, 'automatic', DATE_SUB(NOW(), INTERVAL 1 DAY), DATE_SUB(NOW(), INTERVAL 1 DAY) + INTERVAL 40 MINUTE, 40, 2000, 'Soil moisture below 30%', 27.8, 51.5, 'off', NULL),
(3, 4, 'scheduled', DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY) + INTERVAL 50 MINUTE, 50, 4000, 'Scheduled irrigation', 32.5, 48.3, 'off', NULL),
(4, 5, 'manual', DATE_SUB(NOW(), INTERVAL 4 DAY), DATE_SUB(NOW(), INTERVAL 4 DAY) + INTERVAL 55 MINUTE, 55, 2475, 'Manual irrigation', 30.1, 44.7, 'off', 2);

-- ============================================
-- Sample Crop Recommendations
-- ============================================
INSERT INTO crop_recommendations (field_id, recommended_crop, confidence_score, soil_moisture_avg, temperature_avg, humidity_avg, soil_type, season, expected_yield, water_requirement, growth_duration_days, recommendation_reason, model_version, is_accepted) VALUES
(1, 'Wheat', 92.5, 42.3, 23.5, 64.2, 'Loamy', 'Rabi', 1850, 'Medium', 150, 'Optimal soil conditions and temperature for wheat cultivation. Loamy soil provides good drainage and nutrient retention.', 'v2.1.0', TRUE),
(2, 'Cotton', 88.7, 48.5, 28.2, 62.5, 'Sandy Loam', 'Kharif', 950, 'High', 180, 'High temperature and moderate humidity ideal for cotton. Sandy loam ensures good root development.', 'v2.1.0', TRUE),
(3, 'Rice', 95.2, 55.8, 25.8, 72.3, 'Clay', 'Kharif', 2200, 'Very High', 120, 'Clay soil with high moisture retention perfect for rice. Temperature and humidity in optimal range.', 'v2.1.0', TRUE),
(5, 'Maize', 85.3, 38.5, 24.5, 60.8, 'Sandy', 'Kharif', 1200, 'Medium', 90, 'Sandy soil with moderate moisture suitable for maize. Good drainage prevents waterlogging.', 'v2.1.0', FALSE),
(5, 'Millet', 82.1, 38.5, 24.5, 60.8, 'Sandy', 'Kharif', 800, 'Low', 75, 'Drought-resistant crop suitable for sandy soil. Low water requirement makes it cost-effective.', 'v2.1.0', FALSE);

-- ============================================
-- Sample Alerts
-- ============================================
INSERT INTO alerts (user_id, field_id, sensor_id, alert_type, alert_category, title, message, threshold_value, current_value, is_read, is_resolved, push_notification_sent, email_sent) VALUES
(1, 1, 2, 'critical', 'soil_moisture', 'Low Soil Moisture Alert', 'Soil moisture in North Field has dropped to 28.5%. Immediate irrigation recommended.', 30.0, 28.5, TRUE, TRUE, TRUE, TRUE),
(1, 2, 3, 'warning', 'temperature', 'High Temperature Warning', 'Temperature in South Field is 32°C. Monitor crop health closely.', 30.0, 32.0, TRUE, FALSE, TRUE, FALSE),
(2, 3, 4, 'info', 'irrigation', 'Irrigation Completed', 'Automatic irrigation completed successfully. Duration: 50 minutes.', NULL, NULL, TRUE, TRUE, TRUE, FALSE),
(2, 3, 4, 'warning', 'sensor_offline', 'Sensor Connectivity Issue', 'Sensor ESP32-D4E5F6A1B2C3 has not sent data for 2 hours.', NULL, NULL, FALSE, FALSE, TRUE, TRUE),
(3, 5, 6, 'info', 'crop_health', 'New Crop Recommendation', 'AI model suggests Maize for Test Field with 85.3% confidence.', NULL, NULL, FALSE, FALSE, TRUE, FALSE);

-- ============================================
-- Sample Irrigation Schedules
-- ============================================
INSERT INTO irrigation_schedules (field_id, schedule_name, start_date, end_date, time_of_day, duration_minutes, frequency, custom_days, is_active, created_by) VALUES
(1, 'Morning Irrigation - Wheat Season', '2024-11-01', '2025-04-15', '06:00:00', 45, 'alternate_days', NULL, TRUE, 1),
(2, 'Evening Irrigation - Cotton', '2024-05-15', '2024-11-30', '18:00:00', 40, 'daily', NULL, TRUE, 1),
(3, 'Rice Field - Twice Daily', '2024-06-01', '2024-10-30', '07:00:00', 50, 'daily', NULL, TRUE, 2),
(4, 'Weekly Deep Irrigation', '2024-03-01', '2025-02-28', '05:30:00', 90, 'weekly', 'Sun', TRUE, 2);

-- ============================================
-- Sample Weather Data
-- ============================================
INSERT INTO weather_data (field_id, temperature, humidity, rainfall, wind_speed, cloud_cover, weather_condition, forecast_date, is_forecast, data_source) VALUES
-- Historical data
(1, 23.5, 65.0, 0, 12.5, 20, 'Sunny', CURDATE() - INTERVAL 1 DAY, FALSE, 'OpenWeatherMap'),
(1, 22.8, 68.0, 2.5, 15.0, 45, 'Partly Cloudy', CURDATE() - INTERVAL 2 DAY, FALSE, 'OpenWeatherMap'),
-- Forecast data
(1, 24.0, 62.0, 0, 10.0, 15, 'Sunny', CURDATE() + INTERVAL 1 DAY, TRUE, 'OpenWeatherMap'),
(1, 25.5, 60.0, 0, 8.5, 10, 'Clear', CURDATE() + INTERVAL 2 DAY, TRUE, 'OpenWeatherMap'),
(2, 26.5, 58.0, 0, 14.0, 25, 'Sunny', CURDATE(), FALSE, 'OpenWeatherMap'),
(3, 25.0, 70.0, 5.0, 18.0, 60, 'Rainy', CURDATE() - INTERVAL 1 DAY, FALSE, 'Local Sensor');

-- ============================================
-- Sample System Settings
-- ============================================
INSERT INTO system_settings (user_id, setting_key, setting_value, setting_type, description) VALUES
(NULL, 'soil_moisture_threshold_low', '30', 'global', 'Global threshold for low soil moisture alert'),
(NULL, 'soil_moisture_threshold_critical', '20', 'global', 'Global threshold for critical soil moisture alert'),
(NULL, 'temperature_threshold_high', '35', 'global', 'High temperature warning threshold in Celsius'),
(NULL, 'auto_irrigation_enabled', 'true', 'global', 'Enable automatic irrigation system-wide'),
(1, 'notification_email', 'true', 'user', 'Enable email notifications for user'),
(1, 'notification_push', 'true', 'user', 'Enable push notifications for user'),
(1, 'notification_sms', 'false', 'user', 'Enable SMS notifications for user'),
(2, 'preferred_language', 'urdu', 'user', 'User preferred language for notifications');

-- ============================================
-- Sample Audit Logs
-- ============================================
INSERT INTO audit_logs (user_id, action_type, table_name, record_id, old_value, new_value, ip_address, user_agent) VALUES
(1, 'LOGIN', NULL, NULL, NULL, NULL, '192.168.1.100', 'Mozilla/5.0 (Android 12; Mobile)'),
(1, 'UPDATE', 'fields', 1, '{"current_crop": null}', '{"current_crop": "Wheat"}', '192.168.1.100', 'Mozilla/5.0 (Android 12; Mobile)'),
(2, 'LOGIN', NULL, NULL, NULL, NULL, '192.168.1.105', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0)'),
(2, 'CREATE', 'irrigation_logs', 3, NULL, '{"irrigation_type": "automatic", "duration_minutes": 50}', '192.168.1.105', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0)'),
(4, 'LOGIN', NULL, NULL, NULL, NULL, '192.168.1.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)');

-- ============================================
-- End of Sample Data
-- ============================================
