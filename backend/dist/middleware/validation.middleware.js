import { ZodError } from 'zod';
/**
 * Validation middleware factory
 */
export function validate(schema, source = 'body') {
    return (req, res, next) => {
        try {
            const data = req[source];
            const parsed = schema.parse(data);
            req[source] = parsed;
            next();
        }
        catch (error) {
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
//# sourceMappingURL=validation.middleware.js.map