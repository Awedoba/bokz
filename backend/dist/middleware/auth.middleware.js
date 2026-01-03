import { verifyAccessToken, getUserById } from '../services/auth.service.js';
/**
 * Authentication middleware - requires valid JWT token
 */
export async function authenticate(req, res, next) {
    try {
        const authHeader = req.headers.authorization;
        const tokenFromCookie = req.cookies?.accessToken;
        const token = authHeader?.startsWith('Bearer ')
            ? authHeader.slice(7)
            : tokenFromCookie;
        if (!token) {
            res.status(401).json({ error: 'Authentication required' });
            return;
        }
        const payload = verifyAccessToken(token);
        if (!payload) {
            res.status(401).json({ error: 'Invalid or expired token' });
            return;
        }
        // Verify user still exists
        const user = await getUserById(payload.userId);
        if (!user) {
            res.status(401).json({ error: 'User not found' });
            return;
        }
        req.user = {
            id: payload.userId,
            email: payload.email,
            isGuest: payload.isGuest,
        };
        next();
    }
    catch (error) {
        res.status(401).json({ error: 'Authentication failed' });
    }
}
/**
 * Optional authentication - attaches user if token present but doesn't require it
 */
export async function optionalAuth(req, res, next) {
    try {
        const authHeader = req.headers.authorization;
        const tokenFromCookie = req.cookies?.accessToken;
        const token = authHeader?.startsWith('Bearer ')
            ? authHeader.slice(7)
            : tokenFromCookie;
        if (token) {
            const payload = verifyAccessToken(token);
            if (payload) {
                const user = await getUserById(payload.userId);
                if (user) {
                    req.user = {
                        id: payload.userId,
                        email: payload.email,
                        isGuest: payload.isGuest,
                    };
                }
            }
        }
        next();
    }
    catch {
        // Silently continue without auth
        next();
    }
}
/**
 * Requires non-guest user
 */
export async function requireRegistered(req, res, next) {
    if (!req.user) {
        res.status(401).json({ error: 'Authentication required' });
        return;
    }
    if (req.user.isGuest) {
        res.status(403).json({ error: 'This action requires a registered account' });
        return;
    }
    next();
}
//# sourceMappingURL=auth.middleware.js.map