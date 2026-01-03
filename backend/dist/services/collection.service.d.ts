import { collections } from '../db/schema/index.js';
export declare class CollectionService {
    /**
     * Create a new collection
     */
    static createCollection(userId: string, data: {
        name: string;
        description?: string;
        color?: string;
    }): Promise<{
        id: string;
        name: string;
        createdAt: Date | null;
        updatedAt: Date | null;
        description: string | null;
        userId: string;
        color: string | null;
        sortOrder: number | null;
    }>;
    /**
     * Get all collections for user
     */
    static getCollections(userId: string): Promise<{
        id: string;
        name: string;
        createdAt: Date | null;
        updatedAt: Date | null;
        description: string | null;
        userId: string;
        color: string | null;
        sortOrder: number | null;
        bookCollections: {
            bookId: string;
            collectionId: string;
            addedAt: Date | null;
            book: {
                id: string;
                createdAt: Date | null;
                updatedAt: Date | null;
                description: string | null;
                userId: string;
                title: string;
                author: string | null;
                coverUrl: string | null;
                filePath: string;
                format: string;
                fileSize: number | null;
                totalPages: number | null;
                metadata: import("../db/schema/index.js").BookMetadata | null;
            };
        }[];
    }[]>;
    /**
     * Get single collection details
     */
    static getCollectionById(userId: string, collectionId: string): Promise<{
        id: string;
        name: string;
        createdAt: Date | null;
        updatedAt: Date | null;
        description: string | null;
        userId: string;
        color: string | null;
        sortOrder: number | null;
        bookCollections: {
            bookId: string;
            collectionId: string;
            addedAt: Date | null;
            book: {
                id: string;
                createdAt: Date | null;
                updatedAt: Date | null;
                description: string | null;
                userId: string;
                title: string;
                author: string | null;
                coverUrl: string | null;
                filePath: string;
                format: string;
                fileSize: number | null;
                totalPages: number | null;
                metadata: import("../db/schema/index.js").BookMetadata | null;
            };
        }[];
    } | undefined>;
    /**
     * Update collection
     */
    static updateCollection(userId: string, collectionId: string, data: Partial<typeof collections.$inferInsert>): Promise<{
        id: string;
        name: string;
        createdAt: Date | null;
        updatedAt: Date | null;
        description: string | null;
        userId: string;
        color: string | null;
        sortOrder: number | null;
    }>;
    /**
     * Delete collection
     */
    static deleteCollection(userId: string, collectionId: string): Promise<boolean>;
    /**
     * Add book to collection
     */
    static addBookToCollection(userId: string, collectionId: string, bookId: string): Promise<boolean>;
    /**
     * Remove book from collection
     */
    static removeBookFromCollection(userId: string, collectionId: string, bookId: string): Promise<boolean>;
}
//# sourceMappingURL=collection.service.d.ts.map