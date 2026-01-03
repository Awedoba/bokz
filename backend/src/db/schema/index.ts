import { sqliteTable, text, integer, real } from 'drizzle-orm/sqlite-core';
import { relations } from 'drizzle-orm';
import { nanoid } from 'nanoid';

// ============================================
// USERS
// ============================================

export const users = sqliteTable('users', {
    id: text('id').primaryKey().$defaultFn(() => nanoid()),
    email: text('email').unique(),
    passwordHash: text('password_hash'),
    name: text('name').notNull(),
    avatarUrl: text('avatar_url'),
    isGuest: integer('is_guest', { mode: 'boolean' }).default(false),
    preferences: text('preferences', { mode: 'json' }).$type<UserPreferences>(),
    createdAt: integer('created_at', { mode: 'timestamp' }).$defaultFn(() => new Date()),
    updatedAt: integer('updated_at', { mode: 'timestamp' }).$defaultFn(() => new Date()),
});

export type UserPreferences = {
    theme?: 'light' | 'dark' | 'system';
    fontSize?: number;
    fontFamily?: string;
    lineHeight?: number;
    readingMode?: 'paginated' | 'scroll';
    notifications?: boolean;
};

export const usersRelations = relations(users, ({ many }) => ({
    oauthAccounts: many(oauthAccounts),
    books: many(books),
    collections: many(collections),
    readingProgress: many(readingProgress),
    readingSessions: many(readingSessions),
}));

// ============================================
// OAUTH ACCOUNTS
// ============================================

export const oauthAccounts = sqliteTable('oauth_accounts', {
    id: text('id').primaryKey().$defaultFn(() => nanoid()),
    userId: text('user_id').notNull().references(() => users.id, { onDelete: 'cascade' }),
    provider: text('provider').notNull(), // 'google' | 'apple'
    providerId: text('provider_id').notNull(),
    createdAt: integer('created_at', { mode: 'timestamp' }).$defaultFn(() => new Date()),
});

export const oauthAccountsRelations = relations(oauthAccounts, ({ one }) => ({
    user: one(users, {
        fields: [oauthAccounts.userId],
        references: [users.id],
    }),
}));

// ============================================
// REFRESH TOKENS
// ============================================

export const refreshTokens = sqliteTable('refresh_tokens', {
    id: text('id').primaryKey().$defaultFn(() => nanoid()),
    userId: text('user_id').notNull().references(() => users.id, { onDelete: 'cascade' }),
    token: text('token').notNull().unique(),
    expiresAt: integer('expires_at', { mode: 'timestamp' }).notNull(),
    createdAt: integer('created_at', { mode: 'timestamp' }).$defaultFn(() => new Date()),
});

// ============================================
// BOOKS
// ============================================

export const books = sqliteTable('books', {
    id: text('id').primaryKey().$defaultFn(() => nanoid()),
    userId: text('user_id').notNull().references(() => users.id, { onDelete: 'cascade' }),
    title: text('title').notNull(),
    author: text('author'),
    description: text('description'),
    coverUrl: text('cover_url'),
    filePath: text('file_path').notNull(),
    format: text('format').notNull(), // 'epub' | 'pdf' | 'txt'
    fileSize: integer('file_size'),
    totalPages: integer('total_pages'),
    metadata: text('metadata', { mode: 'json' }).$type<BookMetadata>(),
    createdAt: integer('created_at', { mode: 'timestamp' }).$defaultFn(() => new Date()),
    updatedAt: integer('updated_at', { mode: 'timestamp' }).$defaultFn(() => new Date()),
});

export type BookMetadata = {
    isbn?: string;
    publisher?: string;
    publishedDate?: string;
    language?: string;
    subjects?: string[];
    tableOfContents?: { title: string; href: string }[];
};

export const booksRelations = relations(books, ({ one, many }) => ({
    user: one(users, {
        fields: [books.userId],
        references: [users.id],
    }),
    bookCollections: many(bookCollections),
    bookmarks: many(bookmarks),
    annotations: many(annotations),
    readingProgress: many(readingProgress),
    readingSessions: many(readingSessions),
}));

// ============================================
// COLLECTIONS
// ============================================

export const collections = sqliteTable('collections', {
    id: text('id').primaryKey().$defaultFn(() => nanoid()),
    userId: text('user_id').notNull().references(() => users.id, { onDelete: 'cascade' }),
    name: text('name').notNull(),
    description: text('description'),
    color: text('color').default('#6366f1'),
    sortOrder: integer('sort_order').default(0),
    createdAt: integer('created_at', { mode: 'timestamp' }).$defaultFn(() => new Date()),
    updatedAt: integer('updated_at', { mode: 'timestamp' }).$defaultFn(() => new Date()),
});

export const collectionsRelations = relations(collections, ({ one, many }) => ({
    user: one(users, {
        fields: [collections.userId],
        references: [users.id],
    }),
    bookCollections: many(bookCollections),
}));

// ============================================
// BOOK COLLECTIONS (Junction Table)
// ============================================

export const bookCollections = sqliteTable('book_collections', {
    bookId: text('book_id').notNull().references(() => books.id, { onDelete: 'cascade' }),
    collectionId: text('collection_id').notNull().references(() => collections.id, { onDelete: 'cascade' }),
    addedAt: integer('added_at', { mode: 'timestamp' }).$defaultFn(() => new Date()),
});

export const bookCollectionsRelations = relations(bookCollections, ({ one }) => ({
    book: one(books, {
        fields: [bookCollections.bookId],
        references: [books.id],
    }),
    collection: one(collections, {
        fields: [bookCollections.collectionId],
        references: [collections.id],
    }),
}));

// ============================================
// READING PROGRESS
// ============================================

export const readingProgress = sqliteTable('reading_progress', {
    id: text('id').primaryKey().$defaultFn(() => nanoid()),
    userId: text('user_id').notNull().references(() => users.id, { onDelete: 'cascade' }),
    bookId: text('book_id').notNull().references(() => books.id, { onDelete: 'cascade' }),
    location: text('location'), // CFI for EPUB, page number for PDF
    pageNumber: integer('page_number'),
    percentage: real('percentage').default(0),
    timeSpentSeconds: integer('time_spent_seconds').default(0),
    lastReadAt: integer('last_read_at', { mode: 'timestamp' }).$defaultFn(() => new Date()),
    syncedAt: integer('synced_at', { mode: 'timestamp' }),
});

export const readingProgressRelations = relations(readingProgress, ({ one }) => ({
    user: one(users, {
        fields: [readingProgress.userId],
        references: [users.id],
    }),
    book: one(books, {
        fields: [readingProgress.bookId],
        references: [books.id],
    }),
}));

// ============================================
// BOOKMARKS
// ============================================

export const bookmarks = sqliteTable('bookmarks', {
    id: text('id').primaryKey().$defaultFn(() => nanoid()),
    userId: text('user_id').notNull().references(() => users.id, { onDelete: 'cascade' }),
    bookId: text('book_id').notNull().references(() => books.id, { onDelete: 'cascade' }),
    location: text('location').notNull(),
    pageNumber: integer('page_number'),
    title: text('title'),
    note: text('note'),
    createdAt: integer('created_at', { mode: 'timestamp' }).$defaultFn(() => new Date()),
});

export const bookmarksRelations = relations(bookmarks, ({ one }) => ({
    user: one(users, {
        fields: [bookmarks.userId],
        references: [users.id],
    }),
    book: one(books, {
        fields: [bookmarks.bookId],
        references: [books.id],
    }),
}));

// ============================================
// ANNOTATIONS
// ============================================

export const annotations = sqliteTable('annotations', {
    id: text('id').primaryKey().$defaultFn(() => nanoid()),
    userId: text('user_id').notNull().references(() => users.id, { onDelete: 'cascade' }),
    bookId: text('book_id').notNull().references(() => books.id, { onDelete: 'cascade' }),
    type: text('type').notNull(), // 'highlight' | 'underline' | 'note'
    locationStart: text('location_start').notNull(),
    locationEnd: text('location_end'),
    pageNumber: integer('page_number'),
    selectedText: text('selected_text'),
    note: text('note'),
    color: text('color').default('#fbbf24'),
    metadata: text('metadata', { mode: 'json' }).$type<AnnotationMetadata>(),
    createdAt: integer('created_at', { mode: 'timestamp' }).$defaultFn(() => new Date()),
    updatedAt: integer('updated_at', { mode: 'timestamp' }).$defaultFn(() => new Date()),
});

export type AnnotationMetadata = {
    chapter?: string;
    emotion?: string;
    tags?: string[];
};

export const annotationsRelations = relations(annotations, ({ one }) => ({
    user: one(users, {
        fields: [annotations.userId],
        references: [users.id],
    }),
    book: one(books, {
        fields: [annotations.bookId],
        references: [books.id],
    }),
}));

// ============================================
// READING SESSIONS (Analytics)
// ============================================

export const readingSessions = sqliteTable('reading_sessions', {
    id: text('id').primaryKey().$defaultFn(() => nanoid()),
    userId: text('user_id').notNull().references(() => users.id, { onDelete: 'cascade' }),
    bookId: text('book_id').notNull().references(() => books.id, { onDelete: 'cascade' }),
    pagesRead: integer('pages_read').default(0),
    durationSeconds: integer('duration_seconds').default(0),
    sessionDate: text('session_date').notNull(), // YYYY-MM-DD
    startedAt: integer('started_at', { mode: 'timestamp' }).$defaultFn(() => new Date()),
    endedAt: integer('ended_at', { mode: 'timestamp' }),
});

export const readingSessionsRelations = relations(readingSessions, ({ one }) => ({
    user: one(users, {
        fields: [readingSessions.userId],
        references: [users.id],
    }),
    book: one(books, {
        fields: [readingSessions.bookId],
        references: [books.id],
    }),
}));

// ============================================
// READING GOALS
// ============================================

export const readingGoals = sqliteTable('reading_goals', {
    id: text('id').primaryKey().$defaultFn(() => nanoid()),
    userId: text('user_id').notNull().references(() => users.id, { onDelete: 'cascade' }),
    year: integer('year').notNull(),
    targetBooks: integer('target_books').default(12),
    targetMinutesPerDay: integer('target_minutes_per_day').default(30),
    createdAt: integer('created_at', { mode: 'timestamp' }).$defaultFn(() => new Date()),
    updatedAt: integer('updated_at', { mode: 'timestamp' }).$defaultFn(() => new Date()),
});

// ============================================
// TYPE EXPORTS
// ============================================

export type User = typeof users.$inferSelect;
export type NewUser = typeof users.$inferInsert;
export type Book = typeof books.$inferSelect;
export type NewBook = typeof books.$inferInsert;
export type Collection = typeof collections.$inferSelect;
export type NewCollection = typeof collections.$inferInsert;
export type Bookmark = typeof bookmarks.$inferSelect;
export type NewBookmark = typeof bookmarks.$inferInsert;
export type Annotation = typeof annotations.$inferSelect;
export type NewAnnotation = typeof annotations.$inferInsert;
export type ReadingProgress = typeof readingProgress.$inferSelect;
export type ReadingSession = typeof readingSessions.$inferSelect;
export type ReadingGoal = typeof readingGoals.$inferSelect;
