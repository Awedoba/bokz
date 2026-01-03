<template>
  <div>
    <button 
      @click="isOpen = true"
      class="flex items-center justify-center px-4 py-2 text-sm font-medium text-white transition-colors bg-purple-600 rounded-lg hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 dark:focus:ring-offset-gray-800"
    >
      <Icon name="heroicons:plus" class="w-5 h-5 mr-2" />
      Upload Book
    </button>

    <TransitionRoot appear :show="isOpen" as="template">
      <Dialog as="div" @close="closeModal" class="relative z-50">
        <TransitionChild
          as="template"
          enter="duration-300 ease-out"
          enter-from="opacity-0"
          enter-to="opacity-100"
          leave="duration-200 ease-in"
          leave-from="opacity-100"
          leave-to="opacity-0"
        >
          <div class="fixed inset-0 bg-black/25 backdrop-blur-sm" />
        </TransitionChild>

        <div class="fixed inset-0 overflow-y-auto">
          <div class="flex items-center justify-center min-h-full p-4 text-center">
            <TransitionChild
              as="template"
              enter="duration-300 ease-out"
              enter-from="opacity-0 scale-95"
              enter-to="opacity-100 scale-100"
              leave="duration-200 ease-in"
              leave-from="opacity-100 scale-100"
              leave-to="opacity-0 scale-95"
            >
              <DialogPanel class="w-full max-w-md p-6 overflow-hidden text-left align-middle transition-all transform bg-white shadow-xl rounded-2xl dark:bg-dark-surface dark:border dark:border-gray-700">
                <DialogTitle as="h3" class="text-lg font-medium leading-6 text-gray-900 dark:text-white">
                  Upload Book
                </DialogTitle>
                
                <div class="mt-4">
                  <div 
                    class="flex flex-col items-center justify-center w-full h-64 border-2 border-dashed rounded-lg cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-800"
                    :class="[
                      isDragging ? 'border-purple-500 bg-purple-50 dark:bg-purple-900/20' : 'border-gray-300 dark:border-gray-600',
                      file ? 'border-green-500 bg-green-50 dark:bg-green-900/20' : ''
                    ]"
                    @dragover.prevent="isDragging = true"
                    @dragleave.prevent="isDragging = false"
                    @drop.prevent="handleDrop"
                    @click="$refs.fileInput.click()"
                  >
                    <div v-if="uploading" class="flex flex-col items-center">
                      <Icon name="svg-spinners:90-ring-with-bg" class="w-10 h-10 text-purple-600 mb-3" />
                      <p class="text-sm text-gray-500 dark:text-gray-400">Processing {{ file?.name }}...</p>
                    </div>
                    
                    <div v-else-if="file" class="flex flex-col items-center">
                      <Icon name="heroicons:document-text" class="w-10 h-10 text-green-500 mb-3" />
                      <p class="text-sm font-medium text-gray-900 dark:text-white">{{ file.name }}</p>
                      <p class="text-xs text-gray-500 dark:text-gray-400 mt-1">{{ formatFileSize(file.size) }}</p>
                      <button @click.stop="file = null" class="mt-3 text-xs text-red-500 hover:text-red-600">Remove</button>
                    </div>

                    <div v-else class="flex flex-col items-center pt-5 pb-6">
                      <Icon name="heroicons:cloud-arrow-up" class="w-10 h-10 text-gray-400 mb-3" />
                      <p class="mb-2 text-sm text-gray-500 dark:text-gray-400"><span class="font-semibold">Click to upload</span> or drag and drop</p>
                      <p class="text-xs text-gray-500 dark:text-gray-400">EPUB, PDF, TXT (MAX. 100MB)</p>
                    </div>
                    
                    <input ref="fileInput" type="file" class="hidden" accept=".epub,.pdf,.txt,.mp3,.m4a" @change="handleFileSelect" />
                  </div>

                  <p v-if="error" class="mt-2 text-sm text-red-600 dark:text-red-400">{{ error }}</p>
                </div>

                <div class="mt-6 flex justify-end space-x-3">
                  <button
                    type="button"
                    class="inline-flex justify-center px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600 dark:hover:bg-gray-700"
                    @click="closeModal"
                  >
                    Cancel
                  </button>
                  <button
                    type="button"
                    class="inline-flex justify-center px-4 py-2 text-sm font-medium text-white bg-purple-600 border border-transparent rounded-md hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 disabled:opacity-50 disabled:cursor-not-allowed"
                    :disabled="!file || uploading"
                    @click="uploadFile"
                  >
                    {{ uploading ? 'Uploading...' : 'Upload' }}
                  </button>
                </div>
              </DialogPanel>
            </TransitionChild>
          </div>
        </div>
      </Dialog>
    </TransitionRoot>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { Dialog, DialogPanel, DialogTitle, TransitionChild, TransitionRoot } from '@headlessui/vue';
import { useBookStore } from '~/stores/books';

const bookStore = useBookStore();
const isOpen = ref(false);
const isDragging = ref(false);
const file = ref(null);
const uploading = ref(false);
const error = ref('');
const fileInput = ref(null);

function closeModal() {
  if (uploading.value) return;
  isOpen.value = false;
  file.value = null;
  error.value = '';
}

function handleFileSelect(event) {
  const selectedFile = event.target.files[0];
  validateAndSetFile(selectedFile);
}

function handleDrop(event) {
  isDragging.value = false;
  const droppedFile = event.dataTransfer.files[0];
  validateAndSetFile(droppedFile);
}

function validateAndSetFile(selectedFile) {
  error.value = '';
  if (!selectedFile) return;

  const validTypes = ['application/epub+zip', 'application/pdf', 'text/plain', 'audio/mpeg', 'audio/mp4'];
  // Note: mimetype detection in browser can be tricky, check extension as fallback
  const validExtensions = ['.epub', '.pdf', '.txt', '.mp3', '.m4a'];
  const ext = '.' + selectedFile.name.split('.').pop().toLowerCase();

  if (!validExtensions.includes(ext) && !validTypes.includes(selectedFile.type)) {
    error.value = 'Invalid file type. Please upload EPUB, PDF, or TXT.';
    return;
  }

  if (selectedFile.size > 100 * 1024 * 1024) { // 100MB
    error.value = 'File is too large. Max size is 100MB.';
    return;
  }

  file.value = selectedFile;
}

async function uploadFile() {
  if (!file.value) return;

  uploading.value = true;
  error.value = '';

  try {
    await bookStore.uploadBook(file.value);
    closeModal();
    // Optional: Show success toast
  } catch (err) {
    error.value = err.message || 'Upload failed';
  } finally {
    uploading.value = false;
  }
}

function formatFileSize(bytes) {
  if (bytes === 0) return '0 Bytes';
  const k = 1024;
  const sizes = ['Bytes', 'KB', 'MB', 'GB'];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
}
</script>
