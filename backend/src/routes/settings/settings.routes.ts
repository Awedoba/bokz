import { Router, Request, Response } from 'express';
import { authenticate, asyncHandler } from '../../middleware/index.js';

const router = Router();

// GET /api/settings
router.get('/', authenticate, asyncHandler(async (req: Request, res: Response) => {
    res.json({ settings: { theme: 'system', notifications: true } }); // TODO: Implement service
}));

// PATCH /api/settings
router.patch('/', authenticate, asyncHandler(async (req: Request, res: Response) => {
    res.json({ settings: req.body }); // TODO: Implement service
}));

export default router;
