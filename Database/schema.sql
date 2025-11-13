-- ============================================
-- Smart AI-Powered Agriculture System
-- MySQL Database Schema
-- ============================================
-- Description: Normalized database schema for IoT-based smart farming
-- Version: 1.0
-- Date: 2025-11-06
-- ============================================

-- Create database
CREATE DATABASE IF NOT EXISTS smart_agriculture;
USE smart_agriculture;

-- ============================================
-- Table: users
-- Description: Stores farmer/user information and authentication credentials
-- ============================================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    address TEXT,
    city VARCHAR(50),
    province VARCHAR(50),
    postal_code VARCHAR(10),
    role ENUM('farmer', 'admin', 'technician') DEFAULT 'farmer',
    is_active BOOLEAN DEFAULT TRUE,
    email_verified BOOLEAN DEFAULT FALSE,
    phone_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    INDEX idx_email (email),
    INDEX idx_phone (phone),
    INDEX idx_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: fields
-- Description: Stores information about farmer's land plots/fields
-- ============================================
CREATE TABLE fields (
    field_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    field_name VARCHAR(100) NOT NULL,
    location_latitude DECIMAL(10, 8),
    location_longitude DECIMAL(11, 8),
    area_size DECIMAL(10, 2) NOT NULL COMMENT 'Area in acres or hectares',
    area_unit ENUM('acres', 'hectares', 'square_meters') DEFAULT 'acres',
    soil_type VARCHAR(50) COMMENT 'e.g., Clay, Sandy, Loamy',
    current_crop VARCHAR(100),
    planting_date DATE,
    expected_harvest_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_is_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: sensors
-- Description: Stores IoT sensor device information
-- ============================================
CREATE TABLE sensors (
    sensor_id INT AUTO_INCREMENT PRIMARY KEY,
    field_id INT NOT NULL,
    sensor_type ENUM('soil_moisture', 'temperature', 'humidity', 'light', 'rain', 'water_flow', 'combined') NOT NULL,
    device_id VARCHAR(100) UNIQUE NOT NULL COMMENT 'ESP32 MAC address or unique identifier',
    sensor_model VARCHAR(100) COMMENT 'e.g., YL-69, DHT22, FC-37',
    installation_date DATE NOT NULL,
    location_description TEXT COMMENT 'Specific location within the field',
    calibration_offset DECIMAL(5, 2) DEFAULT 0.00 COMMENT 'Calibration adjustment value',
    is_active BOOLEAN DEFAULT TRUE,
    last_maintenance_date DATE,
    battery_level DECIMAL(5, 2) COMMENT 'Battery percentage if applicable',
    firmware_version VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (field_id) REFERENCES fields(field_id) ON DELETE CASCADE,
    INDEX idx_field_id (field_id),
    INDEX idx_device_id (device_id),
    INDEX idx_sensor_type (sensor_type),
    INDEX idx_is_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: sensor_readings
-- Description: Stores real-time sensor data from IoT devices
-- ============================================
CREATE TABLE sensor_readings (
    reading_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sensor_id INT NOT NULL,
    soil_moisture DECIMAL(5, 2) COMMENT 'Percentage (0-100)',
    temperature DECIMAL(5, 2) COMMENT 'Celsius',
    humidity DECIMAL(5, 2) COMMENT 'Percentage (0-100)',
    light_intensity DECIMAL(8, 2) COMMENT 'Lux or percentage',
    rainfall DECIMAL(6, 2) COMMENT 'mm or boolean (0/1)',
    water_flow_rate DECIMAL(8, 2) COMMENT 'Liters per minute',
    battery_voltage DECIMAL(4, 2) COMMENT 'Volts',
    signal_strength INT COMMENT 'WiFi signal strength in dBm',
    reading_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id) ON DELETE CASCADE,
    INDEX idx_sensor_id (sensor_id),
    INDEX idx_reading_timestamp (reading_timestamp),
    INDEX idx_sensor_timestamp (sensor_id, reading_timestamp)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: irrigation_logs
-- Description: Records all irrigation events (manual and automatic)
-- ============================================
CREATE TABLE irrigation_logs (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    field_id INT NOT NULL,
    sensor_id INT COMMENT 'NULL if manual irrigation',
    irrigation_type ENUM('automatic', 'manual', 'scheduled') NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NULL,
    duration_minutes INT COMMENT 'Calculated duration',
    water_used_liters DECIMAL(10, 2) COMMENT 'Total water consumed',
    trigger_reason VARCHAR(255) COMMENT 'e.g., Soil moisture below 30%',
    soil_moisture_before DECIMAL(5, 2),
    soil_moisture_after DECIMAL(5, 2),
    pump_status ENUM('on', 'off', 'error') DEFAULT 'off',
    initiated_by INT COMMENT 'user_id if manual, NULL if automatic',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (field_id) REFERENCES fields(field_id) ON DELETE CASCADE,
    FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id) ON DELETE SET NULL,
    FOREIGN KEY (initiated_by) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_field_id (field_id),
    INDEX idx_start_time (start_time),
    INDEX idx_irrigation_type (irrigation_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: crop_recommendations
-- Description: AI-generated crop recommendations based on soil and weather data
-- ============================================
CREATE TABLE crop_recommendations (
    recommendation_id INT AUTO_INCREMENT PRIMARY KEY,
    field_id INT NOT NULL,
    recommended_crop VARCHAR(100) NOT NULL,
    confidence_score DECIMAL(5, 2) COMMENT 'AI model confidence (0-100)',
    soil_moisture_avg DECIMAL(5, 2),
    temperature_avg DECIMAL(5, 2),
    humidity_avg DECIMAL(5, 2),
    soil_type VARCHAR(50),
    season VARCHAR(20) COMMENT 'e.g., Kharif, Rabi',
    expected_yield DECIMAL(10, 2) COMMENT 'Expected yield in kg/acre',
    water_requirement VARCHAR(50) COMMENT 'e.g., Low, Medium, High',
    growth_duration_days INT COMMENT 'Days to harvest',
    recommendation_reason TEXT COMMENT 'AI explanation',
    model_version VARCHAR(20) COMMENT 'ML model version used',
    is_accepted BOOLEAN DEFAULT FALSE,
    accepted_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (field_id) REFERENCES fields(field_id) ON DELETE CASCADE,
    INDEX idx_field_id (field_id),
    INDEX idx_recommended_crop (recommended_crop),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: alerts
-- Description: Stores notifications and warnings for farmers
-- ============================================
CREATE TABLE alerts (
    alert_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    field_id INT,
    sensor_id INT,
    alert_type ENUM('critical', 'warning', 'info', 'success') DEFAULT 'info',
    alert_category ENUM('soil_moisture', 'temperature', 'humidity', 'irrigation', 'sensor_offline', 'crop_health', 'weather', 'system') NOT NULL,
    title VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    threshold_value DECIMAL(10, 2) COMMENT 'Threshold that triggered the alert',
    current_value DECIMAL(10, 2) COMMENT 'Current sensor value',
    is_read BOOLEAN DEFAULT FALSE,
    is_resolved BOOLEAN DEFAULT FALSE,
    resolved_at TIMESTAMP NULL,
    action_taken TEXT COMMENT 'What action was taken to resolve',
    push_notification_sent BOOLEAN DEFAULT FALSE,
    email_sent BOOLEAN DEFAULT FALSE,
    sms_sent BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (field_id) REFERENCES fields(field_id) ON DELETE CASCADE,
    FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_field_id (field_id),
    INDEX idx_alert_type (alert_type),
    INDEX idx_is_read (is_read),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: irrigation_schedules
-- Description: Stores scheduled irrigation plans
-- ============================================
CREATE TABLE irrigation_schedules (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    field_id INT NOT NULL,
    schedule_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    time_of_day TIME NOT NULL COMMENT 'Preferred irrigation time',
    duration_minutes INT NOT NULL,
    frequency ENUM('daily', 'alternate_days', 'weekly', 'custom') DEFAULT 'daily',
    custom_days VARCHAR(50) COMMENT 'e.g., Mon,Wed,Fri',
    is_active BOOLEAN DEFAULT TRUE,
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (field_id) REFERENCES fields(field_id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_field_id (field_id),
    INDEX idx_is_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: weather_data
-- Description: Stores weather forecast and historical weather data
-- ============================================
CREATE TABLE weather_data (
    weather_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    field_id INT NOT NULL,
    temperature DECIMAL(5, 2) COMMENT 'Celsius',
    humidity DECIMAL(5, 2) COMMENT 'Percentage',
    rainfall DECIMAL(6, 2) COMMENT 'mm',
    wind_speed DECIMAL(5, 2) COMMENT 'km/h',
    cloud_cover DECIMAL(5, 2) COMMENT 'Percentage',
    weather_condition VARCHAR(50) COMMENT 'e.g., Sunny, Rainy, Cloudy',
    forecast_date DATE NOT NULL,
    is_forecast BOOLEAN DEFAULT FALSE COMMENT 'TRUE for forecast, FALSE for actual',
    data_source VARCHAR(50) COMMENT 'e.g., OpenWeatherMap, Local Sensor',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (field_id) REFERENCES fields(field_id) ON DELETE CASCADE,
    INDEX idx_field_id (field_id),
    INDEX idx_forecast_date (forecast_date),
    INDEX idx_is_forecast (is_forecast)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: system_settings
-- Description: Stores system-wide and user-specific configuration
-- ============================================
CREATE TABLE system_settings (
    setting_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT COMMENT 'NULL for global settings',
    setting_key VARCHAR(100) NOT NULL,
    setting_value TEXT NOT NULL,
    setting_type ENUM('global', 'user', 'field') DEFAULT 'global',
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_setting (user_id, setting_key),
    INDEX idx_setting_key (setting_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table: audit_logs
-- Description: Tracks all important system activities for security and debugging
-- ============================================
CREATE TABLE audit_logs (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action_type VARCHAR(50) NOT NULL COMMENT 'e.g., LOGIN, LOGOUT, CREATE, UPDATE, DELETE',
    table_name VARCHAR(50) COMMENT 'Affected table',
    record_id INT COMMENT 'Affected record ID',
    old_value TEXT COMMENT 'Previous value (JSON)',
    new_value TEXT COMMENT 'New value (JSON)',
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_action_type (action_type),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- End of Schema
-- ============================================
