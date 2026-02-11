import express from 'express';
import { getFields, getFieldById, createField, updateField, deleteField } from '../controllers/fieldController.js';
import { authenticateToken } from '../middleware/auth.js';

const router = express.Router();

router.use(authenticateToken);

router.get('/', getFields);
router.get('/:id', getFieldById);
router.post('/', createField);
router.put('/:id', updateField);
router.delete('/:id', deleteField);

export default router;
