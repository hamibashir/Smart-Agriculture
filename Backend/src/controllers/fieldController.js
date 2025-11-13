import pool from '../config/database.js';

// Get all fields for logged-in user
export const getFields = async (req, res) => {
  try {
    const [fields] = await pool.query(
      'SELECT * FROM fields WHERE user_id = ? ORDER BY created_at DESC',
      [req.user.user_id]
    );

    res.json({
      success: true,
      data: fields
    });
  } catch (error) {
    console.error('Get fields error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Get single field by ID
export const getFieldById = async (req, res) => {
  try {
    const { id } = req.params;

    const [fields] = await pool.query(
      'SELECT * FROM fields WHERE field_id = ? AND user_id = ?',
      [id, req.user.user_id]
    );

    if (fields.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Field not found'
      });
    }

    res.json({
      success: true,
      data: fields[0]
    });
  } catch (error) {
    console.error('Get field error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Create new field
export const createField = async (req, res) => {
  try {
    const {
      field_name,
      location_latitude,
      location_longitude,
      area_size,
      area_unit,
      soil_type,
      current_crop,
      planting_date,
      expected_harvest_date
    } = req.body;

    if (!field_name || !area_size || !area_unit) {
      return res.status(400).json({
        success: false,
        message: 'Please provide field name, area size, and area unit'
      });
    }

    const [result] = await pool.query(
      `INSERT INTO fields (user_id, field_name, location_latitude, location_longitude, area_size, area_unit, soil_type, current_crop, planting_date, expected_harvest_date) 
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [req.user.user_id, field_name, location_latitude, location_longitude, area_size, area_unit, soil_type, current_crop, planting_date, expected_harvest_date]
    );

    const [fields] = await pool.query(
      'SELECT * FROM fields WHERE field_id = ?',
      [result.insertId]
    );

    res.status(201).json({
      success: true,
      message: 'Field created successfully',
      data: fields[0]
    });
  } catch (error) {
    console.error('Create field error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Update field
export const updateField = async (req, res) => {
  try {
    const { id } = req.params;
    const {
      field_name,
      location_latitude,
      location_longitude,
      area_size,
      area_unit,
      soil_type,
      current_crop,
      planting_date,
      expected_harvest_date,
      is_active
    } = req.body;

    // Check if field belongs to user
    const [existingFields] = await pool.query(
      'SELECT * FROM fields WHERE field_id = ? AND user_id = ?',
      [id, req.user.user_id]
    );

    if (existingFields.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Field not found'
      });
    }

    await pool.query(
      `UPDATE fields SET field_name = ?, location_latitude = ?, location_longitude = ?, area_size = ?, area_unit = ?, 
       soil_type = ?, current_crop = ?, planting_date = ?, expected_harvest_date = ?, is_active = ?, updated_at = NOW() 
       WHERE field_id = ?`,
      [field_name, location_latitude, location_longitude, area_size, area_unit, soil_type, current_crop, planting_date, expected_harvest_date, is_active, id]
    );

    const [fields] = await pool.query(
      'SELECT * FROM fields WHERE field_id = ?',
      [id]
    );

    res.json({
      success: true,
      message: 'Field updated successfully',
      data: fields[0]
    });
  } catch (error) {
    console.error('Update field error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};

// Delete field
export const deleteField = async (req, res) => {
  try {
    const { id } = req.params;

    const [existingFields] = await pool.query(
      'SELECT * FROM fields WHERE field_id = ? AND user_id = ?',
      [id, req.user.user_id]
    );

    if (existingFields.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Field not found'
      });
    }

    await pool.query('DELETE FROM fields WHERE field_id = ?', [id]);

    res.json({
      success: true,
      message: 'Field deleted successfully'
    });
  } catch (error) {
    console.error('Delete field error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
};
