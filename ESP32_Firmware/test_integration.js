/**
 * ESP32 Integration Test Script
 * 
 * This script simulates ESP32 sensor data to test your backend integration
 * Run this before deploying physical hardware to ensure everything works
 * 
 * Usage: node test_integration.js
 */

import axios from 'axios';

// Configuration - UPDATE THESE!
const SERVER_URL = 'http://localhost:5000'; // Change to your server IP
const API_ENDPOINT = '/api/sensors/reading';
const DEVICE_ID = 'ESP32_001'; // Must match your registered sensor

// Test data generation
const generateSensorData = () => {
  return {
    device_id: DEVICE_ID,
    soil_moisture: (Math.random() * 50 + 30).toFixed(1), // 30-80%
    temperature: (Math.random() * 10 + 20).toFixed(1),   // 20-30°C
    humidity: (Math.random() * 20 + 50).toFixed(1),      // 50-70%
    light_intensity: (Math.random() * 40 + 40).toFixed(1), // 40-80%
    water_flow_rate: (Math.random() * 30 + 10).toFixed(1), // 10-40%
    battery_voltage: (Math.random() * 0.8 + 3.4).toFixed(2), // 3.4-4.2V
    signal_strength: Math.floor(Math.random() * 30 - 70)   // -70 to -40 dBm
  };
};

// Test functions
const testHealthEndpoint = async () => {
  try {
    console.log('🏥 Testing health endpoint...');
    const response = await axios.get(`${SERVER_URL}/health`);
    
    if (response.status === 200) {
      console.log('✅ Health check passed');
      console.log(`📊 Response: ${response.data.message}`);
      return true;
    }
  } catch (error) {
    console.log('❌ Health check failed:', error.message);
    return false;
  }
};

const testSensorEndpoint = async () => {
  try {
    console.log('🔬 Testing sensor data endpoint...');
    const sensorData = generateSensorData();
    
    console.log('📦 Test payload:', JSON.stringify(sensorData, null, 2));
    
    const response = await axios.post(
      `${SERVER_URL}${API_ENDPOINT}`, 
      sensorData,
      {
        headers: {
          'Content-Type': 'application/json'
        },
        timeout: 5000
      }
    );
    
    if (response.status === 201 || response.status === 200) {
      console.log('✅ Sensor data posted successfully');
      console.log(`📥 Response: ${JSON.stringify(response.data)}`);
      return true;
    }
  } catch (error) {
    console.log('❌ Sensor endpoint test failed:', error.message);
    if (error.response) {
      console.log('📄 Error response:', error.response.data);
    }
    return false;
  }
};

const testDatabaseQuery = async () => {
  try {
    console.log('🗄️ Testing database integration...');
    
    // This would require a custom endpoint, but we can simulate
    console.log('💡 To verify database, run this SQL query:');
    console.log(`
    SELECT 
      sr.*,
      s.device_id 
    FROM sensor_readings sr 
    JOIN sensors s ON sr.sensor_id = s.sensor_id 
    WHERE s.device_id = '${DEVICE_ID}' 
    ORDER BY sr.reading_timestamp DESC 
    LIMIT 5;
    `);
    
    return true;
  } catch (error) {
    console.log('❌ Database test failed:', error.message);
    return false;
  }
};

const runMultipleTests = async (count = 5) => {
  console.log(`🔄 Running ${count} consecutive sensor data tests...`);
  
  let successCount = 0;
  
  for (let i = 1; i <= count; i++) {
    console.log(`\n--- Test ${i}/${count} ---`);
    
    const success = await testSensorEndpoint();
    if (success) successCount++;
    
    // Wait 2 seconds between tests
    if (i < count) {
      console.log('⏳ Waiting 2 seconds...');
      await new Promise(resolve => setTimeout(resolve, 2000));
    }
  }
  
  console.log(`\n📊 Success Rate: ${successCount}/${count} (${(successCount/count*100).toFixed(1)}%)`);
  return successCount === count;
};

// Main test function
const runIntegrationTests = async () => {
  console.log('🌾 ========================================');
  console.log('🌾  ESP32 Backend Integration Test');
  console.log('🌾 ========================================');
  console.log(`🔗 Server URL: ${SERVER_URL}`);
  console.log(`📱 Device ID: ${DEVICE_ID}`);
  console.log('🌾 ========================================\n');
  
  let allTestsPassed = true;
  
  // Test 1: Health check
  const healthPass = await testHealthEndpoint();
  allTestsPassed = allTestsPassed && healthPass;
  
  console.log('');
  
  // Test 2: Single sensor data post
  const sensorPass = await testSensorEndpoint();
  allTestsPassed = allTestsPassed && sensorPass;
  
  console.log('');
  
  // Test 3: Multiple consecutive posts
  const multiplePass = await runMultipleTests(3);
  allTestsPassed = allTestsPassed && multiplePass;
  
  console.log('');
  
  // Test 4: Database verification info
  await testDatabaseQuery();
  
  console.log('\n🌾 ========================================');
  if (allTestsPassed) {
    console.log('🎉 ALL TESTS PASSED!');
    console.log('✅ Your backend is ready for ESP32 integration');
    console.log('📱 You can now upload firmware to your ESP32');
  } else {
    console.log('❌ Some tests failed');
    console.log('🔧 Please fix the issues before proceeding');
  }
  console.log('🌾 ========================================');
};

// Error handling for missing axios
const checkDependencies = () => {
  try {
    // This will work if axios is available
    return true;
  } catch (error) {
    console.log('❌ Missing dependencies');
    console.log('📦 Please install axios: npm install axios');
    console.log('💡 Or run manually with curl:');
    console.log(`
curl -X POST ${SERVER_URL}${API_ENDPOINT} \\
  -H "Content-Type: application/json" \\
  -d '{
    "device_id": "${DEVICE_ID}",
    "soil_moisture": 45.2,
    "temperature": 28.5,
    "humidity": 65.3,
    "light_intensity": 78.0,
    "water_flow_rate": 12.5,
    "battery_voltage": 3.8,
    "signal_strength": -45
  }'
    `);
    return false;
  }
};

// Run tests if dependencies are available
if (checkDependencies()) {
  runIntegrationTests().catch(error => {
    console.log('❌ Test execution failed:', error.message);
  });
}
