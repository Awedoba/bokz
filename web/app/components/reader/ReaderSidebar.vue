<template>
  <Transition
    enter-active-class="transform transition ease-in-out duration-300 sm:duration-300"
    enter-from-class="-translate-x-full"
    enter-to-class="translate-x-0"
    leave-active-class="transform transition ease-in-out duration-300 sm:duration-300"
    leave-from-class="translate-x-0"
    leave-to-class="-translate-x-full"
  >
    <div v-if="isOpen" class="fixed inset-y-0 left-0 flex max-w-xs w-full flex-col bg-white dark:bg-gray-900 shadow-xl z-50 border-r border-gray-200 dark:border-gray-700">
      <!-- Sidebar Header -->
      <div class="px-4 py-4 flex items-center justify-between border-b border-gray-200 dark:border-gray-700">
        <h2 class="text-lg font-medium text-gray-900 dark:text-white">{{ activeTabLabel }}</h2>
        <button
          type="button"
          class="-mr-2 flex h-8 w-8 items-center justify-center rounded-full bg-white dark:bg-gray-800 text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-purple-500"
          @click="$emit('close')"
        >
          <span class="sr-only">Close sidebar</span>
          <Icon name="heroicons:x-mark" class="h-5 w-5" />
        </button>
      </div>

      <!-- Tabs -->
      <div class="flex border-b border-gray-200 dark:border-gray-700">
        <button
          v-for="tab in tabs"
          :key="tab.id"
          @click="activeTab = tab.id"
          class="flex-1 py-3 px-1 text-center text-sm font-medium border-b-2 hover:bg-gray-50 dark:hover:bg-gray-800 transition-colors"
          :class="[
            activeTab === tab.id
              ? 'border-purple-500 text-purple-600 dark:text-purple-400'
              : 'border-transparent text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-300'
          ]"
          :title="tab.label"
        >
          <Icon :name="tab.icon" class="h-5 w-5 mx-auto" />
        </button>
      </div>

      <!-- Content -->
      <div class="flex-1 overflow-y-auto px-2 py-2 scrollbar-thin scrollbar-thumb-gray-300 dark:scrollbar-thumb-gray-600">
        <!-- Chapters Tab -->
        <div v-if="activeTab === 'chapters'" class="space-y-1">
          <ul v-if="toc && toc.length" class="space-y-1">
             <li v-for="(item, index) in toc" :key="index">
                <button 
                  @click="$emit('navigate', item.href)"
                  class="w-full text-left px-3 py-2 text-sm text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-md truncate transition-colors"
                  :title="item.label"
                >
                  {{ item.label }}
                </button>
                <!-- Nested chapters could be handled recursively here if TOC structure is nested -->
             </li>
          </ul>
          <div v-else class="text-center py-8 text-gray-500 text-sm">No chapters found.</div>
        </div>

        <!-- Bookmarks Tab -->
        <div v-if="activeTab === 'bookmarks'" class="space-y-2">
           <div v-if="bookmarks && bookmarks.length">
             <div v-for="bookmark in bookmarks" :key="bookmark.id" class="p-3 bg-gray-50 dark:bg-gray-800 rounded-md hover:bg-gray-100 dark:hover:bg-gray-700 cursor-pointer" @click="$emit('navigate', bookmark.location)">
               <p class="text-sm font-medium text-gray-900 dark:text-white line-clamp-2">{{ bookmark.note || bookmark.text || 'Bookmark' }}</p>
               <p class="mt-1 text-xs text-gray-500">{{ formatDate(bookmark.createdAt) }}</p>
             </div>
           </div>
           <div v-else class="text-center py-8 text-gray-500 text-sm">No bookmarks yet.</div>
        </div>

        <!-- Annotations Tab -->
        <div v-if="activeTab === 'annotations'" class="space-y-2">
            <div v-if="annotations && annotations.length">
               <div v-for="ann in annotations" :key="ann.id" class="p-3 bg-yellow-50 dark:bg-yellow-900/10 rounded-md border-l-4 border-yellow-400 hover:opacity-90 cursor-pointer" @click="$emit('navigate', ann.location)">
                  <p class="text-sm text-gray-800 dark:text-gray-200 line-clamp-3">"{{ ann.text }}"</p>
                  <p v-if="ann.note" class="mt-2 text-xs font-medium text-gray-600 dark:text-gray-400">{{ ann.note }}</p>
               </div>
            </div>
            <div v-else class="text-center py-8 text-gray-500 text-sm">No annotations yet.</div>
        </div>

        <!-- Notes Tab (General Book Notes) -->
        <div v-if="activeTab === 'notes'">
            <div class="p-4 text-center text-gray-500 text-sm">
                Notes feature coming soon.
            </div>
        </div>
      </div>
    </div>
  </Transition>

  <!-- Overlay -->
  <Transition
    enter-active-class="opacity-0 ease-out duration-300"
    enter-to-class="opacity-100"
    leave-active-class="opacity-100 ease-in duration-200"
    leave-to-class="opacity-0"
  >
    <div v-if="isOpen" class="fixed inset-0 bg-gray-600 bg-opacity-75 z-40 transition-opacity" @click="$emit('close')"></div>
  </Transition>
</template>

<script setup lang="ts">
const props = defineProps<{
  isOpen: boolean;
  toc?: any[];
  bookmarks?: any[];
  annotations?: any[];
}>();

defineEmits(['close', 'navigate']);

const tabs = [
  { id: 'chapters', label: 'Provisions/Chapters', icon: 'heroicons:list-bullet' },
  { id: 'bookmarks', label: 'Bookmarks', icon: 'heroicons:bookmark' },
  { id: 'annotations', label: 'Annotations', icon: 'heroicons:pencil-square' },
  { id: 'notes', label: 'Notes', icon: 'heroicons:document-text' },
];

const activeTab = ref('chapters');

const activeTabLabel = computed(() => {
  return tabs.find(t => t.id === activeTab.value)?.label || 'Menu';
});

function formatDate(date: string) {
    if(!date) return '';
    return new Date(date).toLocaleDateString();
}
</script>
