<template>
  <div class="h-full w-full relative group">
    <div id="epub-viewer" class="h-full w-full"></div>
    
    <!-- Navigation Overlay (Previous) -->
    <div 
      class="absolute inset-y-0 left-0 w-16 z-10 flex items-center justify-start pl-2 opacity-0 group-hover:opacity-100 transition-opacity cursor-pointer hover:bg-black/5 dark:hover:bg-white/5"
      @click="prevPage"
    >
      <Icon name="heroicons:chevron-left" class="w-8 h-8 text-gray-400" />
    </div>

    <!-- Navigation Overlay (Next) -->
    <div 
      class="absolute inset-y-0 right-0 w-16 z-10 flex items-center justify-end pr-2 opacity-0 group-hover:opacity-100 transition-opacity cursor-pointer hover:bg-black/5 dark:hover:bg-white/5"
      @click="nextPage"
    >
      <Icon name="heroicons:chevron-right" class="w-8 h-8 text-gray-400" />
    </div>

    <!-- Loading Indicator -->
    <div v-if="loading" class="absolute inset-0 flex items-center justify-center bg-white dark:bg-gray-900 z-20">
      <Icon name="svg-spinners:90-ring-with-bg" class="w-10 h-10 text-purple-600" />
    </div>
  </div>
</template>

<script setup>
import { onMounted, onUnmounted, ref, watch } from 'vue';
import ePub from 'epubjs';
import { useReaderStore } from '~/stores/reader';

const props = defineProps({
  url: { type: String, required: true },
  initialLocation: { type: String, default: null },
  bookId: { type: String, required: true },
  annotations: { type: Array, default: () => [] },
});

const emit = defineEmits(['ready', 'relocated', 'selection']);
const readerStore = useReaderStore();

const book = ref(null);
const rendition = ref(null);
const loading = ref(true);

onMounted(async () => {
  loading.value = true;
  if (!process.client) return;

  try {
    book.value = ePub(props.url);
    
    // Wait for book to be ready
    await book.value.ready;

    // Render to element
    rendition.value = book.value.renderTo('epub-viewer', {
      width: '100%',
      height: '100%',
      flow: 'paginated',
      manager: 'default',
    });

    // Display
    await rendition.value.display(props.initialLocation || undefined);
    
    // Hook events
    rendition.value.on('relocated', (location) => {
      handleRelocated(location);
    });

    rendition.value.on('selected', (cfiRange, contents) => {
      handleSelection(cfiRange, contents);
    });

    // Render annotations
    if (props.annotations) {
      props.annotations.forEach(annotation => {
        rendition.value.annotations.add(annotation.type, annotation.locationStart, {}, () => {}, 'hl-default');
      });
    }

    applySettings();
    loading.value = false;
    emit('ready', book.value);
  } catch (error) {
    console.error('Error loading EPUB:', error);
    loading.value = false;
  }
});

function handleSelection(cfiRange, contents) {
  // Add highlight immediately for feedback
  rendition.value.annotations.add('highlight', cfiRange);
  contents.window.getSelection().removeAllRanges();
  
  // Emit event to parent to handle "Save Annotation" UI
  emit('selection', cfiRange);
}

// Expose method to add annotation visually from parent
function addAnnotation(type, cfiRange) {
   rendition.value?.annotations.add(type, cfiRange);
}

defineExpose({
  addAnnotation
});


onUnmounted(() => {
  if (book.value) {
    book.value.destroy();
  }
});

function handleRelocated(location) {
  const percentage = location.start.percentage;
  const cfi = location.start.cfi;
  
  readerStore.saveProgress(props.bookId, cfi, percentage * 100);
  emit('relocated', { cfi, percentage });
}

function prevPage() {
  rendition.value?.prev();
}

function nextPage() {
  rendition.value?.next();
}

// Watch for theme/font changes
watch(() => readerStore.settings, () => {
  applySettings();
}, { deep: true });

function applySettings() {
  if (!rendition.value) return;

  const { fontSize, theme, fontFamily } = readerStore.settings;
  
  rendition.value.themes.fontSize(`${fontSize}%`);
  rendition.value.themes.font(fontFamily);
  
  // Register and select themes
  rendition.value.themes.register('light', { body: { color: '#000000', background: '#ffffff' } });
  rendition.value.themes.register('dark', { body: { color: '#ffffff', background: '#111827' } }); // gray-900
  rendition.value.themes.register('sepia', { body: { color: '#5f4b32', background: '#f6e0b5' } });
  
  rendition.value.themes.select(theme);
}
</script>

<style>
/* Override epubjs iframe constraints if necessary */
</style>
