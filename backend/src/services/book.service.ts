import fs from 'fs/promises';
import path from 'path';
import { EPub } from 'epub2';
import { createRequire } from 'module';
const require = createRequire(import.meta.url);
const pdf = require('pdf-parse');
import sharp from 'sharp';
import { nanoid } from 'nanoid';
import { db } from '../db/index.js';
import { books, users } from '../db/schema/index.js';
import { config } from '../config/index.js';
import { eq, desc, and, like } from 'drizzle-orm';

export interface FileData {
    path: string;
    filename: string;
    originalname: string;
    mimetype: string;
    size: number;
}

export class BookService {
    /**
     * Process uploaded book file and extract metadata
     */
    static async processBook(userId: string, file: FileData) {
        let metadata: any = {};
        let coverUrl: string | undefined;
        let title = file.originalname.replace(path.extname(file.originalname), '');
        let author: string | undefined;
        let description: string | undefined;
        let totalPages: number | undefined;
        let format = 'txt';

        try {
            if (file.mimetype === 'application/epub+zip') {
                format = 'epub';
                const epubData = await this.parseEpub(file.path);
                metadata = epubData.metadata;
                title = epubData.metadata.title || title;
                author = epubData.metadata.creator;
                description = epubData.metadata.description;

                if (epubData.coverBuffer) {
                    coverUrl = await this.saveCoverImage(epubData.coverBuffer);
                }
            } else if (file.mimetype === 'application/pdf') {
                format = 'pdf';
                const pdfData = await this.parsePdf(file.path);
                metadata = pdfData.info;
                totalPages = pdfData.numpages;
                // Basic PDF metadata extraction
                if (pdfData.info) {
                    title = pdfData.info.Title || title;
                    author = pdfData.info.Author;
                }
            }

            // Save to database
            const [book] = await db.insert(books).values({
                userId,
                title,
                author,
                description,
                coverUrl,
                filePath: file.filename, // Store relative path/filename
                format,
                fileSize: file.size,
                totalPages,
                metadata,
            }).returning();

            return book;
        } catch (error) {
            // Clean up file if processing fails
            await fs.unlink(file.path).catch(() => { });
            throw error;
        }
    }

    /**
     * Parse EPUB file
     */
    private static async parseEpub(filePath: string) {
        return new Promise<{ metadata: any; coverBuffer?: Buffer }>((resolve, reject) => {
            const epub = new EPub(filePath);

            epub.on('end', async () => {
                let coverBuffer: Buffer | undefined;

                try {
                    // Try to get cover image
                    if (epub.metadata.cover) {
                        const coverPath = epub.metadata.cover;
                        epub.getImage(coverPath, (error: any, data: Buffer, mimeType: string) => {
                            if (!error && data) {
                                coverBuffer = data;
                            }
                            resolve({ metadata: epub.metadata, coverBuffer });
                        });
                    } else {
                        resolve({ metadata: epub.metadata });
                    }
                } catch (e) {
                    resolve({ metadata: epub.metadata });
                }
            });

            epub.on('error', (err: any) => {
                reject(err);
            });

            epub.parse();
        });
    }

    /**
     * Parse PDF file
     */
    private static async parsePdf(filePath: string) {
        const dataBuffer = await fs.readFile(filePath);
        return await pdf(dataBuffer);
    }

    /**
     * Save cover image (process with sharp)
     */
    private static async saveCoverImage(buffer: Buffer): Promise<string> {
        const filename = `cover-${nanoid()}.webp`;
        const outputPath = path.join(config.upload.dir, filename);

        await sharp(buffer)
            .resize(400, 600, { fit: 'cover' }) // Standardize cover size
            .webp({ quality: 80 })
            .toFile(outputPath);

        return filename;
    }

    /**
     * Get all books for user with filtering/pagination
     */
    static async getBooks(userId: string, query: {
        search?: string;
        format?: string;
        limit?: number;
        offset?: number
    }) {
        const whereConditions = [eq(books.userId, userId)];

        if (query.format) {
            whereConditions.push(eq(books.format, query.format));
        }

        if (query.search) {
            whereConditions.push(like(books.title, `%${query.search}%`));
        }

        return db.query.books.findMany({
            where: and(...whereConditions),
            orderBy: [desc(books.createdAt)],
            limit: query.limit || 50,
            offset: query.offset || 0,
            with: {
                readingProgress: true, // simplified relation fetch
            }
        });
    }

    /**
     * Get single book details
     */
    static async getBookById(userId: string, bookId: string) {
        return db.query.books.findFirst({
            where: and(eq(books.id, bookId), eq(books.userId, userId)),
            with: {
                readingProgress: true,
                bookmarks: true,
            }
        });
    }

    /**
     * Update book metadata
     */
    static async updateBook(userId: string, bookId: string, data: Partial<typeof books.$inferInsert>) {
        const [updated] = await db.update(books)
            .set({ ...data, updatedAt: new Date() })
            .where(and(eq(books.id, bookId), eq(books.userId, userId)))
            .returning();
        return updated;
    }

    /**
     * Delete book and files
     */
    static async deleteBook(userId: string, bookId: string) {
        const book = await this.getBookById(userId, bookId);
        if (!book) return false;

        // Delete DB record
        await db.delete(books).where(eq(books.id, bookId));

        // Delete files asynchronously
        const tasks = [
            fs.unlink(path.join(config.upload.dir, book.filePath)).catch(() => { }),
        ];

        if (book.coverUrl) {
            tasks.push(fs.unlink(path.join(config.upload.dir, book.coverUrl)).catch(() => { }));
        }

        await Promise.all(tasks);
        return true;
    }
}
