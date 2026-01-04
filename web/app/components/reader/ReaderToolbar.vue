<template>
  <header class="fixed top-0 left-0 right-0 bg-white dark:bg-gray-900 border-b border-gray-200 dark:border-gray-700 h-16 z-40 flex items-center justify-between px-4 shadow-sm transition-transform duration-300"
    :class="{'translate-y-0': show, '-translate-y-full': !show}"
  >
    <!-- Left: Back & Title -->
    <div class="flex items-center space-x-4">
      <NuxtLink to="/" class="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-600 dark:text-gray-300">
        <Icon name="heroicons:home" class="w-5 h-5" />
      </NuxtLink>
      <button @click="$emit('toggle-sidebar')" class="p-2 rounded hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-600 dark:text-gray-300 md:hidden">
         <Icon name="heroicons:bars-3-bottom-left" class="w-5 h-5" />
      </button>
      <h1 class="text-sm sm:text-base font-semibold text-gray-900 dark:text-white truncate max-w-[150px] sm:max-w-md">
        {{ title }}
      </h1>
    </div>

    <!-- Right: Tools -->
    <div class="flex items-center space-x-1 sm:space-x-2">
      <!-- Search (Toggle) -->
      <button @click="$emit('toggle-search')" class="p-2 rounded hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-600 dark:text-gray-300" title="Search">
        <Icon name="heroicons:magnifying-glass" class="w-5 h-5" />
      </button>

      <!-- Zoom Controls -->
      <div class="hidden sm:flex items-center border-l border-r border-gray-200 dark:border-gray-700 px-2 mx-2 space-x-1">
         <button @click="$emit('zoom-out')" class="p-1.5 rounded hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-600 dark:text-gray-300">
           <Icon name="heroicons:minus-circle" class="w-5 h-5" />
         </button>
         <button @click="$emit('zoom-in')" class="p-1.5 rounded hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-600 dark:text-gray-300">
           <Icon name="heroicons:plus-circle" class="w-5 h-5" />
         </button>
      </div>

      <!-- Rotate -->
       <button @click="$emit('rotate')" class="hidden sm:block p-2 rounded hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-600 dark:text-gray-300" title="Rotate">
        <Icon name="heroicons:arrow-path" class="w-5 h-5" />
      </button>

      <!-- Sidebar Toggle (Desktop) -->
      <button @click="$emit('toggle-sidebar')" class="hidden md:block p-2 rounded hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-600 dark:text-gray-300" :class="{'bg-gray-100 dark:bg-gray-800': sidebarOpen}">
         <Icon name="heroicons:bars-3-bottom-left" class="w-5 h-5" />
      </button>
    </div>
  </header>
</template>

<script setup lang="ts">
defineProps<{
  title?: string;
  show: boolean;
  sidebarOpen: boolean;
}>();

defineEmits(['toggle-sidebar', 'toggle-search', 'zoom-in', 'zoom-out', 'rotate']);
</script>
