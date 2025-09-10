<script setup>
import Header from '../components/Header.vue';
import Hero from '../components/Hero.vue';
import TestemonialLogos from '../components/Testemonial-Logos.vue';
import PortfolioPreview from '../components/Portfolio-Preview.vue';
import About from '../components/About.vue';
import TestemonialDetailed from '../components/Testemonials-Detailed.vue';
import Footer from '../components/Footer.vue';
</script>

<template>
  <div class="home">
    <Header />
    <main class="content">
      <Hero />
      <TestemonialLogos />
      <PortfolioPreview />
      <section id="about">
        <About />
      </section>
      <section id="testimonials">
        <TestemonialDetailed />
      </section>
      <section id="contact">
        <Footer />
      </section>
    </main>
  </div>
</template>

<style scoped>
.home {
  margin: 0px;
}
</style>
