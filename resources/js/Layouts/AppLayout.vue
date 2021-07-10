<template>
    <div>
        <jet-banner />

        <div class="min-h-screen bg-gray-100">

            <!-- Sidebar -->
            <div class="flex relative">
                <JetSidebar
                    @toggle="toggleSidebar"
                    :show="showingSidebar"
                >
                    <JetSidebarLink
                        :href="route('dashboard')"
                        :active="route().current('dashboard')"
                    >Dashboard</JetSidebarLink>
                </JetSidebar>
                <div class="flex-1">
                    <nav class="bg-white border-b border-gray-100">
                        <!-- Primary Navigation Menu -->
                        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                            <div class="flex justify-between h-16">
                                <div class="flex">
                                    <!-- Logo -->
                                    <div class="flex-shrink-0 flex items-center">
                                        <button @click="toggleSidebar">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                                            </svg>
                                        </button>
                                    </div>

                                    <!-- Navigation Links -->
                                    <div class="sm:-my-px ml-5 flex items-center">
                                        <slot name="header"></slot>
                                    </div>
                                </div>

                            </div>
                        </div>
                        
                    </nav>

                    <!-- Page Content -->
                    <main>
                        <transition
                            enter-active-class="transition transform duration-300"
                            enter-from-class="translate-y-8 opacity-0"
                            enter-to-class="translate-y-0"
                            leave-active-class="transition transform duration-200"
                            leave-from-class="translate-y-0"
                            leave-to-class="translate-y-8 opacity-0"
                            mode="out-in"
                            appear
                        >
                            <slot :key="$page.url"></slot>
                        </transition>
                    </main>
                </div>
            </div>

        </div>
    </div>
</template>

<script>
import JetApplicationLogo from "@/Jetstream/ApplicationLogo";
import JetBanner from "@/Jetstream/Banner";
import JetDropdown from "@/Jetstream/Dropdown";
import JetDropdownLink from "@/Jetstream/DropdownLink";
import JetNavLink from "@/Jetstream/NavLink";
import JetResponsiveNavLink from "@/Jetstream/ResponsiveNavLink";
import JetSidebarLink from "@/Jetstream/SidebarLink";
import JetSidebar from '@/Jetstream/Sidebar';

export default {
    components: {
        JetApplicationLogo,
        JetBanner,
        JetDropdown,
        JetDropdownLink,
        JetNavLink,
        JetResponsiveNavLink,
        JetSidebarLink,
        JetSidebar
    },

    data() {
        return {
            showingNavigationDropdown: false,
            showingSidebar: localStorage.getItem('jet-sidebar') === 'true'
        };
    },

    methods: {
        switchToTeam(team) {
            this.$inertia.put(
                route("current-team.update"),
                {
                    team_id: team.id,
                },
                {
                    preserveState: false,
                }
            );
        },

        toggleSidebar() {
            this.showingSidebar = !this.showingSidebar;
            localStorage.setItem('jet-sidebar', this.showingSidebar);
        },

        logout() {
            this.$inertia.post(route("logout"));
        },
    },
};
</script>
