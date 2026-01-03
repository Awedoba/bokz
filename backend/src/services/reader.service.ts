import { db } from '../db/index.js';
import { readingProgress, bookmarks, annotations, books } from '../db/schema/index.js';
import { eq, and, desc } from 'drizzle-orm';

export class ReaderService {
    /**
     * Update reading progress
     */
    static async updateProgress(userId: string, bookId: string, data: {
        location: string;
        pageNumber?: number;
        percentage: number;
        timeSpentSeconds?: number;
    }) {
        const existing = await db.query.readingProgress.findFirst({
            where: and(eq(readingProgress.userId, userId), eq(readingProgress.bookId, bookId)),
        });

        if (existing) {
            const [updated] = await db.update(readingProgress)
                .set({
                    ...data,
                    lastReadAt: new Date(),
                    // Increment time spent if provided
                    timeSpentSeconds: (existing.timeSpentSeconds || 0) + (data.timeSpentSeconds || 0)
                })
                .where(eq(readingProgress.id, existing.id))
                .returning();
            return updated;
        } else {
            const [created] = await db.insert(readingProgress).values({
                userId,
                bookId,
                location: data.location,
                pageNumber: data.pageNumber,
                percentage: data.percentage,
                timeSpentSeconds: data.timeSpentSeconds || 0,
                lastReadAt: new Date(),
            }).returning();
            return created;
        }
    }

    /**
     * Get reading progress for a book
     */
    static async getProgress(userId: string, bookId: string) {
        return db.query.readingProgress.findFirst({
            where: and(eq(readingProgress.userId, userId), eq(readingProgress.bookId, bookId)),
        });
    }

    /**
     * Create bookmark
     */
    static async createBookmark(userId: string, bookId: string, data: {
        location: string;
        title?: string;
        note?: string;
        pageNumber?: number;
    }) {
        const [bookmark] = await db.insert(bookmarks).values({
            userId,
            bookId,
            ...data,
        }).returning();
        return bookmark;
    }

    /**
     * Get bookmarks for a book
     */
    static async getBookmarks(userId: string, bookId: string) {
        return db.query.bookmarks.findMany({
            where: and(eq(bookmarks.userId, userId), eq(bookmarks.bookId, bookId)),
            orderBy: [desc(bookmarks.createdAt)],
        });
    }

    /**
     * Delete bookmark
     */
    static async deleteBookmark(userId: string, bookmarkId: string) {
        await db.delete(bookmarks)
            .where(and(eq(bookmarks.id, bookmarkId), eq(bookmarks.userId, userId)));
        return true;
    }

    /**
     * Create annotation
     */
    static async createAnnotation(userId: string, bookId: string, data: {
        type: 'highlight' | 'underline' | 'note';
        locationStart: string;
        locationEnd?: string;
        pageNumber?: number;
        selectedText?: string;
        note?: string;
        color?: string;
    }) {
        const [annotation] = await db.insert(annotations).values({
            userId,
            bookId,
            ...data,
        }).returning();
        return annotation;
    }

    /**
     * Get annotations for a book
     */
    static async getAnnotations(userId: string, bookId: string) {
        return db.query.annotations.findMany({
            where: and(eq(annotations.userId, userId), eq(annotations.bookId, bookId)),
            orderBy: [desc(annotations.createdAt)],
        });
    }

    /**
     * Delete annotation
     */
    static async deleteAnnotation(userId: string, annotationId: string) {
        await db.delete(annotations)
            .where(and(eq(annotations.id, annotationId), eq(annotations.userId, userId)));
        return true;
    }

    /**
     * Update annotation
     */
    static async updateAnnotation(userId: string, annotationId: string, data: {
        note?: string;
        color?: string;
    }) {
        const [updated] = await db.update(annotations)
            .set({ ...data, updatedAt: new Date() })
            .where(and(eq(annotations.id, annotationId), eq(annotations.userId, userId)))
            .returning();
        return updated;
    }
}
