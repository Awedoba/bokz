<template>
  <NuxtLayout name="reader">
    <template #title>{{ bookTitle }}</template>

    <template #actions>
      <button 
        @click="toggleSettings"
        class="p-2 text-gray-500 hover:bg-gray-100 rounded-full dark:hover:bg-gray-800"
      >
        <Icon name="heroicons:cog-6-tooth" class="w-5 h-5" />
      </button>
    </template>

    <div class="flex h-screen w-screen overflow-hidden bg-white dark:bg-gray-900">
      <!-- Sidebar -->
      <ReaderSidebar 
        :is-open="sidebarOpen"
        :toc="toc"
        :bookmarks="bookmarks"
        :annotations="annotations"
        @close="sidebarOpen = false"
        @navigate="onNavigate"
      />

      <!-- Main Content -->
      <div class="flex-1 flex flex-col relative transition-all duration-300 ease-in-out h-full" :class="{'md:ml-0': !sidebarOpen, 'md:ml-80': sidebarOpen}">
         
         <ReaderToolbar 
           :title="bookTitle"
           :show="toolbarVisible"
           :sidebar-open="sidebarOpen"
           @toggle-sidebar="sidebarOpen = !sidebarOpen"
           @toggle-search="toggleSearch"
           @zoom-in="zoomIn"
           @zoom-out="zoomOut"
           @rotate="rotate"
         />

         <div class="flex-1 relative overflow-hidden mt-16 mb-12">
            <ClientOnly>
                <EpubReader 
                  v-if="book && book.format === 'epub'"
                  ref="epubReaderRef"
                  :url="bookUrl"
                  :initial-location="initialLocation"
                  :book-id="book.id"
                  :annotations="annotations"
                  @ready="onReaderReady"
                  @selection="onSelection"
                  @update:toc="onTocUpdate"
                  @page-change="onPageChange"
                />
                <PdfReader
                  v-else-if="book && book.format === 'pdf'"
                  ref="pdfReaderRef"
                  :url="bookUrl"
                  :initial-page="1" 
                  @page-change="onPdfPageChange"
                />
                <div v-else class="flex items-center justify-center h-full">
                  <Icon name="svg-spinners:90-ring-with-bg" class="w-10 h-10 text-purple-600" />
                </div>
            </ClientOnly>

            <!-- Annotation Menu (Simplified) -->
            <Transition
              enter-active-class="transition duration-200 ease-out"
              enter-from-class="translate-y-1 opacity-0"
              enter-to-class="translate-y-0 opacity-100"
              leave-active-class="transition duration-150 ease-in"
              leave-from-class="translate-y-0 opacity-100"
              leave-to-class="translate-y-1 opacity-0"
            >
            <div v-if="showAnnotationMenu" class="absolute top-4 left-1/2 -translate-x-1/2 bg-gray-900 text-white rounded-full px-4 py-2 flex space-x-4 shadow-lg z-50">
              <button @click="saveHighlight('highlight')" class="hover:text-yellow-400">
                <Icon name="heroicons:pencil" class="w-5 h-5" />
              </button>
              <button @click="playText" class="hover:text-purple-400">
                <Icon name="heroicons:speaker-wave" class="w-5 h-5" />
              </button>
              <button @click="saveHighlight('underline')" class="hover:text-blue-400">
                <Icon name="bi:type-underline" class="w-5 h-5" />
              </button>
              <button @click="cancelSelection" class="hover:text-red-400">
                <Icon name="heroicons:x-mark" class="w-5 h-5" />
              </button>
            </div>
            </Transition>
         </div>

         <ReaderFooter 
            :current-page="currentPage"
            :total-pages="totalPages"
            :can-prev="currentPage > 1"
            :can-next="currentPage < totalPages"
            @prev="prevPage"
            @next="nextPage"
            @toggle-settings="toggleSettings"
         />
      </div>
       
       <TtsPlayer 
         :text="ttsText" 
         :show="showTtsPlayer" 
         @finish="showTtsPlayer = false"
       />
       
       <ReaderSettings 
         :show="showSettings" 
         @close="showSettings = false" 
       />
    </div>
  </NuxtLayout>
</template>

<script setup lang="ts">
import { ref, onMounted, computed, watch } from 'vue';
import { useRoute } from 'vue-router';
import { useBookStore } from '~/stores/books';
import { useReaderStore } from '~/stores/reader';
import EpubReader from '~/components/reader/EpubReader.vue';
import PdfReader from '~/components/reader/PdfReader.vue';
import TtsPlayer from '~/components/reader/TtsPlayer.vue';
import ReaderSettings from '~/components/reader/ReaderSettings.vue';
import ReaderSidebar from '~/components/reader/ReaderSidebar.vue';
import ReaderFooter from '~/components/reader/ReaderFooter.vue';
import ReaderToolbar from '~/components/reader/ReaderToolbar.vue';
import { useAuthStore } from '~/stores/auth';

definePageMeta({
  layout: false, // manage layout manually to pass slots
});

const route = useRoute();
const bookId = route.params.id as string;
const config = useRuntimeConfig();
const bookStore = useBookStore();
const readerStore = useReaderStore();
const authStore = useAuthStore();

const book = ref<any>(null);
const loading = ref(true);
const annotations = ref<any[]>([]);
const bookmarks = ref<any[]>([]); // New Bookmarks
const toc = ref<any[]>([]);       // New TOC
const showAnnotationMenu = ref(false);
const currentSelection = ref<any>(null);

// Reader Refs
const epubReaderRef = ref<InstanceType<typeof EpubReader> | null>(null);
const pdfReaderRef = ref<InstanceType<typeof PdfReader> | null>(null);

// UI State
const sidebarOpen = ref(false);
const toolbarVisible = ref(true);
const showSettings = ref(false);
const showTtsPlayer = ref(false);
const ttsText = ref('');

// Pagination State
const currentPage = ref(1);
const totalPages = ref(0);

const bookUrl = computed(() => {
  if (!book.value) return '';
  return `${config.public.apiBase.replace('/api', '')}/uploads/${book.value.filePath}`; 
});

const bookTitle = computed(() => book.value?.title || 'Loading...');
const initialLocation = computed(() => book.value?.readingProgress?.[0]?.location);

onMounted(async () => {
  // Fetch book details directly or via store
  try {
    // If we have store data, try finding it there first to be fast
    const cachedBook = bookStore.books.find(b => b.id === bookId);
    
    // Always fetch fresh to get progress and annotations
    const [bookRes, annotationsRes, bookmarksRes] = await Promise.all([
      useFetch(`/api/books/${bookId}`, {
        baseURL: config.public.apiBase,
        headers: { Authorization: `Bearer ${authStore.accessToken}` }
      }),
      useFetch(`/api/reader/${bookId}/annotations`, {
        baseURL: config.public.apiBase,
        headers: { Authorization: `Bearer ${authStore.accessToken}` }
      }),
      // Assuming bookmarks endpoint exists or we mock it
      Promise.resolve({ data: { value: { bookmarks: [] } } }) // Mock for now if no endpoint
    ]);
    
    if (bookRes.data.value) {
      book.value = (bookRes.data.value as any).book;
    }
    if (annotationsRes.data.value) {
      annotations.value = (annotationsRes.data.value as any).annotations || [];
    }
    
    // TODO: Implement actual bookmarks fetching
    // bookmarks.value = bookmarksRes.data.value.bookmarks;

  } catch (err) {
    console.error('Failed to load book', err);
  } finally {
    loading.value = false;
  }
});

function onReaderReady(epubBook: any) {
  // Can get metadata etc from epub object
  console.log('Reader ready');
}

function onSelection(cfiRange: any) {
  currentSelection.value = cfiRange;
  showAnnotationMenu.value = true;
}

function playText() {
  const selection = window.getSelection();
  if (selection && selection.toString()) {
     ttsText.value = selection.toString();
     showTtsPlayer.value = true;
     showAnnotationMenu.value = false;
  }
}

function cancelSelection() {
  showAnnotationMenu.value = false;
  currentSelection.value = null;
}

async function saveHighlight(type: string) {
  if (!currentSelection.value) return;

  try {
    const { data } = await useFetch(`/api/reader/${bookId}/annotations`, {
      method: 'POST',
      baseURL: config.public.apiBase,
      headers: { Authorization: `Bearer ${authStore.accessToken}` },
      body: {
        type,
        locationStart: currentSelection.value,
        color: type === 'highlight' ? '#fbbf24' : '#60a5fa' 
      }
    });

    if (data.value) {
      annotations.value.push((data.value as any).annotation);
    }
  } catch (err) {
    console.error('Failed to save annotation', err);
  } finally {
    showAnnotationMenu.value = false;
    currentSelection.value = null;
  }
}

function onPdfPageChange({ page, percentage }: { page: number, percentage: number }) {
  // Save progress for PDF
  readerStore.saveProgress(bookId, page.toString(), percentage * 100);
  currentPage.value = page;
  // TODO: Set total pages for PDF
}

// --- New Methods for Enhanced UI ---

function toggleSettings() {
  showSettings.value = !showSettings.value;
}

function toggleSearch() {
  // TODO: Implement search UI toggle
  alert('Search feature coming soon');
}

function zoomIn() {
  epubReaderRef.value?.zoom(10);
  // PDF zoom implementation needed
}

function zoomOut() {
  epubReaderRef.value?.zoom(-10);
}

function rotate() {
  epubReaderRef.value?.rotate(90);
}

function prevPage() {
    epubReaderRef.value?.prevPage();
    // PDF prev page
    pdfReaderRef.value?.prevPage && pdfReaderRef.value.prevPage();
}

function nextPage() {
    epubReaderRef.value?.nextPage();
     // PDF next page
    pdfReaderRef.value?.nextPage && pdfReaderRef.value.nextPage();
}

function onNavigate(href: string) {
    if (book.value?.format === 'epub') {
        epubReaderRef.value?.goTo(href);
    } else {
        // PDF navigation logic
    }
    // Mobile: Close sidebar on navigate
    if (window.innerWidth < 768) {
        sidebarOpen.value = false;
    }
}

function onTocUpdate(newToc: any[]) {
    toc.value = newToc;
}

function onPageChange({ page, total }: { page: number, total: number }) {
    currentPage.value = page;
    totalPages.value = total;
}
</script>
