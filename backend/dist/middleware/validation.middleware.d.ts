import { Request, Response, NextFunction } from 'express';
import { ZodSchema } from 'zod';
/**
 * Validation middleware factory
 */
export declare function validate<T>(schema: ZodSchema<T>, source?: 'body' | 'query' | 'params'): (req: Request, res: Response, next: NextFunction) => void;
//# sourceMappingURL=validation.middleware.d.ts.map