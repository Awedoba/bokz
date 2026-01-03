# Refined Prompt: Bokz Book Reader Application

Use this prompt to generate the book reader application step by step.

---

## Project Overview

Create a web-based book reader application called **Bokz** with:
- **Backend**: Node.js API in `/backend` folder
- **Frontend**: Nuxt.js app in `/web` folder
- **Database**: SQLite with Drizzle ORM
- **Design**: Follow templates in `/ui templates` (dark/light themes)

---

## Core Requirements

### Authentication
- Email/password registration and login with JWT
- OAuth support (Google, Apple)
- Guest mode with local-only data storage
- Password reset via email
- Profile management and account deletion

### Book Management
- Import: EPUB, PDF, TXT (single and bulk)
- Export: Library backup (ZIP), book metadata
- Metadata parsing and cover extraction
- Local filesystem storage

### Library
- Grid and list view toggle
- Collections with name, color, description
- Search by title, author, content
- Filter by collection, format, reading status
- Sort by title, author, date, last read
- Drag-and-drop organization

### Reader
- EPUB: epub.js with pagination and scroll modes
- PDF: PDF.js with zoom and page navigation
- TXT: Clean typography with adjustable margins
- Table of contents navigation
- Keyboard shortcuts and touch gestures
- Distraction-free reading mode

### Bookmarks & Progress
- Quick bookmark with optional notes
- Auto-save reading position
- Visual progress bar
- Cross-device sync via WebSocket

### Annotations
- Highlight with multiple colors
- Underline text
- Add notes to selections
- Annotation tabs for organizing thoughts
- Search all annotations
- Export to Markdown/JSON

### Audio
- Text-to-speech for any book
- Multiple voice options
- Playback speed control
- Highlight current text while reading
- Audiobook file support (MP3, M4A)

### Analytics
- Reading time (daily/weekly/monthly)
- Pages read and books completed
- Reading streaks
- Yearly reading goals

### Settings
- Light/dark/system themes
- Font family and size
- Line height and margins
- Reading mode (sepia, night)
- Notification preferences
- Data export options

---

## Technical Specifications

### Backend Stack
```
Node.js 20 LTS
Express.js
SQLite + better-sqlite3
Drizzle ORM
JWT for authentication
Socket.io for real-time sync
Zod for validation
```

### Frontend Stack
```
Nuxt 3
TailwindCSS
Pinia for state
Headless UI for components
epub.js for EPUB
PDF.js for PDF
Howler.js for audio
PWA + Service Workers
```

### Deployment
- Backend: Railway or Render
- Frontend: Vercel
- SQLite file persisted on backend host

---

## Sync & Offline Requirements

1. **Real-time sync** via WebSocket for:
   - Reading progress
   - Bookmarks
   - Annotations
   - Settings

2. **Offline support**:
   - PWA with service worker
   - IndexedDB for local data
   - Queue changes when offline
   - Sync on reconnection

3. **Conflict resolution**:
   - Last-write-wins with timestamps
   - Preserve both versions for annotations

---

## Design Guidelines

Based on provided UI templates:
- Dark theme: Rich backgrounds, subtle gradients
- Accent color: Purple/violet
- Typography: Clean sans-serif for UI, serif option for reading
- Book covers: 2:3 aspect ratio, rounded corners
- Cards: Subtle borders, hover lift effects
- Reader: Slide-out panels, minimal chrome

---

## Implementation Order

1. **Phase 1**: Backend setup, auth, database schema
2. **Phase 2**: Book upload, library views, collections
3. **Phase 3**: Reader (EPUB, PDF, TXT), progress tracking
4. **Phase 4**: Annotations, bookmarks, search
5. **Phase 5**: WebSocket sync, PWA, offline support
6. **Phase 6**: TTS, audiobook player
7. **Phase 7**: Analytics, goals, settings polish
8. **Phase 8**: Deployment, monitoring

---

## Output Expectations

For each phase, provide:
1. Complete, working code files
2. Clear file paths
3. Dependencies in package.json
4. Database migrations
5. Brief explanation of key decisions

Prioritize:
- Clean, maintainable code
- Performance (lazy loading, virtual scrolling)
- Accessibility (ARIA, keyboard navigation)
- Security (input validation, secure auth)
