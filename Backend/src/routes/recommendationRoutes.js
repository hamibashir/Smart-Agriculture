import express from 'express';
import { getRecommendations, acceptRecommendation, createRecommendation, deleteRecommendation, generateManualRecommendation } from '../controllers/recommendationController.js';
import { authenticateToken } from '../middleware/auth.js';

const router = express.Router();

router.use(authenticateToken);

router.get('/:fieldId', getRecommendations);
router.post('/:fieldId/generate', generateManualRecommendation); // New Route
router.put('/:id/accept', acceptRecommendation);
router.delete('/:id', deleteRecommendation);
router.post('/', createRecommendation);

export default router;
