<template>
  <div class="fixed bottom-0 left-0 right-0 bg-white dark:bg-gray-900 border-t border-gray-200 dark:border-gray-800 p-4 shadow-lg transform transition-transform" :class="show ? 'translate-y-0' : 'translate-y-full'">
     <div class="max-w-2xl mx-auto flex items-center justify-between">
       <!-- Playback Controls -->
       <div class="flex items-center space-x-4">
          <button @click="stop" class="text-gray-500 hover:text-red-500">
             <Icon name="heroicons:stop" class="w-6 h-6" />
          </button>
          
          <button @click="togglePlay" class="bg-purple-600 text-white rounded-full p-3 hover:bg-purple-700">
             <Icon :name="isPlaying ? 'heroicons:pause' : 'heroicons:play'" class="w-6 h-6" />
          </button>
       </div>

       <!-- Info -->
       <div class="flex-1 mx-4">
         <div class="text-xs text-gray-500 mb-1">Text to Speech</div>
         <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-1.5 overflow-hidden">
            <div class="bg-purple-600 h-full transition-all duration-300" style="width: 0%"></div>
            <!-- Progress bar for speech is tricky without knowing text length relative to time, simplified for now -->
         </div>
       </div>

       <!-- Settings -->
       <div class="flex items-center space-x-2">
         <select v-model="selectedVoiceIndex" class="text-xs border-none bg-transparent dark:text-gray-300 focus:ring-0">
           <option v-for="(voice, index) in voices" :key="index" :value="index">
             {{ voice.name }}
           </option>
         </select>
         
         <div class="flex items-center space-x-1">
            <Icon name="heroicons:bolt" class="w-4 h-4 text-gray-400" />
            <select v-model="rate" class="text-xs border-none bg-transparent dark:text-gray-300 focus:ring-0 w-16">
              <option :value="0.5">0.5x</option>
              <option :value="0.75">0.75x</option>
              <option :value="1">1x</option>
              <option :value="1.25">1.25x</option>
              <option :value="1.5">1.5x</option>
              <option :value="2">2x</option>
            </select>
         </div>
       </div>
     </div>
  </div>
</template>

<script setup>
import { useSpeechSynthesis } from '@vueuse/core';
import { ref, watch, computed } from 'vue';

const props = defineProps({
  text: { type: String, default: '' },
  show: { type: Boolean, default: false },
});

const emit = defineEmits(['finish']);

const rate = ref(1);
const pitch = ref(1);
const selectedVoiceIndex = ref(0);

const voice = ref(undefined);
const textSource = computed(() => props.text);

const { 
  speak, 
  stop, 
  isPlaying, 
  voices, 
  isSupported 
} = useSpeechSynthesis(textSource, {
  voice,
  rate,
  pitch,
});

watch([voices, selectedVoiceIndex], () => {
  if (voices.value && voices.value.length > 0) {
    voice.value = voices.value[selectedVoiceIndex.value];
  }
});

watch(() => props.text, (newText) => {
  if (isPlaying.value && newText) {
    stop();
    setTimeout(() => speak(), 100);
  }
});

function togglePlay() {
  if (isPlaying.value) {
    window.speechSynthesis.pause(); // Standard API pause
    // note: useSpeechSynthesis doesn't export pause/resume directly easily in some versions, 
    // but we can toggle `speak/stop` or use window.speechSynthesis
   
    // If we want to resume, we need to know we were paused. 
    // Simple implementation: stop/start for now as pause is flaky in browsers
    stop(); 
  } else {
    speak();
  }
}

// Ensure voices are loaded
onMounted(() => {
  if (speechSynthesis.onvoiceschanged !== undefined) {
    speechSynthesis.onvoiceschanged = () => {
      // Force update voices if needed, VueUse usually handles this
    };
  }
});
</script>
