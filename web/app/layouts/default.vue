<template>
  <div class="min-h-screen bg-gray-50 dark:bg-dark-bg text-gray-900 dark:text-gray-100 transition-colors duration-200">
    <!-- Navbar -->
    <nav class="fixed top-0 z-50 w-full bg-white dark:bg-dark-surface border-b border-gray-200 dark:border-gray-800">
      <div class="px-3 py-3 lg:px-5 lg:pl-3">
        <div class="flex items-center justify-between">
          
          <!-- Left: Logo & Sidebar Toggle -->
          <div class="flex items-center justify-start">
            <button 
              @click="toggleSidebar"
              class="inline-flex items-center p-2 text-sm text-gray-500 rounded-lg sm:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600"
            >
              <span class="sr-only">Open sidebar</span>
              <Icon name="heroicons:bars-3" class="w-6 h-6" />
            </button>
            <NuxtLink to="/" class="flex ml-2 md:mr-24">
              <Icon name="heroicons-solid:book-open" class="h-8 w-8 mr-3 text-purple-600 dark:text-purple-500" />
              <span class="self-center text-xl font-semibold sm:text-2xl whitespace-nowrap dark:text-white">Bokz</span>
            </NuxtLink>
          </div>

          <!-- Right: Search, User Menu -->
          <div class="flex items-center">
            
            <!-- Search (hidden on mobile) -->
            <div class="hidden md:block relative mr-4">
              <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                <Icon name="heroicons:magnifying-glass" class="w-5 h-5 text-gray-500" />
              </div>
              <input 
                type="text" 
                class="block w-full p-2 pl-10 text-sm text-gray-900 border border-gray-300 rounded-lg bg-gray-50 focus:ring-purple-500 focus:border-purple-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-purple-500 dark:focus:border-purple-500" 
                placeholder="Search..."
              >
            </div>

            <!-- Theme Toggle -->
            <button 
              @click="toggleTheme" 
              class="p-2 mr-2 text-gray-500 rounded-lg hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-700"
            >
              <Icon :name="isDark ? 'heroicons:sun' : 'heroicons:moon'" class="w-5 h-5" />
            </button>

            <!-- User Menu -->
            <Menu as="div" class="relative ml-3" v-if="authStore.isAuthenticated">
              <div>
                <MenuButton class="flex text-sm bg-gray-800 rounded-full focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-600">
                  <span class="sr-only">Open user menu</span>
                  <img class="w-8 h-8 rounded-full" :src="authStore.user?.avatarUrl || 'https://ui-avatars.com/api/?name=' + authStore.user?.name" alt="user photo">
                </MenuButton>
              </div>
              <transition
                enter-active-class="transition ease-out duration-100"
                enter-from-class="transform opacity-0 scale-95"
                enter-to-class="transform opacity-100 scale-100"
                leave-active-class="transition ease-in duration-75"
                leave-from-class="transform opacity-100 scale-100"
                leave-to-class="transform opacity-0 scale-95"
              >
                <MenuItems class="absolute right-0 z-50 mt-2 w-48 origin-top-right rounded-md bg-white dark:bg-gray-700 py-1 shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none">
                  <div class="px-4 py-3">
                    <p class="text-sm text-gray-900 dark:text-white">{{ authStore.user?.name }}</p>
                    <p class="text-sm font-medium text-gray-500 truncate dark:text-gray-400">{{ authStore.user?.email }}</p>
                  </div>
                  <MenuItem v-slot="{ active }">
                    <a href="#" :class="[active ? 'bg-gray-100 dark:bg-gray-600' : '', 'block px-4 py-2 text-sm text-gray-700 dark:text-gray-200']">Settings</a>
                  </MenuItem>
                  <MenuItem v-slot="{ active }">
                    <button @click="logout" :class="[active ? 'bg-gray-100 dark:bg-gray-600' : '', 'block w-full text-left px-4 py-2 text-sm text-gray-700 dark:text-gray-200']">Sign out</button>
                  </MenuItem>
                </MenuItems>
              </transition>
            </Menu>
            
            <!-- Login Button (if guest/not logged in) -->
            <NuxtLink 
              v-else 
              to="/login"
              class="text-white bg-purple-700 hover:bg-purple-800 focus:ring-4 focus:ring-purple-300 font-medium rounded-lg text-sm px-4 py-2 dark:bg-purple-600 dark:hover:bg-purple-700 focus:outline-none dark:focus:ring-purple-800"
            >
              Log in
            </NuxtLink>

          </div>
        </div>
      </div>
    </nav>

    <!-- Sidebar -->
    <aside 
      class="fixed top-0 left-0 z-40 w-64 h-screen pt-20 transition-transform bg-white border-r border-gray-200 sm:translate-x-0 dark:bg-dark-surface dark:border-gray-800"
      :class="{ '-translate-x-full': !sidebarOpen }"
    >
      <div class="h-full px-3 pb-4 overflow-y-auto bg-white dark:bg-dark-surface">
        <ul class="space-y-2 font-medium">
          <li v-for="item in navigation" :key="item.name">
            <NuxtLink 
              :to="item.href" 
              class="flex items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group"
              active-class="bg-gray-100 dark:bg-gray-700 text-purple-600 dark:text-purple-400"
            >
              <Icon :name="item.icon" class="w-5 h-5 text-gray-500 transition duration-75 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white" />
              <span class="ml-3">{{ item.name }}</span>
            </NuxtLink>
          </li>
        </ul>
        
        <!-- Collections Section -->
        <LibraryCollectionList />

      </div>
    </aside>

    <!-- Main Content -->
    <div class="p-4 sm:ml-64 pt-20">
      <slot />
    </div>

  </div>
</template>

<script setup>
import { ref } from 'vue'
import { Menu, MenuButton, MenuItems, MenuItem } from '@headlessui/vue'
import { useAuthStore } from '~/stores/auth'

const authStore = useAuthStore()
const sidebarOpen = ref(false) // Mobile sidebar state
const isDark = useDark()
const toggleTheme = useToggle(isDark)

const navigation = [
  { name: 'Dashboard', href: '/', icon: 'heroicons:home' },
  { name: 'Library', href: '/library', icon: 'heroicons:book-open' },
  { name: 'Discover', href: '/discover', icon: 'heroicons:globe-alt' },
  { name: 'Analytics', href: '/analytics', icon: 'heroicons:chart-bar' },
  { name: 'Settings', href: '/settings', icon: 'heroicons:cog-6-tooth' },
]

function toggleSidebar() {
  sidebarOpen.value = !sidebarOpen.value
}

async function logout() {
  // Implement logout logic
  const { error } = await useFetch('/api/auth/logout', {
    method: 'POST',
    baseURL: useRuntimeConfig().public.apiBase,
    headers: { Authorization: `Bearer ${authStore.accessToken}` }
  })
  
  if (!error.value) {
    authStore.clearAuth()
    navigateTo('/login')
  }
}
</script>
