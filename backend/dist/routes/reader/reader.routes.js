import { Router } from 'express';
import { authenticate, asyncHandler, validate } from '../../middleware/index.js';
import { ReaderService } from '../../services/reader.service.js';
import { z } from 'zod';
const router = Router();
// Validation Schemas
const progressSchema = z.object({
    location: z.string(),
    pageNumber: z.number().optional(),
    percentage: z.number().min(0).max(100),
    timeSpentSeconds: z.number().min(0).optional(),
});
const bookmarkSchema = z.object({
    location: z.string(),
    title: z.string().optional(),
    note: z.string().optional(),
    pageNumber: z.number().optional(),
});
const annotationSchema = z.object({
    type: z.enum(['highlight', 'underline', 'note']),
    locationStart: z.string(),
    locationEnd: z.string().optional(),
    pageNumber: z.number().optional(),
    selectedText: z.string().optional(),
    note: z.string().optional(),
    color: z.string().optional(),
});
/**
 * GET /api/reader/:bookId/progress
 * Get reading progress
 */
router.get('/:bookId/progress', authenticate, asyncHandler(async (req, res) => {
    const progress = await ReaderService.getProgress(req.user.id, req.params.bookId);
    res.json({ progress });
}));
/**
 * POST /api/reader/:bookId/progress
 * Update reading progress
 */
router.post('/:bookId/progress', authenticate, validate(progressSchema), asyncHandler(async (req, res) => {
    const progress = await ReaderService.updateProgress(req.user.id, req.params.bookId, req.body);
    res.json({ progress });
}));
/**
 * GET /api/reader/:bookId/bookmarks
 * Get bookmarks
 */
router.get('/:bookId/bookmarks', authenticate, asyncHandler(async (req, res) => {
    const bookmarks = await ReaderService.getBookmarks(req.user.id, req.params.bookId);
    res.json({ bookmarks });
}));
/**
 * POST /api/reader/:bookId/bookmarks
 * Create bookmark
 */
router.post('/:bookId/bookmarks', authenticate, validate(bookmarkSchema), asyncHandler(async (req, res) => {
    const bookmark = await ReaderService.createBookmark(req.user.id, req.params.bookId, req.body);
    res.status(201).json({ bookmark });
}));
/**
 * DELETE /api/reader/bookmarks/:id
 * Delete bookmark
 */
router.delete('/bookmarks/:id', authenticate, asyncHandler(async (req, res) => {
    await ReaderService.deleteBookmark(req.user.id, req.params.id);
    res.json({ message: 'Bookmark deleted' });
}));
/**
 * GET /api/reader/:bookId/annotations
 * Get annotations
 */
router.get('/:bookId/annotations', authenticate, asyncHandler(async (req, res) => {
    const annotations = await ReaderService.getAnnotations(req.user.id, req.params.bookId);
    res.json({ annotations });
}));
/**
 * POST /api/reader/:bookId/annotations
 * Create annotation
 */
router.post('/:bookId/annotations', authenticate, validate(annotationSchema), asyncHandler(async (req, res) => {
    const annotation = await ReaderService.createAnnotation(req.user.id, req.params.bookId, req.body);
    res.status(201).json({ annotation });
}));
/**
 * PATCH /api/reader/annotations/:id
 * Update annotation note/color
 */
router.patch('/annotations/:id', authenticate, validate(z.object({ note: z.string().optional(), color: z.string().optional() })), asyncHandler(async (req, res) => {
    const annotation = await ReaderService.updateAnnotation(req.user.id, req.params.id, req.body);
    if (!annotation) {
        res.status(404).json({ error: 'Annotation not found' });
        return;
    }
    res.json({ annotation });
}));
/**
 * DELETE /api/reader/annotations/:id
 * Delete annotation
 */
router.delete('/annotations/:id', authenticate, asyncHandler(async (req, res) => {
    await ReaderService.deleteAnnotation(req.user.id, req.params.id);
    res.json({ message: 'Annotation deleted' });
}));
export default router;
//# sourceMappingURL=reader.routes.js.map