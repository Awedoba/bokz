export declare class ReaderService {
    /**
     * Update reading progress
     */
    static updateProgress(userId: string, bookId: string, data: {
        location: string;
        pageNumber?: number;
        percentage: number;
        timeSpentSeconds?: number;
    }): Promise<{
        id: string;
        userId: string;
        bookId: string;
        location: string | null;
        pageNumber: number | null;
        percentage: number | null;
        timeSpentSeconds: number | null;
        lastReadAt: Date | null;
        syncedAt: Date | null;
    }>;
    /**
     * Get reading progress for a book
     */
    static getProgress(userId: string, bookId: string): Promise<{
        id: string;
        userId: string;
        bookId: string;
        location: string | null;
        pageNumber: number | null;
        percentage: number | null;
        timeSpentSeconds: number | null;
        lastReadAt: Date | null;
        syncedAt: Date | null;
    } | undefined>;
    /**
     * Create bookmark
     */
    static createBookmark(userId: string, bookId: string, data: {
        location: string;
        title?: string;
        note?: string;
        pageNumber?: number;
    }): Promise<{
        id: string;
        createdAt: Date | null;
        userId: string;
        title: string | null;
        bookId: string;
        location: string;
        pageNumber: number | null;
        note: string | null;
    }>;
    /**
     * Get bookmarks for a book
     */
    static getBookmarks(userId: string, bookId: string): Promise<{
        id: string;
        createdAt: Date | null;
        userId: string;
        title: string | null;
        bookId: string;
        location: string;
        pageNumber: number | null;
        note: string | null;
    }[]>;
    /**
     * Delete bookmark
     */
    static deleteBookmark(userId: string, bookmarkId: string): Promise<boolean>;
    /**
     * Create annotation
     */
    static createAnnotation(userId: string, bookId: string, data: {
        type: 'highlight' | 'underline' | 'note';
        locationStart: string;
        locationEnd?: string;
        pageNumber?: number;
        selectedText?: string;
        note?: string;
        color?: string;
    }): Promise<{
        id: string;
        createdAt: Date | null;
        updatedAt: Date | null;
        userId: string;
        metadata: import("../db/schema/index.js").AnnotationMetadata | null;
        color: string | null;
        bookId: string;
        pageNumber: number | null;
        note: string | null;
        type: string;
        locationStart: string;
        locationEnd: string | null;
        selectedText: string | null;
    }>;
    /**
     * Get annotations for a book
     */
    static getAnnotations(userId: string, bookId: string): Promise<{
        id: string;
        createdAt: Date | null;
        updatedAt: Date | null;
        userId: string;
        metadata: import("../db/schema/index.js").AnnotationMetadata | null;
        color: string | null;
        bookId: string;
        pageNumber: number | null;
        note: string | null;
        type: string;
        locationStart: string;
        locationEnd: string | null;
        selectedText: string | null;
    }[]>;
    /**
     * Delete annotation
     */
    static deleteAnnotation(userId: string, annotationId: string): Promise<boolean>;
    /**
     * Update annotation
     */
    static updateAnnotation(userId: string, annotationId: string, data: {
        note?: string;
        color?: string;
    }): Promise<{
        id: string;
        createdAt: Date | null;
        updatedAt: Date | null;
        userId: string;
        metadata: import("../db/schema/index.js").AnnotationMetadata | null;
        color: string | null;
        bookId: string;
        pageNumber: number | null;
        note: string | null;
        type: string;
        locationStart: string;
        locationEnd: string | null;
        selectedText: string | null;
    }>;
}
//# sourceMappingURL=reader.service.d.ts.map