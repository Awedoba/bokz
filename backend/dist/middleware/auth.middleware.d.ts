import { Request, Response, NextFunction } from 'express';
declare global {
    namespace Express {
        interface Request {
            user?: {
                id: string;
                email?: string;
                isGuest: boolean;
            };
        }
    }
}
/**
 * Authentication middleware - requires valid JWT token
 */
export declare function authenticate(req: Request, res: Response, next: NextFunction): Promise<void>;
/**
 * Optional authentication - attaches user if token present but doesn't require it
 */
export declare function optionalAuth(req: Request, res: Response, next: NextFunction): Promise<void>;
/**
 * Requires non-guest user
 */
export declare function requireRegistered(req: Request, res: Response, next: NextFunction): Promise<void>;
//# sourceMappingURL=auth.middleware.d.ts.map