import fs from 'fs/promises';
import path from 'path';
import EPub from 'epub2';
// @ts-ignore
import pdf from 'pdf-parse';
import sharp from 'sharp';
import { nanoid } from 'nanoid';
import { db } from '../db/index.js';
import { books } from '../db/schema/index.js';
import { config } from '../config/index.js';
import { eq, desc, and, like } from 'drizzle-orm';
export class BookService {
    /**
     * Process uploaded book file and extract metadata
     */
    static async processBook(userId, file) {
        let metadata = {};
        let coverUrl;
        let title = file.originalname.replace(path.extname(file.originalname), '');
        let author;
        let description;
        let totalPages;
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
            }
            else if (file.mimetype === 'application/pdf') {
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
        }
        catch (error) {
            // Clean up file if processing fails
            await fs.unlink(file.path).catch(() => { });
            throw error;
        }
    }
    /**
     * Parse EPUB file
     */
    static async parseEpub(filePath) {
        return new Promise((resolve, reject) => {
            const epub = new EPub(filePath);
            epub.on('end', async () => {
                let coverBuffer;
                try {
                    // Try to get cover image
                    if (epub.metadata.cover) {
                        const coverPath = epub.metadata.cover;
                        epub.getImage(coverPath, (error, data, mimeType) => {
                            if (!error && data) {
                                coverBuffer = data;
                            }
                            resolve({ metadata: epub.metadata, coverBuffer });
                        });
                    }
                    else {
                        resolve({ metadata: epub.metadata });
                    }
                }
                catch (e) {
                    resolve({ metadata: epub.metadata });
                }
            });
            epub.on('error', (err) => {
                reject(err);
            });
            epub.parse();
        });
    }
    /**
     * Parse PDF file
     */
    static async parsePdf(filePath) {
        const dataBuffer = await fs.readFile(filePath);
        return await pdf(dataBuffer);
    }
    /**
     * Save cover image (process with sharp)
     */
    static async saveCoverImage(buffer) {
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
    static async getBooks(userId, query) {
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
    static async getBookById(userId, bookId) {
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
    static async updateBook(userId, bookId, data) {
        const [updated] = await db.update(books)
            .set({ ...data, updatedAt: new Date() })
            .where(and(eq(books.id, bookId), eq(books.userId, userId)))
            .returning();
        return updated;
    }
    /**
     * Delete book and files
     */
    static async deleteBook(userId, bookId) {
        const book = await this.getBookById(userId, bookId);
        if (!book)
            return false;
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
//# sourceMappingURL=book.service.js.map