<template>
  <div class="fixed inset-0 bg-white dark:bg-gray-900 overflow-hidden flex flex-col">
    <!-- simplified header (auto-hide logic can be added later) -->
    <header class="h-12 flex items-center justify-between px-4 bg-white dark:bg-gray-900 border-b border-gray-200 dark:border-gray-800 z-50">
      <div class="flex items-center">
        <NuxtLink to="/" class="mr-4 text-gray-500 hover:text-gray-900 dark:hover:text-white">
          <Icon name="heroicons:arrow-left" class="w-5 h-5" />
        </NuxtLink>
        <h1 class="text-sm font-medium truncate max-w-xs sm:max-w-md dark:text-gray-200">
          <slot name="title">Reader</slot>
        </h1>
      </div>
      
      <div class="flex items-center space-x-2">
        <slot name="actions" />
      </div>
    </header>

    <main class="flex-1 relative">
      <slot />
    </main>
    
    <!-- Optional: Footer/Progress bar -->
    <slot name="footer" />
  </div>
</template>

<script setup>
// Component logic mainly about UI controls visibility
</script>
