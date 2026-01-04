import { defineStore } from 'pinia';
import { useAuthStore } from './auth';
import type { Socket } from 'socket.io-client';

export const useSyncStore = defineStore('sync', () => {
    const { $socket } = useNuxtApp();
    const socket = $socket as Socket;
    const auth = useAuthStore();

    const isConnected = ref(false);

    function connect() {
        if (!auth.isAuthenticated) return;

        if (!socket.connected) {
            socket.connect();
        }

        socket.emit('join', auth.user.id);
        isConnected.value = true;
    }

    function disconnect() {
        if (socket.connected) {
            socket.disconnect();
        }
        isConnected.value = false;
    }

    function emitProgressUpdate(bookId: string, data: any) {
        if (!isConnected.value) connect();
        socket.emit('progress:update', {
            userId: auth.user.id,
            bookId,
            ...data,
            syncedAt: new Date()
        });
    }

    // Listeners should be set up where needed (e.g. in Reader component)
    // or we can set up global listeners here if they update the store directly

    return {
        socket,
        isConnected,
        connect,
        disconnect,
        emitProgressUpdate,
    };
});
