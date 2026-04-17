import express from 'express';
import { chatWithAI } from '../controllers/chatController.js';
import { authenticateToken } from '../middleware/auth.js';

const router = express.Router();

router.use(authenticateToken);
router.post('/', chatWithAI);

export default router;
