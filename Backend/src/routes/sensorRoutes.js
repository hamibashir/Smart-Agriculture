import express from 'express';
import { getSensorsByField, getSensorReadings, getLatestReading, createSensorReadingSharedDemo, createSensorSharedDemo, updateSensor } from '../controllers/sensorController.js';
import { authenticateToken } from '../middleware/auth.js';

const router = express.Router();

// Public route for ESP32/IoT devices
router.post('/reading', createSensorReadingSharedDemo);

// Protected routes
router.use(authenticateToken);
router.get('/field/:fieldId', getSensorsByField);
router.get('/:sensorId/readings', getSensorReadings);
router.get('/:sensorId/latest', getLatestReading);
router.post('/', createSensorSharedDemo);
router.put('/:sensorId', updateSensor);

export default router;
