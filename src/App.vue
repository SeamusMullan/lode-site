
<script setup>
import Header from './components/Header.vue';
</script>

<template>
  <div class="app">
    <Header />
    <!-- Contains RouterLink components -->
    <main class="content">
      <RouterView />
    </main>
    <Footer />
  </div>
</template>

<style scoped>
</style>
