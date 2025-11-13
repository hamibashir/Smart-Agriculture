import pool from '../config/database.js';

// Get all sensors for a field
export const getSensorsByField = async (req, res) => {
  try {
    const { fieldId } = req.params;

    // Verify field belongs to user
    const [fields] = await pool.query(
      'SELECT * FROM fields WHERE field_id = ? AND user_id = ?',
      [fieldId, req.user.user_id]
    );

    if (fields.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Field not found'
      });
    }

    const [sensors] = await pool.query(
      'SELECT * FROM sensors WHERE field_id = ? ORDER BY created_at DESC',
      [fieldId]
    );

    res.json({
      success: true,
      data: sensors
    });
  } catch (error) {
    console.error('Get sensors error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Get sensor readings
export const getSensorReadings = async (req, res) => {
  try {
    const { sensorId } = req.params;
    const { limit = 100, offset = 0 } = req.query;

    // Verify sensor belongs to user's field
    const [sensors] = await pool.query(
      `SELECT s.* FROM sensors s 
       JOIN fields f ON s.field_id = f.field_id 
       WHERE s.sensor_id = ? AND f.user_id = ?`,
      [sensorId, req.user.user_id]
    );

    if (sensors.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Sensor not found'
      });
    }

    const [readings] = await pool.query(
      `SELECT * FROM sensor_readings 
       WHERE sensor_id = ? 
       ORDER BY reading_timestamp DESC 
       LIMIT ? OFFSET ?`,
      [sensorId, parseInt(limit), parseInt(offset)]
    );

    res.json({
      success: true,
      data: readings
    });
  } catch (error) {
    console.error('Get sensor readings error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Get latest sensor reading
export const getLatestReading = async (req, res) => {
  try {
    const { sensorId } = req.params;

    const [sensors] = await pool.query(
      `SELECT s.* FROM sensors s 
       JOIN fields f ON s.field_id = f.field_id 
       WHERE s.sensor_id = ? AND f.user_id = ?`,
      [sensorId, req.user.user_id]
    );

    if (sensors.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Sensor not found'
      });
    }

    const [readings] = await pool.query(
      `SELECT * FROM sensor_readings 
       WHERE sensor_id = ? 
       ORDER BY reading_timestamp DESC 
       LIMIT 1`,
      [sensorId]
    );

    res.json({
      success: true,
      data: readings[0] || null
    });
  } catch (error) {
    console.error('Get latest reading error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Create sensor reading (for ESP32/IoT devices)
export const createSensorReading = async (req, res) => {
  try {
    const {
      device_id,
      soil_moisture,
      temperature,
      humidity,
      light_intensity,
      rainfall,
      water_flow_rate,
      battery_voltage,
      signal_strength
    } = req.body;

    if (!device_id) {
      return res.status(400).json({
        success: false,
        message: 'Device ID is required'
      });
    }

    // Find sensor by device_id
    const [sensors] = await pool.query(
      'SELECT * FROM sensors WHERE device_id = ?',
      [device_id]
    );

    if (sensors.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Sensor not found with this device ID'
      });
    }

    const sensor = sensors[0];

    // Insert reading
    const [result] = await pool.query(
      `INSERT INTO sensor_readings (sensor_id, soil_moisture, temperature, humidity, light_intensity, rainfall, water_flow_rate, battery_voltage, signal_strength) 
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [sensor.sensor_id, soil_moisture, temperature, humidity, light_intensity, rainfall, water_flow_rate, battery_voltage, signal_strength]
    );

    // Update sensor battery level if provided
    if (battery_voltage) {
      const battery_percentage = (battery_voltage / 4.2) * 100; // Assuming 4.2V is 100%
      await pool.query(
        'UPDATE sensors SET battery_level = ? WHERE sensor_id = ?',
        [battery_percentage, sensor.sensor_id]
      );
    }

    res.status(201).json({
      success: true,
      message: 'Sensor reading recorded successfully',
      reading_id: result.insertId
    });
  } catch (error) {
    console.error('Create sensor reading error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Create new sensor
export const createSensor = async (req, res) => {
  try {
    const {
      field_id,
      sensor_type,
      device_id,
      sensor_model,
      installation_date,
      location_description
    } = req.body;

    // Verify field belongs to user
    const [fields] = await pool.query(
      'SELECT * FROM fields WHERE field_id = ? AND user_id = ?',
      [field_id, req.user.user_id]
    );

    if (fields.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Field not found'
      });
    }

    // Check if device_id already exists
    const [existingSensors] = await pool.query(
      'SELECT * FROM sensors WHERE device_id = ?',
      [device_id]
    );

    if (existingSensors.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Sensor with this device ID already exists'
      });
    }

    const [result] = await pool.query(
      `INSERT INTO sensors (field_id, sensor_type, device_id, sensor_model, installation_date, location_description) 
       VALUES (?, ?, ?, ?, ?, ?)`,
      [field_id, sensor_type, device_id, sensor_model, installation_date, location_description]
    );

    const [sensors] = await pool.query(
      'SELECT * FROM sensors WHERE sensor_id = ?',
      [result.insertId]
    );

    res.status(201).json({
      success: true,
      message: 'Sensor created successfully',
      data: sensors[0]
    });
  } catch (error) {
    console.error('Create sensor error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};
