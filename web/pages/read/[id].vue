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

    <div class="h-full w-full px-4 sm:px-0 mx-auto max-w-4xl bg-white dark:bg-gray-900 shadow-xl relative">
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
        />
        <PdfReader
          v-else-if="book && book.format === 'pdf'"
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

<script setup>
import { ref, onMounted, computed } from 'vue';
import { useRoute } from 'vue-router';
import { useBookStore } from '~/stores/books';
import { useReaderStore } from '~/stores/reader';
import EpubReader from '~/components/reader/EpubReader.vue';
import PdfReader from '~/components/reader/PdfReader.vue';
import TtsPlayer from '~/components/reader/TtsPlayer.vue';
import ReaderSettings from '~/components/reader/ReaderSettings.vue';
import { useAuthStore } from '~/stores/auth';

definePageMeta({
  layout: false, // manage layout manually to pass slots
});

const route = useRoute();
const bookId = route.params.id;
const config = useRuntimeConfig();
const bookStore = useBookStore();
const readerStore = useReaderStore();
const authStore = useAuthStore();

const book = ref(null);
const loading = ref(true);
const annotations = ref([]);
const showAnnotationMenu = ref(false);
const currentSelection = ref(null);
const epubReaderRef = ref(null);

// TTS State
const showTtsPlayer = ref(false);
const ttsText = ref('');

// Settings State
const showSettings = ref(false);

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
    const [bookRes, annotationsRes] = await Promise.all([
      useFetch(`/api/books/${bookId}`, {
        baseURL: config.public.apiBase,
        headers: { Authorization: `Bearer ${authStore.accessToken}` }
      }),
      useFetch(`/api/reader/${bookId}/annotations`, {
        baseURL: config.public.apiBase,
        headers: { Authorization: `Bearer ${authStore.accessToken}` }
      })
    ]);
    
    if (bookRes.data.value) {
      book.value = (bookRes.data.value as any).book;
    }
    if (annotationsRes.data.value) {
      annotations.value = (annotationsRes.data.value as any).annotations;
    }

  } catch (err) {
    console.error('Failed to load book', err);
  } finally {
    loading.value = false;
  }
});

function onReaderReady(epubBook) {
  // Can get metadata etc from epub object
  console.log('Reader ready');
}

function onSelection(cfiRange) {
  currentSelection.value = cfiRange;
  showAnnotationMenu.value = true;
  
  // For TTS, we can get text immediately if we have the range object
  // epubReaderRef.value can expose a method to get text from range
  // TODO: Implement getTextFromCfi in EpubReader
}

function playText() {
  // If selected, play selection.
  // We need to extract the text content from the selection range object (which is just a CFI string usually here)
  // For simplicity, we assume we might get text content in onSelection or ask reader for it.
  
  // Simplest approach: use browser selection
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
  // Ideally remove the temporary highlight added by reader
}

async function saveHighlight(type) {
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
      // Reader already added it visually, so just close menu
    }
  } catch (err) {
    console.error('Failed to save annotation', err);
  } finally {
    showAnnotationMenu.value = false;
    currentSelection.value = null;
  }
}

function onPdfPageChange({ page, percentage }) {
  // Save progress for PDF
  // PDF location is page number string here
  readerStore.saveProgress(bookId, page.toString(), percentage * 100);
}

function toggleSettings() {
  showSettings.value = !showSettings.value;
}
</script>
