import express from 'express';
import {
  getSensorsByField,
  getSensorReadings,
  getLatestReading,
  createSensorReading,
  createSensor,
  updateSensor
} from '../controllers/sensorController.js';
import { authenticateToken } from '../middleware/auth.js';

const router = express.Router();

// Public route for ESP32/IoT devices to post readings
router.post('/reading', createSensorReading);

// Protected routes
router.use(authenticateToken);

router.get('/field/:fieldId', getSensorsByField);
router.get('/:sensorId/readings', getSensorReadings);
router.get('/:sensorId/latest', getLatestReading);
router.post('/', createSensor);
router.put('/:sensorId', updateSensor);

export default router;
