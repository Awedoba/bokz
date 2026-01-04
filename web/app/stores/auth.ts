import { defineStore } from 'pinia';

export interface User {
    id: string;
    email?: string;
    name: string;
    avatarUrl?: string;
    isGuest: boolean;
    preferences?: any;
}

export const useAuthStore = defineStore('auth', {
    state: () => ({
        user: null as User | null,
        accessToken: null as string | null,
        loading: false,
        initialized: false,
    }),

    getters: {
        isAuthenticated: (state) => !!state.user,
        isGuest: (state) => state.user?.isGuest === true,
    },

    actions: {
        setUser(user: User | null) {
            this.user = user;
            if (import.meta.client && user) {
                localStorage.setItem('user', JSON.stringify(user));
            }
        },

        setToken(token: string | null) {
            this.accessToken = token;
            if (import.meta.client && token) {
                localStorage.setItem('accessToken', token);
                const cookie = useCookie('accessToken');
                cookie.value = token; // Keep cookie in sync for potential SSR use
            }
        },

        clearAuth() {
            this.user = null;
            this.accessToken = null;
            if (import.meta.client) {
                localStorage.removeItem('user');
                localStorage.removeItem('accessToken');
            }
            const cookie = useCookie('accessToken');
            cookie.value = null;
        },

        async fetchUser() {
            if (!this.accessToken) return;

            this.loading = true;
            try {
                const { data, error } = await useFetch('/api/auth/me', {
                    baseURL: useRuntimeConfig().public.apiBase,
                    headers: {
                        Authorization: `Bearer ${this.accessToken}`
                    }
                });

                if (data.value) {
                    this.setUser((data.value as any).user);
                } else if (error.value) {
                    this.clearAuth();
                    navigateTo('/login'); // Force redirect on invalid token
                }
            } catch (err) {
                this.clearAuth();
                navigateTo('/login');
            } finally {
                this.loading = false;
                this.initialized = true;
            }
        },

        // Initial load from storage
        initAuth() {
            if (import.meta.client) {
                const token = localStorage.getItem('accessToken');
                const user = localStorage.getItem('user');

                if (token) {
                    this.accessToken = token;
                    if (user) {
                        try {
                            this.user = JSON.parse(user);
                        } catch (e) {
                            console.error('Failed to parse user from local storage', e);
                        }
                    }
                    // Validate token
                    this.fetchUser();
                } else {
                    this.initialized = true;
                }
            } else {
                // Server-side fallback (if needed)
                const token = useCookie('accessToken').value;
                if (token) {
                    this.accessToken = token;
                }
                this.initialized = true;
            }
        }
    }
});
