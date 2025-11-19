-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 19, 2025 at 04:32 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+05:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smart_agriculture`
--

-- --------------------------------------------------------

--
-- Table structure for table `alerts`
--

CREATE TABLE `alerts` (
  `alert_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `field_id` int(11) DEFAULT NULL,
  `sensor_id` int(11) DEFAULT NULL,
  `alert_type` enum('critical','warning','info','success') DEFAULT 'info',
  `alert_category` enum('soil_moisture','temperature','humidity','irrigation','sensor_offline','crop_health','weather','system') NOT NULL,
  `title` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `threshold_value` decimal(10,2) DEFAULT NULL COMMENT 'Threshold that triggered the alert',
  `current_value` decimal(10,2) DEFAULT NULL COMMENT 'Current sensor value',
  `is_read` tinyint(1) DEFAULT 0,
  `is_resolved` tinyint(1) DEFAULT 0,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `action_taken` text DEFAULT NULL COMMENT 'What action was taken to resolve',
  `push_notification_sent` tinyint(1) DEFAULT 0,
  `email_sent` tinyint(1) DEFAULT 0,
  `sms_sent` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `alerts`
--

INSERT INTO `alerts` (`alert_id`, `user_id`, `field_id`, `sensor_id`, `alert_type`, `alert_category`, `title`, `message`, `threshold_value`, `current_value`, `is_read`, `is_resolved`, `resolved_at`, `action_taken`, `push_notification_sent`, `email_sent`, `sms_sent`, `created_at`) VALUES
(7, 5, 6, NULL, 'warning', 'temperature', 'High Temperature Warning', 'Temperature in Main Field - Wheat is 23.1°C. Monitor crop health.', 25.00, 23.10, 1, 1, '2025-11-10 16:44:52', NULL, 0, 0, 0, '2025-11-05 20:40:35'),
(9, 5, 6, NULL, 'info', 'irrigation', 'Irrigation Completed', 'Automatic irrigation completed successfully. Duration: 45 minutes, Water used: 3200 liters.', NULL, NULL, 1, 1, NULL, NULL, 0, 0, 0, '2025-11-03 21:40:35');

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `log_id` bigint(20) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action_type` varchar(50) NOT NULL COMMENT 'e.g., LOGIN, LOGOUT, CREATE, UPDATE, DELETE',
  `table_name` varchar(50) DEFAULT NULL COMMENT 'Affected table',
  `record_id` int(11) DEFAULT NULL COMMENT 'Affected record ID',
  `old_value` text DEFAULT NULL COMMENT 'Previous value (JSON)',
  `new_value` text DEFAULT NULL COMMENT 'New value (JSON)',
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`log_id`, `user_id`, `action_type`, `table_name`, `record_id`, `old_value`, `new_value`, `ip_address`, `user_agent`, `created_at`) VALUES
(6, 5, 'LOGIN', NULL, NULL, NULL, NULL, '192.168.1.150', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0', '2025-11-05 21:40:35'),
(7, 5, 'CREATE', 'fields', 6, NULL, '{\"field_name\": \"Main Field - Wheat\", \"area_size\": 8.5}', '192.168.1.150', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0', '2025-11-05 21:40:35'),
(8, 5, 'CREATE', 'irrigation_logs', NULL, NULL, '{\"irrigation_type\": \"automatic\", \"duration_minutes\": 45}', '192.168.1.150', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0', '2025-11-05 21:40:35'),
(9, 5, 'UPDATE', 'alerts', NULL, '{\"is_read\": false}', '{\"is_read\": true}', '192.168.1.150', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0', '2025-11-05 21:40:35');

-- --------------------------------------------------------

--
-- Table structure for table `crop_recommendations`
--

CREATE TABLE `crop_recommendations` (
  `recommendation_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `recommended_crop` varchar(100) NOT NULL,
  `confidence_score` decimal(5,2) DEFAULT NULL COMMENT 'AI model confidence (0-100)',
  `soil_moisture_avg` decimal(5,2) DEFAULT NULL,
  `temperature_avg` decimal(5,2) DEFAULT NULL,
  `humidity_avg` decimal(5,2) DEFAULT NULL,
  `soil_type` varchar(50) DEFAULT NULL,
  `season` varchar(20) DEFAULT NULL COMMENT 'e.g., Kharif, Rabi',
  `expected_yield` decimal(10,2) DEFAULT NULL COMMENT 'Expected yield in kg/acre',
  `water_requirement` varchar(50) DEFAULT NULL COMMENT 'e.g., Low, Medium, High',
  `growth_duration_days` int(11) DEFAULT NULL COMMENT 'Days to harvest',
  `recommendation_reason` text DEFAULT NULL COMMENT 'AI explanation',
  `model_version` varchar(20) DEFAULT NULL COMMENT 'ML model version used',
  `is_accepted` tinyint(1) DEFAULT 0,
  `accepted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `crop_recommendations`
--

INSERT INTO `crop_recommendations` (`recommendation_id`, `field_id`, `recommended_crop`, `confidence_score`, `soil_moisture_avg`, `temperature_avg`, `humidity_avg`, `soil_type`, `season`, `expected_yield`, `water_requirement`, `growth_duration_days`, `recommendation_reason`, `model_version`, `is_accepted`, `accepted_at`, `created_at`) VALUES
(6, 6, 'Wheat', 94.50, 45.20, 22.50, 62.00, 'Loamy', 'Rabi', 3200.00, 'Medium', 150, 'Excellent soil conditions and optimal temperature for wheat cultivation. Loamy soil provides good drainage and nutrient retention.', NULL, 1, NULL, '2025-10-31 21:40:35');

-- --------------------------------------------------------

--
-- Table structure for table `fields`
--

CREATE TABLE `fields` (
  `field_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `field_name` varchar(100) NOT NULL,
  `location_latitude` decimal(10,8) DEFAULT NULL,
  `location_longitude` decimal(11,8) DEFAULT NULL,
  `area_size` decimal(10,2) NOT NULL COMMENT 'Area in acres or hectares',
  `area_unit` enum('acres','hectares','square_meters') DEFAULT 'acres',
  `soil_type` varchar(50) DEFAULT NULL COMMENT 'e.g., Clay, Sandy, Loamy',
  `current_crop` varchar(100) DEFAULT NULL,
  `planting_date` date DEFAULT NULL,
  `expected_harvest_date` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fields`
--

INSERT INTO `fields` (`field_id`, `user_id`, `field_name`, `location_latitude`, `location_longitude`, `area_size`, `area_unit`, `soil_type`, `current_crop`, `planting_date`, `expected_harvest_date`, `is_active`, `created_at`, `updated_at`) VALUES
(6, 5, 'Main Field - Wheat', 33.56510000, 73.01690000, 8.50, 'acres', 'Loamy', 'Wheat', '2024-11-01', '2025-04-20', 1, '2025-11-05 21:40:35', '2025-11-05 21:40:35');

-- --------------------------------------------------------

--
-- Table structure for table `irrigation_logs`
--

CREATE TABLE `irrigation_logs` (
  `log_id` bigint(20) NOT NULL,
  `field_id` int(11) NOT NULL,
  `sensor_id` int(11) DEFAULT NULL COMMENT 'NULL if manual irrigation',
  `irrigation_type` enum('automatic','manual','scheduled') NOT NULL,
  `start_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `end_time` timestamp NULL DEFAULT NULL,
  `duration_minutes` int(11) DEFAULT NULL COMMENT 'Calculated duration',
  `water_used_liters` decimal(10,2) DEFAULT NULL COMMENT 'Total water consumed',
  `trigger_reason` varchar(255) DEFAULT NULL COMMENT 'e.g., Soil moisture below 30%',
  `soil_moisture_before` decimal(5,2) DEFAULT NULL,
  `soil_moisture_after` decimal(5,2) DEFAULT NULL,
  `pump_status` enum('on','off','error') DEFAULT 'off',
  `initiated_by` int(11) DEFAULT NULL COMMENT 'user_id if manual, NULL if automatic',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `irrigation_logs`
--

INSERT INTO `irrigation_logs` (`log_id`, `field_id`, `sensor_id`, `irrigation_type`, `start_time`, `end_time`, `duration_minutes`, `water_used_liters`, `trigger_reason`, `soil_moisture_before`, `soil_moisture_after`, `pump_status`, `initiated_by`, `notes`, `created_at`) VALUES
(6, 6, NULL, 'automatic', '2025-11-03 21:40:35', '2025-11-03 22:25:35', 45, 3200.00, 'Soil moisture below 35%', 32.50, 48.20, 'off', 5, NULL, '2025-11-05 21:40:35'),
(7, 6, NULL, 'scheduled', '2025-11-01 21:40:35', '2025-11-01 22:20:35', 40, 2850.00, 'Scheduled irrigation - Morning', 38.20, 52.50, 'off', 5, NULL, '2025-11-05 21:40:35'),
(8, 6, NULL, 'manual', '2025-10-30 21:40:35', '2025-10-30 22:30:35', 50, 3500.00, 'Manual irrigation by farmer', 35.80, 50.20, 'off', 5, NULL, '2025-11-05 21:40:35');

-- --------------------------------------------------------

--
-- Table structure for table `irrigation_schedules`
--

CREATE TABLE `irrigation_schedules` (
  `schedule_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `schedule_name` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `time_of_day` time NOT NULL COMMENT 'Preferred irrigation time',
  `duration_minutes` int(11) NOT NULL,
  `frequency` enum('daily','alternate_days','weekly','custom') DEFAULT 'daily',
  `custom_days` varchar(50) DEFAULT NULL COMMENT 'e.g., Mon,Wed,Fri',
  `is_active` tinyint(1) DEFAULT 1,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `irrigation_schedules`
--

INSERT INTO `irrigation_schedules` (`schedule_id`, `field_id`, `schedule_name`, `start_date`, `end_date`, `time_of_day`, `duration_minutes`, `frequency`, `custom_days`, `is_active`, `created_by`, `created_at`, `updated_at`) VALUES
(5, 6, 'Morning Irrigation - Wheat', '2024-11-01', '2025-04-20', '06:00:00', 40, 'alternate_days', NULL, 1, 5, '2025-11-05 21:40:35', '2025-11-05 21:40:35'),
(6, 6, 'Evening Irrigation - Wheat', '2024-11-01', '2025-04-20', '18:00:00', 35, 'weekly', 'Sunday,Wednesday', 1, 5, '2025-11-05 21:40:35', '2025-11-05 21:40:35');

-- --------------------------------------------------------

--
-- Table structure for table `sensors`
--

CREATE TABLE `sensors` (
  `sensor_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `sensor_type` enum('soil_moisture','temperature','humidity','light','rain','water_flow','combined') NOT NULL,
  `device_id` varchar(100) NOT NULL COMMENT 'ESP32 MAC address or unique identifier',
  `sensor_model` varchar(100) DEFAULT NULL COMMENT 'e.g., YL-69, DHT22, FC-37',
  `installation_date` date NOT NULL,
  `location_description` text DEFAULT NULL COMMENT 'Specific location within the field',
  `calibration_offset` decimal(5,2) DEFAULT 0.00 COMMENT 'Calibration adjustment value',
  `is_active` tinyint(1) DEFAULT 1,
  `last_maintenance_date` date DEFAULT NULL,
  `battery_level` decimal(5,2) DEFAULT NULL COMMENT 'Battery percentage if applicable',
  `firmware_version` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sensors`
--

INSERT INTO `sensors` (`sensor_id`, `field_id`, `sensor_type`, `device_id`, `sensor_model`, `installation_date`, `location_description`, `calibration_offset`, `is_active`, `last_maintenance_date`, `battery_level`, `firmware_version`, `created_at`, `updated_at`) VALUES
(14, 6, 'combined', 'ESP_32test', 'ESP32 + DHT11 + Soil Sensor', '2025-11-17', 'Test Location', 0.00, 1, NULL, 100.00, '1.0.0', '2025-11-17 14:16:52', '2025-11-17 14:16:52');

-- --------------------------------------------------------

--
-- Table structure for table `sensor_readings`
--

CREATE TABLE `sensor_readings` (
  `reading_id` bigint(20) NOT NULL,
  `sensor_id` int(11) NOT NULL,
  `reading_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `soil_moisture` decimal(5,2) DEFAULT NULL COMMENT 'Percentage',
  `temperature` decimal(5,2) DEFAULT NULL COMMENT 'Celsius',
  `humidity` decimal(5,2) DEFAULT NULL COMMENT 'Percentage',
  `light_intensity` int(11) DEFAULT NULL COMMENT 'Lux',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sensor_readings`
--

INSERT INTO `sensor_readings` (`reading_id`, `sensor_id`, `reading_time`, `soil_moisture`, `temperature`, `humidity`, `light_intensity`, `created_at`) VALUES
(1, 14, '2025-11-19 15:53:26', 45.50, 26.20, 60.50, 800, '2025-11-19 15:53:26');

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `setting_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL COMMENT 'NULL for global settings',
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text NOT NULL,
  `setting_type` enum('global','user','field') DEFAULT 'global',
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`setting_id`, `user_id`, `setting_key`, `setting_value`, `setting_type`, `description`, `created_at`, `updated_at`) VALUES
(1, NULL, 'soil_moisture_threshold_low', '30', 'global', 'Global threshold for low soil moisture alert', '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(2, NULL, 'soil_moisture_threshold_critical', '20', 'global', 'Global threshold for critical soil moisture alert', '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(3, NULL, 'temperature_threshold_high', '35', 'global', 'High temperature warning threshold in Celsius', '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(4, NULL, 'auto_irrigation_enabled', 'true', 'global', 'Enable automatic irrigation system-wide', '2025-11-05 21:25:29', '2025-11-05 21:25:29');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `province` varchar(50) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `role` enum('farmer','admin','technician') DEFAULT 'farmer',
  `is_active` tinyint(1) DEFAULT 1,
  `email_verified` tinyint(1) DEFAULT 0,
  `phone_verified` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_login` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `phone`, `password_hash`, `address`, `city`, `province`, `postal_code`, `role`, `is_active`, `email_verified`, `phone_verified`, `created_at`, `updated_at`, `last_login`) VALUES
(5, 'HAMZA BASHIR', 'hamzabashir1289@gmail.com', '+923320573993', '$2a$10$zZe2IyLoCX9jc5P.2Swg5e9upf12hHGmb16pGTBjWAwsDSe8RXKge', 'H # 543, Street 25, Sector G, Bahria Town phase 8', 'Rawalpindi', 'punjab', NULL, 'farmer', 1, 0, 0, '2025-11-05 21:31:57', '2025-11-18 17:37:02', '2025-11-18 17:37:02');

-- --------------------------------------------------------

--
-- Table structure for table `weather_data`
--

CREATE TABLE `weather_data` (
  `weather_id` bigint(20) NOT NULL,
  `field_id` int(11) NOT NULL,
  `temperature` decimal(5,2) DEFAULT NULL COMMENT 'Celsius',
  `humidity` decimal(5,2) DEFAULT NULL COMMENT 'Percentage',
  `rainfall` decimal(6,2) DEFAULT NULL COMMENT 'mm',
  `wind_speed` decimal(5,2) DEFAULT NULL COMMENT 'km/h',
  `cloud_cover` decimal(5,2) DEFAULT NULL COMMENT 'Percentage',
  `weather_condition` varchar(50) DEFAULT NULL COMMENT 'e.g., Sunny, Rainy, Cloudy',
  `forecast_date` date NOT NULL,
  `is_forecast` tinyint(1) DEFAULT 0 COMMENT 'TRUE for forecast, FALSE for actual',
  `data_source` varchar(50) DEFAULT NULL COMMENT 'e.g., OpenWeatherMap, Local Sensor',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `weather_data`
--

INSERT INTO `weather_data` (`weather_id`, `field_id`, `temperature`, `humidity`, `rainfall`, `wind_speed`, `cloud_cover`, `weather_condition`, `forecast_date`, `is_forecast`, `data_source`, `created_at`) VALUES
(7, 6, '23.50', '62.00', '0.00', '8.50', '25.00', 'Partly Cloudy', '2025-11-06', 0, NULL, '2025-11-05 21:40:35'),
(11, 6, '24.00', '58.00', '0.00', '10.00', '30.00', 'Sunny', '2025-11-07', 1, NULL, '2025-11-05 21:40:35'),
(12, 6, '22.50', '65.00', '2.50', '12.00', '60.00', 'Light Rain', '2025-11-08', 1, NULL, '2025-11-05 21:40:35'),
(13, 6, '21.00', '70.00', '5.00', '15.00', '80.00', 'Rainy', '2025-11-09', 1, NULL, '2025-11-05 21:40:35');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alerts`
--
ALTER TABLE `alerts`
  ADD PRIMARY KEY (`alert_id`),
  ADD KEY `sensor_id` (`sensor_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_field_id` (`field_id`),
  ADD KEY `idx_alert_type` (`alert_type`),
  ADD KEY `idx_is_read` (`is_read`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_action_type` (`action_type`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `crop_recommendations`
--
ALTER TABLE `crop_recommendations`
  ADD PRIMARY KEY (`recommendation_id`),
  ADD KEY `idx_field_id` (`field_id`),
  ADD KEY `idx_recommended_crop` (`recommended_crop`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `fields`
--
ALTER TABLE `fields`
  ADD PRIMARY KEY (`field_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_is_active` (`is_active`);

--
-- Indexes for table `irrigation_logs`
--
ALTER TABLE `irrigation_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `sensor_id` (`sensor_id`),
  ADD KEY `initiated_by` (`initiated_by`),
  ADD KEY `idx_field_id` (`field_id`),
  ADD KEY `idx_start_time` (`start_time`),
  ADD KEY `idx_irrigation_type` (`irrigation_type`);

--
-- Indexes for table `irrigation_schedules`
--
ALTER TABLE `irrigation_schedules`
  ADD PRIMARY KEY (`schedule_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_field_id` (`field_id`),
  ADD KEY `idx_is_active` (`is_active`);

--
-- Indexes for table `sensors`
--
ALTER TABLE `sensors`
  ADD PRIMARY KEY (`sensor_id`),
  ADD UNIQUE KEY `device_id` (`device_id`),
  ADD KEY `idx_field_id` (`field_id`),
  ADD KEY `idx_device_id` (`device_id`),
  ADD KEY `idx_sensor_type` (`sensor_type`),
  ADD KEY `idx_is_active` (`is_active`);

--
-- Indexes for table `sensor_readings`
--
ALTER TABLE `sensor_readings`
  ADD PRIMARY KEY (`reading_id`),
  ADD KEY `idx_sensor_id` (`sensor_id`),
  ADD KEY `idx_reading_time` (`reading_time`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`setting_id`),
  ADD UNIQUE KEY `unique_user_setting` (`user_id`,`setting_key`),
  ADD KEY `idx_setting_key` (`setting_key`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_phone` (`phone`),
  ADD KEY `idx_role` (`role`);

--
-- Indexes for table `weather_data`
--
ALTER TABLE `weather_data`
  ADD PRIMARY KEY (`weather_id`),
  ADD KEY `idx_field_id` (`field_id`),
  ADD KEY `idx_forecast_date` (`forecast_date`),
  ADD KEY `idx_is_forecast` (`is_forecast`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alerts`
--
ALTER TABLE `alerts`
  MODIFY `alert_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `log_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `crop_recommendations`
--
ALTER TABLE `crop_recommendations`
  MODIFY `recommendation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `fields`
--
ALTER TABLE `fields`
  MODIFY `field_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `irrigation_logs`
--
ALTER TABLE `irrigation_logs`
  MODIFY `log_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `irrigation_schedules`
--
ALTER TABLE `irrigation_schedules`
  MODIFY `schedule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `sensors`
--
ALTER TABLE `sensors`
  MODIFY `sensor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `sensor_readings`
--
ALTER TABLE `sensor_readings`
  MODIFY `reading_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `setting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `weather_data`
--
ALTER TABLE `weather_data`
  MODIFY `weather_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `alerts`
--
ALTER TABLE `alerts`
  ADD CONSTRAINT `alerts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `alerts_ibfk_2` FOREIGN KEY (`field_id`) REFERENCES `fields` (`field_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `alerts_ibfk_3` FOREIGN KEY (`sensor_id`) REFERENCES `sensors` (`sensor_id`) ON DELETE SET NULL;

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `crop_recommendations`
--
ALTER TABLE `crop_recommendations`
  ADD CONSTRAINT `crop_recommendations_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `fields` (`field_id`) ON DELETE CASCADE;

--
-- Constraints for table `fields`
--
ALTER TABLE `fields`
  ADD CONSTRAINT `fields_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `irrigation_logs`
--
ALTER TABLE `irrigation_logs`
  ADD CONSTRAINT `irrigation_logs_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `fields` (`field_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `irrigation_logs_ibfk_2` FOREIGN KEY (`sensor_id`) REFERENCES `sensors` (`sensor_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `irrigation_logs_ibfk_3` FOREIGN KEY (`initiated_by`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `irrigation_schedules`
--
ALTER TABLE `irrigation_schedules`
  ADD CONSTRAINT `irrigation_schedules_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `fields` (`field_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `irrigation_schedules_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `sensors`
--
ALTER TABLE `sensors`
  ADD CONSTRAINT `sensors_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `fields` (`field_id`) ON DELETE CASCADE;

--
-- Constraints for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD CONSTRAINT `system_settings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `weather_data`
--
ALTER TABLE `weather_data`
  ADD CONSTRAINT `weather_data_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `fields` (`field_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
