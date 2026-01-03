<template>
  <div class="h-full w-full relative group bg-gray-100 dark:bg-gray-800 flex flex-col items-center overflow-hidden">
    <!-- PDF Container -->
    <div id="pdf-container" class="flex-1 w-full overflow-auto flex justify-center py-4 relative">
       <div class="relative shadow-lg ring-1 ring-black/5">
          <canvas ref="canvasRef" class="max-w-full"></canvas>
          <!-- Text Layer for selection (TODO) -->
       </div>
    </div>

    <!-- Navigation Overlay -->
    <div class="absolute bottom-6 left-1/2 -translate-x-1/2 bg-white dark:bg-gray-900 shadow-lg rounded-full px-4 py-2 flex items-center space-x-4 z-20 border border-gray-200 dark:border-gray-700">
      <button @click="prevPage" :disabled="currentPage <= 1" class="p-1 hover:text-purple-600 disabled:opacity-30">
        <Icon name="heroicons:chevron-left" class="w-5 h-5" />
      </button>
      <span class="text-sm font-medium tabular-nums">{{ currentPage }} / {{ totalPages }}</span>
      <button @click="nextPage" :disabled="currentPage >= totalPages" class="p-1 hover:text-purple-600 disabled:opacity-30">
        <Icon name="heroicons:chevron-right" class="w-5 h-5" />
      </button>
    </div>

    <!-- Loading -->
    <div v-if="loading" class="absolute inset-0 flex items-center justify-center bg-white/80 dark:bg-gray-900/80 z-30">
      <Icon name="svg-spinners:90-ring-with-bg" class="w-10 h-10 text-purple-600" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue';
import * as pdfjsLib from 'pdfjs-dist';
// Worker is set in a plugin or globally
// import 'pdfjs-dist/build/pdf.worker.mjs'; // This often needs handling in Nuxt/Vite

const props = defineProps({
  url: { type: String, required: true },
  initialPage: { type: Number, default: 1 },
});

const emit = defineEmits(['ready', 'page-change']);

const canvasRef = ref(null);
const loading = ref(true);
const pdfDoc = ref(null);
const currentPage = ref(props.initialPage || 1);
const totalPages = ref(0);
const scale = ref(1.5);

// Configure worker locally if not global
// pdfjsLib.GlobalWorkerOptions.workerSrc = `https://unpkg.com/pdfjs-dist@${pdfjsLib.version}/build/pdf.worker.min.js`;
// Better to use local worker, but let's try CDN fallback for simplicity or check if we can import it.
// In Nuxt, we often copy the worker to public dir. For now, let's use the CDN for instant reliability or try direct import if configured.
pdfjsLib.GlobalWorkerOptions.workerSrc = new URL('pdfjs-dist/build/pdf.worker.min.mjs', import.meta.url).toString();


onMounted(async () => {
  await loadPdf();
});

async function loadPdf() {
  loading.value = true;
  try {
    const loadingTask = pdfjsLib.getDocument(props.url);
    pdfDoc.value = await loadingTask.promise;
    totalPages.value = pdfDoc.value.numPages;
    
    emit('ready', pdfDoc.value);
    await renderPage(currentPage.value);
  } catch (err) {
    console.error('Error loading PDF:', err);
  } finally {
    loading.value = false;
  }
}

async function renderPage(num) {
  if (!pdfDoc.value) return;
  
  try {
    const page = await pdfDoc.value.getPage(num);
    
    const viewport = page.getViewport({ scale: scale.value });
    const canvas = canvasRef.value;
    const context = canvas.getContext('2d');

    canvas.height = viewport.height;
    canvas.width = viewport.width;

    const renderContext = {
      canvasContext: context,
      viewport: viewport
    };

    await page.render(renderContext).promise;
    currentPage.value = num;
    emit('page-change', { page: num, percentage: num / totalPages.value });
  } catch (err) {
    console.error('Error rendering page:', err);
  }
}

function prevPage() {
  if (currentPage.value <= 1) return;
  renderPage(currentPage.value - 1);
}

function nextPage() {
  if (currentPage.value >= totalPages.value) return;
  renderPage(currentPage.value + 1);
}

// Watch URL changes
watch(() => props.url, () => {
  loadPdf();
});
</script>
