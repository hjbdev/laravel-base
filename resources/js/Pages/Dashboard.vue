<template>
    <app-layout>
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight"> Dashboard </h2>
        </template>

        <div class="py-7">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <Card>
                    <welcome />
                </Card>
            </div>
        </div>
    </app-layout>
</template>

<script>
    import AppLayout from '@/Layouts/AppLayout'
    import Welcome from '@/Jetstream/Welcome'
    import Card from '@/Ui/Card'

    export default {
        components: {
            AppLayout,
            Welcome,
            Card
        },
    }
</script>
