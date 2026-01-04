import { Router, Request, Response } from 'express';
import { upload, authenticate, asyncHandler } from '../../middleware/index.js';
import { BookService, FileData } from '../../services/book.service.js';

const router = Router();

/**
 * POST /api/books
 * Upload and process a new book
 */
router.post(
    '/',
    authenticate,
    upload.single('file'),
    asyncHandler(async (req: Request, res: Response) => {
        if (!req.file) {
            res.status(400).json({ error: 'No file uploaded' });
            return;
        }

        const fileData: FileData = {
            path: req.file.path,
            filename: req.file.filename,
            originalname: req.file.originalname,
            mimetype: req.file.mimetype,
            size: req.file.size,
        };

        const book = await BookService.processBook(req.user!.id, fileData);

        res.status(201).json({ book });
    })
);

/**
 * GET /api/books
 * List all books
 */
router.get(
    '/',
    authenticate,
    asyncHandler(async (req: Request, res: Response) => {
        const { search, format, limit, offset } = req.query;

        const books = await BookService.getBooks(req.user!.id, {
            search: search as string,
            format: format as string,
            limit: limit ? parseInt(limit as string) : undefined,
            offset: offset ? parseInt(offset as string) : undefined,
        });

        res.json({ books });
    })
);

/**
 * GET /api/books/discover
 * Get books for discovery (trending, recent, etc.)
 */
router.get(
    '/discover',
    authenticate,
    asyncHandler(async (req: Request, res: Response) => {
        // For now, just return recent books. In future, implement trending logic.
        const recent = await BookService.getBooks(req.user!.id, {
            limit: 10,
            offset: 0
            // TODO: Add sort by createdAt desc to Service if not default (it is default)
        });

        // We can add more sections like "random" or "suggested" here
        res.json({
            recent: recent,
            trending: recent // Mocking trending as recent for now
        });
    })
);

/**
 * GET /api/books/:id
 * Get book details
 */
router.get(
    '/:id',
    authenticate,
    asyncHandler(async (req: Request, res: Response) => {
        const book = await BookService.getBookById(req.user!.id, req.params.id);

        if (!book) {
            res.status(404).json({ error: 'Book not found' });
            return;
        }

        res.json({ book });
    })
);

/**
 * PATCH /api/books/:id
 * Update book metadata
 */
router.patch(
    '/:id',
    authenticate,
    asyncHandler(async (req: Request, res: Response) => {
        const { title, author, description, coverUrl } = req.body;

        const book = await BookService.updateBook(req.user!.id, req.params.id, {
            title,
            author,
            description,
            coverUrl,
        });

        if (!book) {
            res.status(404).json({ error: 'Book not found' });
            return;
        }

        res.json({ book });
    })
);

/**
 * DELETE /api/books/:id
 * Delete book
 */
router.delete(
    '/:id',
    authenticate,
    asyncHandler(async (req: Request, res: Response) => {
        const success = await BookService.deleteBook(req.user!.id, req.params.id);

        if (!success) {
            res.status(404).json({ error: 'Book not found' });
            return;
        }

        res.json({ message: 'Book deleted successfully' });
    })
);

export default router;
