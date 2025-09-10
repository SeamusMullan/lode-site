<script setup>
import Header from '../components/Header.vue';
import PortfolioDetailed from '../components/Portfolio-Detailed.vue';
import Footer from '../components/Footer.vue';
</script>

<template>
  <div class="portfolio-page">
    <Header />
    <main class="content">
      <PortfolioDetailed />
    </main>
    <Footer />
  </div>
</template>

<style scoped>
.portfolio-page {
  margin: 0px;
}
</style>
