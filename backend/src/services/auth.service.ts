import jwt from 'jsonwebtoken';
import bcrypt from 'bcryptjs';
import { nanoid } from 'nanoid';
import { config } from '../config/index.js';
import { db } from '../db/index.js';
import { users, refreshTokens, oauthAccounts } from '../db/schema/index.js';
import { eq, and } from 'drizzle-orm';

const SALT_ROUNDS = 12;

export interface TokenPayload {
    userId: string;
    email?: string;
    isGuest: boolean;
}

export interface AuthTokens {
    accessToken: string;
    refreshToken: string;
}

// ============================================
// PASSWORD UTILITIES
// ============================================

export async function hashPassword(password: string): Promise<string> {
    return bcrypt.hash(password, SALT_ROUNDS);
}

export async function verifyPassword(password: string, hash: string): Promise<boolean> {
    return bcrypt.compare(password, hash);
}

// ============================================
// TOKEN UTILITIES
// ============================================

export function generateAccessToken(payload: TokenPayload): string {
    return jwt.sign(payload as any, config.jwt.secret, {
        expiresIn: config.jwt.expiresIn as any,
    });
}

export function generateRefreshToken(): string {
    return nanoid(64);
}

export function verifyAccessToken(token: string): TokenPayload | null {
    try {
        return jwt.verify(token, config.jwt.secret) as TokenPayload;
    } catch {
        return null;
    }
}

// ============================================
// AUTH OPERATIONS
// ============================================

export async function createUser(data: {
    email: string;
    password: string;
    name: string;
}): Promise<{ user: typeof users.$inferSelect; tokens: AuthTokens }> {
    const existingUser = await db.query.users.findFirst({
        where: eq(users.email, data.email),
    });

    if (existingUser) {
        throw new Error('Email already registered');
    }

    const passwordHash = await hashPassword(data.password);

    const [user] = await db.insert(users).values({
        email: data.email,
        passwordHash,
        name: data.name,
        isGuest: false,
        preferences: {
            theme: 'system',
            fontSize: 16,
            fontFamily: 'serif',
            lineHeight: 1.6,
            readingMode: 'paginated',
            notifications: true,
        },
    }).returning();

    const tokens = await generateAuthTokens(user);

    return { user, tokens };
}

export async function loginUser(data: {
    email: string;
    password: string;
}): Promise<{ user: typeof users.$inferSelect; tokens: AuthTokens }> {
    const user = await db.query.users.findFirst({
        where: eq(users.email, data.email),
    });

    if (!user || !user.passwordHash) {
        throw new Error('Invalid email or password');
    }

    const isValid = await verifyPassword(data.password, user.passwordHash);
    if (!isValid) {
        throw new Error('Invalid email or password');
    }

    const tokens = await generateAuthTokens(user);

    return { user, tokens };
}

export async function createGuestUser(): Promise<{ user: typeof users.$inferSelect; tokens: AuthTokens }> {
    const guestName = `Guest-${nanoid(6)}`;

    const [user] = await db.insert(users).values({
        name: guestName,
        isGuest: true,
        preferences: {
            theme: 'system',
            fontSize: 16,
            fontFamily: 'serif',
            lineHeight: 1.6,
            readingMode: 'paginated',
            notifications: false,
        },
    }).returning();

    const tokens = await generateAuthTokens(user);

    return { user, tokens };
}

export async function generateAuthTokens(user: typeof users.$inferSelect): Promise<AuthTokens> {
    const accessToken = generateAccessToken({
        userId: user.id,
        email: user.email ?? undefined,
        isGuest: user.isGuest ?? false,
    });

    const refreshToken = generateRefreshToken();

    // Calculate expiry date
    const refreshExpiresIn = config.jwt.refreshExpiresIn;
    const days = parseInt(refreshExpiresIn.replace('d', ''), 10);
    const expiresAt = new Date(Date.now() + days * 24 * 60 * 60 * 1000);

    // Store refresh token
    await db.insert(refreshTokens).values({
        userId: user.id,
        token: refreshToken,
        expiresAt,
    });

    return { accessToken, refreshToken };
}

export async function refreshAccessToken(token: string): Promise<AuthTokens | null> {
    const storedToken = await db.query.refreshTokens.findFirst({
        where: eq(refreshTokens.token, token),
    });

    if (!storedToken || storedToken.expiresAt < new Date()) {
        // Delete expired token if found
        if (storedToken) {
            await db.delete(refreshTokens).where(eq(refreshTokens.id, storedToken.id));
        }
        return null;
    }

    const user = await db.query.users.findFirst({
        where: eq(users.id, storedToken.userId),
    });

    if (!user) {
        return null;
    }

    // Delete old refresh token
    await db.delete(refreshTokens).where(eq(refreshTokens.id, storedToken.id));

    // Generate new tokens
    return generateAuthTokens(user);
}

export async function logout(userId: string, refreshToken?: string): Promise<void> {
    if (refreshToken) {
        await db.delete(refreshTokens).where(
            and(
                eq(refreshTokens.userId, userId),
                eq(refreshTokens.token, refreshToken)
            )
        );
    } else {
        // Logout from all devices
        await db.delete(refreshTokens).where(eq(refreshTokens.userId, userId));
    }
}

export async function getUserById(userId: string) {
    return db.query.users.findFirst({
        where: eq(users.id, userId),
    });
}

// ============================================
// OAUTH OPERATIONS
// ============================================

export async function findOrCreateOAuthUser(data: {
    provider: string;
    providerId: string;
    email?: string;
    name: string;
    avatarUrl?: string;
}): Promise<{ user: typeof users.$inferSelect; tokens: AuthTokens }> {
    // Check if OAuth account exists
    const existingOAuth = await db.query.oauthAccounts.findFirst({
        where: and(
            eq(oauthAccounts.provider, data.provider),
            eq(oauthAccounts.providerId, data.providerId)
        ),
    });

    if (existingOAuth) {
        const user = await getUserById(existingOAuth.userId);
        if (!user) {
            throw new Error('User not found');
        }
        const tokens = await generateAuthTokens(user);
        return { user, tokens };
    }

    // Check if user with email exists
    let user: typeof users.$inferSelect | undefined;

    if (data.email) {
        user = await db.query.users.findFirst({
            where: eq(users.email, data.email),
        });
    }

    // Create new user if not found
    if (!user) {
        const [newUser] = await db.insert(users).values({
            email: data.email,
            name: data.name,
            avatarUrl: data.avatarUrl,
            isGuest: false,
            preferences: {
                theme: 'system',
                fontSize: 16,
                fontFamily: 'serif',
                lineHeight: 1.6,
                readingMode: 'paginated',
                notifications: true,
            },
        }).returning();
        user = newUser;
    }

    // Link OAuth account
    await db.insert(oauthAccounts).values({
        userId: user.id,
        provider: data.provider,
        providerId: data.providerId,
    });

    const tokens = await generateAuthTokens(user);
    return { user, tokens };
}
