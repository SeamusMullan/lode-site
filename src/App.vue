
<script setup>
import Header from './components/Header.vue';
import Hero from './components/Hero.vue';
</script>

<template>
  <div class="app">
    <Header />
    <!-- Contains RouterLink components -->
    <main class="content">
        <Hero />
    </main>
    <Footer />
  </div>
</template>

<style scoped>
</style>
