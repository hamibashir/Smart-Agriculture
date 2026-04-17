import pool from '../config/database.js';
import axios from 'axios';

export const chatWithAI = async (req, res) => {
  try {
    const userId = req.user.user_id;
    const { fieldId, message } = req.body;

    if (!message) {
      return res.status(400).json({ success: false, message: 'Message is required.' });
    }

    // Get the specified field or the latest active field
    let sensorQuery = `
       SELECT sr.soil_moisture, sr.temperature, sr.humidity, sr.rainfall, f.field_name, f.soil_type, f.current_crop
       FROM sensor_readings sr
       JOIN sensors s ON sr.sensor_id = s.sensor_id
       JOIN fields f ON s.field_id = f.field_id
       WHERE f.user_id = ? AND s.is_active = TRUE
    `;
    const queryParams = [userId];

    if (fieldId) {
       sensorQuery += ` AND f.field_id = ?`;
       queryParams.push(fieldId);
    }
    sensorQuery += ` ORDER BY sr.reading_time DESC LIMIT 1`;

    const [sensorReading] = await pool.query(sensorQuery, queryParams);

    let contextData = "No active sensor data available for the farm right now.";
    if (sensorReading.length > 0) {
      const data = sensorReading[0];
      contextData = `
        Field Name: ${data.field_name}
        Current Crop: ${data.current_crop || 'None'}
        Soil Type: ${data.soil_type || 'Unknown'}
        Current Soil Moisture: ${parseFloat(data.soil_moisture).toFixed(1)}%
        Current Temperature: ${parseFloat(data.temperature).toFixed(1)}°C
        Current Humidity: ${parseFloat(data.humidity).toFixed(1)}%
        Latest Rainfall: ${parseFloat(data.rainfall).toFixed(1)}mm
      `;
    }

    // ==========================================
    // AGRIBOT: Local AI Engine (100% Offline)
    // ==========================================
    // The panel presentation requires a 100% reliable local AI that doesn't 
    // depend on internet or a potentially rate-limited Gemini API.
    
    let reply = "";
    const msgLower = message.toLowerCase();

    // 1. Basic Greetings & Help
    if (msgLower === "hi" || msgLower === "hello" || msgLower.includes("help") || msgLower === "hey") {
      reply = "Hello! I am AgriBot, your smart assistant. I can help you monitor field sensors, decide when to run the water pump, and recommend crops based on your soil and weather. Ask me anything!";
    } 
    // 2. Data Present
    else if (sensorReading.length > 0) {
      const { soil_moisture, temperature, humidity, rainfall, field_name, soil_type, current_crop } = sensorReading[0];
      const moisture = parseFloat(soil_moisture);
      const temp = parseFloat(temperature);
      const hum = parseFloat(humidity);

      // Irrigation & Drought Logic
      if (msgLower.includes("water") || msgLower.includes("pump") || msgLower.includes("irrigation") || msgLower.includes("dry")) {
        if (moisture < 30) {
          reply = `🚨 URGENT: Your soil moisture in ${field_name} is critically low at ${moisture}%. Turn the water pump ON immediately to prevent crop damage to your ${current_crop || 'field'}.`;
        } else if (moisture >= 30 && moisture < 60) {
          reply = `The moisture level is moderate (${moisture}%). If you are growing a high-water crop like Rice, consider irrigating soon. For regular crops, no immediate action is needed.`;
        } else {
          reply = `✅ Your field is well-hydrated! Moisture is at a healthy ${moisture}%. Do NOT turn on the pump, as overwatering can cause root rot.`;
        }
      } 
      // Temperature / Heat Logic
      else if (msgLower.includes("hot") || msgLower.includes("heat") || msgLower.includes("temperature")) {
         if (temp > 35) reply = `🌡️ Yes, your field is very hot right now at ${temp}°C. If moisture is low, crops will suffer heat stress quickly. Keep your soil hydrated!`;
         else if (temp < 10) reply = `❄️ It is quite cold at ${temp}°C. Monitor for frost if you are growing sensitive crops.`;
         else reply = `The temperature is optimal at ${temp}°C. Your crops should be comfortable.`;
      }
      // Humidity Logic
      else if (msgLower.includes("humid")) {
         if (hum > 70) reply = `☁️ Humidity is high at ${hum}%. Be cautious, as high humidity increases the risk of fungal diseases. Ensure good airflow if possible.`;
         else if (hum < 30) reply = `Humidity is low at ${hum}%. The air is dry, which can increase the water demand of your crops.`;
         else reply = `Humidity is absolutely perfect at ${hum}%.`;
      }
      // Rain Logic
      else if (msgLower.includes("rain")) {
         if (rainfall > 0) reply = `🌧️ Yes, sensors detect a rainfall intensity of ${parseFloat(rainfall).toFixed(1)}mm. The pump should remain OFF to save water.`;
         else reply = `No rainfall detected in ${field_name} currently. You will need to rely on the water pump if moisture drops.`;
      }
      // Soil Type Logic
      else if (msgLower.includes("soil type") || msgLower.includes("type of soil") || msgLower.includes("my soil")) {
         reply = `Your registered soil type for ${field_name} is ${soil_type ? soil_type.toUpperCase() : 'Unknown'}.`;
      }
      // Specific Crop Queries (Wheat, Rice, Cotton)
      else if (msgLower.includes("wheat")) {
         if (temp > 25) reply = `Wheat prefers cooler winter temperatures (Rabi season). With current temp at ${temp}°C, growing wheat might lead to early heading or poor yields. Wait for cooler patterns.`;
         else reply = `Yes! Wheat thrives in cooler temperatures like your current ${temp}°C. It is an excellent Rabi crop choice.`;
      }
      else if (msgLower.includes("rice")) {
         reply = `Rice requires heavily flooded conditions and 'High' water availability. With your current moisture at ${moisture}% and ${soil_type || 'your'} soil, only proceed if you can guarantee consistent irrigation throughout the Kharif season.`;
      }
      else if (msgLower.includes("cotton")) {
         if (temp < 20) reply = `Cotton requires intense heat and sunlight (Kharif season). Current temp is too low at ${temp}°C.`;
         else reply = `Cotton is a highly profitable Kharif crop and loves the heat! At ${temp}°C, it would thrive. However, monitor pests like whitefly.`;
      }
      // General Crop Recommendation Logic
      else if (msgLower.includes("crop") || msgLower.includes("grow") || msgLower.includes("recommend") || msgLower.includes("season")) {
        let bestCrops = "";
        if (temp > 25) bestCrops = "Cotton or Maize (Kharif Season crops)";
        if (temp <= 25) bestCrops = "Wheat, Mustard, or Chickpeas (Rabi Season crops)";
        
        reply = `Based on your local ${soil_type || 'loamy'} soil and current temperature of ${temp}°C, the best crops to grow right now would be ${bestCrops}. For mathematical predictions, hit the blue "Predict" button!`;
      } 
      // Environment / Weather / Health Logic
      else if (msgLower.includes("health") || msgLower.includes("condition") || msgLower.includes("weather") || msgLower.includes("status") || msgLower.includes("report")) {
        reply = `Farm Status (${field_name}):\n🌡️ Temp: ${temp}°C\n💧 Moisture: ${moisture}%\n☁️ Humidity: ${hum}%\n🌧️ Rain: ${rainfall > 0 ? 'Yes' : 'No'}\nOverall, ${temp > 35 ? 'it is extremely hot, protect your crops' : temp < 10 ? 'it is quite cold, monitor for frost' : 'the weather is optimal for routine farming'}.`;
      }
      // Specific crop inquiry
      else if (msgLower.includes(current_crop?.toLowerCase() || 'missing_crop')) {
         reply = `Your current crop is ${current_crop}. With the moisture at ${moisture}% and temperature at ${temp}°C, ${moisture < 40 ? 'it needs water soon.' : 'it is growing in optimal conditions.'}`;
      }
      // Fallback AI parsing
      else {
        reply = `I am analyzing live data from "${field_name}". (Moisture: ${moisture}%, Temp: ${temp}°C). Try asking me about watering schedules, crop recommendations, or field health!`;
      }
    } 
    // 3. No Data Present
    else {
       if (msgLower.includes("water") || msgLower.includes("pump")) {
           reply = "I cannot see any active sensors. Generally in Pakistan, water crops when the top 3 inches of soil feel dry.";
       } else if (msgLower.includes("crop")) {
           reply = "Without sensor data, a general Pakistani rule: plant Wheat in winter (Rabi) and Cotton or Rice in summer (Kharif).";
       } else {
           reply = "I cannot see any live sensor data right now. Please ensure your ESP32 hardware is active on this field.";
       }
    }

    // Fast robust execution completed. Add minimal delay to feel natural.
    await new Promise(resolve => setTimeout(resolve, 800));
    return res.json({ success: true, reply });

  } catch (error) {
    console.error('Chat error:', error.response?.data || error.message);
    res.status(500).json({ success: false, message: 'Failed to process AI chat. Please try again.' });
  }
};
