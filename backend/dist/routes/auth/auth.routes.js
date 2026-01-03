import { Router } from 'express';
import { validate, asyncHandler, authenticate } from '../../middleware/index.js';
import { registerSchema, loginSchema, updateProfileSchema, } from './auth.schemas.js';
import { createUser, loginUser, createGuestUser, refreshAccessToken, logout, getUserById, } from '../../services/auth.service.js';
import { db } from '../../db/index.js';
import { users } from '../../db/schema/index.js';
import { eq } from 'drizzle-orm';
import { config } from '../../config/index.js';
const router = Router();
// Cookie options
const cookieOptions = {
    httpOnly: true,
    secure: config.env === 'production',
    sameSite: 'lax',
    maxAge: 7 * 24 * 60 * 60 * 1000, // 7 days
};
const refreshCookieOptions = {
    ...cookieOptions,
    maxAge: 30 * 24 * 60 * 60 * 1000, // 30 days
    path: '/api/auth/refresh',
};
/**
 * POST /api/auth/register
 * Register a new user
 */
router.post('/register', validate(registerSchema), asyncHandler(async (req, res) => {
    const { email, password, name } = req.body;
    try {
        const { user, tokens } = await createUser({ email, password, name });
        res.cookie('accessToken', tokens.accessToken, cookieOptions);
        res.cookie('refreshToken', tokens.refreshToken, refreshCookieOptions);
        res.status(201).json({
            user: {
                id: user.id,
                email: user.email,
                name: user.name,
                avatarUrl: user.avatarUrl,
                isGuest: user.isGuest,
                preferences: user.preferences,
            },
            tokens,
        });
    }
    catch (error) {
        if (error.message === 'Email already registered') {
            res.status(409).json({ error: error.message });
            return;
        }
        throw error;
    }
}));
/**
 * POST /api/auth/login
 * Login with email and password
 */
router.post('/login', validate(loginSchema), asyncHandler(async (req, res) => {
    const { email, password } = req.body;
    try {
        const { user, tokens } = await loginUser({ email, password });
        res.cookie('accessToken', tokens.accessToken, cookieOptions);
        res.cookie('refreshToken', tokens.refreshToken, refreshCookieOptions);
        res.json({
            user: {
                id: user.id,
                email: user.email,
                name: user.name,
                avatarUrl: user.avatarUrl,
                isGuest: user.isGuest,
                preferences: user.preferences,
            },
            tokens,
        });
    }
    catch (error) {
        if (error.message === 'Invalid email or password') {
            res.status(401).json({ error: error.message });
            return;
        }
        throw error;
    }
}));
/**
 * POST /api/auth/guest
 * Create a guest account
 */
router.post('/guest', asyncHandler(async (req, res) => {
    const { user, tokens } = await createGuestUser();
    res.cookie('accessToken', tokens.accessToken, cookieOptions);
    res.cookie('refreshToken', tokens.refreshToken, refreshCookieOptions);
    res.status(201).json({
        user: {
            id: user.id,
            name: user.name,
            isGuest: user.isGuest,
            preferences: user.preferences,
        },
        tokens,
    });
}));
/**
 * POST /api/auth/refresh
 * Refresh access token
 */
router.post('/refresh', asyncHandler(async (req, res) => {
    const refreshToken = req.cookies?.refreshToken || req.body.refreshToken;
    if (!refreshToken) {
        res.status(400).json({ error: 'Refresh token required' });
        return;
    }
    const tokens = await refreshAccessToken(refreshToken);
    if (!tokens) {
        res.status(401).json({ error: 'Invalid or expired refresh token' });
        return;
    }
    res.cookie('accessToken', tokens.accessToken, cookieOptions);
    res.cookie('refreshToken', tokens.refreshToken, refreshCookieOptions);
    res.json({ tokens });
}));
/**
 * POST /api/auth/logout
 * Logout user
 */
router.post('/logout', authenticate, asyncHandler(async (req, res) => {
    const refreshToken = req.cookies?.refreshToken;
    await logout(req.user.id, refreshToken);
    res.clearCookie('accessToken');
    res.clearCookie('refreshToken', { path: '/api/auth/refresh' });
    res.json({ message: 'Logged out successfully' });
}));
/**
 * GET /api/auth/me
 * Get current user
 */
router.get('/me', authenticate, asyncHandler(async (req, res) => {
    const user = await getUserById(req.user.id);
    if (!user) {
        res.status(404).json({ error: 'User not found' });
        return;
    }
    res.json({
        user: {
            id: user.id,
            email: user.email,
            name: user.name,
            avatarUrl: user.avatarUrl,
            isGuest: user.isGuest,
            preferences: user.preferences,
            createdAt: user.createdAt,
        },
    });
}));
/**
 * PATCH /api/auth/me
 * Update current user profile
 */
router.patch('/me', authenticate, validate(updateProfileSchema), asyncHandler(async (req, res) => {
    const { name, avatarUrl, preferences } = req.body;
    const currentUser = await getUserById(req.user.id);
    if (!currentUser) {
        res.status(404).json({ error: 'User not found' });
        return;
    }
    const updatedPreferences = preferences
        ? { ...currentUser.preferences, ...preferences }
        : currentUser.preferences;
    const [updatedUser] = await db
        .update(users)
        .set({
        ...(name && { name }),
        ...(avatarUrl !== undefined && { avatarUrl }),
        ...(preferences && { preferences: updatedPreferences }),
        updatedAt: new Date(),
    })
        .where(eq(users.id, req.user.id))
        .returning();
    res.json({
        user: {
            id: updatedUser.id,
            email: updatedUser.email,
            name: updatedUser.name,
            avatarUrl: updatedUser.avatarUrl,
            isGuest: updatedUser.isGuest,
            preferences: updatedUser.preferences,
        },
    });
}));
/**
 * DELETE /api/auth/me
 * Delete current user account
 */
router.delete('/me', authenticate, asyncHandler(async (req, res) => {
    await db.delete(users).where(eq(users.id, req.user.id));
    res.clearCookie('accessToken');
    res.clearCookie('refreshToken', { path: '/api/auth/refresh' });
    res.json({ message: 'Account deleted successfully' });
}));
export default router;
//# sourceMappingURL=auth.routes.js.map