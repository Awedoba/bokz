import { Router, Request, Response } from 'express';
import { authenticate, asyncHandler } from '../../middleware/index.js';

const router = Router();

// GET /api/analytics
router.get('/', authenticate, asyncHandler(async (req: Request, res: Response) => {
    res.json({ stats: { booksRead: 0, pagesRead: 0, timeSpent: 0 } }); // TODO: Implement service
}));

export default router;
