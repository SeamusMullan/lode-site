
<script setup>
import Header from './components/Header.vue';
import Hero from './components/Hero.vue';
import TestemonialLogos from './components/Testemonial-Logos.vue';
import PortfolioPreview from './components/Portfolio-Preview.vue';
import About from './components/About.vue';
import TestemonialDetailed from './components/Testemonials-Detailed.vue';
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
      <About />
      <TestemonialDetailed />
    </main>
    <Footer />
  </div>
</template>

<style scoped>

.app {
  margin: 0px; 
}

</style>
