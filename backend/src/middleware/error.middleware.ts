import { Request, Response, NextFunction } from 'express';

export interface ApiError extends Error {
    statusCode?: number;
    code?: string;
}

/**
 * Global error handling middleware
 */
export function errorHandler(
    err: ApiError,
    req: Request,
    res: Response,
    _next: NextFunction
): void {
    console.error(`[Error] ${req.method} ${req.path}:`, err);

    const statusCode = err.statusCode || 500;
    const message = err.message || 'Internal server error';

    res.status(statusCode).json({
        error: message,
        code: err.code,
        ...(process.env.NODE_ENV === 'development' && { stack: err.stack }),
    });
}

/**
 * 404 Not Found middleware
 */
export function notFound(req: Request, res: Response): void {
    res.status(404).json({
        error: 'Resource not found',
        path: req.path,
    });
}

/**
 * Create an API error with status code
 */
export function createError(message: string, statusCode: number, code?: string): ApiError {
    const error: ApiError = new Error(message);
    error.statusCode = statusCode;
    error.code = code;
    return error;
}

/**
 * Async route handler wrapper
 */
export function asyncHandler(
    fn: (req: Request, res: Response, next: NextFunction) => Promise<void>
) {
    return (req: Request, res: Response, next: NextFunction) => {
        Promise.resolve(fn(req, res, next)).catch(next);
    };
}
