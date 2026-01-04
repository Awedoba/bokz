import express from 'express';
import cors from 'cors';
import cookieParser from 'cookie-parser';
import { createServer } from 'http';
import { Server as SocketServer } from 'socket.io';

import { config } from './config/index.js';
import { errorHandler, notFound } from './middleware/index.js';
import { authRouter, bookRouter, collectionRouter, readerRouter } from './routes/index.js';

// Initialize Express app
const app = express();
const httpServer = createServer(app);

// Initialize Socket.io
const io = new SocketServer(httpServer, {
    cors: {
        origin: config.cors.origin,
        credentials: true,
    },
});

// ============================================
// MIDDLEWARE
// ============================================

const corsOptions = {
    origin: config.cors.origin,
    credentials: true,
};

console.log('Allowed CORS Origins:', config.cors.origin);

app.use(cors(corsOptions));
// Enable pre-flight across-the-board
app.options(/(.*)/, cors(corsOptions));

app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

// Request logging in development
if (config.env === 'development') {
    app.use((req, res, next) => {
        console.log(`${new Date().toISOString()} ${req.method} ${req.path}`);
        next();
    });
}

// ============================================
// ROUTES
// ============================================

// Health check
app.get('/api/health', (req, res) => {
    res.json({
        status: 'ok',
        timestamp: new Date().toISOString(),
        env: config.env,
    });
});

// Auth routes
app.use('/api/auth', authRouter);
app.use('/api/books', bookRouter);
app.use('/api/collections', collectionRouter);
app.use('/api/reader', readerRouter);

// Serve uploads
app.use('/uploads', express.static(config.upload.dir));

// TODO: Add more routes as implemented
// app.use('/api/collections', collectionsRouter);
// app.use('/api/annotations', annotationsRouter);
// app.use('/api/analytics', analyticsRouter);
// app.use('/api/settings', settingsRouter);

// ============================================
// ERROR HANDLING
// ============================================

app.use(notFound);
app.use(errorHandler);

// ============================================
// SOCKET.IO
// ============================================

io.on('connection', (socket) => {
    console.log(`Socket connected: ${socket.id}`);

    // Join user room for real-time sync
    socket.on('join', (userId: string) => {
        socket.join(`user:${userId}`);
        console.log(`User ${userId} joined room`);
    });

    // Handle reading progress sync
    socket.on('progress:update', (data) => {
        // Broadcast to other devices of same user
        socket.to(`user:${data.userId}`).emit('progress:sync', data);
    });

    // Handle bookmark sync
    socket.on('bookmark:update', (data) => {
        socket.to(`user:${data.userId}`).emit('bookmark:sync', data);
    });

    // Handle annotation sync
    socket.on('annotation:update', (data) => {
        socket.to(`user:${data.userId}`).emit('annotation:sync', data);
    });

    socket.on('disconnect', () => {
        console.log(`Socket disconnected: ${socket.id}`);
    });
});

// ============================================
// START SERVER
// ============================================

httpServer.listen(config.port, () => {
    console.log(`
╔═══════════════════════════════════════════╗
║       📚 Bokz API Server Started          ║
╠═══════════════════════════════════════════╣
║  Port:        ${String(config.port).padEnd(27)}║
║  Environment: ${config.env.padEnd(27)}║
║  Database:    ${config.database.url.slice(0, 27).padEnd(27)}║
╚═══════════════════════════════════════════╝
  `);
});

export { app, io };
