import * as schema from './schema/index.js';
declare const client: import("@libsql/client").Client;
export declare const db: import("drizzle-orm/libsql").LibSQLDatabase<typeof schema> & {
    $client: import("@libsql/client").Client;
};
export { client };
//# sourceMappingURL=index.d.ts.map