<template>
  <TransitionRoot as="template" :show="show">
    <Dialog as="div" class="relative z-50" @close="$emit('close')">
      <TransitionChild as="template" enter="ease-out duration-300" enter-from="opacity-0" enter-to="opacity-100" leave="ease-in duration-200" leave-from="opacity-100" leave-to="opacity-0">
        <div class="fixed inset-0 bg-black/25 backdrop-blur-sm" />
      </TransitionChild>

      <div class="fixed inset-0 overflow-y-auto">
        <div class="flex min-h-full items-center justify-center p-4 text-center">
          <TransitionChild as="template" enter="ease-out duration-300" enter-from="opacity-0 scale-95" enter-to="opacity-100 scale-100" leave="ease-in duration-200" leave-from="opacity-100 scale-100" leave-to="opacity-0 scale-95">
            <DialogPanel class="w-full max-w-sm transform overflow-hidden rounded-2xl bg-white dark:bg-gray-800 p-6 text-left align-middle shadow-xl transition-all border border-gray-100 dark:border-gray-700">
              <DialogTitle as="h3" class="text-lg font-medium leading-6 text-gray-900 dark:text-white border-b border-gray-200 dark:border-gray-700 pb-2 mb-4">
                Reader Settings
              </DialogTitle>
              
              <div class="space-y-6">
                <!-- Theme -->
                <div>
                  <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Theme</label>
                  <div class="grid grid-cols-3 gap-3">
                    <button 
                      v-for="theme in themes" 
                      :key="theme.value"
                      @click="readerStore.settings.theme = theme.value"
                      class="flex flex-col items-center justify-center p-2 rounded-lg border-2 transition-all"
                      :class="[
                        readerStore.settings.theme === theme.value ? 'border-purple-600' : 'border-transparent hover:bg-gray-50 dark:hover:bg-gray-700',
                        theme.class
                      ]"
                    >
                      <span class="text-xs font-semibold">{{ theme.label }}</span>
                    </button>
                  </div>
                </div>

                <!-- Font Size -->
                <div>
                  <div class="flex items-center justify-between mb-2">
                     <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">Font Size</label>
                     <span class="text-xs text-gray-500">{{ readerStore.settings.fontSize }}%</span>
                  </div>
                  <div class="flex items-center space-x-4">
                    <button @click="adjustFontSize(-10)" class="p-1 rounded hover:bg-gray-100 dark:hover:bg-gray-700">
                       <Icon name="heroicons:minus-small" class="w-5 h-5 text-gray-600 dark:text-gray-300" />
                    </button>
                    <div class="flex-1 h-2 bg-gray-200 dark:bg-gray-700 rounded-full overflow-hidden">
                       <div class="bg-purple-600 h-full transition-all" :style="{ width: (readerStore.settings.fontSize - 50) + '%' }"></div>
                    </div>
                    <button @click="adjustFontSize(10)" class="p-1 rounded hover:bg-gray-100 dark:hover:bg-gray-700">
                       <Icon name="heroicons:plus-small" class="w-5 h-5 text-gray-600 dark:text-gray-300" />
                    </button>
                  </div>
                </div>

                <!-- Font Family -->
                <div>
                   <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Font Family</label>
                   <select v-model="readerStore.settings.fontFamily" class="block w-full rounded-md border-gray-300 shadow-sm focus:border-purple-500 focus:ring-purple-500 sm:text-sm dark:bg-gray-700 dark:border-gray-600 dark:text-white">
                     <option value="serif">Serif (Merriweather)</option>
                     <option value="sans-serif">Sans-Serif (Inter)</option>
                   </select>
                </div>
              </div>

              <div class="mt-8 flex justify-end">
                <button
                  type="button"
                  class="inline-flex justify-center rounded-md border border-transparent bg-purple-100 px-4 py-2 text-sm font-medium text-purple-900 hover:bg-purple-200 focus:outline-none"
                  @click="$emit('close')"
                >
                  Done
                </button>
              </div>
            </DialogPanel>
          </TransitionChild>
        </div>
      </div>
    </Dialog>
  </TransitionRoot>
</template>

<script setup>
import { useReaderStore } from '~/stores/reader';
import { Dialog, DialogPanel, DialogTitle, TransitionChild, TransitionRoot } from '@headlessui/vue';

defineProps({
  show: Boolean
});

defineEmits(['close']);

const readerStore = useReaderStore();

const themes = [
  { label: 'Light', value: 'light', class: 'bg-white text-gray-900 border-gray-200' },
  { label: 'Sepia', value: 'sepia', class: 'bg-[#f6e0b5] text-[#5f4b32] border-[#eaddc5]' },
  { label: 'Dark', value: 'dark', class: 'bg-gray-900 text-white border-gray-700' },
];

function adjustFontSize(delta) {
  const newSize = readerStore.settings.fontSize + delta;
  if (newSize >= 50 && newSize <= 200) {
    readerStore.settings.fontSize = newSize;
  }
}
</script>
