<template>
    <!-- We have to co-ordinate these transitions to make the layout re-flow smoothly. -->
    <transition
        enter-active-class="transition transform duration-300"
        enter-from-class="-translate-x-full flex-0"
        enter-to-class="translate-x-0"
        leave-active-class="transition transform duration-200"
        leave-from-class="translate-x-0"
        leave-to-class="-translate-x-full flex-0"
    >
        <div
            class="fixed left-0 top-0 bottom-0 w-64 bg-gradient-to-b from-blue-900 to-blue-800 text-white z-50 flex flex-col"
            v-if="show"
        >
            <div class="h-16 border-b border-gray-900 shadow flex items-center py-3 px-4 sm:px-6 lg:px-8">
                <JetApplicationLogo class="h-10"></JetApplicationLogo>
            </div>
            <div class="flex-1">
                <slot></slot>
            </div>
            <div>
                <div class="relative py-3 px-4 sm:px-6 lg:px-8 ">
                    <!-- Teams Dropdown -->
                    <jet-dropdown
                        align="bottom-left"
                        width="48"
                        v-if="$page.props.jetstream.hasTeamFeatures"
                    >
                        <template #trigger>
                            <button
                                type="button"
                                class="flex items-center font-light hover:bg-white-900 hover:bg-opacity-10 transition focus:outline-none w-full text-left"
                            >
                                <div class="flex-1 text-sm">{{ $page.props.user.current_team.name }}</div>
                                <svg
                                    class="inline-block h-4 w-4"
                                    xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 20 20"
                                    fill="currentColor"
                                >
                                    <path
                                        fill-rule="evenodd"
                                        d="M10 3a1 1 0 01.707.293l3 3a1 1 0 01-1.414 1.414L10 5.414 7.707 7.707a1 1 0 01-1.414-1.414l3-3A1 1 0 0110 3zm-3.707 9.293a1 1 0 011.414 0L10 14.586l2.293-2.293a1 1 0 011.414 1.414l-3 3a1 1 0 01-1.414 0l-3-3a1 1 0 010-1.414z"
                                        clip-rule="evenodd"
                                    />
                                </svg>
                            </button>
                        </template>

                        <template #content>
                            <div>
                                <!-- Team Management -->
                                <template v-if="$page.props.jetstream.hasTeamFeatures">
                                    <div class="block px-4 py-2 text-xs text-gray-400">
                                        Manage Team
                                    </div>

                                    <!-- Team Settings -->
                                    <jet-dropdown-link :href="route('teams.show', $page.props.user.current_team)">
                                        Team Settings
                                    </jet-dropdown-link>

                                    <jet-dropdown-link
                                        :href="route('teams.create')"
                                        v-if="$page.props.jetstream.canCreateTeams"
                                    >
                                        Create New Team
                                    </jet-dropdown-link>

                                    <div class="border-t border-gray-100"></div>

                                    <!-- Team Switcher -->
                                    <div class="block px-4 py-2 text-xs text-gray-400">
                                        Switch Teams
                                    </div>

                                    <template
                                        v-for="team in $page.props.user.all_teams"
                                        :key="team.id"
                                    >
                                        <form @submit.prevent="switchToTeam(team)">
                                            <jet-dropdown-link as="button">
                                                <div class="flex items-center">
                                                    <svg
                                                        v-if="team.id == $page.props.user.current_team_id"
                                                        class="mr-2 h-5 w-5 text-green-400"
                                                        fill="none"
                                                        stroke-linecap="round"
                                                        stroke-linejoin="round"
                                                        stroke-width="2"
                                                        stroke="currentColor"
                                                        viewBox="0 0 24 24"
                                                    >
                                                        <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                                    </svg>
                                                    <div>{{ team.name }}</div>
                                                </div>
                                            </jet-dropdown-link>
                                        </form>
                                    </template>
                                </template>
                            </div>
                        </template>
                    </jet-dropdown>
                </div>

                <!-- Settings Dropdown -->
                <div class="relative py-3 px-4 sm:px-6 lg:px-8">
                    <jet-dropdown
                        align="bottom-left-12"
                        width="48"
                    >
                        <template #trigger>
                            <button
                                type="button"
                                class="flex items-center font-light hover:bg-white-900 hover:bg-opacity-10 transition focus:outline-none w-full text-left"
                            >
                                <div class="flex-1">
                                    <div class="font-medium text-sm text-white">{{ $page.props.user.name }}</div>
                                    <div class="font-medium text-xs text-gray-300">{{ $page.props.user.email }}</div>
                                </div>
                                <svg
                                    class="inline-block h-4 w-4"
                                    xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 20 20"
                                    fill="currentColor"
                                >
                                    <path
                                        fill-rule="evenodd"
                                        d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                        clip-rule="evenodd"
                                    />
                                </svg>
                            </button>
                        </template>

                        <template #content>
                            <!-- Account Management -->
                            <div class="block px-4 py-2 text-xs text-gray-400">
                                Manage Account
                            </div>

                            <jet-dropdown-link :href="route('profile.show')">
                                Profile
                            </jet-dropdown-link>

                            <jet-dropdown-link
                                :href="route('api-tokens.index')"
                                v-if="$page.props.jetstream.hasApiFeatures"
                            >
                                API Tokens
                            </jet-dropdown-link>

                            <div class="border-t border-gray-100"></div>

                            <!-- Authentication -->
                            <form @submit.prevent="logout">
                                <jet-dropdown-link as="button">
                                    Log Out
                                </jet-dropdown-link>
                            </form>
                        </template>
                    </jet-dropdown>
                </div>
                <div class="py-3 px-4 sm:px-6 lg:px-8">
                    
                </div>
            </div>
        </div>
    </transition>
    <transition
        enter-active-class="transition-all duration-300"
        enter-from-class="w-0"
        enter-to-class="sm:w-64"
        leave-active-class="transition-all duration-200"
        leave-from-class="sm:w-64"
        leave-to-class="w-0"
        @after-enter="afterEnter"
    >
        <div v-if="show" ref="spacer"></div>
    </transition>
    <transition
        enter-active-class="transition-all duration-300"
        enter-from-class="opacity-0"
        enter-to-class="opacity-100"
        leave-active-class="transition-all duration-200"
        leave-from-class="opacity-100"
        leave-to-class="opacity-0"
    >
        <div
            v-if="show"
            class="fixed inset-0 sm:hidden bg-black bg-opacity-25 z-40"
            @click="emit('toggle')"
        ></div>
    </transition>
</template>
<script>
import JetApplicationLogo from "@/Jetstream/ApplicationLogo";
import JetSidebarLink from "@/Jetstream/SidebarLink";
import JetDropdown from "@/Jetstream/Dropdown";
import JetDropdownLink from "@/Jetstream/DropdownLink";
import { onMounted, ref } from 'vue';

export default {
    emits: ["toggle"],
    props: {
        show: Boolean,
    },
    components: {
        JetApplicationLogo,
        JetSidebarLink,
        JetDropdown,
        JetDropdownLink,
    },
    setup(props, { emit }) {
        const afterEnter = (el) => {
            el.classList.add("sm:w-64");
        };

        const spacer = ref(null);

        onMounted(() => {
            if(props.show) {
                spacer.value.classList.add('sm:w-64');
            }
        });

        return { afterEnter, emit, spacer };
    },
};
</script>