# Bokz - Book Reader Application

A modern web-based book reader with offline support, real-time sync, and rich annotation features.

## Project Structure

```
bokz/
├── backend/          # Node.js API server
├── web/              # Nuxt.js frontend
├── ui templates/     # Design reference images
└── docs/             # Documentation
```

## Quick Start

### Backend
```bash
cd backend
npm install
npm run dev
```

### Frontend
```bash
cd web
npm install
npm run dev
```

## Features

- 📚 **Library Management** - Collections, search, filtering
- 📖 **Multi-format Reader** - EPUB, PDF, TXT support
- 🔖 **Bookmarks & Annotations** - Highlights, notes, tabs
- 🔄 **Real-time Sync** - Cross-device synchronization
- 📴 **Offline Support** - PWA with local caching
- 🔊 **Audio** - Text-to-speech and audiobook support
- 📊 **Analytics** - Reading stats and goals
- 🌙 **Themes** - Light and dark modes

## Documentation

- [Implementation Plan](docs/implementation_plan.md)
- [API Documentation](docs/api/README.md)
- [User Guide](docs/guides/user-guide.md)
- [Developer Guide](docs/guides/developer-guide.md)

## Tech Stack

**Backend:** Node.js, Express, SQLite, Drizzle ORM, Socket.io  
**Frontend:** Nuxt 3, TailwindCSS, Pinia, epub.js, PDF.js  
**Deploy:** Railway (backend), Vercel (frontend)

## License

MIT
