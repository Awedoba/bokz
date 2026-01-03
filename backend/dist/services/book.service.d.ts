import { books } from '../db/schema/index.js';
export interface FileData {
    path: string;
    filename: string;
    originalname: string;
    mimetype: string;
    size: number;
}
export declare class BookService {
    /**
     * Process uploaded book file and extract metadata
     */
    static processBook(userId: string, file: FileData): Promise<{
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
    }>;
    /**
     * Parse EPUB file
     */
    private static parseEpub;
    /**
     * Parse PDF file
     */
    private static parsePdf;
    /**
     * Save cover image (process with sharp)
     */
    private static saveCoverImage;
    /**
     * Get all books for user with filtering/pagination
     */
    static getBooks(userId: string, query: {
        search?: string;
        format?: string;
        limit?: number;
        offset?: number;
    }): Promise<{
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
        readingProgress: {
            id: string;
            userId: string;
            bookId: string;
            location: string | null;
            pageNumber: number | null;
            percentage: number | null;
            timeSpentSeconds: number | null;
            lastReadAt: Date | null;
            syncedAt: Date | null;
        }[];
    }[]>;
    /**
     * Get single book details
     */
    static getBookById(userId: string, bookId: string): Promise<{
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
        readingProgress: {
            id: string;
            userId: string;
            bookId: string;
            location: string | null;
            pageNumber: number | null;
            percentage: number | null;
            timeSpentSeconds: number | null;
            lastReadAt: Date | null;
            syncedAt: Date | null;
        }[];
        bookmarks: {
            id: string;
            createdAt: Date | null;
            userId: string;
            title: string | null;
            bookId: string;
            location: string;
            pageNumber: number | null;
            note: string | null;
        }[];
    } | undefined>;
    /**
     * Update book metadata
     */
    static updateBook(userId: string, bookId: string, data: Partial<typeof books.$inferInsert>): Promise<{
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
    }>;
    /**
     * Delete book and files
     */
    static deleteBook(userId: string, bookId: string): Promise<boolean>;
}
//# sourceMappingURL=book.service.d.ts.map