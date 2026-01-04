<template>
  <div class="flex min-h-full flex-1 flex-col justify-center py-12 sm:px-6 lg:px-8">
    <div class="sm:mx-auto sm:w-full sm:max-w-md">
      <div class="flex justify-center">
        <Icon name="heroicons-solid:book-open" class="h-12 w-12 text-purple-600 dark:text-purple-500" />
      </div>
      <h2 class="mt-6 text-center text-2xl font-bold leading-9 tracking-tight text-gray-900 dark:text-white">
        Sign in to your account
      </h2>
      <p class="mt-2 text-center text-sm text-gray-600 dark:text-gray-400">
        Or
        <NuxtLink to="/auth/register" class="font-medium text-purple-600 hover:text-purple-500 dark:text-purple-400">
          create a new account
        </NuxtLink>
      </p>
    </div>

    <div class="mt-10 sm:mx-auto sm:w-full sm:max-w-[480px]">
      <div class="bg-white px-6 py-12 shadow sm:rounded-lg sm:px-12 dark:bg-dark-surface dark:border dark:border-gray-800">
        <form class="space-y-6" @submit.prevent="handleLogin">
          
          <div v-if="error" class="p-3 text-sm text-red-600 bg-red-100 rounded-lg dark:bg-red-900/30 dark:text-red-400">
            {{ error }}
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
                autocomplete="current-password" 
                required 
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-purple-600 sm:text-sm sm:leading-6 dark:bg-gray-800 dark:ring-gray-700 dark:text-white"
              />
            </div>
          </div>

          <div class="flex items-center justify-between">
            <div class="flex items-center">
              <input 
                id="remember-me" 
                name="remember-me" 
                type="checkbox" 
                class="h-4 w-4 rounded border-gray-300 text-purple-600 focus:ring-purple-600 dark:border-gray-600 dark:bg-gray-700" 
              />
              <label for="remember-me" class="ml-3 block text-sm leading-6 text-gray-900 dark:text-gray-300">Remember me</label>
            </div>

            <div class="text-sm leading-6">
              <a href="#" class="font-semibold text-purple-600 hover:text-purple-500 dark:text-purple-400">Forgot password?</a>
            </div>
          </div>

          <div>
            <button 
              type="submit" 
              :disabled="loading"
              class="flex w-full justify-center rounded-md bg-purple-600 px-3 py-1.5 text-sm font-semibold leading-6 text-white shadow-sm hover:bg-purple-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-purple-600 disabled:opacity-70 disabled:cursor-not-allowed"
            >
              <span v-if="loading">Signing in...</span>
              <span v-else>Sign in</span>
            </button>
          </div>
        </form>

        <div class="mt-6">
          <div class="relative">
            <div class="absolute inset-0 flex items-center">
              <div class="w-full border-t border-gray-300 dark:border-gray-700" />
            </div>
            <div class="relative flex justify-center text-sm">
              <span class="bg-white px-2 text-gray-500 dark:bg-dark-surface dark:text-gray-400">Or continue with</span>
            </div>
          </div>

          <div class="mt-6 grid grid-cols-2 gap-4">
            <a href="#" class="flex w-full items-center justify-center gap-3 rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus-visible:ring-transparent dark:bg-gray-800 dark:ring-gray-700 dark:text-white dark:hover:bg-gray-700">
              <Icon name="logos:google-icon" class="h-5 w-5" />
              <span class="text-sm font-semibold leading-6">Google</span>
            </a>

            <button 
              @click="handleGuestLogin"
              class="flex w-full items-center justify-center gap-3 rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus-visible:ring-transparent dark:bg-gray-800 dark:ring-gray-700 dark:text-white dark:hover:bg-gray-700"
            >
              <Icon name="heroicons:user" class="h-5 w-5 text-gray-500" />
              <span class="text-sm font-semibold leading-6">Guest</span>
            </button>
          </div>
        </div>
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

const email = ref('');
const password = ref('');
const error = ref('');
const loading = ref(false);

async function handleLogin() {
  loading.value = true;
  error.value = '';

  try {
    // Call backend API
    const response = await $fetch('api/auth/login', {
      method: 'POST',
      baseURL: config.public.apiBase,
      body: {
        email: email.value,
        password: password.value,
      },
      onResponseError({ response }) {
        error.value = response._data?.error || 'Login failed';
      }
    });

    if (response && response.user) {
      authStore.setUser(response.user);
      authStore.setToken(response.tokens.accessToken);
      // Save token for SSR
      const tokenCookie = useCookie('accessToken', {
        maxAge: 60 * 60 * 24 * 7, // 7 days
        path: '/'
      });
      tokenCookie.value = response.tokens.accessToken;
      
      router.push('/');
    }
  } catch (err) {
    // Error handled in onResponseError
  } finally {
    loading.value = false;
  }
}

async function handleGuestLogin() {
  loading.value = true;
  error.value = '';

  try {
    const response = await $fetch('api/auth/guest', {
      method: 'POST',
      baseURL: config.public.apiBase,
      onResponseError({ response }) {
        error.value = response._data?.error || 'Guest login failed';
      }
    });

    if (response && response.user) {
      authStore.setUser(response.user);
      authStore.setToken(response.tokens.accessToken);
      
      const tokenCookie = useCookie('accessToken', {
        maxAge: 60 * 60 * 24 * 7, // 7 days
        path: '/'
      });
      tokenCookie.value = response.tokens.accessToken;
      
      router.push('/');
    }
  } catch (err) {
    console.error(err);
  } finally {
    loading.value = false;
  }
}
</script>
