<template>
  <div class="mt-8">
     <div class="flex items-center justify-between px-2 mb-2">
       <h3 class="text-xs font-semibold text-gray-500 uppercase dark:text-gray-400">Collections</h3>
       <button @click="isOpen = true" class="text-gray-500 hover:text-gray-900 dark:hover:text-white" title="New Collection">
         <Icon name="heroicons:plus" class="w-4 h-4" />
       </button>
     </div>
     
     <ul class="space-y-1">
       <li v-for="collection in collectionStore.collections" :key="collection.id">
         <div class="group flex items-center justify-between p-2 text-gray-900 rounded-lg dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors cursor-pointer">
            <div class="flex items-center truncate">
              <span class="w-3 h-3 rounded-full mr-3 flex-shrink-0" :style="{ backgroundColor: collection.color || '#6366f1' }"></span>
              <span class="text-sm truncate">{{ collection.name }}</span>
            </div>
            <button 
              @click.stop="deleteCollection(collection.id)"
              class="opacity-0 group-hover:opacity-100 p-1 text-gray-400 hover:text-red-500 transition-opacity"
            >
              <Icon name="heroicons:trash" class="w-3 h-3" />
            </button>
         </div>
       </li>
     </ul>

     <!-- Create Collection Modal -->
     <TransitionRoot appear :show="isOpen" as="template">
      <Dialog as="div" @close="isOpen = false" class="relative z-50">
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
            <DialogPanel class="w-full max-w-md p-6 overflow-hidden text-left align-middle transition-all transform bg-white shadow-xl rounded-2xl dark:bg-dark-surface dark:border dark:border-gray-700">
              <DialogTitle as="h3" class="text-lg font-medium leading-6 text-gray-900 dark:text-white">
                New Collection
              </DialogTitle>

              <form @submit.prevent="createCollection" class="mt-4 space-y-4">
                <div>
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">Name</label>
                  <input v-model="form.name" type="text" required class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500 sm:text-sm dark:bg-gray-800 dark:border-gray-600 dark:text-white" />
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">Color</label>
                  <div class="mt-2 flex space-x-2">
                    <button 
                      v-for="color in colors" 
                      :key="color" 
                      type="button"
                      @click="form.color = color"
                      class="w-6 h-6 rounded-full focus:outline-none focus:ring-2 focus:ring-offset-2 dark:focus:ring-offset-gray-800"
                      :class="form.color === color ? 'ring-2 ring-purple-500' : ''"
                      :style="{ backgroundColor: color }"
                    ></button>
                  </div>
                </div>

                <div class="mt-6 flex justify-end space-x-3">
                  <button type="button" class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50 dark:bg-gray-800 dark:text-gray-300 dark:border-gray-600" @click="isOpen = false">Cancel</button>
                  <button type="submit" class="px-4 py-2 text-sm font-medium text-white bg-purple-600 rounded-md hover:bg-purple-700 disabled:opacity-50" :disabled="loading">Create</button>
                </div>
              </form>
            </DialogPanel>
          </div>
        </div>
      </Dialog>
    </TransitionRoot>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useCollectionStore } from '~/stores/collections';
import { Dialog, DialogPanel, DialogTitle, TransitionChild, TransitionRoot } from '@headlessui/vue';

const collectionStore = useCollectionStore();
const isOpen = ref(false);
const loading = ref(false);

const colors = ['#ef4444', '#f97316', '#f59e0b', '#84cc16', '#10b981', '#06b6d4', '#3b82f6', '#6366f1', '#8b5cf6', '#ec4899'];

const form = ref({
  name: '',
  color: '#6366f1'
});

onMounted(() => {
  collectionStore.fetchCollections();
});

async function createCollection() {
  loading.value = true;
  try {
    await collectionStore.createCollection({ ...form.value });
    isOpen.value = false;
    form.value.name = ''; // Reset form
  } catch (err) {
    alert('Failed to create collection');
  } finally {
    loading.value = false;
  }
}

async function deleteCollection(id) {
  if (!confirm('Delete this collection?')) return;
  await collectionStore.deleteCollection(id);
}
</script>
