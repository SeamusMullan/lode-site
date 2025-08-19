
<script setup>
import Header from './components/Header.vue';
import Hero from './components/Hero.vue';
import TestemonialLogos from './components/Testemonial-Logos.vue';
import PortfolioPreview from './components/Portfolio-Preview.vue';
</script>

<template>
  <div class="app">
    <Header />
    <!-- Contains RouterLink components -->
    <main class="content">
      <!--<Hero />-->
      <Hero />
      <TestemonialLogos />
      <PortfolioPreview />
    </main>
    <Footer />
  </div>
</template>

<style scoped>

.app {
  margin: 0px; 
}

</style>
