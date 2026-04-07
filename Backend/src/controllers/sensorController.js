import pool from '../config/database.js';

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
    if (!field || !field.soil_type) return;

    // Get average of last 5 readings for stable prediction
    const [readings] = await pool.query(
      `SELECT 
        AVG(soil_moisture) AS soil_moisture,
        AVG(temperature)   AS temperature,
        AVG(humidity)      AS humidity,
        AVG(rainfall)      AS rainfall
       FROM sensor_readings
       WHERE sensor_id = ?
       ORDER BY reading_timestamp DESC
       LIMIT 5`,
      [sensorId]
    );

    const avg = readings[0];
    if (!avg.soil_moisture) return; // Not enough data yet

    // Determine season from current month (Pakistan: Rabi=Oct-Mar, Kharif=Apr-Sep)
    const month   = new Date().getMonth() + 1;
    const season  = (month >= 10 || month <= 3) ? 'rabi' : 'kharif';

    // Call Flask AI API
    const response = await fetch(`${AI_API_URL}/predict`, {
      method:  'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        soil_moisture: parseFloat(avg.soil_moisture).toFixed(2),
        temperature:   parseFloat(avg.temperature).toFixed(2),
        humidity:      parseFloat(avg.humidity).toFixed(2),
        soil_type:     field.soil_type.toLowerCase().replace(' ', '_'),
        season:        season,
        rainfall:      parseFloat(avg.rainfall || 0).toFixed(2)
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

// Create sensor reading (for ESP32/IoT devices)
export const createSensorReading = async (req, res) => {
  try {
    const { device_id, soil_moisture, temperature, humidity, light_intensity, rainfall } = req.body;

    if (!device_id) {
      return res.status(400).json({ success: false, message: 'Device ID is required' });
    }

    // Get sensor + its linked field in one query
    const [[sensor]] = await pool.query(
      'SELECT s.sensor_id, s.field_id FROM sensors s WHERE s.device_id = ?',
      [device_id]
    );
    if (!sensor) {
      return res.status(404).json({ success: false, message: 'Sensor not found with this device ID' });
    }

    const [result] = await pool.query(
      'INSERT INTO sensor_readings (sensor_id, soil_moisture, temperature, humidity, light_intensity, rainfall) VALUES (?, ?, ?, ?, ?, ?)',
      [sensor.sensor_id, soil_moisture, temperature, humidity, light_intensity, rainfall || 0]
    );

    // ✅ Respond to ESP32 immediately — don't wait for AI
    res.status(201).json({ success: true, message: 'Sensor reading recorded successfully', reading_id: result.insertId });

    // 🤖 Trigger AI recommendation in background (every 10th reading to avoid spam)
    if (result.insertId % 10 === 0) {
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

    if (!await verifyFieldOwnership(field_id, req.user.user_id)) {
      return res.status(404).json({ success: false, message: 'Field not found' });
    }

    const [[existing]] = await pool.query('SELECT sensor_id FROM sensors WHERE device_id = ?', [device_id]);
    if (existing) {
      return res.status(400).json({ success: false, message: 'Sensor with this device ID already exists' });
    }

    const [result] = await pool.query(
      'INSERT INTO sensors (field_id, sensor_type, device_id, sensor_model, installation_date, location_description) VALUES (?, ?, ?, ?, ?, ?)',
      [field_id, sensor_type, device_id, sensor_model, installation_date, location_description]
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
