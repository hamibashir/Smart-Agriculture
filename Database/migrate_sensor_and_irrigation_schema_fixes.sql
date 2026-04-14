-- Run once on existing databases to align schema with latest ESP32 payload behavior.

START TRANSACTION;

-- 1) Keep irrigation start_time immutable after insert.
ALTER TABLE irrigation_logs
  MODIFY COLUMN start_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- 2) Align light_intensity with ESP32 payload (percentage 0-100).
-- If legacy values are above 100 (often raw ADC-like values), normalize them.
UPDATE sensor_readings
SET light_intensity = ROUND(
  LEAST(100, GREATEST(0, 100 - ((light_intensity / 4095) * 100))),
  2
)
WHERE light_intensity IS NOT NULL AND light_intensity > 100;

ALTER TABLE sensor_readings
  MODIFY COLUMN light_intensity DECIMAL(5,2) DEFAULT NULL COMMENT 'Percentage (0-100 from ADC mapping)';

-- 3) Ensure rainfall is boolean.
UPDATE sensor_readings
SET rainfall = CASE WHEN COALESCE(rainfall, 0) > 0 THEN 1 ELSE 0 END;

ALTER TABLE sensor_readings
  MODIFY COLUMN rainfall tinyint(1) NOT NULL DEFAULT 0 COMMENT '1=raining, 0=not raining';

-- 4) Fix known sample metadata mismatch.
UPDATE sensors
SET sensor_model = 'ESP32 + DHT22 + Soil Sensor'
WHERE device_id = 'ESP_32test';

COMMIT;
