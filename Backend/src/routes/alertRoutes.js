import express from 'express';
import { 
  getAlerts, 
  markAsRead, 
  markAsResolved, 
  createAlert,
  getUnreadCount 
} from '../controllers/alertController.js';
import { authenticateToken } from '../middleware/auth.js';

const router = express.Router();

// All routes require authentication
router.use(authenticateToken);

router.get('/', getAlerts);
router.get('/unread-count', getUnreadCount);
router.put('/:id/read', markAsRead);
router.put('/:id/resolve', markAsResolved);
router.post('/', createAlert);

export default router;
