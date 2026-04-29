import express from 'express';
import { getSensorsByField, getSensorReadings, getLatestReading, createSensorReadingSharedDemo, createSensorSharedDemo, updateSensor, getPumpCommand } from '../controllers/sensorController.js';
import { authenticateToken } from '../middleware/auth.js';

const router = express.Router();

// Public routes for ESP32/IoT devices (no auth required)
router.post('/reading', createSensorReadingSharedDemo);  // Full sensor upload (30s)
router.get('/command/:deviceId', getPumpCommand);         // Lightweight command poll (5s)

// Protected routes
router.use(authenticateToken);
router.get('/field/:fieldId', getSensorsByField);
router.get('/:sensorId/readings', getSensorReadings);
router.get('/:sensorId/latest', getLatestReading);
router.post('/', createSensorSharedDemo);
router.put('/:sensorId', updateSensor);

export default router;
