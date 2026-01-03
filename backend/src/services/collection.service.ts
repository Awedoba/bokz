import { db } from '../db/index.js';
import { collections, bookCollections, books } from '../db/schema/index.js';
import { eq, and, desc } from 'drizzle-orm';
import { nanoid } from 'nanoid';

export class CollectionService {
    /**
     * Create a new collection
     */
    static async createCollection(userId: string, data: { name: string; description?: string; color?: string }) {
        const [collection] = await db.insert(collections).values({
            userId,
            name: data.name,
            description: data.description,
            color: data.color,
        }).returning();
        return collection;
    }

    /**
     * Get all collections for user
     */
    static async getCollections(userId: string) {
        return db.query.collections.findMany({
            where: eq(collections.userId, userId),
            orderBy: [desc(collections.createdAt)],
            with: {
                bookCollections: {
                    with: {
                        book: true
                    }
                }
            }
        });
    }

    /**
     * Get single collection details
     */
    static async getCollectionById(userId: string, collectionId: string) {
        return db.query.collections.findFirst({
            where: and(eq(collections.id, collectionId), eq(collections.userId, userId)),
            with: {
                bookCollections: {
                    with: {
                        book: true
                    }
                }
            }
        });
    }

    /**
     * Update collection
     */
    static async updateCollection(userId: string, collectionId: string, data: Partial<typeof collections.$inferInsert>) {
        const [updated] = await db.update(collections)
            .set({ ...data, updatedAt: new Date() })
            .where(and(eq(collections.id, collectionId), eq(collections.userId, userId)))
            .returning();
        return updated;
    }

    /**
     * Delete collection
     */
    static async deleteCollection(userId: string, collectionId: string) {
        await db.delete(collections)
            .where(and(eq(collections.id, collectionId), eq(collections.userId, userId)));
        return true;
    }

    /**
     * Add book to collection
     */
    static async addBookToCollection(userId: string, collectionId: string, bookId: string) {
        // Verify ownership
        const collection = await this.getCollectionById(userId, collectionId);
        if (!collection) throw new Error('Collection not found');

        await db.insert(bookCollections).values({
            collectionId,
            bookId,
        }).onConflictDoNothing();

        return true;
    }

    /**
     * Remove book from collection
     */
    static async removeBookFromCollection(userId: string, collectionId: string, bookId: string) {
        // Verify ownership
        const collection = await this.getCollectionById(userId, collectionId);
        if (!collection) throw new Error('Collection not found');

        await db.delete(bookCollections)
            .where(and(eq(bookCollections.collectionId, collectionId), eq(bookCollections.bookId, bookId)));

        return true;
    }
}
