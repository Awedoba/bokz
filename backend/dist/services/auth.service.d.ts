import { users } from '../db/schema/index.js';
export interface TokenPayload {
    userId: string;
    email?: string;
    isGuest: boolean;
}
export interface AuthTokens {
    accessToken: string;
    refreshToken: string;
}
export declare function hashPassword(password: string): Promise<string>;
export declare function verifyPassword(password: string, hash: string): Promise<boolean>;
export declare function generateAccessToken(payload: TokenPayload): string;
export declare function generateRefreshToken(): string;
export declare function verifyAccessToken(token: string): TokenPayload | null;
export declare function createUser(data: {
    email: string;
    password: string;
    name: string;
}): Promise<{
    user: typeof users.$inferSelect;
    tokens: AuthTokens;
}>;
export declare function loginUser(data: {
    email: string;
    password: string;
}): Promise<{
    user: typeof users.$inferSelect;
    tokens: AuthTokens;
}>;
export declare function createGuestUser(): Promise<{
    user: typeof users.$inferSelect;
    tokens: AuthTokens;
}>;
export declare function generateAuthTokens(user: typeof users.$inferSelect): Promise<AuthTokens>;
export declare function refreshAccessToken(token: string): Promise<AuthTokens | null>;
export declare function logout(userId: string, refreshToken?: string): Promise<void>;
export declare function getUserById(userId: string): Promise<{
    id: string;
    name: string;
    email: string | null;
    passwordHash: string | null;
    avatarUrl: string | null;
    isGuest: boolean | null;
    preferences: import("../db/schema/index.js").UserPreferences | null;
    createdAt: Date | null;
    updatedAt: Date | null;
} | undefined>;
export declare function findOrCreateOAuthUser(data: {
    provider: string;
    providerId: string;
    email?: string;
    name: string;
    avatarUrl?: string;
}): Promise<{
    user: typeof users.$inferSelect;
    tokens: AuthTokens;
}>;
//# sourceMappingURL=auth.service.d.ts.map