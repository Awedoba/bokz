export default defineNuxtPlugin(async (nuxtApp) => {
    const authStore = useAuthStore()
    // Synchronously restore from localStorage if possible
    authStore.initAuth()
})
