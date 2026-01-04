import { Router, Request, Response } from 'express';
import { authenticate, asyncHandler } from '../../middleware/index.js';

const router = Router();

// GET /api/annotations
router.get('/', authenticate, asyncHandler(async (req: Request, res: Response) => {
    res.json({ annotations: [] }); // TODO: Implement service
}));

// POST /api/annotations
router.post('/', authenticate, asyncHandler(async (req: Request, res: Response) => {
    res.status(201).json({ annotation: req.body }); // TODO: Implement service
}));

export default router;
