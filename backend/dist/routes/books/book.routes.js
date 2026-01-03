import { Router } from 'express';
import { upload, authenticate, asyncHandler } from '../../middleware/index.js';
import { BookService } from '../../services/book.service.js';
const router = Router();
/**
 * POST /api/books
 * Upload and process a new book
 */
router.post('/', authenticate, upload.single('file'), asyncHandler(async (req, res) => {
    if (!req.file) {
        res.status(400).json({ error: 'No file uploaded' });
        return;
    }
    const fileData = {
        path: req.file.path,
        filename: req.file.filename,
        originalname: req.file.originalname,
        mimetype: req.file.mimetype,
        size: req.file.size,
    };
    const book = await BookService.processBook(req.user.id, fileData);
    res.status(201).json({ book });
}));
/**
 * GET /api/books
 * List all books
 */
router.get('/', authenticate, asyncHandler(async (req, res) => {
    const { search, format, limit, offset } = req.query;
    const books = await BookService.getBooks(req.user.id, {
        search: search,
        format: format,
        limit: limit ? parseInt(limit) : undefined,
        offset: offset ? parseInt(offset) : undefined,
    });
    res.json({ books });
}));
/**
 * GET /api/books/:id
 * Get book details
 */
router.get('/:id', authenticate, asyncHandler(async (req, res) => {
    const book = await BookService.getBookById(req.user.id, req.params.id);
    if (!book) {
        res.status(404).json({ error: 'Book not found' });
        return;
    }
    res.json({ book });
}));
/**
 * PATCH /api/books/:id
 * Update book metadata
 */
router.patch('/:id', authenticate, asyncHandler(async (req, res) => {
    const { title, author, description, coverUrl } = req.body;
    const book = await BookService.updateBook(req.user.id, req.params.id, {
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
}));
/**
 * DELETE /api/books/:id
 * Delete book
 */
router.delete('/:id', authenticate, asyncHandler(async (req, res) => {
    const success = await BookService.deleteBook(req.user.id, req.params.id);
    if (!success) {
        res.status(404).json({ error: 'Book not found' });
        return;
    }
    res.json({ message: 'Book deleted successfully' });
}));
export default router;
//# sourceMappingURL=book.routes.js.map