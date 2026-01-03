import 'dotenv/config';
export declare const config: {
    readonly env: string;
    readonly port: number;
    readonly database: {
        readonly url: string;
    };
    readonly jwt: {
        readonly secret: string;
        readonly expiresIn: string;
        readonly refreshExpiresIn: string;
    };
    readonly oauth: {
        readonly google: {
            readonly clientId: string | undefined;
            readonly clientSecret: string | undefined;
        };
        readonly apple: {
            readonly clientId: string | undefined;
            readonly clientSecret: string | undefined;
        };
    };
    readonly cors: {
        readonly origin: string;
    };
    readonly upload: {
        readonly dir: string;
        readonly maxFileSize: number;
    };
};
export type Config = typeof config;
//# sourceMappingURL=index.d.ts.map