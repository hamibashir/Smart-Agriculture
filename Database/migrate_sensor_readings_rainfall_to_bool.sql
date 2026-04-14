-- Run once on an existing DB that still has sensor_readings.rainfall as DECIMAL (mm).
-- Collapses historical values to 0/1, then changes the column type.

UPDATE sensor_readings
SET rainfall = CASE WHEN COALESCE(rainfall, 0) > 0 THEN 1 ELSE 0 END;

ALTER TABLE sensor_readings
  MODIFY COLUMN rainfall tinyint(1) NOT NULL DEFAULT 0 COMMENT '1=raining, 0=not raining';
