import { z } from 'zod';
export declare const registerSchema: z.ZodObject<{
    email: z.ZodString;
    password: z.ZodString;
    name: z.ZodString;
}, "strip", z.ZodTypeAny, {
    name: string;
    email: string;
    password: string;
}, {
    name: string;
    email: string;
    password: string;
}>;
export declare const loginSchema: z.ZodObject<{
    email: z.ZodString;
    password: z.ZodString;
}, "strip", z.ZodTypeAny, {
    email: string;
    password: string;
}, {
    email: string;
    password: string;
}>;
export declare const refreshTokenSchema: z.ZodObject<{
    refreshToken: z.ZodString;
}, "strip", z.ZodTypeAny, {
    refreshToken: string;
}, {
    refreshToken: string;
}>;
export declare const updateProfileSchema: z.ZodObject<{
    name: z.ZodOptional<z.ZodString>;
    avatarUrl: z.ZodNullable<z.ZodOptional<z.ZodString>>;
    preferences: z.ZodOptional<z.ZodObject<{
        theme: z.ZodOptional<z.ZodEnum<["light", "dark", "system"]>>;
        fontSize: z.ZodOptional<z.ZodNumber>;
        fontFamily: z.ZodOptional<z.ZodString>;
        lineHeight: z.ZodOptional<z.ZodNumber>;
        readingMode: z.ZodOptional<z.ZodEnum<["paginated", "scroll"]>>;
        notifications: z.ZodOptional<z.ZodBoolean>;
    }, "strip", z.ZodTypeAny, {
        theme?: "light" | "dark" | "system" | undefined;
        fontSize?: number | undefined;
        fontFamily?: string | undefined;
        lineHeight?: number | undefined;
        readingMode?: "paginated" | "scroll" | undefined;
        notifications?: boolean | undefined;
    }, {
        theme?: "light" | "dark" | "system" | undefined;
        fontSize?: number | undefined;
        fontFamily?: string | undefined;
        lineHeight?: number | undefined;
        readingMode?: "paginated" | "scroll" | undefined;
        notifications?: boolean | undefined;
    }>>;
}, "strip", z.ZodTypeAny, {
    name?: string | undefined;
    avatarUrl?: string | null | undefined;
    preferences?: {
        theme?: "light" | "dark" | "system" | undefined;
        fontSize?: number | undefined;
        fontFamily?: string | undefined;
        lineHeight?: number | undefined;
        readingMode?: "paginated" | "scroll" | undefined;
        notifications?: boolean | undefined;
    } | undefined;
}, {
    name?: string | undefined;
    avatarUrl?: string | null | undefined;
    preferences?: {
        theme?: "light" | "dark" | "system" | undefined;
        fontSize?: number | undefined;
        fontFamily?: string | undefined;
        lineHeight?: number | undefined;
        readingMode?: "paginated" | "scroll" | undefined;
        notifications?: boolean | undefined;
    } | undefined;
}>;
export declare const forgotPasswordSchema: z.ZodObject<{
    email: z.ZodString;
}, "strip", z.ZodTypeAny, {
    email: string;
}, {
    email: string;
}>;
export declare const resetPasswordSchema: z.ZodObject<{
    token: z.ZodString;
    password: z.ZodString;
}, "strip", z.ZodTypeAny, {
    token: string;
    password: string;
}, {
    token: string;
    password: string;
}>;
export type RegisterInput = z.infer<typeof registerSchema>;
export type LoginInput = z.infer<typeof loginSchema>;
export type UpdateProfileInput = z.infer<typeof updateProfileSchema>;
//# sourceMappingURL=auth.schemas.d.ts.map