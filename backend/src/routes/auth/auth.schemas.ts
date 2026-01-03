import { z } from 'zod';

export const registerSchema = z.object({
    email: z.string().email('Invalid email address'),
    password: z.string().min(8, 'Password must be at least 8 characters'),
    name: z.string().min(1, 'Name is required').max(100),
});

export const loginSchema = z.object({
    email: z.string().email('Invalid email address'),
    password: z.string().min(1, 'Password is required'),
});

export const refreshTokenSchema = z.object({
    refreshToken: z.string().min(1, 'Refresh token is required'),
});

export const updateProfileSchema = z.object({
    name: z.string().min(1).max(100).optional(),
    avatarUrl: z.string().url().optional().nullable(),
    preferences: z.object({
        theme: z.enum(['light', 'dark', 'system']).optional(),
        fontSize: z.number().min(12).max(32).optional(),
        fontFamily: z.string().optional(),
        lineHeight: z.number().min(1).max(3).optional(),
        readingMode: z.enum(['paginated', 'scroll']).optional(),
        notifications: z.boolean().optional(),
    }).optional(),
});

export const forgotPasswordSchema = z.object({
    email: z.string().email('Invalid email address'),
});

export const resetPasswordSchema = z.object({
    token: z.string().min(1, 'Reset token is required'),
    password: z.string().min(8, 'Password must be at least 8 characters'),
});

export type RegisterInput = z.infer<typeof registerSchema>;
export type LoginInput = z.infer<typeof loginSchema>;
export type UpdateProfileInput = z.infer<typeof updateProfileSchema>;
