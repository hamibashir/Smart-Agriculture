import pool from '../config/database.js';

// Get all alerts for user
export const getAlerts = async (req, res) => {
  try {
    const { is_read, alert_type, limit = 50, offset = 0 } = req.query;

    let query = 'SELECT * FROM alerts WHERE user_id = ?';
    const params = [req.user.user_id];

    if (is_read !== undefined) {
      query += ' AND is_read = ?';
      params.push(is_read === 'true' ? 1 : 0);
    }

    if (alert_type) {
      query += ' AND alert_type = ?';
      params.push(alert_type);
    }

    query += ' ORDER BY created_at DESC LIMIT ? OFFSET ?';
    params.push(parseInt(limit), parseInt(offset));

    const [alerts] = await pool.query(query, params);

    res.json({
      success: true,
      data: alerts
    });
  } catch (error) {
    console.error('Get alerts error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Mark alert as read
export const markAsRead = async (req, res) => {
  try {
    const { id } = req.params;

    const [alerts] = await pool.query(
      'SELECT * FROM alerts WHERE alert_id = ? AND user_id = ?',
      [id, req.user.user_id]
    );

    if (alerts.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Alert not found'
      });
    }

    await pool.query(
      'UPDATE alerts SET is_read = TRUE WHERE alert_id = ?',
      [id]
    );

    res.json({
      success: true,
      message: 'Alert marked as read'
    });
  } catch (error) {
    console.error('Mark as read error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Mark alert as resolved
export const markAsResolved = async (req, res) => {
  try {
    const { id } = req.params;
    const { action_taken } = req.body;

    const [alerts] = await pool.query(
      'SELECT * FROM alerts WHERE alert_id = ? AND user_id = ?',
      [id, req.user.user_id]
    );

    if (alerts.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Alert not found'
      });
    }

    await pool.query(
      'UPDATE alerts SET is_resolved = TRUE, resolved_at = NOW(), action_taken = ? WHERE alert_id = ?',
      [action_taken, id]
    );

    res.json({
      success: true,
      message: 'Alert marked as resolved'
    });
  } catch (error) {
    console.error('Mark as resolved error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Create alert (for system/automated alerts)
export const createAlert = async (req, res) => {
  try {
    const {
      user_id,
      field_id,
      sensor_id,
      alert_type,
      alert_category,
      title,
      message,
      threshold_value,
      current_value
    } = req.body;

    const [result] = await pool.query(
      `INSERT INTO alerts (user_id, field_id, sensor_id, alert_type, alert_category, title, message, threshold_value, current_value) 
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [user_id, field_id, sensor_id, alert_type, alert_category, title, message, threshold_value, current_value]
    );

    // TODO: Send push notification to user

    res.status(201).json({
      success: true,
      message: 'Alert created successfully',
      alert_id: result.insertId
    });
  } catch (error) {
    console.error('Create alert error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Get unread alerts count
export const getUnreadCount = async (req, res) => {
  try {
    const [result] = await pool.query(
      'SELECT COUNT(*) as count FROM alerts WHERE user_id = ? AND is_read = FALSE',
      [req.user.user_id]
    );

    res.json({
      success: true,
      count: result[0].count
    });
  } catch (error) {
    console.error('Get unread count error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Delete alert
export const deleteAlert = async (req, res) => {
  try {
    const { id } = req.params;

    const [alerts] = await pool.query(
      'SELECT * FROM alerts WHERE alert_id = ? AND user_id = ?',
      [id, req.user.user_id]
    );

    if (alerts.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Alert not found'
      });
    }

    await pool.query(
      'DELETE FROM alerts WHERE alert_id = ?',
      [id]
    );

    res.json({
      success: true,
      message: 'Alert deleted successfully'
    });
  } catch (error) {
    console.error('Delete alert error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};
