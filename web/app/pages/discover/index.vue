<template>
  <div class="px-4 sm:px-6 lg:px-8 py-8">
    <div class="mb-8">
      <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Discover</h1>
      <p class="mt-2 text-gray-600 dark:text-gray-400">Explore new additions and trending books.</p>
    </div>

    <!-- Loading State -->
    <div v-if="pending" class="flex justify-center py-12">
      <Icon name="svg-spinners:90-ring-with-bg" class="w-8 h-8 text-purple-600" />
    </div>

    <!-- Error State -->
    <div v-else-if="error" class="p-4 mb-6 text-red-700 bg-red-100 rounded-lg dark:bg-red-900/30 dark:text-red-400">
      Failed to load discovery content.
    </div>

    <div v-else class="space-y-12">
      <!-- Recent Section -->
      <section>
        <div class="flex items-center justify-between mb-4">
          <h2 class="text-xl font-semibold text-gray-900 dark:text-white flex items-center">
            <Icon name="heroicons:clock" class="w-5 h-5 mr-2 text-purple-500" />
            Recently Added
          </h2>
        </div>
        
        <div v-if="data?.recent?.length" class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 gap-6">
          <div v-for="book in data.recent" :key="book.id" class="group relative">
             <NuxtLink :to="'/read/' + book.id" class="aspect-[2/3] w-full block overflow-hidden rounded-lg bg-gray-200 dark:bg-gray-800 shadow transition-all duration-200 group-hover:shadow-lg group-hover:-translate-y-1">
              <img 
                v-if="book.coverUrl" 
                :src="getCoverUrl(book.coverUrl)" 
                :alt="book.title" 
                class="h-full w-full object-cover object-center"
              />
              <div v-else class="flex h-full w-full flex-col items-center justify-center p-4 text-center bg-gradient-to-br from-purple-100 to-blue-50 dark:from-purple-900/30 dark:to-blue-900/20">
                <span class="font-serif text-lg font-bold text-gray-900 dark:text-white line-clamp-3">{{ book.title }}</span>
                <span class="mt-2 text-xs text-gray-500 dark:text-gray-400 line-clamp-1">{{ book.author || 'Unknown Author' }}</span>
                <span class="mt-auto px-2 py-0.5 text-[10px] font-bold uppercase tracking-wider bg-black/5 dark:bg-white/10 rounded">{{ book.format }}</span>
              </div>
            </NuxtLink>
            <div class="mt-2">
              <h3 class="text-sm font-medium text-gray-900 dark:text-white truncate" :title="book.title">
                {{ book.title }}
              </h3>
              <p class="text-xs text-gray-500 dark:text-gray-400 truncate">{{ book.author || 'Unknown Author' }}</p>
            </div>
          </div>
        </div>
        <div v-else class="text-gray-500 dark:text-gray-400 text-sm">No recent books found.</div>
      </section>

      <!-- Trending Section (Using same data for now) -->
      <section>
        <div class="flex items-center justify-between mb-4">
          <h2 class="text-xl font-semibold text-gray-900 dark:text-white flex items-center">
            <Icon name="heroicons:fire" class="w-5 h-5 mr-2 text-orange-500" />
            Trending Now
          </h2>
        </div>
        
        <div v-if="data?.trending?.length" class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 gap-6">
           <div v-for="book in data.trending" :key="book.id" class="group relative">
             <NuxtLink :to="'/read/' + book.id" class="aspect-[2/3] w-full block overflow-hidden rounded-lg bg-gray-200 dark:bg-gray-800 shadow transition-all duration-200 group-hover:shadow-lg group-hover:-translate-y-1">
              <img 
                v-if="book.coverUrl" 
                :src="getCoverUrl(book.coverUrl)" 
                :alt="book.title" 
                class="h-full w-full object-cover object-center"
              />
              <div v-else class="flex h-full w-full flex-col items-center justify-center p-4 text-center bg-gradient-to-br from-purple-100 to-blue-50 dark:from-purple-900/30 dark:to-blue-900/20">
                <span class="font-serif text-lg font-bold text-gray-900 dark:text-white line-clamp-3">{{ book.title }}</span>
                <span class="mt-2 text-xs text-gray-500 dark:text-gray-400 line-clamp-1">{{ book.author || 'Unknown Author' }}</span>
                <span class="mt-auto px-2 py-0.5 text-[10px] font-bold uppercase tracking-wider bg-black/5 dark:bg-white/10 rounded">{{ book.format }}</span>
              </div>
            </NuxtLink>
            <div class="mt-2">
              <h3 class="text-sm font-medium text-gray-900 dark:text-white truncate" :title="book.title">
                {{ book.title }}
              </h3>
              <p class="text-xs text-gray-500 dark:text-gray-400 truncate">{{ book.author || 'Unknown Author' }}</p>
            </div>
          </div>
        </div>
        <div v-else class="text-gray-500 dark:text-gray-400 text-sm">No trending books yet.</div>
      </section>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useAuthStore } from '~/stores/auth';

const config = useRuntimeConfig();
const authStore = useAuthStore();

const { data, pending, error, refresh } = await useFetch('/api/books/discover', {
  baseURL: config.public.apiBase,
  headers: {
    Authorization: `Bearer ${authStore.accessToken}`
  }
});

function getCoverUrl(path: string) {
  if (!path) return '';
  return `${config.public.apiBase.replace('/api', '')}/uploads/${path}`;
}
</script>
