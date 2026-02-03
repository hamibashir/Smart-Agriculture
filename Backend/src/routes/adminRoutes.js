import express from 'express';
import { authenticateToken, requireRole } from '../middleware/auth.js';
import { getAllUsers, getAllFields, getAllSensors, getAdminStats, getAuditLogs, updateUserStatus, getSystemActivity } from '../controllers/adminController.js';

const router = express.Router();

router.use(authenticateToken, requireRole('admin'));

router.get('/users', getAllUsers);
router.get('/fields', getAllFields);
router.get('/sensors', getAllSensors);
router.get('/stats', getAdminStats);
router.get('/audit-logs', getAuditLogs);
router.get('/activity', getSystemActivity);
router.put('/users/:userId', updateUserStatus);

export default router;
