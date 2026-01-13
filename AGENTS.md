# AGENTS.md — Bokz repo guidance

This repository contains a Node/TypeScript backend and a Nuxt frontend.
These notes are optimized for agentic coding tools (Codex/opencode/etc.).

## Repo layout

- `backend/` — Node.js 20+ API server (Express 5, Socket.io, SQLite, Drizzle, Zod)
- `web/` — Nuxt 4 frontend (Tailwind, Pinia)
- `docs/` — project notes
- `ui templates/` — design reference images

## Prerequisites

- Node.js: use a modern LTS (recommended: Node 20+)
- Package managers:
  - Backend uses `npm` (has `backend/package-lock.json`)
  - Web uses `pnpm` (has `web/pnpm-lock.yaml`)

## Build / lint / test commands

### Backend (`backend/`)

Install:
- `cd backend && npm ci`

Dev server:
- `cd backend && npm run dev`

Build (TypeScript emit):
- `cd backend && npm run build`

Start built server:
- `cd backend && npm run start`

DB / migrations (drizzle-kit):
- `cd backend && npm run db:generate`
- `cd backend && npm run db:migrate`
- `cd backend && npm run db:push`
- `cd backend && npm run db:studio`

Single “test” / targeted repro (no formal test runner currently):
- Run one-off TS scripts with tsx:
  - `cd backend && npx tsx test-uuid.ts`
  - `cd backend && npx tsx test-epub.ts`
  - `cd backend && npx tsx test-pdf.ts`

Quick smoke checks:
- Health endpoint (after starting backend): `curl http://localhost:3001/api/health`

Lint / format:
- No repo-wide lint/format scripts are configured yet.
- Avoid introducing new tooling unprompted; keep formatting consistent with nearby code.

### Web (`web/`)

Install:
- `cd web && pnpm install`

Dev server:
- `cd web && pnpm dev`  (Nuxt)

Build:
- `cd web && pnpm build`

Preview build:
- `cd web && pnpm preview`

Single “test”:
- No test runner configured in `web/package.json` currently.

Lint / format:
- No lint/format scripts are configured in `web/package.json` currently.

## Cursor / Copilot / agent rules

- No Cursor rules were found (`.cursor/rules/` or `.cursorrules`).
- No Copilot instructions were found (`.github/copilot-instructions.md`).
- If these are added later, mirror/extend them here.

## Code style guidelines

### General

- Prefer small, reviewable changes; avoid unrelated refactors.
- Keep existing conventions per package (`backend/` vs `web/`).
- TypeScript is generally `strict`; keep type safety (avoid `any` unless unavoidable).
- Use explicit names (avoid one-letter identifiers outside small callbacks).

### Imports

Backend (`backend/`):
- Group imports: built-ins → external deps → internal modules.
- Keep blank line between groups.
- IMPORTANT: this backend uses ESM and keeps `.js` extensions in internal imports
  inside TypeScript (e.g. `import { foo } from './foo.js'`). Preserve this.

Web (`web/`):
- Use Nuxt conventions:
  - Prefer `~/...` aliases for app imports when used in existing files.
  - Leverage Nuxt auto-imports where idiomatic (`useRouter`, `useFetch`, etc.).
- Keep import lists short; split long imports across multiple lines.

### Formatting

- Match the file you are editing.
  - Backend files commonly use 4-space indentation and semicolons.
  - Vue SFC templates commonly use 2-space indentation.
- Prefer trailing commas for multiline objects/arrays.
- Keep lines reasonably short; wrap long object literals instead of horizontal scrolling.

### Naming and file organization

Backend (`backend/src/`):
- Naming patterns in use:
  - Routes: `*.routes.ts` (e.g. `auth.routes.ts`)
  - Schemas: `*.schemas.ts` (Zod)
  - Services: `*.service.ts`
  - Middleware: `*.middleware.ts`
- Prefer `camelCase` for variables/functions, `PascalCase` for types/classes.
- Route paths live under `/api/...` and are mounted in `src/index.ts`.

Web (`web/app/`):
- Vue components: `PascalCase.vue` when used as components.
- Pages: follow Nuxt file-based routing (often `kebab` or simple names like `login.vue`).
- Pinia stores live in `app/stores/` (e.g. `auth.ts`).

### Types and runtime validation

Backend:
- Validate request input with Zod schemas and the `validate()` middleware.
- Prefer deriving types from schemas (`z.infer<typeof schema>`) for request bodies.
- Prefer `unknown` in catch blocks; narrow via `instanceof`/guards.
  - When existing code uses `catch (error: any)`, don’t churn it unless needed.

Web:
- Prefer typed store state and explicit interfaces when expanding stores.
- When calling APIs, normalize error handling (use `onResponseError`/try-catch).

### Error handling

Backend:
- Wrap async route handlers with `asyncHandler()`.
- For expected failures:
  - Return an appropriate status code + JSON `{ error: string }` (as existing routes do), or
  - Throw an `ApiError` created via `createError(message, statusCode, code?)`.
- Let unexpected exceptions bubble to `errorHandler`.
- Keep error payloads stable; avoid leaking secrets. Stack traces should stay dev-only.

Web:
- Show user-friendly messages; log details to console only when helpful.
- Avoid swallowing errors silently unless the UX demands it.

### Security / correctness footguns

- Backend auth relies on JWT + cookies; keep cookie flags consistent (`httpOnly`, `secure` in prod).
- CORS origins are configurable; avoid widening them casually.
- Uploaded files are served from `/uploads`; validate file types/sizes in upload middleware.

## When adding new tests/linting (optional future work)

- If you introduce a test runner, document:
  - `test` (all tests)
  - `test:watch`
  - “single test” command (file/grep-based)
- If you introduce a formatter/linter (ESLint/Biome/Prettier), add:
  - `lint` / `lint:fix`
  - `format` / `format:check`
  - Keep configs shared across `backend/` and `web/` only if practical.
