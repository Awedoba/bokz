<template>
  <div class="fixed bottom-0 left-0 right-0 bg-white dark:bg-gray-900 border-t border-gray-200 dark:border-gray-700 px-4 py-2 z-40 flex items-center justify-between shadow-[0_-1px_3px_rgba(0,0,0,0.1)]">
    <!-- Page Navigation -->
    <div class="flex items-center space-x-2">
      <button 
        @click="$emit('prev')" 
        class="p-1.5 rounded-full hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-600 dark:text-gray-300 disabled:opacity-50 disabled:cursor-not-allowed"
        :disabled="!canPrev"
      >
        <span class="sr-only">Previous Page</span>
        <Icon name="heroicons:chevron-left" class="w-5 h-5" />
      </button>

      <div class="text-sm font-medium text-gray-700 dark:text-gray-200 min-w-[80px] text-center">
        <span v-if="totalPages > 0">Page {{ currentPage }} / {{ totalPages }}</span>
        <span v-else>Thinking...</span>
      </div>

      <button 
        @click="$emit('next')"
        class="p-1.5 rounded-full hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-600 dark:text-gray-300 disabled:opacity-50 disabled:cursor-not-allowed"
        :disabled="!canNext"
      >
        <span class="sr-only">Next Page</span>
        <Icon name="heroicons:chevron-right" class="w-5 h-5" />
      </button>
    </div>

    <!-- Quick Settings / Toggles -->
    <div class="flex items-center space-x-4">
      <button 
        @click="$emit('toggle-settings')"
        class="p-1.5 rounded hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-600 dark:text-gray-300"
        title="Display Settings"
      >
        <Icon name="heroicons:adjustments-horizontal" class="w-5 h-5" />
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  currentPage: number;
  totalPages: number;
  canPrev: boolean;
  canNext: boolean;
}>();

defineEmits(['prev', 'next', 'toggle-settings']);
</script>
