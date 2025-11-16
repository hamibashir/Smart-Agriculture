-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 16, 2025 at 06:16 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


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
(1, 1, 1, 2, 'critical', 'soil_moisture', 'Low Soil Moisture Alert', 'Soil moisture in North Field has dropped to 28.5%. Immediate irrigation recommended.', 30.00, 28.50, 1, 1, NULL, NULL, 1, 1, 0, '2025-11-05 21:25:29'),
(2, 1, 2, 3, 'warning', 'temperature', 'High Temperature Warning', 'Temperature in South Field is 32°C. Monitor crop health closely.', 30.00, 32.00, 1, 0, NULL, NULL, 1, 0, 0, '2025-11-05 21:25:29'),
(3, 2, 3, 4, 'info', 'irrigation', 'Irrigation Completed', 'Automatic irrigation completed successfully. Duration: 50 minutes.', NULL, NULL, 1, 1, NULL, NULL, 1, 0, 0, '2025-11-05 21:25:29'),
(4, 2, 3, 4, 'warning', 'sensor_offline', 'Sensor Connectivity Issue', 'Sensor ESP32-D4E5F6A1B2C3 has not sent data for 2 hours.', NULL, NULL, 0, 0, NULL, NULL, 1, 1, 0, '2025-11-05 21:25:29'),
(5, 3, 5, 6, 'info', 'crop_health', 'New Crop Recommendation', 'AI model suggests Maize for Test Field with 85.3% confidence.', NULL, NULL, 0, 0, NULL, NULL, 1, 0, 0, '2025-11-05 21:25:29'),
(6, 5, 9, 12, 'critical', 'soil_moisture', 'Critical: Low Soil Moisture', 'Soil moisture in North Field - Cotton has dropped to 38.2%. Immediate irrigation recommended.', 40.00, 38.20, 0, 0, NULL, NULL, 0, 0, 0, '2025-11-05 21:10:35'),
(7, 5, 6, 7, 'warning', 'temperature', 'High Temperature Warning', 'Temperature in Main Field - Wheat is 23.1°C. Monitor crop health.', 25.00, 23.10, 1, 1, '2025-11-10 16:44:52', NULL, 0, 0, 0, '2025-11-05 20:40:35'),
(8, 5, 7, 9, 'warning', 'humidity', 'High Humidity Alert', 'Humidity in South Field - Rice is 76.2%. Risk of fungal growth.', 75.00, 76.20, 0, 0, NULL, NULL, 0, 0, 0, '2025-11-05 19:40:35'),
(9, 5, 6, NULL, 'info', 'irrigation', 'Irrigation Completed', 'Automatic irrigation completed successfully. Duration: 45 minutes, Water used: 3200 liters.', NULL, NULL, 1, 1, NULL, NULL, 0, 0, 0, '2025-11-03 21:40:35'),
(10, 5, 8, 11, 'info', 'sensor_offline', 'Sensor Back Online', 'Sensor ESP32-HAMZA-005 is back online after maintenance.', NULL, NULL, 1, 1, NULL, NULL, 0, 0, 0, '2025-11-02 21:40:35'),
(11, 5, 7, NULL, 'success', 'crop_health', 'Optimal Growing Conditions', 'All parameters in South Field - Rice are within ideal range for rice cultivation.', NULL, NULL, 1, 1, NULL, NULL, 0, 0, 0, '2025-11-04 21:40:35');

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
(1, 1, 'LOGIN', NULL, NULL, NULL, NULL, '192.168.1.100', 'Mozilla/5.0 (Android 12; Mobile)', '2025-11-05 21:25:29'),
(2, 1, 'UPDATE', 'fields', 1, '{\"current_crop\": null}', '{\"current_crop\": \"Wheat\"}', '192.168.1.100', 'Mozilla/5.0 (Android 12; Mobile)', '2025-11-05 21:25:29'),
(3, 2, 'LOGIN', NULL, NULL, NULL, NULL, '192.168.1.105', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0)', '2025-11-05 21:25:29'),
(4, 2, 'CREATE', 'irrigation_logs', 3, NULL, '{\"irrigation_type\": \"automatic\", \"duration_minutes\": 50}', '192.168.1.105', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0)', '2025-11-05 21:25:29'),
(5, 4, 'LOGIN', NULL, NULL, NULL, NULL, '192.168.1.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)', '2025-11-05 21:25:29'),
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
(1, 1, 'Wheat', 92.50, 42.30, 23.50, 64.20, 'Loamy', 'Rabi', 1850.00, 'Medium', 150, 'Optimal soil conditions and temperature for wheat cultivation. Loamy soil provides good drainage and nutrient retention.', 'v2.1.0', 1, NULL, '2025-11-05 21:25:29'),
(2, 2, 'Cotton', 88.70, 48.50, 28.20, 62.50, 'Sandy Loam', 'Kharif', 950.00, 'High', 180, 'High temperature and moderate humidity ideal for cotton. Sandy loam ensures good root development.', 'v2.1.0', 1, NULL, '2025-11-05 21:25:29'),
(3, 3, 'Rice', 95.20, 55.80, 25.80, 72.30, 'Clay', 'Kharif', 2200.00, 'Very High', 120, 'Clay soil with high moisture retention perfect for rice. Temperature and humidity in optimal range.', 'v2.1.0', 1, NULL, '2025-11-05 21:25:29'),
(4, 5, 'Maize', 85.30, 38.50, 24.50, 60.80, 'Sandy', 'Kharif', 1200.00, 'Medium', 90, 'Sandy soil with moderate moisture suitable for maize. Good drainage prevents waterlogging.', 'v2.1.0', 0, NULL, '2025-11-05 21:25:29'),
(5, 5, 'Millet', 82.10, 38.50, 24.50, 60.80, 'Sandy', 'Kharif', 800.00, 'Low', 75, 'Drought-resistant crop suitable for sandy soil. Low water requirement makes it cost-effective.', 'v2.1.0', 0, NULL, '2025-11-05 21:25:29'),
(6, 6, 'Wheat', 94.50, 45.20, 22.50, 62.00, 'Loamy', 'Rabi', 3200.00, 'Medium', 150, 'Excellent soil conditions and optimal temperature for wheat cultivation. Loamy soil provides good drainage and nutrient retention.', NULL, 1, NULL, '2025-10-31 21:40:35'),
(7, 7, 'Basmati Rice', 96.80, 68.00, 28.20, 75.50, 'Clay Loam', 'Kharif', 2800.00, 'High', 120, 'Perfect conditions for Basmati rice. High humidity and clay loam soil ideal for paddy cultivation. Water retention excellent.', NULL, 1, NULL, '2025-10-26 21:40:35'),
(8, 8, 'Tomatoes', 88.50, 52.00, 24.80, 68.00, 'Sandy Loam', 'All Season', 1500.00, 'Medium', 90, 'Sandy loam soil with good drainage perfect for tomato cultivation. Temperature and moisture levels optimal.', NULL, 0, NULL, '2025-11-03 21:40:35'),
(9, 8, 'Bell Peppers', 85.20, 52.00, 24.80, 68.00, 'Sandy Loam', 'All Season', 1200.00, 'Medium', 75, 'Alternative recommendation: Bell peppers thrive in similar conditions. Good market value and shorter growth cycle.', NULL, 1, '2025-11-10 17:56:01', '2025-11-03 21:40:35'),
(10, 9, 'Cotton', 92.30, 38.00, 26.50, 58.00, 'Loamy', 'Kharif', 1800.00, 'Medium-High', 180, 'Ideal conditions for cotton. Moderate moisture and warm temperature perfect for fiber development. Loamy soil supports deep root growth.', NULL, 1, NULL, '2025-10-21 21:40:35');

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
(1, 1, 'North Field - Wheat', 31.45040000, 73.13500000, 5.50, 'acres', 'Loamy', 'Wheat', '2024-11-01', '2025-04-15', 1, '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(2, 1, 'South Field - Cotton', 31.44900000, 73.13400000, 3.20, 'acres', 'Sandy Loam', 'Cotton', '2024-05-15', '2024-11-30', 1, '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(3, 2, 'Main Field - Rice', 30.15750000, 71.52490000, 8.00, 'acres', 'Clay', 'Rice', '2024-06-01', '2024-10-30', 1, '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(4, 2, 'East Field - Sugarcane', 30.15800000, 71.52600000, 4.50, 'acres', 'Loamy', 'Sugarcane', '2024-03-01', '2025-02-28', 1, '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(5, 3, 'Test Field', 30.06680000, 70.64030000, 2.00, 'acres', 'Sandy', NULL, NULL, NULL, 1, '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(6, 5, 'Main Field - Wheat', 33.56510000, 73.01690000, 8.50, 'acres', 'Loamy', 'Wheat', '2024-11-01', '2025-04-20', 1, '2025-11-05 21:40:35', '2025-11-05 21:40:35'),
(7, 5, 'South Field - Rice', 33.56400000, 73.01800000, 5.20, 'acres', 'Clay Loam', 'Rice', '2024-06-15', '2024-11-30', 1, '2025-11-05 21:40:35', '2025-11-05 21:40:35'),
(8, 5, 'East Field - Vegetables', 33.56600000, 73.01900000, 2.80, 'acres', 'Sandy Loam', 'Mixed Vegetables', '2024-10-01', '2025-01-15', 1, '2025-11-05 21:40:35', '2025-11-05 21:40:35'),
(9, 5, 'North Field - Cotton', 33.56700000, 73.01600000, 6.00, 'acres', 'Loamy', 'Cotton', '2024-05-01', '2024-12-15', 1, '2025-11-05 21:40:35', '2025-11-05 21:40:35'),
(10, 5, 'test field', 31.40000000, 73.10000000, 6.00, 'acres', 'sandy', 'wheat', NULL, NULL, 1, '2025-11-05 21:45:31', '2025-11-05 21:45:31'),
(11, 5, 'tesyvh', NULL, NULL, 60.00, 'acres', 'ckay', 'cotton', NULL, NULL, 1, '2025-11-10 15:50:55', '2025-11-10 15:50:55'),
(12, 5, 'gfsdgf', 30.00000000, 70.00000000, 56.00, 'hectares', 'sandy', 'wheat', NULL, NULL, 1, '2025-11-10 15:56:01', '2025-11-10 15:56:01');

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
(1, 1, 1, 'automatic', '2025-11-03 21:25:29', '2025-11-03 22:10:29', 45, 2250.00, 'Soil moisture below 30%', 28.50, 45.20, 'off', NULL, NULL, '2025-11-05 21:25:29'),
(2, 1, 1, 'manual', '2025-10-31 21:25:29', '2025-10-31 22:25:29', 60, 3000.00, 'Manual irrigation by farmer', 35.20, 52.80, 'off', 1, NULL, '2025-11-05 21:25:29'),
(3, 2, 3, 'automatic', '2025-11-04 21:25:29', '2025-11-04 22:05:29', 40, 2000.00, 'Soil moisture below 30%', 27.80, 51.50, 'off', NULL, NULL, '2025-11-05 21:25:29'),
(4, 3, 4, 'scheduled', '2025-11-02 21:25:29', '2025-11-02 22:15:29', 50, 4000.00, 'Scheduled irrigation', 32.50, 48.30, 'off', NULL, NULL, '2025-11-05 21:25:29'),
(5, 4, 5, 'manual', '2025-11-01 21:25:29', '2025-11-01 22:20:29', 55, 2475.00, 'Manual irrigation', 30.10, 44.70, 'off', 2, NULL, '2025-11-05 21:25:29'),
(6, 6, 7, 'automatic', '2025-11-03 21:40:35', '2025-11-03 22:25:35', 45, 3200.00, 'Soil moisture below 35%', 32.50, 48.20, 'off', 5, NULL, '2025-11-05 21:40:35'),
(7, 6, 7, 'scheduled', '2025-11-01 21:40:35', '2025-11-01 22:20:35', 40, 2850.00, 'Scheduled irrigation - Morning', 38.20, 52.50, 'off', 5, NULL, '2025-11-05 21:40:35'),
(8, 6, 7, 'manual', '2025-10-30 21:40:35', '2025-10-30 22:30:35', 50, 3500.00, 'Manual irrigation by farmer', 35.80, 50.20, 'off', 5, NULL, '2025-11-05 21:40:35'),
(9, 7, 9, 'automatic', '2025-11-04 21:40:35', '2025-11-04 22:40:35', 60, 4200.00, 'Soil moisture below 60%', 58.50, 72.80, 'off', 5, NULL, '2025-11-05 21:40:35'),
(10, 7, 9, 'scheduled', '2025-11-02 21:40:35', '2025-11-02 22:35:35', 55, 3850.00, 'Scheduled irrigation - Evening', 62.20, 75.50, 'off', 5, NULL, '2025-11-05 21:40:35'),
(11, 8, 11, 'manual', '2025-11-04 21:40:35', '2025-11-04 22:10:35', 30, 1800.00, 'Manual watering for vegetables', 48.50, 58.20, 'off', 5, NULL, '2025-11-05 21:40:35'),
(12, 9, 12, 'automatic', '2025-11-02 21:40:35', '2025-11-02 22:15:35', 35, 2450.00, 'Soil moisture below 30%', 28.50, 42.80, 'off', 5, NULL, '2025-11-05 21:40:35'),
(13, 12, NULL, 'manual', '2025-11-10 16:54:02', '2025-11-10 16:54:02', 0, NULL, 'Manual irrigation by farmer', NULL, NULL, 'off', 5, NULL, '2025-11-10 16:53:56'),
(14, 8, NULL, 'manual', '2025-11-10 17:46:18', '2025-11-10 17:46:18', 0, NULL, 'Manual irrigation by farmer', NULL, NULL, 'off', 5, NULL, '2025-11-10 17:46:10'),
(15, 8, NULL, 'manual', '2025-11-10 17:46:23', NULL, NULL, NULL, 'Manual irrigation by farmer', NULL, NULL, 'on', 5, NULL, '2025-11-10 17:46:23');

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
(1, 1, 'Morning Irrigation - Wheat Season', '2024-11-01', '2025-04-15', '06:00:00', 45, 'alternate_days', NULL, 1, 1, '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(2, 2, 'Evening Irrigation - Cotton', '2024-05-15', '2024-11-30', '18:00:00', 40, 'daily', NULL, 1, 1, '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(3, 3, 'Rice Field - Twice Daily', '2024-06-01', '2024-10-30', '07:00:00', 50, 'daily', NULL, 1, 2, '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(4, 4, 'Weekly Deep Irrigation', '2024-03-01', '2025-02-28', '05:30:00', 90, 'weekly', 'Sun', 1, 2, '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(5, 6, 'Morning Irrigation - Wheat', '2024-11-01', '2025-04-20', '06:00:00', 40, 'alternate_days', NULL, 1, 5, '2025-11-05 21:40:35', '2025-11-05 21:40:35'),
(6, 6, 'Evening Irrigation - Wheat', '2024-11-01', '2025-04-20', '18:00:00', 35, 'weekly', 'Sunday,Wednesday', 1, 5, '2025-11-05 21:40:35', '2025-11-05 21:40:35'),
(7, 7, 'Daily Irrigation - Rice', '2024-06-15', '2024-11-30', '07:00:00', 60, 'daily', NULL, 1, 5, '2025-11-05 21:40:35', '2025-11-05 21:40:35'),
(8, 8, 'Morning Watering - Vegetables', '2024-10-01', '2025-01-15', '06:30:00', 25, 'daily', NULL, 1, 5, '2025-11-05 21:40:35', '2025-11-05 21:40:35'),
(9, 9, 'Weekly Irrigation - Cotton', '2024-05-01', '2024-12-15', '08:00:00', 45, 'weekly', 'Monday,Thursday', 1, 5, '2025-11-05 21:40:35', '2025-11-05 21:40:35');

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
(1, 1, 'combined', 'ESP32-A1B2C3D4E5F6', 'ESP32-DevKit', '2024-10-15', 'Center of North Field', 0.00, 1, NULL, 87.50, 'v1.2.3', '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(2, 1, 'soil_moisture', 'ESP32-B2C3D4E5F6A1', 'YL-69', '2024-10-15', 'Northwest corner', 0.00, 1, NULL, 92.00, 'v1.2.3', '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(3, 2, 'combined', 'ESP32-C3D4E5F6A1B2', 'ESP32-DevKit', '2024-10-20', 'Center of South Field', 0.00, 1, NULL, 78.30, 'v1.2.3', '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(4, 3, 'combined', 'ESP32-D4E5F6A1B2C3', 'ESP32-DevKit', '2024-09-10', 'Main Field Center', 0.00, 1, NULL, 95.20, 'v1.2.2', '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(5, 4, 'soil_moisture', 'ESP32-E5F6A1B2C3D4', 'Capacitive v1.2', '2024-08-05', 'East Field Entry Point', 0.00, 1, NULL, 88.70, 'v1.2.1', '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(6, 5, 'combined', 'ESP32-F6A1B2C3D4E5', 'ESP32-DevKit', '2024-11-01', 'Test Field', 0.00, 1, NULL, 100.00, 'v1.2.3', '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(7, 6, 'combined', 'ESP32-HAMZA-001', 'DHT22 + Soil Moisture', '2024-11-01', 'Center of main field', 0.00, 1, NULL, 85.50, 'v1.2.0', '2025-11-05 21:40:35', '2025-11-05 21:40:35'),
(8, 6, 'soil_moisture', 'ESP32-HAMZA-002', 'Capacitive Soil Sensor', '2024-11-01', 'North section', 0.00, 1, NULL, 78.20, 'v1.2.0', '2025-11-05 21:40:35', '2025-11-05 21:40:35'),
(9, 7, 'combined', 'ESP32-HAMZA-003', 'DHT22 + Soil Moisture', '2024-06-15', 'Center of south field', 0.00, 1, NULL, 92.00, 'v1.2.0', '2025-11-05 21:40:35', '2025-11-05 21:40:35'),
(10, 7, 'water_flow', 'ESP32-HAMZA-004', 'YF-S201 Flow Sensor', '2024-06-15', 'Irrigation inlet', 0.00, 1, NULL, 88.50, 'v1.2.0', '2025-11-05 21:40:35', '2025-11-05 21:40:35'),
(11, 8, 'combined', 'ESP32-HAMZA-005', 'DHT22 + Soil Moisture', '2024-10-01', 'Center of east field', 0.00, 1, NULL, 95.00, 'v1.2.0', '2025-11-05 21:40:35', '2025-11-05 21:40:35'),
(12, 9, 'combined', 'ESP32-HAMZA-006', 'DHT22 + Soil Moisture', '2024-05-01', 'Center of north field', 0.00, 1, NULL, 72.50, 'v1.2.0', '2025-11-05 21:40:35', '2025-11-05 21:40:35'),
(13, 9, 'temperature', 'ESP32-HAMZA-007', 'DS18B20', '2024-05-01', 'South corner', 0.00, 1, NULL, 81.00, 'v1.2.0', '2025-11-05 21:40:35', '2025-11-05 21:40:35');

-- --------------------------------------------------------

--
-- Table structure for table `sensor_readings`
--

CREATE TABLE `sensor_readings` (
  `reading_id` bigint(20) NOT NULL,
  `sensor_id` int(11) NOT NULL,
  `soil_moisture` decimal(5,2) DEFAULT NULL COMMENT 'Percentage (0-100)',
  `temperature` decimal(5,2) DEFAULT NULL COMMENT 'Celsius',
  `humidity` decimal(5,2) DEFAULT NULL COMMENT 'Percentage (0-100)',
  `light_intensity` decimal(8,2) DEFAULT NULL COMMENT 'Lux or percentage',
  `rainfall` decimal(6,2) DEFAULT NULL COMMENT 'mm or boolean (0/1)',
  `water_flow_rate` decimal(8,2) DEFAULT NULL COMMENT 'Liters per minute',
  `battery_voltage` decimal(4,2) DEFAULT NULL COMMENT 'Volts',
  `signal_strength` int(11) DEFAULT NULL COMMENT 'WiFi signal strength in dBm',
  `reading_timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sensor_readings`
--

INSERT INTO `sensor_readings` (`reading_id`, `sensor_id`, `soil_moisture`, `temperature`, `humidity`, `light_intensity`, `rainfall`, `water_flow_rate`, `battery_voltage`, `signal_strength`, `reading_timestamp`, `created_at`) VALUES
(1, 1, 45.20, 22.50, 65.30, 45000.00, 0.00, NULL, 3.70, -45, '2025-11-05 20:25:29', '2025-11-05 21:25:29'),
(2, 1, 44.80, 23.10, 64.80, 48000.00, 0.00, NULL, 3.70, -44, '2025-11-05 19:25:29', '2025-11-05 21:25:29'),
(3, 1, 43.50, 24.20, 63.20, 52000.00, 0.00, NULL, 3.70, -46, '2025-11-05 18:25:29', '2025-11-05 21:25:29'),
(4, 1, 42.10, 25.80, 61.50, 58000.00, 0.00, NULL, 3.70, -45, '2025-11-05 17:25:29', '2025-11-05 21:25:29'),
(5, 2, 28.50, 23.50, 66.00, 46000.00, 0.00, NULL, 3.80, -42, '2025-11-05 20:25:29', '2025-11-05 21:25:29'),
(6, 2, 27.20, 24.00, 65.50, 49000.00, 0.00, NULL, 3.80, -43, '2025-11-05 19:25:29', '2025-11-05 21:25:29'),
(7, 3, 52.30, 21.80, 68.50, 42000.00, 0.00, NULL, 3.60, -48, '2025-11-05 20:25:29', '2025-11-05 21:25:29'),
(8, 3, 51.90, 22.30, 67.80, 44000.00, 0.00, NULL, 3.60, -47, '2025-11-05 19:25:29', '2025-11-05 21:25:29'),
(9, 4, 38.70, 26.50, 58.30, 55000.00, 0.00, NULL, 3.90, -40, '2025-11-05 20:25:29', '2025-11-05 21:25:29'),
(10, 4, 37.50, 27.20, 57.10, 58000.00, 0.00, NULL, 3.90, -41, '2025-11-05 19:25:29', '2025-11-05 21:25:29'),
(11, 5, 32.10, 24.80, 62.50, 50000.00, 0.00, NULL, 3.70, -44, '2025-11-05 20:25:29', '2025-11-05 21:25:29'),
(12, 6, 55.80, 20.50, 72.30, 38000.00, 0.00, NULL, 4.00, -38, '2025-11-05 20:55:29', '2025-11-05 21:25:29'),
(13, 7, 45.20, 22.50, 62.30, 48000.00, NULL, NULL, 3.80, -45, '2025-11-05 21:35:35', '2025-11-05 21:40:35'),
(14, 7, 44.80, 23.10, 61.50, 52000.00, NULL, NULL, 3.80, -43, '2025-11-05 21:30:35', '2025-11-05 21:40:35'),
(15, 7, 46.10, 21.80, 63.20, 45000.00, NULL, NULL, 3.80, -46, '2025-11-05 21:25:35', '2025-11-05 21:40:35'),
(16, 8, 43.50, NULL, NULL, NULL, NULL, NULL, 3.70, -48, '2025-11-05 21:35:35', '2025-11-05 21:40:35'),
(17, 8, 44.20, NULL, NULL, NULL, NULL, NULL, 3.70, -47, '2025-11-05 21:30:35', '2025-11-05 21:40:35'),
(18, 9, 68.50, 28.20, 75.80, 55000.00, NULL, NULL, 3.90, -42, '2025-11-05 21:35:35', '2025-11-05 21:40:35'),
(19, 9, 67.80, 28.50, 76.20, 56000.00, NULL, NULL, 3.90, -41, '2025-11-05 21:30:35', '2025-11-05 21:40:35'),
(20, 10, NULL, NULL, NULL, NULL, NULL, NULL, 3.80, -44, '2025-11-05 21:35:35', '2025-11-05 21:40:35'),
(21, 11, 52.30, 24.80, 68.50, 50000.00, NULL, NULL, 3.90, -40, '2025-11-05 21:35:35', '2025-11-05 21:40:35'),
(22, 11, 51.80, 25.20, 67.80, 51000.00, NULL, NULL, 3.90, -39, '2025-11-05 21:30:35', '2025-11-05 21:40:35'),
(23, 12, 38.20, 26.50, 58.30, 58000.00, NULL, NULL, 3.60, -50, '2025-11-05 21:35:35', '2025-11-05 21:40:35'),
(24, 12, 37.80, 27.10, 57.50, 59000.00, NULL, NULL, 3.60, -51, '2025-11-05 21:30:35', '2025-11-05 21:40:35'),
(25, 13, NULL, 26.80, NULL, NULL, NULL, NULL, 3.70, -49, '2025-11-05 21:35:35', '2025-11-05 21:40:35');

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
(4, NULL, 'auto_irrigation_enabled', 'true', 'global', 'Enable automatic irrigation system-wide', '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(5, 1, 'notification_email', 'true', 'user', 'Enable email notifications for user', '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(6, 1, 'notification_push', 'true', 'user', 'Enable push notifications for user', '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(7, 1, 'notification_sms', 'false', 'user', 'Enable SMS notifications for user', '2025-11-05 21:25:29', '2025-11-05 21:25:29'),
(8, 2, 'preferred_language', 'urdu', 'user', 'User preferred language for notifications', '2025-11-05 21:25:29', '2025-11-05 21:25:29');

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
(1, 'Ahmed Ali', 'ahmed.ali@example.com', '+92-300-1234567', '$2b$10$rZ5qJ5YvZ5YvZ5YvZ5YvZOqJ5YvZ5YvZ5YvZ5YvZ5YvZ5YvZ5Yv', 'Village Chak 123, GT Road', 'Faisalabad', 'Punjab', '38000', 'farmer', 1, 1, 1, '2025-11-05 21:25:29', '2025-11-05 21:25:29', NULL),
(2, 'Fatima Khan', 'fatima.khan@example.com', '+92-301-2345678', '$2b$10$rZ5qJ5YvZ5YvZ5YvZ5YvZOqJ5YvZ5YvZ5YvZ5YvZ5YvZ5YvZ5Yv', 'Mohalla Islamabad, Main Road', 'Multan', 'Punjab', '60000', 'farmer', 1, 1, 1, '2025-11-05 21:25:29', '2025-11-05 21:25:29', NULL),
(3, 'Hassan Raza', 'hassan.raza@example.com', '+92-302-3456789', '$2b$10$rZ5qJ5YvZ5YvZ5YvZ5YvZOqJ5YvZ5YvZ5YvZ5YvZ5YvZ5YvZ5Yv', 'Village Kot Addu', 'Muzaffargarh', 'Punjab', '34000', 'farmer', 1, 0, 1, '2025-11-05 21:25:29', '2025-11-05 21:25:29', NULL),
(4, 'Admin User', 'admin@gmail.com', '+92-321-9999999', '$2a$12$JQvJjbsM1U5HHycsMb770eUe138Gzogi/r6unr.dh3gqBcHvq08Hu', 'Smart Agri HQ, I-9', 'Islamabad', 'Islamabad Capital Territory', '44000', 'admin', 1, 1, 1, '2025-11-05 21:25:29', '2025-11-10 15:58:40', '2025-11-10 15:58:40'),
(5, 'HAMZA BASHIR', 'hamzabashir1289@gmail.com', '+923320573993', '$2a$10$zZe2IyLoCX9jc5P.2Swg5e9upf12hHGmb16pGTBjWAwsDSe8RXKge', 'H # 543, Street 25, Sector G, Bahria Town phase 8', 'Rawalpindi', 'punjab', NULL, 'farmer', 1, 0, 0, '2025-11-05 21:31:57', '2025-11-10 17:24:15', '2025-11-10 17:24:15');

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
(1, 1, 23.50, 65.00, 0.00, 12.50, 20.00, 'Sunny', '2025-11-05', 0, 'OpenWeatherMap', '2025-11-05 21:25:29'),
(2, 1, 22.80, 68.00, 2.50, 15.00, 45.00, 'Partly Cloudy', '2025-11-04', 0, 'OpenWeatherMap', '2025-11-05 21:25:29'),
(3, 1, 24.00, 62.00, 0.00, 10.00, 15.00, 'Sunny', '2025-11-07', 1, 'OpenWeatherMap', '2025-11-05 21:25:29'),
(4, 1, 25.50, 60.00, 0.00, 8.50, 10.00, 'Clear', '2025-11-08', 1, 'OpenWeatherMap', '2025-11-05 21:25:29'),
(5, 2, 26.50, 58.00, 0.00, 14.00, 25.00, 'Sunny', '2025-11-06', 0, 'OpenWeatherMap', '2025-11-05 21:25:29'),
(6, 3, 25.00, 70.00, 5.00, 18.00, 60.00, 'Rainy', '2025-11-05', 0, 'Local Sensor', '2025-11-05 21:25:29'),
(7, 6, 23.50, 62.00, 0.00, 8.50, 25.00, 'Partly Cloudy', '2025-11-06', 0, NULL, '2025-11-05 21:40:35'),
(8, 7, 23.50, 62.00, 0.00, 8.50, 25.00, 'Partly Cloudy', '2025-11-06', 0, NULL, '2025-11-05 21:40:35'),
(9, 8, 23.50, 62.00, 0.00, 8.50, 25.00, 'Partly Cloudy', '2025-11-06', 0, NULL, '2025-11-05 21:40:35'),
(10, 9, 23.50, 62.00, 0.00, 8.50, 25.00, 'Partly Cloudy', '2025-11-06', 0, NULL, '2025-11-05 21:40:35'),
(11, 6, 24.00, 58.00, 0.00, 10.00, 30.00, 'Sunny', '2025-11-07', 1, NULL, '2025-11-05 21:40:35'),
(12, 6, 22.50, 65.00, 2.50, 12.00, 60.00, 'Light Rain', '2025-11-08', 1, NULL, '2025-11-05 21:40:35'),
(13, 6, 21.00, 70.00, 5.00, 15.00, 80.00, 'Rainy', '2025-11-09', 1, NULL, '2025-11-05 21:40:35');

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
  ADD KEY `idx_reading_timestamp` (`reading_timestamp`),
  ADD KEY `idx_sensor_timestamp` (`sensor_id`,`reading_timestamp`);

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
  MODIFY `field_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `irrigation_logs`
--
ALTER TABLE `irrigation_logs`
  MODIFY `log_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `irrigation_schedules`
--
ALTER TABLE `irrigation_schedules`
  MODIFY `schedule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `sensors`
--
ALTER TABLE `sensors`
  MODIFY `sensor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `sensor_readings`
--
ALTER TABLE `sensor_readings`
  MODIFY `reading_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

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
-- Constraints for table `sensor_readings`
--
ALTER TABLE `sensor_readings`
  ADD CONSTRAINT `sensor_readings_ibfk_1` FOREIGN KEY (`sensor_id`) REFERENCES `sensors` (`sensor_id`) ON DELETE CASCADE;

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
