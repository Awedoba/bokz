import { createClient } from '@libsql/client';
import { drizzle } from 'drizzle-orm/libsql';
import { config } from '../config/index.js';
import * as schema from './schema/index.js';
import { existsSync, mkdirSync } from 'fs';
import { dirname } from 'path';

// Ensure database directory exists
const dbDir = dirname(config.database.url);
if (!existsSync(dbDir)) {
    mkdirSync(dbDir, { recursive: true });
}

// Create libsql client (works with local SQLite files)
const client = createClient({
    url: `file:${config.database.url}`,
});

// Create Drizzle instance
export const db = drizzle(client, { schema });

export { client };
