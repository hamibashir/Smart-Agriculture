import pool from '../config/database.js';

// Get all users (admin only)
export const getAllUsers = async (req, res) => {
  try {
    const [users] = await pool.query(
      `SELECT user_id, full_name, email, phone, address, city, province, postal_code, 
              role, is_active, email_verified, phone_verified, created_at, updated_at, last_login
       FROM users 
       ORDER BY created_at DESC`
    );

    res.json({
      success: true,
      data: users
    });
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch users'
    });
  }
};

// Get all fields (admin only)
export const getAllFields = async (req, res) => {
  try {
    const [fields] = await pool.query(
      `SELECT f.*, u.full_name as user_name, u.email as user_email,
              (SELECT COUNT(*) FROM sensors s WHERE s.field_id = f.field_id) as sensor_count
       FROM fields f
       LEFT JOIN users u ON f.user_id = u.user_id
       ORDER BY f.created_at DESC`
    );

    res.json({
      success: true,
      data: fields
    });
  } catch (error) {
    console.error('Error fetching fields:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch fields'
    });
  }
};

// Get all sensors (admin only)
export const getAllSensors = async (req, res) => {
  try {
    const [sensors] = await pool.query(
      `SELECT s.*, f.field_name, f.user_id, u.full_name as user_name
       FROM sensors s
       LEFT JOIN fields f ON s.field_id = f.field_id
       LEFT JOIN users u ON f.user_id = u.user_id
       ORDER BY s.created_at DESC`
    );

    res.json({
      success: true,
      data: sensors
    });
  } catch (error) {
    console.error('Error fetching sensors:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch sensors'
    });
  }
};

// Get admin dashboard statistics
export const getAdminStats = async (req, res) => {
  try {
    // Get user counts
    const [userStats] = await pool.query(
      `SELECT 
        COUNT(*) as total_users,
        SUM(CASE WHEN role = 'farmer' THEN 1 ELSE 0 END) as total_farmers,
        SUM(CASE WHEN role = 'admin' THEN 1 ELSE 0 END) as total_admins,
        SUM(CASE WHEN is_active = 1 THEN 1 ELSE 0 END) as active_users
       FROM users`
    );

    // Get field count
    const [fieldStats] = await pool.query(
      `SELECT COUNT(*) as total_fields FROM fields WHERE is_active = 1`
    );

    // Get sensor counts
    const [sensorStats] = await pool.query(
      `SELECT 
        COUNT(*) as total_sensors,
        SUM(CASE WHEN is_active = 1 THEN 1 ELSE 0 END) as active_sensors
       FROM sensors`
    );

    // Get alert counts
    const [alertStats] = await pool.query(
      `SELECT 
        COUNT(*) as total_alerts,
        SUM(CASE WHEN is_read = 0 THEN 1 ELSE 0 END) as unread_alerts,
        SUM(CASE WHEN alert_type = 'critical' THEN 1 ELSE 0 END) as critical_alerts
       FROM alerts`
    );

    const stats = {
      total_users: userStats[0].total_users,
      total_farmers: userStats[0].total_farmers,
      total_admins: userStats[0].total_admins,
      active_users: userStats[0].active_users,
      total_fields: fieldStats[0].total_fields,
      total_sensors: sensorStats[0].total_sensors,
      active_sensors: sensorStats[0].active_sensors,
      offline_sensors: sensorStats[0].total_sensors - sensorStats[0].active_sensors,
      total_alerts: alertStats[0].total_alerts,
      unread_alerts: alertStats[0].unread_alerts,
      critical_alerts: alertStats[0].critical_alerts
    };

    res.json({
      success: true,
      data: stats
    });
  } catch (error) {
    console.error('Error fetching admin stats:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch statistics'
    });
  }
};

// Get audit logs (admin only)
export const getAuditLogs = async (req, res) => {
  try {
    const { limit = 100, offset = 0, action_type, table_name, user_id } = req.query;

    let query = `
      SELECT al.*, u.full_name as user_name, u.email as user_email
      FROM audit_logs al
      LEFT JOIN users u ON al.user_id = u.user_id
      WHERE 1=1
    `;
    const params = [];

    if (action_type) {
      query += ' AND al.action_type = ?';
      params.push(action_type);
    }

    if (table_name) {
      query += ' AND al.table_name = ?';
      params.push(table_name);
    }

    if (user_id) {
      query += ' AND al.user_id = ?';
      params.push(user_id);
    }

    query += ' ORDER BY al.created_at DESC LIMIT ? OFFSET ?';
    params.push(parseInt(limit), parseInt(offset));

    const [logs] = await pool.query(query, params);

    // Get total count
    let countQuery = 'SELECT COUNT(*) as total FROM audit_logs WHERE 1=1';
    const countParams = [];

    if (action_type) {
      countQuery += ' AND action_type = ?';
      countParams.push(action_type);
    }

    if (table_name) {
      countQuery += ' AND table_name = ?';
      countParams.push(table_name);
    }

    if (user_id) {
      countQuery += ' AND user_id = ?';
      countParams.push(user_id);
    }

    const [countResult] = await pool.query(countQuery, countParams);

    res.json({
      success: true,
      data: {
        logs,
        total: countResult[0].total,
        limit: parseInt(limit),
        offset: parseInt(offset)
      }
    });
  } catch (error) {
    console.error('Error fetching audit logs:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch audit logs'
    });
  }
};

// Update user status (admin only)
export const updateUserStatus = async (req, res) => {
  try {
    const { userId } = req.params;
    const { is_active, role } = req.body;

    const updates = [];
    const params = [];

    if (typeof is_active !== 'undefined') {
      updates.push('is_active = ?');
      params.push(is_active);
    }

    if (role) {
      updates.push('role = ?');
      params.push(role);
    }

    if (updates.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'No updates provided'
      });
    }

    params.push(userId);

    await pool.query(
      `UPDATE users SET ${updates.join(', ')}, updated_at = CURRENT_TIMESTAMP WHERE user_id = ?`,
      params
    );

    // Log the action
    await pool.query(
      `INSERT INTO audit_logs (user_id, action_type, table_name, record_id, ip_address)
       VALUES (?, 'UPDATE', 'users', ?, ?)`,
      [req.user.userId, userId, req.ip]
    );

    res.json({
      success: true,
      message: 'User updated successfully'
    });
  } catch (error) {
    console.error('Error updating user:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update user'
    });
  }
};

// Get system activity (admin only)
export const getSystemActivity = async (req, res) => {
  try {
    const { hours = 24 } = req.query;

    const [activity] = await pool.query(
      `SELECT 
        al.action_type,
        al.table_name,
        al.created_at,
        u.full_name as user_name,
        al.ip_address
       FROM audit_logs al
       LEFT JOIN users u ON al.user_id = u.user_id
       WHERE al.created_at >= DATE_SUB(NOW(), INTERVAL ? HOUR)
       ORDER BY al.created_at DESC
       LIMIT 50`,
      [parseInt(hours)]
    );

    res.json({
      success: true,
      data: activity
    });
  } catch (error) {
    console.error('Error fetching system activity:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch system activity'
    });
  }
};
