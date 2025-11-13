import pool from '../config/database.js';

// Get irrigation logs for a field
export const getIrrigationLogs = async (req, res) => {
  try {
    const { fieldId } = req.params;
    const { limit = 50, offset = 0 } = req.query;

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

    const [logs] = await pool.query(
      `SELECT * FROM irrigation_logs 
       WHERE field_id = ? 
       ORDER BY start_time DESC 
       LIMIT ? OFFSET ?`,
      [fieldId, parseInt(limit), parseInt(offset)]
    );

    res.json({
      success: true,
      data: logs
    });
  } catch (error) {
    console.error('Get irrigation logs error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Start manual irrigation
export const startIrrigation = async (req, res) => {
  try {
    const { field_id, sensor_id, trigger_reason, soil_moisture_before } = req.body;

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

    // Check if there's already an active irrigation
    const [activeLogs] = await pool.query(
      'SELECT * FROM irrigation_logs WHERE field_id = ? AND pump_status = "on"',
      [field_id]
    );

    if (activeLogs.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Irrigation already in progress for this field'
      });
    }

    const [result] = await pool.query(
      `INSERT INTO irrigation_logs (field_id, sensor_id, irrigation_type, start_time, trigger_reason, soil_moisture_before, pump_status, initiated_by) 
       VALUES (?, ?, 'manual', NOW(), ?, ?, 'on', ?)`,
      [field_id, sensor_id, trigger_reason || 'Manual irrigation by farmer', soil_moisture_before, req.user.user_id]
    );

    const [logs] = await pool.query(
      'SELECT * FROM irrigation_logs WHERE log_id = ?',
      [result.insertId]
    );

    // TODO: Send command to ESP32/IoT device to turn on pump

    res.status(201).json({
      success: true,
      message: 'Irrigation started successfully',
      data: logs[0]
    });
  } catch (error) {
    console.error('Start irrigation error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Stop irrigation
export const stopIrrigation = async (req, res) => {
  try {
    const { field_id, log_id, soil_moisture_after, water_used_liters } = req.body;

    // Support both field_id (from mobile app) and log_id (direct)
    let logs;
    
    if (log_id) {
      // Direct log_id provided
      [logs] = await pool.query(
        `SELECT il.* FROM irrigation_logs il
         JOIN fields f ON il.field_id = f.field_id
         WHERE il.log_id = ? AND f.user_id = ?`,
        [log_id, req.user.user_id]
      );
    } else if (field_id) {
      // Find active irrigation by field_id
      [logs] = await pool.query(
        `SELECT il.* FROM irrigation_logs il
         JOIN fields f ON il.field_id = f.field_id
         WHERE il.field_id = ? AND f.user_id = ? AND il.pump_status = 'on'
         ORDER BY il.start_time DESC
         LIMIT 1`,
        [field_id, req.user.user_id]
      );
    } else {
      return res.status(400).json({
        success: false,
        message: 'Please provide either field_id or log_id'
      });
    }

    if (logs.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'No active irrigation found for this field'
      });
    }

    const log = logs[0];

    if (log.pump_status !== 'on') {
      return res.status(400).json({
        success: false,
        message: 'Irrigation is not active'
      });
    }

    // Calculate duration
    const start = new Date(log.start_time);
    const end = new Date();
    const duration_minutes = Math.round((end - start) / 60000);

    await pool.query(
      `UPDATE irrigation_logs 
       SET end_time = NOW(), duration_minutes = ?, soil_moisture_after = ?, water_used_liters = ?, pump_status = 'off' 
       WHERE log_id = ?`,
      [duration_minutes, soil_moisture_after, water_used_liters, log.log_id]
    );

    const [updatedLogs] = await pool.query(
      'SELECT * FROM irrigation_logs WHERE log_id = ?',
      [log.log_id]
    );

    // TODO: Send command to ESP32/IoT device to turn off pump

    res.json({
      success: true,
      message: 'Irrigation stopped successfully',
      data: updatedLogs[0]
    });
  } catch (error) {
    console.error('Stop irrigation error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Get irrigation schedules
export const getSchedules = async (req, res) => {
  try {
    const { fieldId } = req.params;

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

    const [schedules] = await pool.query(
      'SELECT * FROM irrigation_schedules WHERE field_id = ? ORDER BY created_at DESC',
      [fieldId]
    );

    res.json({
      success: true,
      data: schedules
    });
  } catch (error) {
    console.error('Get schedules error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Create irrigation schedule
export const createSchedule = async (req, res) => {
  try {
    const {
      field_id,
      schedule_name,
      start_date,
      end_date,
      time_of_day,
      duration_minutes,
      frequency,
      custom_days
    } = req.body;

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

    const [result] = await pool.query(
      `INSERT INTO irrigation_schedules (field_id, schedule_name, start_date, end_date, time_of_day, duration_minutes, frequency, custom_days, created_by) 
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [field_id, schedule_name, start_date, end_date, time_of_day, duration_minutes, frequency, custom_days, req.user.user_id]
    );

    const [schedules] = await pool.query(
      'SELECT * FROM irrigation_schedules WHERE schedule_id = ?',
      [result.insertId]
    );

    res.status(201).json({
      success: true,
      message: 'Schedule created successfully',
      data: schedules[0]
    });
  } catch (error) {
    console.error('Create schedule error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};
