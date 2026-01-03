import { defineConfig } from 'drizzle-kit';

export default defineConfig({
    schema: './src/db/schema/index.ts',
    out: './drizzle',
    dialect: 'sqlite',
    dbCredentials: {
        url: `file:${process.env.DATABASE_URL || './data/bokz.db'}`,
    },
});
