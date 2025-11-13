import express from 'express';
import { 
  getIrrigationLogs, 
  startIrrigation, 
  stopIrrigation,
  getSchedules,
  createSchedule
} from '../controllers/irrigationController.js';
import { authenticateToken } from '../middleware/auth.js';

const router = express.Router();

// All routes require authentication
router.use(authenticateToken);

router.get('/logs/:fieldId', getIrrigationLogs);
router.post('/start', startIrrigation);
router.post('/stop', stopIrrigation);
router.get('/schedules/:fieldId', getSchedules);
router.post('/schedules', createSchedule);

export default router;
