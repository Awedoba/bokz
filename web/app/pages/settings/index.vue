<template>
  <div class="px-4 sm:px-6 lg:px-8 py-8">
    <div class="mb-8">
      <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Settings</h1>
      <p class="mt-2 text-gray-600 dark:text-gray-400">Manage your account and application preferences.</p>
    </div>

    <div class="divide-y divide-gray-200 dark:divide-gray-700">
      <!-- Profile Section -->
      <div class="grid grid-cols-1 gap-x-8 gap-y-10 px-4 py-16 sm:px-6 md:grid-cols-3 lg:px-8">
        <div>
          <h2 class="text-base font-semibold leading-7 text-gray-900 dark:text-white">Profile</h2>
          <p class="mt-1 text-sm leading-6 text-gray-600 dark:text-gray-400">Your personal information.</p>
        </div>

        <form @submit.prevent="updateProfile" class="md:col-span-2">
          <div class="grid grid-cols-1 gap-x-6 gap-y-8 sm:max-w-xl sm:grid-cols-6">
            <div class="col-span-full flex items-center gap-x-8">
              <img :src="user?.avatarUrl || 'https://ui-avatars.com/api/?name=' + (user?.name || 'User')" alt="" class="h-24 w-24 flex-none rounded-lg bg-gray-800 object-cover" />
              <div>
                <button type="button" class="rounded-md bg-white/10 px-3 py-2 text-sm font-semibold text-gray-900 border border-gray-300 shadow-sm hover:bg-gray-50 dark:text-white dark:border-gray-600 dark:hover:bg-gray-800">Change avatar</button>
                <p class="mt-2 text-xs leading-5 text-gray-500 dark:text-gray-400">JPG, GIF or PNG. 1MB max.</p>
              </div>
            </div>

            <div class="col-span-full">
              <label for="name" class="block text-sm font-medium leading-6 text-gray-900 dark:text-white">Name</label>
              <div class="mt-2">
                <input v-model="form.name" type="text" name="name" id="name" autocomplete="name" class="block w-full rounded-md border-0 bg-white/5 py-1.5 text-gray-900 dark:text-white shadow-sm ring-1 ring-inset ring-gray-300 dark:ring-gray-700 focus:ring-2 focus:ring-inset focus:ring-purple-500 sm:text-sm sm:leading-6 pl-2" />
              </div>
            </div>

            <div class="col-span-full">
              <label for="email" class="block text-sm font-medium leading-6 text-gray-900 dark:text-white">Email</label>
              <div class="mt-2">
                <input v-model="form.email" type="email" name="email" id="email" autocomplete="email" disabled class="block w-full rounded-md border-0 bg-gray-100 dark:bg-gray-800 py-1.5 text-gray-500 dark:text-gray-400 shadow-sm ring-1 ring-inset ring-gray-300 dark:ring-gray-700 sm:text-sm sm:leading-6 pl-2 cursor-not-allowed" />
              </div>
            </div>
          </div>

          <div class="mt-8 flex">
            <button type="submit" :disabled="loading" class="rounded-md bg-purple-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-purple-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-purple-600 disabled:opacity-50">Save</button>
          </div>
        </form>
      </div>
      
      <!-- Preferences Section -->
      <div class="grid grid-cols-1 gap-x-8 gap-y-10 px-4 py-16 sm:px-6 md:grid-cols-3 lg:px-8">
        <div>
           <h2 class="text-base font-semibold leading-7 text-gray-900 dark:text-white">Preferences</h2>
           <p class="mt-1 text-sm leading-6 text-gray-600 dark:text-gray-400">Customize your application experience.</p>
        </div>
        
        <form class="md:col-span-2">
           <div class="grid grid-cols-1 gap-x-6 gap-y-8 sm:max-w-xl sm:grid-cols-6">
              <!-- Reading Goals -->
              <div class="col-span-full">
                 <label class="block text-sm font-medium leading-6 text-gray-900 dark:text-white">Daily Reading Goal (minutes)</label>
                 <div class="mt-2">
                     <input type="number" class="block w-32 rounded-md border-0 bg-white/5 py-1.5 text-gray-900 dark:text-white shadow-sm ring-1 ring-inset ring-gray-300 dark:ring-gray-700 focus:ring-2 focus:ring-inset focus:ring-purple-500 sm:text-sm sm:leading-6 pl-2" value="30" />
                 </div>
              </div>
           </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useAuthStore } from '~/stores/auth';

const authStore = useAuthStore();
const user = computed(() => authStore.user);
const loading = ref(false);

const form = ref({
  name: user.value?.name || '',
  email: user.value?.email || '',
});

async function updateProfile() {
    loading.value = true;
    // TODO: Implement update profile API call
    setTimeout(() => {
        loading.value = false;
        alert('Profile updated (mock)');
    }, 1000);
}
</script>
