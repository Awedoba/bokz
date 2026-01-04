import { io } from 'socket.io-client';
import { defineNuxtPlugin } from '#app';
import { useAuthStore } from '~/stores/auth';

export default defineNuxtPlugin((nuxtApp) => {
    const config = useRuntimeConfig();
    const authStore = useAuthStore();

    // Only connect if authenticated
    // We can also connect on demand
    const socket = io(config.public.apiBase.replace('/api', ''), {
        autoConnect: false,
        withCredentials: true,
    });

    return {
        provide: {
            socket,
        },
    };
});
