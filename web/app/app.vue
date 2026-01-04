<template>
  <NuxtLayout>
    <NuxtPage />
  </NuxtLayout>
</template>

<script setup>
import { useAuthStore } from '~/stores/auth';

const authStore = useAuthStore();

// Initialize auth on app mount
// onMounted(() => {
//   authStore.initAuth();
// });
</script>
