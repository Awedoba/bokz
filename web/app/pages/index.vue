<template>
  <div>
    <!-- Welcome Header -->
    <div class="mb-6 flex items-center justify-between">
      <div>
        <h1 class="text-2xl font-bold dark:text-white">Welcome back, {{ authStore.user?.name?.split(' ')[0] || 'Reader' }}!</h1>
        <p class="text-gray-600 dark:text-gray-400">Ready to continue your reading journey?</p>
      </div>
    </div>

    <!-- Continue Reading -->
    <div class="mb-8">
      <div class="flex items-center justify-between mb-4">
        <h2 class="text-lg font-semibold dark:text-white">Continue Reading</h2>
        <NuxtLink to="/library" class="text-sm text-purple-600 hover:text-purple-500 dark:text-purple-400">View all</NuxtLink>
      </div>
      
      <!-- Recent Books -->
      <div v-if="bookStore.books.length > 0" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <NuxtLink 
          v-for="book in bookStore.books.slice(0, 3)" 
          :key="book.id"
          :to="'/read/' + book.id"
          class="bg-white dark:bg-dark-surface rounded-xl shadow-sm border border-gray-100 dark:border-gray-800 p-4 flex items-start space-x-4 hover:shadow-md transition-shadow"
        >
          <div class="w-16 h-24 flex-shrink-0 bg-gray-200 dark:bg-gray-800 rounded overflow-hidden">
             <img 
               v-if="book.coverUrl" 
               :src="getCoverUrl(book.coverUrl)" 
               class="w-full h-full object-cover"
             />
             <div v-else class="w-full h-full flex items-center justify-center text-xs font-bold text-gray-400">
               {{ book.format }}
             </div>
          </div>
          <div>
            <h3 class="font-medium text-gray-900 dark:text-white line-clamp-2">{{ book.title }}</h3>
            <p class="text-xs text-gray-500 dark:text-gray-400 mt-1">{{ book.author || 'Unknown Author' }}</p>
            <div class="mt-3 flex items-center text-xs font-medium text-purple-600 dark:text-purple-400">
              Continue reading <Icon name="heroicons:arrow-right" class="w-3 h-3 ml-1" />
            </div>
          </div>
        </NuxtLink>
      </div>

      <!-- Empty State -->
      <div v-else class="bg-white dark:bg-dark-surface rounded-xl shadow-sm border border-gray-100 dark:border-gray-800 p-6 flex flex-col items-center justify-center h-48 text-center">
        <div class="w-12 h-12 bg-gray-100 dark:bg-gray-800 rounded-full flex items-center justify-center mb-3">
          <Icon name="heroicons:book-open" class="w-6 h-6 text-gray-400" />
        </div>
        <h3 class="font-medium text-gray-900 dark:text-white mb-1">No books in progress</h3>
        <p class="text-sm text-gray-500 dark:text-gray-400 mb-4">Pick a book from your library to start reading</p>
        <NuxtLink to="/library" class="text-sm font-medium text-purple-600 hover:text-purple-500 dark:text-purple-400">Go to Library</NuxtLink>
      </div>
    </div>

    <!-- Recent Activity / Stats Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <!-- Time Read -->
      <div class="bg-white dark:bg-dark-surface p-6 rounded-xl shadow-sm border border-gray-100 dark:border-gray-800">
        <div class="flex items-center justify-between mb-4">
          <h3 class="font-semibold dark:text-white">Reading Time</h3>
          <Icon name="heroicons:clock" class="w-5 h-5 text-gray-400" />
        </div>
        <div class="text-3xl font-bold text-gray-900 dark:text-white mb-1">0h</div>
        <div class="text-sm text-gray-500 dark:text-gray-400">This week</div>
      </div>

      <!-- Books Read -->
      <div class="bg-white dark:bg-dark-surface p-6 rounded-xl shadow-sm border border-gray-100 dark:border-gray-800">
        <div class="flex items-center justify-between mb-4">
          <h3 class="font-semibold dark:text-white">Books Finished</h3>
          <Icon name="heroicons:trophy" class="w-5 h-5 text-gray-400" />
        </div>
        <div class="text-3xl font-bold text-gray-900 dark:text-white mb-1">0</div>
        <div class="text-sm text-gray-500 dark:text-gray-400">Total completed</div>
      </div>

      <!-- Streak -->
      <div class="bg-white dark:bg-dark-surface p-6 rounded-xl shadow-sm border border-gray-100 dark:border-gray-800">
        <div class="flex items-center justify-between mb-4">
          <h3 class="font-semibold dark:text-white">Current Streak</h3>
          <Icon name="heroicons:fire" class="w-5 h-5 text-orange-500" />
        </div>
        <div class="text-3xl font-bold text-gray-900 dark:text-white mb-1">0</div>
        <div class="text-sm text-gray-500 dark:text-gray-400">days in a row</div>
      </div>
    </div>

  </div>
</template>

<script setup>
import { useAuthStore } from '~/stores/auth'
import { useBookStore } from '~/stores/books'

definePageMeta({
  middleware: (to, from) => {
    const auth = useAuthStore()
    if (!auth.isAuthenticated && to.path !== '/login' && to.path !== '/register') {
      return navigateTo('/login')
    }
  }
})

const authStore = useAuthStore()
const bookStore = useBookStore()
const config = useRuntimeConfig()

onMounted(() => {
  if (bookStore.books.length === 0) {
    bookStore.fetchBooks()
  }
})

function getCoverUrl(path) {
  if (!path) return '';
  return `${config.public.apiBase.replace('/api', '')}/uploads/${path}`;
}
</script>
