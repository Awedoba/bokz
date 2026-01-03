import { Request, Response, NextFunction } from 'express';
export interface ApiError extends Error {
    statusCode?: number;
    code?: string;
}
/**
 * Global error handling middleware
 */
export declare function errorHandler(err: ApiError, req: Request, res: Response, _next: NextFunction): void;
/**
 * 404 Not Found middleware
 */
export declare function notFound(req: Request, res: Response): void;
/**
 * Create an API error with status code
 */
export declare function createError(message: string, statusCode: number, code?: string): ApiError;
/**
 * Async route handler wrapper
 */
export declare function asyncHandler(fn: (req: Request, res: Response, next: NextFunction) => Promise<void>): (req: Request, res: Response, next: NextFunction) => void;
//# sourceMappingURL=error.middleware.d.ts.map