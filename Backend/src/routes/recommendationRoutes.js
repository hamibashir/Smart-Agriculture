import express from 'express';
import { 
  getRecommendations, 
  acceptRecommendation, 
  createRecommendation 
} from '../controllers/recommendationController.js';
import { authenticateToken } from '../middleware/auth.js';

const router = express.Router();

// All routes require authentication
router.use(authenticateToken);

router.get('/:fieldId', getRecommendations);
router.put('/:id/accept', acceptRecommendation);
router.post('/', createRecommendation);

export default router;
