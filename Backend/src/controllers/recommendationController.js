import pool from '../config/database.js';

const verifyFieldOwnership = async (fieldId, userId) => {
  const [[field]] = await pool.query('SELECT field_id FROM fields WHERE field_id = ? AND user_id = ?', [fieldId, userId]);
  return field;
};

// Get crop recommendations for a field
export const getRecommendations = async (req, res) => {
  try {
    const { fieldId } = req.params;

    if (!await verifyFieldOwnership(fieldId, req.user.user_id)) {
      return res.status(404).json({ success: false, message: 'Field not found' });
    }

    const [recommendations] = await pool.query(
      'SELECT * FROM crop_recommendations WHERE field_id = ? ORDER BY created_at DESC',
      [fieldId]
    );

    res.json({ success: true, data: recommendations });
  } catch (error) {
    console.error('Get recommendations error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

// Accept recommendation
export const acceptRecommendation = async (req, res) => {
  try {
    const [[recommendation]] = await pool.query(
      `SELECT cr.recommendation_id FROM crop_recommendations cr
       JOIN fields f ON cr.field_id = f.field_id
       WHERE cr.recommendation_id = ? AND f.user_id = ?`,
      [req.params.id, req.user.user_id]
    );

    if (!recommendation) {
      return res.status(404).json({ success: false, message: 'Recommendation not found' });
    }

    await pool.query(
      'UPDATE crop_recommendations SET is_accepted = TRUE, accepted_at = NOW() WHERE recommendation_id = ?',
      [req.params.id]
    );

    res.json({ success: true, message: 'Recommendation accepted successfully' });
  } catch (error) {
    console.error('Accept recommendation error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

// Create recommendation (for ML service)
export const createRecommendation = async (req, res) => {
  try {
    const { field_id, recommended_crop, confidence_score, soil_moisture_avg, temperature_avg, humidity_avg, soil_type, season, expected_yield, water_requirement, growth_duration_days, recommendation_reason, model_version } = req.body;

    const [result] = await pool.query(
      `INSERT INTO crop_recommendations (field_id, recommended_crop, confidence_score, soil_moisture_avg, temperature_avg, humidity_avg, soil_type, season, expected_yield, water_requirement, growth_duration_days, recommendation_reason, model_version) 
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [field_id, recommended_crop, confidence_score, soil_moisture_avg, temperature_avg, humidity_avg, soil_type, season, expected_yield, water_requirement, growth_duration_days, recommendation_reason, model_version]
    );

    const [[recommendation]] = await pool.query('SELECT * FROM crop_recommendations WHERE recommendation_id = ?', [result.insertId]);
    res.status(201).json({ success: true, message: 'Recommendation created successfully', data: recommendation });
  } catch (error) {
    console.error('Create recommendation error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};
