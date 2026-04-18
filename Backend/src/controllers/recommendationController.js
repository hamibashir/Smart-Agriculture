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
      `SELECT cr.recommendation_id, cr.field_id, cr.recommended_crop 
       FROM crop_recommendations cr
       JOIN fields f ON cr.field_id = f.field_id
       WHERE cr.recommendation_id = ? AND f.user_id = ?`,
      [req.params.id, req.user.user_id]
    );

    if (!recommendation) {
      return res.status(404).json({ success: false, message: 'Recommendation not found' });
    }

    // 1. Mark recommendation as accepted
    await pool.query(
      'UPDATE crop_recommendations SET is_accepted = TRUE, accepted_at = NOW() WHERE recommendation_id = ?',
      [req.params.id]
    );

    // 2. Automatically update the field's crop type based on the AI's intelligence!
    await pool.query(
      'UPDATE fields SET current_crop = ? WHERE field_id = ?',
      [recommendation.recommended_crop, recommendation.field_id]
    );

    res.json({ 
      success: true, 
      message: `Recommendation accepted. Field successfully updated to grow ${recommendation.recommended_crop}!` 
    });
  } catch (error) {
    console.error('Accept recommendation error:', error);
    res.status(500).json({ success: false, message: 'Server error' });
  }
};

// Delete a recommendation
export const deleteRecommendation = async (req, res) => {
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

    await pool.query('DELETE FROM crop_recommendations WHERE recommendation_id = ?', [req.params.id]);

    res.json({ success: true, message: 'Recommendation deleted successfully' });
  } catch (error) {
    console.error('Delete recommendation error:', error);
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

// Generate manual recommendation from Flutter App explicit request
export const generateManualRecommendation = async (req, res) => {
  try {
    const { fieldId } = req.params;
    const { season } = req.body; 

    if (!season || !['kharif', 'rabi'].includes(season)) {
       return res.status(400).json({ success: false, message: 'Invalid season. Must be kharif or rabi.' });
    }

    if (!await verifyFieldOwnership(fieldId, req.user.user_id)) {
      return res.status(404).json({ success: false, message: 'Field not found' });
    }

    const [[field]] = await pool.query('SELECT soil_type FROM fields WHERE field_id = ?', [fieldId]);
    const soilTypeStr = (field.soil_type || 'loamy').toLowerCase().replace(' ', '_');

    const [readings] = await pool.query(
      `SELECT 
        AVG(soil_moisture) AS soil_moisture,
        AVG(temperature)   AS temperature,
        AVG(humidity)      AS humidity
       FROM (
         SELECT soil_moisture, temperature, humidity
         FROM sensor_readings sr
         JOIN sensors s ON sr.sensor_id = s.sensor_id
         WHERE s.field_id = ?
         ORDER BY reading_time DESC
         LIMIT 50
       ) AS recent`,
      [fieldId]
    );

    const avg = readings[0];
    if (avg.soil_moisture == null) {
       return res.status(400).json({ success: false, message: 'No sensor data available for this field to analyze.' });
    }

    const AI_API_URL = process.env.AI_API_URL || 'http://localhost:5001';

    const response = await fetch(`${AI_API_URL}/predict`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        soil_moisture: parseFloat(avg.soil_moisture).toFixed(2),
        temperature: parseFloat(avg.temperature).toFixed(2),
        humidity: parseFloat(avg.humidity).toFixed(2),
        soil_type: soilTypeStr,
        season: season
      })
    });

    if (!response.ok) throw new Error('AI API Engine could not be reached.');
    
    const aiResult = await response.json();
    if (!aiResult.success) throw new Error('AI logic failed to predict crop.');

    await pool.query(
      `INSERT INTO crop_recommendations 
        (field_id, recommended_crop, confidence_score, soil_moisture_avg, temperature_avg, 
         humidity_avg, soil_type, season, expected_yield, water_requirement, 
         growth_duration_days, recommendation_reason, model_version)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        fieldId, aiResult.recommended_crop, aiResult.confidence_score, 
        avg.soil_moisture, avg.temperature, avg.humidity, field.soil_type, 
        season, aiResult.expected_yield, aiResult.water_requirement, 
        aiResult.growth_duration_days, aiResult.recommendation_reason, aiResult.model_version
      ]
    );

    res.json({ success: true, message: 'Recommendation generated successfully for ' + season });
  } catch (error) {
    console.error('Manual recommend error:', error);
    res.status(500).json({ success: false, message: error.message });
  }
};
