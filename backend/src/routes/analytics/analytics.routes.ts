import { Router, Request, Response } from 'express';
import { authenticate, asyncHandler } from '../../middleware/index.js';
import { db } from '../../db/index.js';
import { readingSessions, books, readingProgress } from '../../db/schema/index.js';
import { eq, sum, count, desc, and, gte } from 'drizzle-orm';

const router = Router();

// GET /api/analytics
router.get('/', authenticate, asyncHandler(async (req: Request, res: Response) => {
    const userId = req.user!.id;

    // 1. Total Books Read (progress >= 100 or close)
    // Actually readingProgress has percentage. Let's say > 95% is read.
    const booksReadResult = await db.select({ count: count() })
        .from(readingProgress)
        .where(
            and(
                eq(readingProgress.userId, userId),
                gte(readingProgress.percentage, 95)
            )
        );
    const booksRead = booksReadResult[0]?.count || 0;

    // 2. Total Time Spent & Pages Read (from sessions)
    const sessionStats = await db.select({
        totalPages: sum(readingSessions.pagesRead),
        totalTime: sum(readingSessions.durationSeconds)
    })
        .from(readingSessions)
        .where(eq(readingSessions.userId, userId));

    const totalPages = Number(sessionStats[0]?.totalPages) || 0;
    const totalTimeSeconds = Number(sessionStats[0]?.totalTime) || 0;
    const totalHours = Math.round(totalTimeSeconds / 3600);

    // 3. Recent Sessions (for chart/list) - limit 7 days
    const recentSessions = await db.select()
        .from(readingSessions)
        .where(eq(readingSessions.userId, userId))
        .orderBy(desc(readingSessions.sessionDate))
        .limit(7);

    res.json({
        stats: {
            booksRead,
            pagesRead: totalPages,
            timeSpent: totalHours, // in hours
            streak: 0, // TODO: Implement streak calculation logic
        },
        recentSessions
    });
}));

export default router;
