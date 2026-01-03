import { defineStore } from 'pinia';
import { useAuthStore } from './auth';

export interface Book {
    id: string;
    title: string;
    author?: string;
    coverUrl?: string;
    format: string;
    totalPages?: number;
    readingProgress?: {
        percentage: number;
    }[];
    createdAt: string;
}

export const useBookStore = defineStore('books', () => {
    const books = ref<Book[]>([]);
    const loading = ref(false);
    const error = ref<string | null>(null);
    const viewMode = ref<'grid' | 'list'>('grid');

    const auth = useAuthStore();
    const config = useRuntimeConfig();

    function setViewMode(mode: 'grid' | 'list') {
        viewMode.value = mode;
    }

    async function fetchBooks(params: { search?: string; format?: string } = {}) {
        loading.value = true;
        error.value = null;
        try {
            const { data, error: apiError } = await useFetch('/api/books', {
                baseURL: config.public.apiBase,
                headers: { Authorization: `Bearer ${auth.accessToken}` },
                params,
            });

            if (data.value) {
                books.value = (data.value as any).books;
            } else if (apiError.value) {
                error.value = apiError.value.message;
            }
        } catch (err: any) {
            error.value = err.message;
        } finally {
            loading.value = false;
        }
    }

    async function uploadBook(file: File) {
        const formData = new FormData();
        formData.append('file', file);

        try {
            const { data, error: apiError } = await useFetch('/api/books', {
                method: 'POST',
                baseURL: config.public.apiBase,
                headers: { Authorization: `Bearer ${auth.accessToken}` },
                body: formData,
            });

            if (apiError.value) throw new Error(apiError.value.message);

            // Add new book to start of list
            const newBook = (data.value as any).book;
            books.value.unshift(newBook);

            return newBook;
        } catch (err: any) {
            throw err;
        }
    }

    async function deleteBook(bookId: string) {
        try {
            await $fetch(`/api/books/${bookId}`, {
                method: 'DELETE',
                baseURL: config.public.apiBase,
                headers: { Authorization: `Bearer ${auth.accessToken}` },
            });

            books.value = books.value.filter(b => b.id !== bookId);
        } catch (err: any) {
            throw err;
        }
    }

    return {
        books,
        loading,
        error,
        viewMode,
        setViewMode,
        fetchBooks,
        uploadBook,
        deleteBook
    };
});
