<template>
  <div class="flex min-h-full flex-1 flex-col justify-center py-12 sm:px-6 lg:px-8">
    <div class="sm:mx-auto sm:w-full sm:max-w-md">
      <div class="flex justify-center">
        <Icon name="heroicons-solid:book-open" class="h-12 w-12 text-purple-600 dark:text-purple-500" />
      </div>
      <h2 class="mt-6 text-center text-2xl font-bold leading-9 tracking-tight text-gray-900 dark:text-white">
        Create a new account
      </h2>
      <p class="mt-2 text-center text-sm text-gray-600 dark:text-gray-400">
        Already have an account?
        <NuxtLink to="/login" class="font-medium text-purple-600 hover:text-purple-500 dark:text-purple-400">
          Sign in here
        </NuxtLink>
      </p>
    </div>

    <div class="mt-10 sm:mx-auto sm:w-full sm:max-w-[480px]">
      <div class="bg-white px-6 py-12 shadow sm:rounded-lg sm:px-12 dark:bg-dark-surface dark:border dark:border-gray-800">
        <form class="space-y-6" @submit.prevent="handleRegister">
          
          <div v-if="error" class="p-3 text-sm text-red-600 bg-red-100 rounded-lg dark:bg-red-900/30 dark:text-red-400">
            {{ error }}
          </div>

          <div>
            <label for="name" class="block text-sm font-medium leading-6 text-gray-900 dark:text-white">Full Name</label>
            <div class="mt-2">
              <input 
                id="name" 
                v-model="name" 
                name="name" 
                type="text" 
                required 
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-purple-600 sm:text-sm sm:leading-6 dark:bg-gray-800 dark:ring-gray-700 dark:text-white"
              />
            </div>
          </div>

          <div>
            <label for="email" class="block text-sm font-medium leading-6 text-gray-900 dark:text-white">Email address</label>
            <div class="mt-2">
              <input 
                id="email" 
                v-model="email" 
                name="email" 
                type="email" 
                autocomplete="email" 
                required 
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-purple-600 sm:text-sm sm:leading-6 dark:bg-gray-800 dark:ring-gray-700 dark:text-white"
              />
            </div>
          </div>

          <div>
            <label for="password" class="block text-sm font-medium leading-6 text-gray-900 dark:text-white">Password</label>
            <div class="mt-2">
              <input 
                id="password" 
                v-model="password" 
                name="password" 
                type="password" 
                required 
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-purple-600 sm:text-sm sm:leading-6 dark:bg-gray-800 dark:ring-gray-700 dark:text-white"
              />
            </div>
          </div>

          <div>
            <button 
              type="submit" 
              :disabled="loading"
              class="flex w-full justify-center rounded-md bg-purple-600 px-3 py-1.5 text-sm font-semibold leading-6 text-white shadow-sm hover:bg-purple-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-purple-600 disabled:opacity-70 disabled:cursor-not-allowed"
            >
              <span v-if="loading">Creating account...</span>
              <span v-else>Create account</span>
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useAuthStore } from '~/stores/auth';

definePageMeta({
  layout: 'empty'
});

const authStore = useAuthStore();
const router = useRouter();
const config = useRuntimeConfig();

const name = ref('');
const email = ref('');
const password = ref('');
const error = ref('');
const loading = ref(false);

async function handleRegister() {
  loading.value = true;
  error.value = '';

  try {
    const response = await $fetch('api/auth/register', {
      method: 'POST',
      baseURL: config.public.apiBase,
      body: {
        name: name.value,
        email: email.value,
        password: password.value,
      },
      onResponseError({ response }) {
        error.value = response._data?.error || 'Registration failed';
      }
    });

    if (response && response.user) {
      authStore.setUser(response.user);
      authStore.setToken(response.tokens.accessToken);
      
      const tokenCookie = useCookie('accessToken');
      tokenCookie.value = response.tokens.accessToken;
      
      router.push('/');
    }
  } catch (err) {
    // Error handled above
  } finally {
    loading.value = false;
  }
}
</script>
