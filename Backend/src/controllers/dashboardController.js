import pool from '../config/database.js';

// Get dashboard statistics
export const getDashboardStats = async (req, res) => {
  try {
    const userId = req.user.user_id;

    // Combined query for all counts and stats
    const [[stats]] = await pool.query(
      `SELECT 
        (SELECT COUNT(*) FROM fields WHERE user_id = ? AND is_active = TRUE) as total_fields,
        (SELECT COUNT(*) FROM sensors s JOIN fields f ON s.field_id = f.field_id WHERE f.user_id = ? AND s.is_active = TRUE) as active_sensors,
        (SELECT COUNT(*) FROM alerts WHERE user_id = ? AND is_read = FALSE) as unread_alerts,
        (SELECT COUNT(*) FROM crop_recommendations cr JOIN fields f ON cr.field_id = f.field_id WHERE f.user_id = ? AND cr.is_accepted = FALSE) as ai_tips`,
      [userId, userId, userId, userId]
    );

    // Get latest sensor reading for any active sensor belonging to the logged-in user
    const [sensorReading] = await pool.query(
      `SELECT sr.soil_moisture, sr.temperature, sr.humidity, sr.light_intensity, sr.rainfall, f.field_name 
       FROM sensor_readings sr
       JOIN sensors s ON sr.sensor_id = s.sensor_id
       JOIN fields f ON s.field_id = f.field_id
       WHERE f.user_id = ? AND s.is_active = TRUE
       ORDER BY sr.reading_time DESC LIMIT 1`,
      [userId]
    );

    const currentConditions = sensorReading.length > 0
      ? {
        avg_soil_moisture: parseFloat(sensorReading[0].soil_moisture || 0),
        avg_temperature: parseFloat(sensorReading[0].temperature || 0),
        avg_humidity: parseFloat(sensorReading[0].humidity || 0),
        light_intensity: parseFloat(sensorReading[0].light_intensity || 0),
        rainfall: parseInt(sensorReading[0].rainfall || 0),
        latest_field_name: sensorReading[0].field_name || 'Farm'
      }
      : { avg_soil_moisture: 0, avg_temperature: 0, avg_humidity: 0, light_intensity: 0, rainfall: 0, latest_field_name: 'Farm' };

    res.json({
      success: true,
      data: { ...stats, water_saved_today: Math.round(stats.water_saved_today), ...currentConditions }
    });
  } catch (error) {
    console.error('Get dashboard stats error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
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
