<template>
    <inertia-link
        :class="{ 'border-l-4 border-white bg-white bg-opacity-5': active }"
        class="flex items-center py-3 px-4 sm:px-6 lg:px-8 font-light hover:bg-white-900 hover:bg-opacity-10 transition focus:outline-none w-full text-left"
    >
        <svg
            xmlns="http://www.w3.org/2000/svg"
            class="h-4 w-4 inline-block mr-2"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
        >
            <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"
            />
        </svg>
        <div><slot></slot></div>
    </inertia-link>
</template>
<script>
export default {
    props: {
        active: Boolean
    }
}
</script>