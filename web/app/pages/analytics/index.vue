<template>
  <div class="px-4 sm:px-6 lg:px-8 py-8">
    <div class="mb-8">
      <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Analytics</h1>
      <p class="mt-2 text-gray-600 dark:text-gray-400">Track your reading progress and habits.</p>
    </div>

    <!-- Loading State -->
    <div v-if="pending" class="flex justify-center py-12">
      <Icon name="svg-spinners:90-ring-with-bg" class="w-8 h-8 text-purple-600" />
    </div>

    <!-- Error State -->
    <div v-else-if="error" class="p-4 mb-6 text-red-700 bg-red-100 rounded-lg dark:bg-red-900/30 dark:text-red-400">
      Failed to load analytics data.
    </div>

    <div v-else class="space-y-8">
      <!-- Stats Grid -->
      <div class="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-4">
        <!-- Books Read -->
        <div class="relative overflow-hidden rounded-lg bg-white dark:bg-gray-800 shadow px-4 py-5 sm:px-6 sm:pt-6">
          <dt>
            <div class="absolute rounded-md bg-purple-500 p-3">
              <Icon name="heroicons:book-open" class="h-6 w-6 text-white" />
            </div>
            <p class="ml-16 truncate text-sm font-medium text-gray-500 dark:text-gray-400">Books Read</p>
          </dt>
          <dd class="ml-16 flex items-baseline pb-1 sm:pb-2">
            <p class="text-2xl font-semibold text-gray-900 dark:text-white">{{ data?.stats?.booksRead || 0 }}</p>
          </dd>
        </div>

        <!-- Pages Read -->
        <div class="relative overflow-hidden rounded-lg bg-white dark:bg-gray-800 shadow px-4 py-5 sm:px-6 sm:pt-6">
          <dt>
            <div class="absolute rounded-md bg-blue-500 p-3">
              <Icon name="heroicons:document-text" class="h-6 w-6 text-white" />
            </div>
            <p class="ml-16 truncate text-sm font-medium text-gray-500 dark:text-gray-400">Pages Read</p>
          </dt>
          <dd class="ml-16 flex items-baseline pb-1 sm:pb-2">
            <p class="text-2xl font-semibold text-gray-900 dark:text-white">{{ data?.stats?.pagesRead || 0 }}</p>
          </dd>
        </div>

        <!-- Time Spent -->
        <div class="relative overflow-hidden rounded-lg bg-white dark:bg-gray-800 shadow px-4 py-5 sm:px-6 sm:pt-6">
          <dt>
            <div class="absolute rounded-md bg-green-500 p-3">
              <Icon name="heroicons:clock" class="h-6 w-6 text-white" />
            </div>
            <p class="ml-16 truncate text-sm font-medium text-gray-500 dark:text-gray-400">Time Spent</p>
          </dt>
          <dd class="ml-16 flex items-baseline pb-1 sm:pb-2">
            <p class="text-2xl font-semibold text-gray-900 dark:text-white">{{ data?.stats?.timeSpent || 0 }} <span class="text-sm font-normal text-gray-500">hours</span></p>
          </dd>
        </div>
        
         <!-- Current Streak (Mock) -->
        <div class="relative overflow-hidden rounded-lg bg-white dark:bg-gray-800 shadow px-4 py-5 sm:px-6 sm:pt-6">
          <dt>
            <div class="absolute rounded-md bg-orange-500 p-3">
              <Icon name="heroicons:fire" class="h-6 w-6 text-white" />
            </div>
            <p class="ml-16 truncate text-sm font-medium text-gray-500 dark:text-gray-400">Current Streak</p>
          </dt>
          <dd class="ml-16 flex items-baseline pb-1 sm:pb-2">
            <p class="text-2xl font-semibold text-gray-900 dark:text-white">{{ data?.stats?.streak || 0 }} <span class="text-sm font-normal text-gray-500">days</span></p>
          </dd>
        </div>
      </div>

      <!-- Recent Sessions List -->
      <div class="rounded-lg bg-white dark:bg-gray-800 shadow">
        <div class="px-4 py-5 sm:px-6 border-b border-gray-200 dark:border-gray-700">
          <h3 class="text-base font-semibold leading-6 text-gray-900 dark:text-white">Recent Reading Sessions</h3>
        </div>
        <div class="flow-root">
          <ul role="list" class="divide-y divide-gray-200 dark:divide-gray-700">
            <li v-if="!data?.recentSessions?.length" class="px-4 py-5 sm:px-6 text-sm text-gray-500 dark:text-gray-400 text-center">
                No recent reading sessions found. Start reading to see stats here!
            </li>
            <li v-for="session in data?.recentSessions" :key="session.id" class="px-4 py-4 sm:px-6 hover:bg-gray-50 dark:hover:bg-gray-700/50 transition">
              <div class="flex items-center justify-between">
                <div class="flex items-center min-w-0 gap-x-4">
                   <div class="min-w-0 flex-auto">
                     <p class="text-sm font-semibold leading-6 text-gray-900 dark:text-white">
                        Reading Session
                     </p>
                     <p class="mt-1 flex text-xs leading-5 text-gray-500 dark:text-gray-400">
                        <span class="truncate">{{ formatDate(session.sessionDate) }}</span>
                     </p>
                   </div>
                </div>
                <div class="flex flex-col items-end gap-y-1">
                   <p class="text-sm leading-6 text-gray-900 dark:text-white">
                     {{ session.pagesRead }} pages
                   </p>
                   <p class="text-xs leading-5 text-gray-500 dark:text-gray-400">
                     {{ Math.round(session.durationSeconds / 60) }} minutes
                   </p>
                </div>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useAuthStore } from '~/stores/auth';

const config = useRuntimeConfig();
const authStore = useAuthStore();

const { data, pending, error } = await useFetch('/api/analytics', {
  baseURL: config.public.apiBase,
  headers: {
    Authorization: `Bearer ${authStore.accessToken}`
  }
});

function formatDate(dateStr: string) {
    return new Date(dateStr).toLocaleDateString(undefined, { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
}
</script>
