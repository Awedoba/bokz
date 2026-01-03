<template>
  <div>
    <!-- Header -->
    <div class="flex flex-col mb-6 md:flex-row md:items-center md:justify-between">
      <div>
        <h1 class="text-2xl font-bold dark:text-white">My Library</h1>
        <p class="text-gray-600 dark:text-gray-400">
          {{ bookStore.books.length }} {{ bookStore.books.length === 1 ? 'book' : 'books' }}
        </p>
      </div>
      
      <div class="flex flex-col mt-4 space-y-3 md:mt-0 md:flex-row md:space-y-0 md:space-x-3">
        <!-- Search -->
        <div class="relative">
          <input 
            v-model="searchQuery"
            @input="handleSearch"
            type="text" 
            placeholder="Search books..." 
            class="w-full pl-10 pr-4 py-2 border rounded-lg focus:ring-purple-500 focus:border-purple-500 dark:bg-gray-800 dark:border-gray-700 dark:text-white"
          >
          <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
            <Icon name="heroicons:magnifying-glass" class="w-5 h-5 text-gray-400" />
          </div>
        </div>

        <!-- View Toggle -->
        <div class="flex bg-white rounded-lg border border-gray-200 dark:bg-gray-800 dark:border-gray-700 p-1">
          <button 
            @click="bookStore.setViewMode('grid')"
            class="p-1.5 rounded-md transition-colors"
            :class="bookStore.viewMode === 'grid' ? 'bg-gray-100 text-purple-600 dark:bg-gray-700 dark:text-purple-400' : 'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200'"
          >
            <Icon name="heroicons:squares-2x2" class="w-5 h-5" />
          </button>
          <button 
            @click="bookStore.setViewMode('list')"
            class="p-1.5 rounded-md transition-colors"
            :class="bookStore.viewMode === 'list' ? 'bg-gray-100 text-purple-600 dark:bg-gray-700 dark:text-purple-400' : 'text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200'"
          >
            <Icon name="heroicons:list-bullet" class="w-5 h-5" />
          </button>
        </div>

        <BookUpload />
      </div>
    </div>

    <!-- Loading State -->
    <div v-if="bookStore.loading && bookStore.books.length === 0" class="flex justify-center py-12">
      <Icon name="svg-spinners:90-ring-with-bg" class="w-8 h-8 text-purple-600" />
    </div>

    <!-- Error State -->
    <div v-else-if="bookStore.error" class="p-4 mb-6 text-red-700 bg-red-100 rounded-lg dark:bg-red-900/30 dark:text-red-400">
      {{ bookStore.error }}
    </div>

    <!-- Empty State -->
    <div v-else-if="bookStore.books.length === 0" class="flex flex-col items-center justify-center py-16 text-center bg-white rounded-xl border border-dashed border-gray-300 dark:bg-dark-surface dark:border-gray-700">
      <div class="w-16 h-16 bg-gray-50 rounded-full flex items-center justify-center mb-4 dark:bg-gray-800">
        <Icon name="heroicons:book-open" class="w-8 h-8 text-gray-400" />
      </div>
      <h3 class="text-lg font-medium text-gray-900 dark:text-white">Your library is empty</h3>
      <p class="mt-1 text-gray-500 dark:text-gray-400 max-w-sm">
        Upload your first book to get started. We support EPUB, PDF, and TXT formats.
      </p>
      <div class="mt-6">
        <BookUpload />
      </div>
    </div>

    <!-- Book Grid/List -->
    <div v-else>
      <!-- Grid View -->
      <div v-if="bookStore.viewMode === 'grid'" class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 gap-6">
        <div v-for="book in bookStore.books" :key="book.id" class="group relative">
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

            <!-- Overlay Actions -->
            <div class="absolute inset-x-0 bottom-0 p-4 translate-y-full bg-gradient-to-t from-black/80 to-transparent transition-transform duration-200 group-hover:translate-y-0 flex justify-end space-x-2">
               <button 
                 @click.prevent="deleteBook(book.id)"
                 class="p-2 text-white bg-red-600 rounded-full hover:bg-red-700 focus:outline-none"
                 title="Delete Book"
               >
                 <Icon name="heroicons:trash" class="w-4 h-4" />
               </button>
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

      <!-- List View -->
      <div v-else class="bg-white rounded-lg border border-gray-200 shadow-sm dark:bg-dark-surface dark:border-gray-700 divide-y divide-gray-200 dark:divide-gray-700">
        <div v-for="book in bookStore.books" :key="book.id" class="flex items-center p-4 hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-colors">
          <div class="h-16 w-12 flex-shrink-0 overflow-hidden rounded bg-gray-200 dark:bg-gray-800">
            <img 
              v-if="book.coverUrl" 
              :src="getCoverUrl(book.coverUrl)" 
              :alt="book.title" 
              class="h-full w-full object-cover object-center"
            />
            <div v-else class="flex h-full w-full items-center justify-center bg-gray-100 dark:bg-gray-800 text-xs font-bold text-gray-400">
              {{ book.format.toUpperCase() }}
            </div>
          </div>
          <div class="ml-4 flex-1 min-w-0">
            <h3 class="text-sm font-medium text-gray-900 dark:text-white truncate">{{ book.title }}</h3>
            <p class="text-sm text-gray-500 dark:text-gray-400 truncate">{{ book.author || 'Unknown Author' }}</p>
            <div class="flex items-center mt-1 space-x-2 text-xs text-gray-400">
              <span class="uppercase">{{ book.format }}</span>
              <span>&bull;</span>
              <span>Added {{ new Date(book.createdAt).toLocaleDateString() }}</span>
            </div>
          </div>
          <div class="ml-4 flex-shrink-0 flex items-center space-x-2">
            <NuxtLink 
              :to="'/read/' + book.id"
              class="p-2 text-purple-600 hover:text-purple-700 dark:text-purple-400 dark:hover:text-purple-300 transition-colors"
              title="Read Book"
            >
              <Icon name="heroicons:book-open" class="w-5 h-5" />
            </NuxtLink>
            <button 
              @click="deleteBook(book.id)"
              class="p-2 text-gray-400 hover:text-red-600 dark:hover:text-red-400 transition-colors"
            >
              <Icon name="heroicons:trash" class="w-5 h-5" />
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useBookStore } from '~/stores/books';
import { useDebounceFn } from '@vueuse/core';
import BookUpload from '~/components/library/BookUpload.vue';

const bookStore = useBookStore();
const searchQuery = ref('');
const config = useRuntimeConfig();

onMounted(() => {
  bookStore.fetchBooks();
});

const handleSearch = useDebounceFn(() => {
  bookStore.fetchBooks({ search: searchQuery.value });
}, 500);

function getCoverUrl(path) {
  if (!path) return '';
  return `${config.public.apiBase.replace('/api', '')}/uploads/${path}`;
}

async function deleteBook(id) {
  if (!confirm('Are you sure you want to delete this book?')) return;
  
  try {
    await bookStore.deleteBook(id);
  } catch (err) {
    alert('Failed to delete book');
  }
}
</script>
