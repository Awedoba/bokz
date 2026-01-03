/**
 * Global error handling middleware
 */
export function errorHandler(err, req, res, _next) {
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
export function notFound(req, res) {
    res.status(404).json({
        error: 'Resource not found',
        path: req.path,
    });
}
/**
 * Create an API error with status code
 */
export function createError(message, statusCode, code) {
    const error = new Error(message);
    error.statusCode = statusCode;
    error.code = code;
    return error;
}
/**
 * Async route handler wrapper
 */
export function asyncHandler(fn) {
    return (req, res, next) => {
        Promise.resolve(fn(req, res, next)).catch(next);
    };
}
//# sourceMappingURL=error.middleware.js.map