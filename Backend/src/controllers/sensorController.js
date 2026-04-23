import pool from '../config/database.js';

// Development:
//   AI_API_URL=http://localhost:5001
// Production:
//   AI_API_URL=https://ai.yourdomain.com
const AI_API_URL = process.env.AI_API_URL || 'http://localhost:5001';

const verifyFieldOwnership = async (fieldId, userId) => {
  const [[field]] = await pool.query('SELECT field_id FROM fields WHERE field_id = ? AND user_id = ?', [fieldId, userId]);
  return field;
};

const verifySensorOwnership = async (sensorId, userId) => {
  const [[sensor]] = await pool.query(
    'SELECT s.sensor_id FROM sensors s JOIN fields f ON s.field_id = f.field_id WHERE s.sensor_id = ? AND f.user_id = ?',
    [sensorId, userId]
  );
  return sensor;
};

// ── AI Service: Trigger crop recommendation (fire-and-forget) ──
const triggerAIRecommendation = async (fieldId, sensorId) => {
  try {
    // Get field info (soil_type, current_crop, planting_date)
    const [[field]] = await pool.query(
      'SELECT soil_type, planting_date FROM fields WHERE field_id = ?',
      [fieldId]
    );
    if (!field) return;

    // Default to loamy if soil_type is optional/null, preventing silent logic failure!
    const soilTypeStr = (field.soil_type || 'loamy').toLowerCase().replace(' ', '_');

    // Average of the 5 most recent rows
    const [readings] = await pool.query(
      `SELECT 
        AVG(soil_moisture) AS soil_moisture,
        AVG(temperature)   AS temperature,
        AVG(humidity)      AS humidity,
        AVG(rainfall)      AS rainfall
       FROM (
         SELECT soil_moisture, temperature, humidity, rainfall
         FROM sensor_readings
         WHERE sensor_id = ?
         ORDER BY reading_time DESC
         LIMIT 5
       ) AS recent`,
      [sensorId]
    );

    const avg = readings[0];
    if (avg.soil_moisture == null || avg.temperature == null || avg.humidity == null) return;

    // Determine season from current month (Pakistan: Rabi=Oct-Mar, Kharif=Apr-Sep)
    const month = new Date().getMonth() + 1;
    const season = (month >= 10 || month <= 3) ? 'rabi' : 'kharif';

    // Call Flask AI API
    const response = await fetch(`${AI_API_URL}/predict`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        soil_moisture: parseFloat(avg.soil_moisture).toFixed(2),
        temperature: parseFloat(avg.temperature).toFixed(2),
        humidity: parseFloat(avg.humidity).toFixed(2),
        soil_type: soilTypeStr,
        season: season,
        rainfall: parseFloat(avg.rainfall || 0).toFixed(2)
      })
    });

    if (!response.ok) return;

    const aiResult = await response.json();
    if (!aiResult.success) return;

    // Save recommendation to DB
    await pool.query(
      `INSERT INTO crop_recommendations 
        (field_id, recommended_crop, confidence_score, soil_moisture_avg, temperature_avg, 
         humidity_avg, soil_type, season, expected_yield, water_requirement, 
         growth_duration_days, recommendation_reason, model_version)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        fieldId,
        aiResult.recommended_crop,
        aiResult.confidence_score,
        avg.soil_moisture,
        avg.temperature,
        avg.humidity,
        field.soil_type,
        season,
        aiResult.expected_yield,
        aiResult.water_requirement,
        aiResult.growth_duration_days,
        aiResult.recommendation_reason,
        aiResult.model_version
      ]
    );

    console.log(`🤖 AI Recommendation for field ${fieldId}: ${aiResult.recommended_crop} (${aiResult.confidence_score}%)`);
  } catch (err) {
    // Non-critical — never crash the main request
    console.warn(`⚠️  AI recommendation skipped: ${err.message}`);
  }
};

// Get all sensors for a field
export const getSensorsByField = async (req, res) => {
  try {
    const { fieldId } = req.params;

    if (!await verifyFieldOwnership(fieldId, req.user.user_id)) {
      return res.status(404).json({ success: false, message: 'Field not found' });
    }

    const [sensors] = await pool.query('SELECT * FROM sensors WHERE field_id = ? ORDER BY created_at DESC', [fieldId]);
    res.json({ success: true, data: sensors });
  } catch (error) {
    console.error('Get sensors error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

// Get sensor readings
export const getSensorReadings = async (req, res) => {
  try {
    const { sensorId } = req.params;
    const { limit = 100, offset = 0 } = req.query;

    if (!await verifySensorOwnership(sensorId, req.user.user_id)) {
      return res.status(404).json({ success: false, message: 'Sensor not found' });
    }

    const [readings] = await pool.query(
      'SELECT * FROM sensor_readings WHERE sensor_id = ? ORDER BY reading_time DESC LIMIT ? OFFSET ?',
      [sensorId, parseInt(limit), parseInt(offset)]
    );

    res.json({ success: true, data: readings });
  } catch (error) {
    console.error('Get sensor readings error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

// Get latest sensor reading
export const getLatestReading = async (req, res) => {
  try {
    const { sensorId } = req.params;

    if (!await verifySensorOwnership(sensorId, req.user.user_id)) {
      return res.status(404).json({ success: false, message: 'Sensor not found' });
    }

    const [[reading]] = await pool.query(
      'SELECT * FROM sensor_readings WHERE sensor_id = ? ORDER BY reading_time DESC LIMIT 1',
      [sensorId]
    );

    res.json({ success: true, data: reading || null });
  } catch (error) {
    console.error('Get latest reading error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

const toNullableDecimal = (v) => {
  if (v === undefined || v === null || v === '') return null;
  const n = Number(v);
  return Number.isFinite(n) ? n : null;
};

const toNullableInt = (v) => {
  if (v === undefined || v === null || v === '') return null;
  const n = Number(v);
  if (!Number.isFinite(n)) return null;
  return Math.round(Math.min(Math.max(n, -2147483648), 2147483647));
};

/** sensor_readings.rainfall: 0 = not raining, 1 = raining (accepts bool, 0/1, legacy mm > 0) */
const toRainfallBool = (v) => {
  if (v === undefined || v === null || v === '') return null;
  if (typeof v === 'boolean') return v ? 1 : 0;
  if (typeof v === 'string') {
    const t = v.trim().toLowerCase();
    if (t === 'true' || t === '1' || t === 'yes') return 1;
    if (t === 'false' || t === '0' || t === 'no') return 0;
  }
  const n = Number(v);
  if (!Number.isFinite(n)) return null;
  if (n >= 1) return 1;
  if (n <= 0) return 0;
  return n >= 0.5 ? 1 : 0;
};

/** Generic bool parser for tinyint(1): accepts bool, 0/1, yes/no, on/off */
const toTinyIntBool = (v) => {
  if (v === undefined || v === null || v === '') return null;
  if (typeof v === 'boolean') return v ? 1 : 0;
  if (typeof v === 'string') {
    const t = v.trim().toLowerCase();
    if (t === 'true' || t === '1' || t === 'yes' || t === 'on') return 1;
    if (t === 'false' || t === '0' || t === 'no' || t === 'off') return 0;
  }
  const n = Number(v);
  if (!Number.isFinite(n)) return null;
  return n >= 1 ? 1 : 0;
};

// ── Automated Alerts Service (Background Task) ──
const processSmartAlerts = async (userId, fieldId, sensorId, data) => {
  try {
    const alertsToCreate = [];
    
    // 1. Soil Moisture Checks
    if (data.soil != null) {
      if (data.soil < 20) {
        alertsToCreate.push({ type: 'critical', category: 'soil_moisture', title: 'Severe Drought Risk', msg: `Soil moisture is critically low (${data.soil.toFixed(1)}%). Irrigation required immediately to prevent crop damage.` });
      } else if (data.soil > 85) {
        alertsToCreate.push({ type: 'warning', category: 'soil_moisture', title: 'Waterlogging Risk', msg: `Soil moisture is dangerously high (${data.soil.toFixed(1)}%). Risk of root rot.` });
      }
    }

    // 2. Temperature Checks
    if (data.temp != null) {
      if (data.temp > 40) {
        alertsToCreate.push({ type: 'critical', category: 'temperature', title: 'Heat Stress Alert', msg: `Extreme heat detected (${data.temp.toFixed(1)}°C). Crops may suffer heat stress.` });
      } else if (data.temp < 5) {
        alertsToCreate.push({ type: 'warning', category: 'temperature', title: 'Frost Warning', msg: `Temperatures have dropped to ${data.temp.toFixed(1)}°C. Frost damage possible.` });
      }
    }

    // 3. Humidity/Fungal Risk
    if (data.hum != null && data.hum > 85 && data.temp != null && data.temp > 25) {
      alertsToCreate.push({ type: 'warning', category: 'crop_health', title: 'Fungal Infection Risk', msg: `High humidity (${data.hum.toFixed(1)}%) combined with warmth creates ideal conditions for fungal diseases.` });
    }

    // 4. Waste Warning
    if (data.rainInsert === 1 && data.pumpInsert === 1) {
      alertsToCreate.push({ type: 'warning', category: 'irrigation', title: 'Water Waste Detected', msg: 'The irrigation pump is running while it is currently raining. Consider turning it off to save water and prevent flooding.' });
    }

    for (const a of alertsToCreate) {
      // Prevent spam: Only create if there isn't an unresolved alert of the exact same title for this field
      const [[existing]] = await pool.query(
        'SELECT alert_id FROM alerts WHERE field_id = ? AND title = ? AND is_resolved = FALSE',
        [fieldId, a.title]
      );
      
      if (!existing) {
        await pool.query(
          `INSERT INTO alerts (user_id, field_id, sensor_id, alert_type, alert_category, title, message) 
           VALUES (?, ?, ?, ?, ?, ?, ?)`,
          [userId, fieldId, sensorId, a.type, a.category, a.title, a.msg]
        );
      }
    }
  } catch (error) {
    console.warn(`⚠️ Smart Alerts skipped: ${error.message}`);
  }
};

// Create sensor reading (for ESP32/IoT devices)
export const createSensorReading = async (req, res) => {
  try {
    const { device_id, soil_moisture, temperature, humidity, light_intensity, rainfall, pump_on } = req.body;

    if (!device_id) {
      return res.status(400).json({ success: false, message: 'Device ID is required' });
    }

    // Get sensor + its linked field in one query
    const [[sensor]] = await pool.query(
      'SELECT s.sensor_id, s.field_id, f.user_id FROM sensors s JOIN fields f ON s.field_id = f.field_id WHERE s.device_id = ?',
      [device_id]
    );
    if (!sensor) {
      return res.status(404).json({ success: false, message: 'Sensor not found with this device ID' });
    }

    // Align with sensor_readings: decimals + light_intensity INT (lux in schema; IoT may send 0–100)
    const soil = toNullableDecimal(soil_moisture);
    const temp = toNullableDecimal(temperature);
    const hum = toNullableDecimal(humidity);
    const light = toNullableInt(light_intensity);
    const rain = toRainfallBool(rainfall);
    const rainInsert = rain != null ? rain : 0;
    const pump = toTinyIntBool(pump_on);
    let pumpInsert = pump != null ? pump : 0;

    // --- CLOUD OVERRIDE & SMART AUTO-START ENGINE ---
    // Never allow this optional automation block to fail the core sensor ingestion.
    try {
      const [[lastLog]] = await pool.query(
        'SELECT log_id, pump_status, end_time FROM irrigation_logs WHERE field_id = ? ORDER BY start_time DESC LIMIT 1',
        [sensor.field_id]
      );

      if (lastLog && lastLog.pump_status === 'on') {
        pumpInsert = 1; // Farmer turned it ON manually. Force hardware ON.
      } 
      else if (lastLog && lastLog.pump_status === 'off' && soil != null && soil < 20) {
        // The farmer turned it OFF manually, but the soil is critically dry.
        const [[existingAlert]] = await pool.query(
          'SELECT alert_id, is_resolved FROM alerts WHERE field_id = ? AND title = ? AND created_at >= ? ORDER BY created_at DESC LIMIT 1',
          [sensor.field_id, 'Manual Override Warning', lastLog.end_time]
        );

        // Check if it's been 10+ minutes since the farmer turned it OFF
        const minutesSinceOff = (Date.now() - new Date(lastLog.end_time).getTime()) / 60000;

        // Unblock if user actively resolved it OR 10 minutes timed out
        if (minutesSinceOff > 10 || (existingAlert && existingAlert.is_resolved)) {
          pumpInsert = 1; // Force Auto-Start!
          
          const triggerDesc = (existingAlert && existingAlert.is_resolved) 
            ? 'Cloud Auto-Start: Farmer resolved critical dryness warning.' 
            : 'Cloud Auto-Start: 10 minutes timeout on critical dryness.';

          await pool.query(
            `INSERT INTO irrigation_logs (field_id, sensor_id, irrigation_type, start_time, trigger_reason, soil_moisture_before, pump_status, initiated_by) 
             VALUES (?, ?, 'automatic', NOW(), ?, ?, 'on', ?)`,
            [sensor.field_id, sensor.sensor_id, triggerDesc, soil, sensor.user_id]
          );
        } else {
          pumpInsert = 0; // Block the hardware! We are still in the 10-minute waiting window.
          
          // If alert doesn't exist for this session yet, create it immediately.
          if (!existingAlert) {
            await pool.query(
              `INSERT INTO alerts (user_id, field_id, sensor_id, alert_type, alert_category, title, message) 
               VALUES (?, ?, ?, 'critical', 'irrigation', 'Manual Override Warning', 'You turned off the pump, but soil moisture is extremely low. The system will auto-start in 10 minutes to save crops unless you resolve this warning.')`,
              [sensor.user_id, sensor.field_id, sensor.sensor_id]
            );
          }
        }
      }
    } catch (overrideErr) {
      console.warn(`Cloud override skipped: ${overrideErr.message}`);
    }

    const [result] = await pool.query(
      'INSERT INTO sensor_readings (sensor_id, soil_moisture, temperature, humidity, light_intensity, rainfall, pump_on) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [sensor.sensor_id, soil, temp, hum, light, rainInsert, pumpInsert]
    );

    // ✅ Respond to ESP32 immediately — don't wait for background heavy lifting AI/Alerts
    res.status(201).json({ success: true, message: 'Sensor reading recorded successfully', reading_id: result.insertId });

    // 🚨 Trigger automated smart alerts engine continuously (checks limits and dedupes automatically)
    processSmartAlerts(sensor.user_id, sensor.field_id, sensor.sensor_id, { soil, temp, hum, rainInsert, pumpInsert });

    // 🤖 Trigger AI recommendation in background (every 5th reading to keep flow fast for demos)
    if (result.insertId % 5 === 0) {
      triggerAIRecommendation(sensor.field_id, sensor.sensor_id);
    }
  } catch (error) {
    console.error('Create sensor reading error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

// Create new sensor
export const createSensor = async (req, res) => {
  try {
    const { field_id, sensor_type, device_id, sensor_model, installation_date, location_description } = req.body;

    if (!field_id || !device_id) {
      return res.status(400).json({ success: false, message: 'field_id and device_id are required' });
    }

    if (!await verifyFieldOwnership(field_id, req.user.user_id)) {
      return res.status(404).json({ success: false, message: 'Field not found' });
    }

    // If device already exists, bind it to the selected field instead of failing.
    const [[existing]] = await pool.query(
      `SELECT s.sensor_id, s.field_id, f.user_id
       FROM sensors s
       JOIN fields f ON s.field_id = f.field_id
       WHERE s.device_id = ?`,
      [device_id]
    );

    if (existing) {
      // Prevent cross-user device hijacking.
      if (existing.user_id !== req.user.user_id) {
        return res.status(403).json({ success: false, message: 'This device ID is already linked to another user' });
      }

      // If already linked to this field, return success clearly.
      if (Number(existing.field_id) === Number(field_id)) {
        const [[alreadyLinked]] = await pool.query('SELECT * FROM sensors WHERE sensor_id = ?', [existing.sensor_id]);
        return res.status(200).json({
          success: true,
          message: 'Device already linked to this field',
          data: alreadyLinked
        });
      }

      // Re-bind existing device to selected field.
      await pool.query(
        `UPDATE sensors
         SET field_id = ?,
             sensor_type = COALESCE(?, sensor_type),
             sensor_model = COALESCE(?, sensor_model),
             installation_date = COALESCE(?, installation_date),
             location_description = COALESCE(?, location_description),
             updated_at = NOW()
         WHERE sensor_id = ?`,
        [
          field_id,
          sensor_type || null,
          sensor_model || null,
          installation_date || null,
          location_description || null,
          existing.sensor_id
        ]
      );

      const [[boundSensor]] = await pool.query('SELECT * FROM sensors WHERE sensor_id = ?', [existing.sensor_id]);
      return res.status(200).json({
        success: true,
        message: 'Existing device linked to selected field successfully',
        data: boundSensor
      });
    }

    const today = new Date().toISOString().slice(0, 10);

    const [result] = await pool.query(
      'INSERT INTO sensors (field_id, sensor_type, device_id, sensor_model, installation_date, location_description) VALUES (?, ?, ?, ?, ?, ?)',
      [field_id, sensor_type || 'combined', device_id, sensor_model || null, installation_date || today, location_description || null]
    );

    const [[sensor]] = await pool.query('SELECT * FROM sensors WHERE sensor_id = ?', [result.insertId]);
    res.status(201).json({ success: true, message: 'Sensor created successfully', data: sensor });
  } catch (error) {
    console.error('Create sensor error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

// Update sensor (e.g. bind to field)
export const updateSensor = async (req, res) => {
  try {
    const { sensorId } = req.params;
    const { field_id, sensor_name, is_active } = req.body;

    const [[sensor]] = await pool.query('SELECT sensor_id FROM sensors WHERE sensor_id = ?', [sensorId]);
    if (!sensor) {
      return res.status(404).json({ success: false, message: 'Sensor not found' });
    }

    if (field_id && !await verifyFieldOwnership(field_id, req.user.user_id)) {
      return res.status(404).json({ success: false, message: 'Field not found or does not belong to you' });
    }

    const updates = [];
    const params = [];

    if (field_id !== undefined) {
      updates.push('field_id = ?');
      params.push(field_id);
    }

    if (sensor_name) {
      updates.push('sensor_name = ?');
      params.push(sensor_name);
    }

    if (is_active !== undefined) {
      updates.push('is_active = ?');
      params.push(is_active);
    }

    if (updates.length === 0) {
      return res.status(400).json({ success: false, message: 'No updates provided' });
    }

    updates.push('updated_at = NOW()');
    params.push(sensorId);

    await pool.query(`UPDATE sensors SET ${updates.join(', ')} WHERE sensor_id = ?`, params);

    const [[updatedSensor]] = await pool.query('SELECT * FROM sensors WHERE sensor_id = ?', [sensorId]);
    res.json({ success: true, message: 'Sensor updated successfully', data: updatedSensor });
  } catch (error) {
    console.error('Update sensor error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

// Demo mode shared device binding:
// - Allows same device_id across multiple users/fields.
// - Requires DB migration to drop UNIQUE(device_id) on sensors table.
export const createSensorSharedDemo = async (req, res) => {
  try {
    const { field_id, sensor_type, device_id, sensor_model, installation_date, location_description } = req.body;

    if (!field_id || !device_id) {
      return res.status(400).json({ success: false, message: 'field_id and device_id are required' });
    }

    if (!await verifyFieldOwnership(field_id, req.user.user_id)) {
      return res.status(404).json({ success: false, message: 'Field not found' });
    }

    const [[alreadyLinkedToField]] = await pool.query(
      'SELECT sensor_id FROM sensors WHERE device_id = ? AND field_id = ?',
      [device_id, field_id]
    );

    if (alreadyLinkedToField) {
      const [[sensor]] = await pool.query('SELECT * FROM sensors WHERE sensor_id = ?', [alreadyLinkedToField.sensor_id]);
      return res.status(200).json({
        success: true,
        message: 'Device already linked to this field',
        data: sensor
      });
    }

    const today = new Date().toISOString().slice(0, 10);
    const [result] = await pool.query(
      'INSERT INTO sensors (field_id, sensor_type, device_id, sensor_model, installation_date, location_description) VALUES (?, ?, ?, ?, ?, ?)',
      [field_id, sensor_type || 'combined', device_id, sensor_model || null, installation_date || today, location_description || null]
    );

    const [[sensor]] = await pool.query('SELECT * FROM sensors WHERE sensor_id = ?', [result.insertId]);
    res.status(201).json({ success: true, message: 'Sensor linked successfully', data: sensor });
  } catch (error) {
    console.error('Create shared sensor error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

// Demo mode shared device ingestion:
// - One hardware POST fan-outs to all sensor rows with same device_id.
export const createSensorReadingSharedDemo = async (req, res) => {
  try {
    const { device_id, soil_moisture, temperature, humidity, light_intensity, rainfall, pump_on } = req.body;

    if (!device_id) {
      return res.status(400).json({ success: false, message: 'Device ID is required' });
    }

    const [boundSensors] = await pool.query(
      `SELECT s.sensor_id, s.field_id, f.user_id
       FROM sensors s
       JOIN fields f ON s.field_id = f.field_id
       WHERE s.device_id = ? AND s.is_active = TRUE`,
      [device_id]
    );

    if (!boundSensors || boundSensors.length === 0) {
      return res.status(404).json({ success: false, message: 'Sensor not found with this device ID' });
    }

    const soil = toNullableDecimal(soil_moisture);
    const temp = toNullableDecimal(temperature);
    const hum = toNullableDecimal(humidity);
    const light = toNullableInt(light_intensity);
    const rain = toRainfallBool(rainfall);
    const rainInsert = rain != null ? rain : 0;
    const pump = toTinyIntBool(pump_on);
    const basePump = pump != null ? pump : 0;

    const readingIds = [];

    for (const sensor of boundSensors) {
      let pumpInsert = basePump;

      try {
        const [[lastLog]] = await pool.query(
          'SELECT log_id, pump_status, end_time FROM irrigation_logs WHERE field_id = ? ORDER BY start_time DESC LIMIT 1',
          [sensor.field_id]
        );

        if (lastLog && lastLog.pump_status === 'on') {
          pumpInsert = 1;
        } else if (lastLog && lastLog.pump_status === 'off' && soil != null && soil < 20) {
          const [[existingAlert]] = await pool.query(
            'SELECT alert_id, is_resolved FROM alerts WHERE field_id = ? AND title = ? AND created_at >= ? ORDER BY created_at DESC LIMIT 1',
            [sensor.field_id, 'Manual Override Warning', lastLog.end_time]
          );

          const minutesSinceOff = (Date.now() - new Date(lastLog.end_time).getTime()) / 60000;

          if (minutesSinceOff > 10 || (existingAlert && existingAlert.is_resolved)) {
            pumpInsert = 1;
            const triggerDesc = (existingAlert && existingAlert.is_resolved)
              ? 'Cloud Auto-Start: Farmer resolved critical dryness warning.'
              : 'Cloud Auto-Start: 10 minutes timeout on critical dryness.';

            await pool.query(
              `INSERT INTO irrigation_logs (field_id, sensor_id, irrigation_type, start_time, trigger_reason, soil_moisture_before, pump_status, initiated_by)
               VALUES (?, ?, 'automatic', NOW(), ?, ?, 'on', ?)`,
              [sensor.field_id, sensor.sensor_id, triggerDesc, soil, sensor.user_id]
            );
          } else {
            pumpInsert = 0;
            if (!existingAlert) {
              await pool.query(
                `INSERT INTO alerts (user_id, field_id, sensor_id, alert_type, alert_category, title, message)
                 VALUES (?, ?, ?, 'critical', 'irrigation', 'Manual Override Warning', 'You turned off the pump, but soil moisture is extremely low. The system will auto-start in 10 minutes to save crops unless you resolve this warning.')`,
                [sensor.user_id, sensor.field_id, sensor.sensor_id]
              );
            }
          }
        }
      } catch (overrideErr) {
        console.warn(`Cloud override skipped (sensor ${sensor.sensor_id}): ${overrideErr.message}`);
      }

      const [result] = await pool.query(
        'INSERT INTO sensor_readings (sensor_id, soil_moisture, temperature, humidity, light_intensity, rainfall, pump_on) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [sensor.sensor_id, soil, temp, hum, light, rainInsert, pumpInsert]
      );
      readingIds.push(result.insertId);

      processSmartAlerts(sensor.user_id, sensor.field_id, sensor.sensor_id, { soil, temp, hum, rainInsert, pumpInsert });
      if (result.insertId % 5 === 0) {
        triggerAIRecommendation(sensor.field_id, sensor.sensor_id);
      }
    }

    res.status(201).json({
      success: true,
      message: 'Sensor reading recorded successfully',
      reading_id: readingIds[0],
      reading_ids: readingIds,
      bound_sensor_count: boundSensors.length
    });
  } catch (error) {
    console.error('Create shared sensor reading error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};
