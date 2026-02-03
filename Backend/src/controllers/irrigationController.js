import pool from '../config/database.js';

const verifyFieldOwnership = async (fieldId, userId) => {
  const [[field]] = await pool.query('SELECT field_id FROM fields WHERE field_id = ? AND user_id = ?', [fieldId, userId]);
  return field;
};

// Get irrigation logs for a field
export const getIrrigationLogs = async (req, res) => {
  try {
    const { fieldId } = req.params;
    const { limit = 50, offset = 0 } = req.query;

    if (!await verifyFieldOwnership(fieldId, req.user.user_id)) {
      return res.status(404).json({ success: false, message: 'Field not found' });
    }

    const [logs] = await pool.query(
      'SELECT * FROM irrigation_logs WHERE field_id = ? ORDER BY start_time DESC LIMIT ? OFFSET ?',
      [fieldId, parseInt(limit), parseInt(offset)]
    );

    res.json({ success: true, data: logs });
  } catch (error) {
    console.error('Get irrigation logs error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

// Start manual irrigation
export const startIrrigation = async (req, res) => {
  try {
    const { field_id, sensor_id, trigger_reason, soil_moisture_before } = req.body;

    if (!await verifyFieldOwnership(field_id, req.user.user_id)) {
      return res.status(404).json({ success: false, message: 'Field not found' });
    }

    const [[activeLog]] = await pool.query('SELECT log_id FROM irrigation_logs WHERE field_id = ? AND pump_status = "on"', [field_id]);
    if (activeLog) {
      return res.status(400).json({ success: false, message: 'Irrigation already in progress for this field' });
    }

    const [result] = await pool.query(
      `INSERT INTO irrigation_logs (field_id, sensor_id, irrigation_type, start_time, trigger_reason, soil_moisture_before, pump_status, initiated_by) 
       VALUES (?, ?, 'manual', NOW(), ?, ?, 'on', ?)`,
      [field_id, sensor_id, trigger_reason || 'Manual irrigation by farmer', soil_moisture_before, req.user.user_id]
    );

    const [[log]] = await pool.query('SELECT * FROM irrigation_logs WHERE log_id = ?', [result.insertId]);

    // TODO: Send command to ESP32/IoT device to turn on pump
    res.status(201).json({ success: true, message: 'Irrigation started successfully', data: log });
  } catch (error) {
    console.error('Start irrigation error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

// Stop irrigation
export const stopIrrigation = async (req, res) => {
  try {
    const { field_id, log_id, soil_moisture_after, water_used_liters } = req.body;

    if (!field_id && !log_id) {
      return res.status(400).json({ success: false, message: 'Please provide either field_id or log_id' });
    }

    const [[log]] = log_id
      ? await pool.query(
        'SELECT il.* FROM irrigation_logs il JOIN fields f ON il.field_id = f.field_id WHERE il.log_id = ? AND f.user_id = ?',
        [log_id, req.user.user_id]
      )
      : await pool.query(
        'SELECT il.* FROM irrigation_logs il JOIN fields f ON il.field_id = f.field_id WHERE il.field_id = ? AND f.user_id = ? AND il.pump_status = "on" ORDER BY il.start_time DESC LIMIT 1',
        [field_id, req.user.user_id]
      );

    if (!log) return res.status(404).json({ success: false, message: 'No active irrigation found for this field' });
    if (log.pump_status !== 'on') return res.status(400).json({ success: false, message: 'Irrigation is not active' });

    const duration_minutes = Math.round((Date.now() - new Date(log.start_time)) / 60000);

    await pool.query(
      'UPDATE irrigation_logs SET end_time = NOW(), duration_minutes = ?, soil_moisture_after = ?, water_used_liters = ?, pump_status = "off" WHERE log_id = ?',
      [duration_minutes, soil_moisture_after, water_used_liters, log.log_id]
    );

    const [[updatedLog]] = await pool.query('SELECT * FROM irrigation_logs WHERE log_id = ?', [log.log_id]);

    // TODO: Send command to ESP32/IoT device to turn off pump
    res.json({ success: true, message: 'Irrigation stopped successfully', data: updatedLog });
  } catch (error) {
    console.error('Stop irrigation error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

// Get irrigation schedules
export const getSchedules = async (req, res) => {
  try {
    const { fieldId } = req.params;

    if (!await verifyFieldOwnership(fieldId, req.user.user_id)) {
      return res.status(404).json({ success: false, message: 'Field not found' });
    }

    const [schedules] = await pool.query('SELECT * FROM irrigation_schedules WHERE field_id = ? ORDER BY created_at DESC', [fieldId]);
    res.json({ success: true, data: schedules });
  } catch (error) {
    console.error('Get schedules error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

// Create irrigation schedule
export const createSchedule = async (req, res) => {
  try {
    const { field_id, schedule_name, start_date, end_date, time_of_day, duration_minutes, frequency, custom_days } = req.body;

    if (!await verifyFieldOwnership(field_id, req.user.user_id)) {
      return res.status(404).json({ success: false, message: 'Field not found' });
    }

    const [result] = await pool.query(
      `INSERT INTO irrigation_schedules (field_id, schedule_name, start_date, end_date, time_of_day, duration_minutes, frequency, custom_days, created_by) 
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [field_id, schedule_name, start_date, end_date, time_of_day, duration_minutes, frequency, custom_days, req.user.user_id]
    );

    const [[schedule]] = await pool.query('SELECT * FROM irrigation_schedules WHERE schedule_id = ?', [result.insertId]);
    res.status(201).json({ success: true, message: 'Schedule created successfully', data: schedule });
  } catch (error) {
    console.error('Create schedule error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};
