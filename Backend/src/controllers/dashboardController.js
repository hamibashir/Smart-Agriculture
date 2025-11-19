import pool from '../config/database.js';

// Get dashboard statistics
export const getDashboardStats = async (req, res) => {
  try {
    const userId = req.user.user_id;

    // Get total fields
    const [fieldsCount] = await pool.query(
      'SELECT COUNT(*) as count FROM fields WHERE user_id = ? AND is_active = TRUE',
      [userId]
    );

    // Get active sensors
    const [sensorsCount] = await pool.query(
      `SELECT COUNT(*) as count FROM sensors s
       JOIN fields f ON s.field_id = f.field_id
       WHERE f.user_id = ? AND s.is_active = TRUE`,
      [userId]
    );

    // Get total alerts
    const [alertsCount] = await pool.query(
      'SELECT COUNT(*) as count FROM alerts WHERE user_id = ?',
      [userId]
    );

    // Get unread alerts
    const [unreadAlertsCount] = await pool.query(
      'SELECT COUNT(*) as count FROM alerts WHERE user_id = ? AND is_read = FALSE',
      [userId]
    );

    // Get water saved today
    const [waterSaved] = await pool.query(
      `SELECT COALESCE(SUM(water_used_liters), 0) as total FROM irrigation_logs il
       JOIN fields f ON il.field_id = f.field_id
       WHERE f.user_id = ? AND DATE(il.start_time) = CURDATE()`,
      [userId]
    );

    // Check for Sensor 14 (ESP32 Demo) specific data
    const [sensor14Reading] = await pool.query(
      `SELECT * FROM sensor_readings 
       WHERE sensor_id = 14 
       ORDER BY reading_time DESC 
       LIMIT 1`
    );

    let currentConditions = {};

    if (sensor14Reading.length > 0) {
      // Use Sensor 14 data if available
      const reading = sensor14Reading[0];
      currentConditions = {
        avg_soil_moisture: parseFloat(reading.soil_moisture || 0),
        avg_temperature: parseFloat(reading.temperature || 0),
        avg_humidity: parseFloat(reading.humidity || 0)
      };
    } else {
      // Fallback to average of all sensors (last 24 hours)
      const [avgReadings] = await pool.query(
        `SELECT 
          AVG(sr.soil_moisture) as avg_soil_moisture,
          AVG(sr.temperature) as avg_temperature,
          AVG(sr.humidity) as avg_humidity
         FROM sensor_readings sr
         JOIN sensors s ON sr.sensor_id = s.sensor_id
         JOIN fields f ON s.field_id = f.field_id
         WHERE f.user_id = ? AND sr.created_at >= DATE_SUB(NOW(), INTERVAL 24 HOUR)`,
        [userId]
      );

      currentConditions = {
        avg_soil_moisture: Math.round((avgReadings[0].avg_soil_moisture || 0) * 10) / 10,
        avg_temperature: Math.round((avgReadings[0].avg_temperature || 0) * 10) / 10,
        avg_humidity: Math.round((avgReadings[0].avg_humidity || 0) * 10) / 10
      };
    }

    const stats = {
      total_fields: fieldsCount[0].count,
      active_sensors: sensorsCount[0].count,
      total_alerts: alertsCount[0].count,
      unread_alerts: unreadAlertsCount[0].count,
      water_saved_today: Math.round(waterSaved[0].total || 0),
      ...currentConditions
    };

    res.json({
      success: true,
      data: stats
    });
  } catch (error) {
    console.error('Get dashboard stats error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Get recent activity
export const getRecentActivity = async (req, res) => {
  try {
    const userId = req.user.user_id;
    const { limit = 10 } = req.query;

    // Get recent irrigation logs
    const [irrigationLogs] = await pool.query(
      `SELECT il.*, f.field_name FROM irrigation_logs il
       JOIN fields f ON il.field_id = f.field_id
       WHERE f.user_id = ?
       ORDER BY il.start_time DESC
       LIMIT ?`,
      [userId, parseInt(limit)]
    );

    // Get recent alerts
    const [alerts] = await pool.query(
      `SELECT * FROM alerts
       WHERE user_id = ?
       ORDER BY created_at DESC
       LIMIT ?`,
      [userId, parseInt(limit)]
    );

    res.json({
      success: true,
      data: {
        irrigation_logs: irrigationLogs,
        alerts: alerts
      }
    });
  } catch (error) {
    console.error('Get recent activity error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};
