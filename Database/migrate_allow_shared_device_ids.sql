-- Smart Agriculture DB sync migration (dev/prod)
-- Safe to run multiple times.
-- Purpose:
-- 1) Allow shared device IDs across users/fields
-- 2) Align sensor_readings schema with backend runtime
-- 3) Keep indexes/columns consistent between local and cPanel

-- Use the currently selected database in phpMyAdmin.
SET @db_name = DATABASE();

-- =========================================================
-- 1) Remove UNIQUE(device_id) if it exists on sensors table
-- =========================================================
SET @unique_device_idx = NULL;
SELECT s.INDEX_NAME
INTO @unique_device_idx
FROM information_schema.statistics s
WHERE s.TABLE_SCHEMA = @db_name
  AND s.TABLE_NAME = 'sensors'
  AND s.COLUMN_NAME = 'device_id'
  AND s.NON_UNIQUE = 0
LIMIT 1;

SET @sql_drop_unique_device = IF(
  @unique_device_idx IS NULL,
  'SELECT ''UNIQUE(device_id) not found, skip drop''',
  CONCAT('ALTER TABLE `sensors` DROP INDEX `', @unique_device_idx, '`')
);
PREPARE stmt FROM @sql_drop_unique_device;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- =========================================================
-- 2) Ensure normal index exists on sensors.device_id
-- =========================================================
SET @has_idx_device = 0;
SELECT COUNT(*)
INTO @has_idx_device
FROM information_schema.statistics s
WHERE s.TABLE_SCHEMA = @db_name
  AND s.TABLE_NAME = 'sensors'
  AND s.INDEX_NAME = 'idx_device_id';

SET @sql_add_idx_device = IF(
  @has_idx_device > 0,
  'SELECT ''idx_device_id already exists, skip add''',
  'ALTER TABLE `sensors` ADD INDEX `idx_device_id` (`device_id`)'
);
PREPARE stmt FROM @sql_add_idx_device;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- =========================================================
-- 3) Ensure sensor_readings.reading_time exists
--    If old reading_timestamp exists, rename it.
-- =========================================================
SET @has_reading_time = 0;
SET @has_reading_timestamp = 0;

SELECT COUNT(*)
INTO @has_reading_time
FROM information_schema.columns c
WHERE c.TABLE_SCHEMA = @db_name
  AND c.TABLE_NAME = 'sensor_readings'
  AND c.COLUMN_NAME = 'reading_time';

SELECT COUNT(*)
INTO @has_reading_timestamp
FROM information_schema.columns c
WHERE c.TABLE_SCHEMA = @db_name
  AND c.TABLE_NAME = 'sensor_readings'
  AND c.COLUMN_NAME = 'reading_timestamp';

SET @sql_fix_reading_time = IF(
  @has_reading_time > 0,
  'SELECT ''reading_time already exists, skip''',
  IF(
    @has_reading_timestamp > 0,
    'ALTER TABLE `sensor_readings` CHANGE COLUMN `reading_timestamp` `reading_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP',
    'ALTER TABLE `sensor_readings` ADD COLUMN `reading_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `sensor_id`'
  )
);
PREPARE stmt FROM @sql_fix_reading_time;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- =========================================================
-- 4) Ensure sensor_readings.rainfall is boolean tinyint(1)
-- =========================================================
UPDATE `sensor_readings`
SET `rainfall` = CASE WHEN COALESCE(`rainfall`, 0) > 0 THEN 1 ELSE 0 END;

ALTER TABLE `sensor_readings`
  MODIFY COLUMN `rainfall` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1=raining, 0=not raining';

-- =========================================================
-- 5) Ensure sensor_readings.pump_on exists
-- =========================================================
SET @has_pump_on = 0;
SELECT COUNT(*)
INTO @has_pump_on
FROM information_schema.columns c
WHERE c.TABLE_SCHEMA = @db_name
  AND c.TABLE_NAME = 'sensor_readings'
  AND c.COLUMN_NAME = 'pump_on';

SET @sql_add_pump_on = IF(
  @has_pump_on > 0,
  'SELECT ''pump_on already exists, skip''',
  'ALTER TABLE `sensor_readings` ADD COLUMN `pump_on` tinyint(1) NOT NULL DEFAULT 0 COMMENT ''1=pump on, 0=pump off'' AFTER `rainfall`'
);
PREPARE stmt FROM @sql_add_pump_on;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- =========================================================
-- 6) Ensure indexes used by backend queries exist
-- =========================================================
SET @has_idx_reading_time = 0;
SELECT COUNT(*)
INTO @has_idx_reading_time
FROM information_schema.statistics s
WHERE s.TABLE_SCHEMA = @db_name
  AND s.TABLE_NAME = 'sensor_readings'
  AND s.INDEX_NAME = 'idx_reading_time';

SET @sql_add_idx_reading_time = IF(
  @has_idx_reading_time > 0,
  'SELECT ''idx_reading_time already exists, skip''',
  'ALTER TABLE `sensor_readings` ADD INDEX `idx_reading_time` (`reading_time`)'
);
PREPARE stmt FROM @sql_add_idx_reading_time;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @has_idx_sensor_time = 0;
SELECT COUNT(*)
INTO @has_idx_sensor_time
FROM information_schema.statistics s
WHERE s.TABLE_SCHEMA = @db_name
  AND s.TABLE_NAME = 'sensor_readings'
  AND s.INDEX_NAME = 'idx_sensor_time';

SET @sql_add_idx_sensor_time = IF(
  @has_idx_sensor_time > 0,
  'SELECT ''idx_sensor_time already exists, skip''',
  'ALTER TABLE `sensor_readings` ADD INDEX `idx_sensor_time` (`sensor_id`, `reading_time` DESC)'
);
PREPARE stmt FROM @sql_add_idx_sensor_time;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Optional sanity checks
SHOW INDEX FROM `sensors`;
SHOW COLUMNS FROM `sensor_readings`;
