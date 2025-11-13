import express from 'express';
import { authenticateToken } from '../middleware/auth.js';
import {
  getAllUsers,
  getAllFields,
  getAllSensors,
  getAdminStats,
  getAuditLogs,
  updateUserStatus,
  getSystemActivity
} from '../controllers/adminController.js';

const router = express.Router();

// Middleware to check if user is admin
const requireAdmin = (req, res, next) => {
  if (req.user.role !== 'admin') {
    return res.status(403).json({
      success: false,
      message: 'Access denied. Admin privileges required.'
    });
  }
  next();
};

// All routes require authentication and admin role
router.use(authenticateToken);
router.use(requireAdmin);

// Admin routes
router.get('/users', getAllUsers);
router.get('/fields', getAllFields);
router.get('/sensors', getAllSensors);
router.get('/stats', getAdminStats);
router.get('/audit-logs', getAuditLogs);
router.get('/activity', getSystemActivity);
router.put('/users/:userId', updateUserStatus);

export default router;
