import { defineStore } from 'pinia';
import { useAuthStore } from './auth';

export interface Collection {
    id: string;
    name: string;
    description?: string;
    color: string;
    bookCollections?: { book: any }[];
    _count?: { books: number };
}

export const useCollectionStore = defineStore('collections', () => {
    const collections = ref<Collection[]>([]);
    const loading = ref(false);
    const error = ref<string | null>(null);

    const auth = useAuthStore();
    const config = useRuntimeConfig();

    async function fetchCollections() {
        loading.value = true;
        try {
            const { data } = await useFetch('/api/collections', {
                baseURL: config.public.apiBase,
                headers: { Authorization: `Bearer ${auth.accessToken}` },
            });

            if (data.value) {
                collections.value = (data.value as any).collections;
            }
        } catch (err: any) {
            error.value = err.message;
        } finally {
            loading.value = false;
        }
    }

    async function createCollection(data: { name: string; description?: string; color?: string }) {
        try {
            const { data: resData, error: apiError } = await useFetch('/api/collections', {
                method: 'POST',
                baseURL: config.public.apiBase,
                headers: { Authorization: `Bearer ${auth.accessToken}` },
                body: data,
            });

            if (apiError.value) throw new Error(apiError.value.message);

            const newCollection = (resData.value as any).collection;
            collections.value.unshift(newCollection);
            return newCollection;
        } catch (err: any) {
            throw err;
        }
    }

    async function deleteCollection(id: string) {
        try {
            await $fetch(`/api/collections/${id}`, {
                method: 'DELETE',
                baseURL: config.public.apiBase,
                headers: { Authorization: `Bearer ${auth.accessToken}` },
            });

            collections.value = collections.value.filter(c => c.id !== id);
        } catch (err: any) {
            throw err;
        }
    }

    return {
        collections,
        loading,
        error,
        fetchCollections,
        createCollection,
        deleteCollection,
    };
});
