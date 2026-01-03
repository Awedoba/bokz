import { Request, Response, NextFunction } from 'express';
import { ZodSchema, ZodError } from 'zod';

/**
 * Validation middleware factory
 */
export function validate<T>(
    schema: ZodSchema<T>,
    source: 'body' | 'query' | 'params' = 'body'
) {
    return (req: Request, res: Response, next: NextFunction): void => {
        try {
            const data = req[source];
            const parsed = schema.parse(data);
            req[source] = parsed as any;
            next();
        } catch (error) {
            if (error instanceof ZodError) {
                const errors = error.errors.map((e) => ({
                    field: e.path.join('.'),
                    message: e.message,
                }));

                res.status(400).json({
                    error: 'Validation failed',
                    details: errors,
                });
                return;
            }
            next(error);
        }
    };
}
