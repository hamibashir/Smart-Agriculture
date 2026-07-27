import pool from '../config/database.js';
import axios from 'axios';

export const chatWithAI = async (req, res) => {
  try {
    const userId = req.user.user_id;
    const { fieldId, message } = req.body;

    if (!message) {
      return res.status(400).json({ success: false, message: 'Message is required.' });
    }

    // Fetch all active fields and their sensors for the user
    const [fields] = await pool.query(`
      SELECT f.field_id, f.field_name, f.soil_type, f.current_crop, s.sensor_id 
      FROM fields f 
      JOIN sensors s ON f.field_id = s.field_id 
      WHERE f.user_id = ? AND s.is_active = TRUE
    `, [userId]);

    let contextData = "Here is the real-time data for all fields on the user's farm:\n\n";
    let hasData = false;

    // Fetch the latest reading for each active field safely
    for (const field of fields) {
      const [readings] = await pool.query(`
        SELECT soil_moisture, temperature, humidity, rainfall 
        FROM sensor_readings 
        WHERE sensor_id = ? 
        ORDER BY reading_time DESC 
        LIMIT 1
      `, [field.sensor_id]);

      if (readings.length > 0) {
        hasData = true;
        const data = readings[0];
        contextData += `Field Name: ${field.field_name}\nCurrent Crop: ${field.current_crop || 'None'}\nSoil Type: ${field.soil_type || 'Unknown'}\nMoisture: ${parseFloat(data.soil_moisture).toFixed(1)}%\nTemperature: ${parseFloat(data.temperature).toFixed(1)}°C\nHumidity: ${parseFloat(data.humidity).toFixed(1)}%\nRainfall: ${parseFloat(data.rainfall).toFixed(1)}mm\n\n`;
      }
    }

    if (!hasData) {
      contextData = "No active sensor data is currently available for any fields.";
    }

    // ==========================================
    // AGRIBOT: Google Gemini AI Integration
    // ==========================================
    const geminiApiKey = process.env.GEMINI_API_KEY || "AQ.Ab8RN6LKqTi-9IJeQfze6FFUpRGW54C88zxjjmMtFZwLoAgrvg";
    
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

    const geminiUrl = `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-lite:generateContent?key=${geminiApiKey}`;

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
