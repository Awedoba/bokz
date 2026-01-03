/** @type {import('tailwindcss').Config} */
module.exports = {
    content: [
        "./components/**/*.{js,vue,ts}",
        "./layouts/**/*.vue",
        "./pages/**/*.vue",
        "./plugins/**/*.{js,ts}",
        "./app.vue",
        "./error.vue",
    ],
    darkMode: 'class',
    theme: {
        extend: {
            colors: {
                // Custom dark theme colors based on templates
                dark: {
                    bg: '#0f172a',
                    surface: '#1e293b',
                    accent: '#7c3aed', // Violet-600
                }
            },
            fontFamily: {
                sans: ['Inter', 'sans-serif'],
                serif: ['Inter', 'Georgia', 'serif'],
            }
        },
    },
    plugins: [
        require('@tailwindcss/typography'),
        require('@tailwindcss/forms'),
    ],
}
