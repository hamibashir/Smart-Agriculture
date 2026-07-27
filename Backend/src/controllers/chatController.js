import pool from '../config/database.js';
import axios from 'axios';

export const chatWithAI = async (req, res) => {
  try {
    const userId = req.user.user_id;
    const { fieldId, message } = req.body;

    if (!message) {
      return res.status(400).json({ success: false, message: 'Message is required.' });
    }

    // Fetch all active fields and their latest sensor readings in ONE optimized lightweight query
    const [fieldsData] = await pool.query(`
      SELECT 
        f.field_name, 
        f.soil_type, 
        f.current_crop, 
        sr.soil_moisture, 
        sr.temperature, 
        sr.humidity, 
        sr.rainfall
      FROM fields f
      JOIN sensors s ON f.field_id = s.field_id
      LEFT JOIN (
        SELECT sensor_id, MAX(reading_time) as max_time
        FROM sensor_readings
        GROUP BY sensor_id
      ) latest_time ON s.sensor_id = latest_time.sensor_id
      LEFT JOIN sensor_readings sr ON sr.sensor_id = latest_time.sensor_id AND sr.reading_time = latest_time.max_time
      WHERE f.user_id = ? AND s.is_active = TRUE
    `, [userId]);

    let contextData = "Farm Live Context:\n";
    let hasData = false;

    for (const data of fieldsData) {
      hasData = true;
      contextData += `\n[Field: ${data.field_name}] - Crop: ${data.current_crop || 'None'}, Soil: ${data.soil_type || 'Unknown'}\n`;
      if (data.soil_moisture !== null && data.soil_moisture !== undefined) {
        contextData += `Sensors: Moisture ${parseFloat(data.soil_moisture).toFixed(1)}%, Temp ${parseFloat(data.temperature).toFixed(1)}°C, Humidity ${parseFloat(data.humidity).toFixed(1)}%, Rain ${parseFloat(data.rainfall).toFixed(1)}mm\n`;
      } else {
        contextData += `Sensors: No data available yet.\n`;
      }
    }

    if (!hasData) {
      contextData = "No active fields or sensor data available for the user.";
    }

    // ==========================================
    // AGRIBOT: Google Gemini AI Integration
    // ==========================================
    const geminiApiKey = "AQ.Ab8RN6LE2U3RmuNsZ1IMn6egKA52qqgRP8UZ_Ci3xURkKyH3yQ";
    
    if (!geminiApiKey) {
      // Graceful fallback if API key is missing
      return res.json({ 
        success: true, 
        reply: "AI is currently offline (API key is missing). Please set GEMINI_API_KEY in the environment." 
      });
    }

    const systemPrompt = `You are AgriBot, a smart AI assistant for a farmer.
You have been provided with the real-time sensor data of the farmer's fields below.
Answer the user's question accurately based ONLY on this context. 
Be concise, helpful, and strictly related to agriculture. Do not hallucinate data.

Context Data:
${contextData}

User Question: ${message}`;

    const geminiUrl = `https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-flash-lite:generateContent?key=${geminiApiKey}`;

    try {
      const aiResponse = await axios.post(geminiUrl, {
        contents: [{ parts: [{ text: systemPrompt }] }]
      });

      let reply = aiResponse.data?.candidates?.[0]?.content?.parts?.[0]?.text;

      if (!reply) {
        reply = "I'm sorry, I couldn't formulate a proper response at the moment.";
      }

      return res.json({ success: true, reply: reply.trim() });
      
    } catch (aiError) {
      // STRICT ERROR HANDLING for Digital Ocean App Platform
      // Never crash the server, gracefully fallback to a safe JSON response.
      console.error('Gemini AI API Error:', aiError.response?.data || aiError.message);
      
      return res.json({ 
        success: true, 
        reply: "I am having trouble connecting to my AI engine right now. Please try again later." 
      });
    }

  } catch (error) {
    // Top-level catch block for Database errors or unexpected issues
    console.error('Chat error:', error.message);
    res.status(500).json({ success: false, message: 'Failed to process AI chat safely.' });
  }
};
