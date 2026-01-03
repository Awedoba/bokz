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
        setUser(user: User) {
            this.user = user;
        },

        setToken(token: string) {
            this.accessToken = token;
        },

        clearAuth() {
            this.user = null;
            this.accessToken = null;
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
                    this.user = (data.value as any).user;
                } else if (error.value) {
                    this.clearAuth();
                }
            } catch (err) {
                this.clearAuth();
            } finally {
                this.loading = false;
                this.initialized = true;
            }
        },

        // Initial load from cookies if available
        initAuth() {
            const token = useCookie('accessToken').value;
            if (token) {
                this.accessToken = token;
                this.fetchUser();
            } else {
                this.initialized = true;
            }
        }
    }
});
