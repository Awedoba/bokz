import { defineStore } from 'pinia';
import { ref } from 'vue';
import { useAuthStore } from './auth';
import { useSyncStore } from './sync';

export const useReaderStore = defineStore('reader', () => {
    const settings = ref({
        fontSize: 100, // percentage
        theme: 'light', // light, dark, sepia
        fontFamily: 'serif',
    });

    const currentLocation = ref<string | null>(null);
    const progress = ref(0);
    const bookId = ref<string | null>(null);

    const auth = useAuthStore();
    const config = useRuntimeConfig();

    async function saveProgress(bId: string, location: string, percentage: number) {
        if (!auth.isAuthenticated) return;

        try {
            // Optimistic update
            currentLocation.value = location;
            progress.value = percentage;
            bookId.value = bId;

            // Real-time Sync
            const syncStore = useSyncStore();
            syncStore.emitProgressUpdate(bId, { location, percentage });

            await $fetch(`/api/reader/${bId}/progress`, {
                method: 'POST',
                baseURL: config.public.apiBase,
                headers: { Authorization: `Bearer ${auth.accessToken}` },
                body: {
                    location,
                    percentage: Math.round(percentage * 100) / 100, // round to 2 decimals
                }
            });
        } catch (err) {
            console.error('Failed to save progress', err);
        }
    }

    return {
        settings,
        currentLocation,
        progress,
        bookId,
        saveProgress,
    };
});
