import { Router, Request, Response } from 'express';
import { authenticate, asyncHandler, validate } from '../../middleware/index.js';
import { CollectionService } from '../../services/collection.service.js';
import { z } from 'zod';

const router = Router();

const createCollectionSchema = z.object({
    name: z.string().min(1).max(50),
    description: z.string().optional(),
    color: z.string().regex(/^#[0-9A-F]{6}$/i).optional(),
});

/**
 * POST /api/collections
 * Create new collection
 */
router.post(
    '/',
    authenticate,
    validate(createCollectionSchema),
    asyncHandler(async (req: Request, res: Response) => {
        const collection = await CollectionService.createCollection(req.user!.id, req.body);
        res.status(201).json({ collection });
    })
);

/**
 * GET /api/collections
 * List all collections
 */
router.get(
    '/',
    authenticate,
    asyncHandler(async (req: Request, res: Response) => {
        const collections = await CollectionService.getCollections(req.user!.id);
        res.json({ collections });
    })
);

/**
 * GET /api/collections/:id
 * Get details
 */
router.get(
    '/:id',
    authenticate,
    asyncHandler(async (req: Request, res: Response) => {
        const collection = await CollectionService.getCollectionById(req.user!.id, req.params.id);
        if (!collection) {
            res.status(404).json({ error: 'Collection not found' });
            return;
        }
        res.json({ collection });
    })
);

/**
 * PATCH /api/collections/:id
 * Update collection
 */
router.patch(
    '/:id',
    authenticate,
    validate(createCollectionSchema.partial()),
    asyncHandler(async (req: Request, res: Response) => {
        const collection = await CollectionService.updateCollection(req.user!.id, req.params.id, req.body);
        if (!collection) {
            res.status(404).json({ error: 'Collection not found' });
            return;
        }
        res.json({ collection });
    })
);

/**
 * DELETE /api/collections/:id
 * Delete collection
 */
router.delete(
    '/:id',
    authenticate,
    asyncHandler(async (req: Request, res: Response) => {
        await CollectionService.deleteCollection(req.user!.id, req.params.id);
        res.json({ message: 'Collection deleted' });
    })
);

/**
 * POST /api/collections/:id/books
 * Add book to collection
 */
router.post(
    '/:id/books',
    authenticate,
    asyncHandler(async (req: Request, res: Response) => {
        const { bookId } = req.body;
        await CollectionService.addBookToCollection(req.user!.id, req.params.id, bookId);
        res.json({ message: 'Book added to collection' });
    })
);

/**
 * DELETE /api/collections/:id/books/:bookId
 * Remove book from collection
 */
router.delete(
    '/:id/books/:bookId',
    authenticate,
    asyncHandler(async (req: Request, res: Response) => {
        await CollectionService.removeBookFromCollection(req.user!.id, req.params.id, req.params.bookId);
        res.json({ message: 'Book removed from collection' });
    })
);

export default router;
