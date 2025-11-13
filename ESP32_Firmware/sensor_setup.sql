-- ============================================
-- ESP32 Sensor Setup SQL Script
-- ============================================
-- This script helps you register your ESP32 device in the database
-- Run this after setting up your hardware
-- ============================================

-- Example: Insert a new sensor for your ESP32 device
-- IMPORTANT: Replace field_id with your actual field ID from the fields table

INSERT INTO sensors (
    field_id,
    sensor_type,
    device_id,
    sensor_model,
    installation_date,
    location_description,
    is_active,
    battery_level
) VALUES (
    1, -- Replace with your field_id (check fields table)
    'combined', -- This ESP32 has multiple sensors
    'ESP32_001', -- Must match deviceId in Arduino code
    'ESP32 + YL69 + DHT22 + FC35 + CW020', -- Description of your setup
    CURDATE(), -- Today's date
    'Field center monitoring station', -- Where you placed it
    TRUE, -- Active sensor
    100.0 -- Start with 100% battery
);

-- ============================================
-- Check if sensor was created successfully
-- ============================================
SELECT * FROM sensors WHERE device_id = 'ESP32_001';

-- ============================================
-- Optional: Create additional ESP32 devices
-- ============================================

-- For multiple fields, duplicate the INSERT with different device_id and field_id:

/*
INSERT INTO sensors (
    field_id,
    sensor_type,
    device_id,
    sensor_model,
    installation_date,
    location_description,
    is_active,
    battery_level
) VALUES (
    2, -- Different field
    'combined',
    'ESP32_002', -- Different device ID
    'ESP32 + YL69 + DHT22 + FC35 + CW020',
    CURDATE(),
    'North field monitoring station',
    TRUE,
    100.0
);
*/

-- ============================================
-- Verify your fields exist first
-- ============================================
SELECT field_id, field_name, user_id FROM fields ORDER BY field_id;

-- ============================================
-- Check sensor readings after ESP32 starts sending data
-- ============================================
SELECT 
    sr.reading_id,
    sr.soil_moisture,
    sr.temperature,
    sr.humidity,
    sr.light_intensity,
    sr.water_flow_rate,
    sr.battery_voltage,
    sr.signal_strength,
    sr.reading_timestamp,
    s.device_id
FROM sensor_readings sr
JOIN sensors s ON sr.sensor_id = s.sensor_id
WHERE s.device_id = 'ESP32_001'
ORDER BY sr.reading_timestamp DESC
LIMIT 10;

-- ============================================
-- Monitor sensor health
-- ============================================
SELECT 
    s.device_id,
    s.sensor_model,
    s.battery_level,
    s.is_active,
    s.installation_date,
    f.field_name,
    COUNT(sr.reading_id) as total_readings,
    MAX(sr.reading_timestamp) as last_reading
FROM sensors s
LEFT JOIN fields f ON s.field_id = f.field_id
LEFT JOIN sensor_readings sr ON s.sensor_id = sr.sensor_id
WHERE s.device_id LIKE 'ESP32_%'
GROUP BY s.sensor_id
ORDER BY last_reading DESC;
