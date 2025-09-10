<template>
  <div class="header">
    <div class="header-left">
      <!-- <h1>My Website</h1> -->
       <img src="/lode.png" alt="Logo" style="height:5rem; width: auto;">
    </div>

    <div class="header-right">
      <RouterLink to="/">Home</RouterLink>
      <a href="#about" @click="scrollToSection">About</a>
      <a href="#testimonials" @click="scrollToSection">Testimonials</a>
      <RouterLink to="/portfolio">Portfolio</RouterLink>
      <a href="#contact" @click="scrollToSection">Contact</a>
    </div>
  </div>
</template>

<script setup>
import { useRouter, useRoute } from 'vue-router'

const router = useRouter()
const route = useRoute()

const scrollToSection = (event) => {
  event.preventDefault()
  const targetId = event.target.getAttribute('href').substring(1) // Remove the #
  
  // If we're not on the home page, navigate there first
  if (route.name !== 'Home') {
    router.push({ name: 'Home', hash: `#${targetId}` })
    return
  }
  
  // If we're already on the home page, scroll to the section
  const targetElement = document.getElementById(targetId)
  if (targetElement) {
    targetElement.scrollIntoView({ 
      behavior: 'smooth',
      block: 'start'
    })
  }
}
</script>

<style lang="scss" scoped>
.header {
  background: linear-gradient(
    to bottom,
    rgba(0, 0, 0, 1.000) 0%, // full black
    rgba(0, 0, 0, 0.738) 19%,
    rgba(0, 0, 0, 0.541) 34%,
    rgba(0, 0, 0, 0.382) 47%,
    rgba(0, 0, 0, 0.278) 56.5%,
    rgba(0, 0, 0, 0.194) 65%,
    rgba(0, 0, 0, 0.126) 73%,
    rgba(0, 0, 0, 0.075) 80.2%,
    rgba(0, 0, 0, 0.042) 86.1%,
    rgba(0, 0, 0, 0.021) 91%,
    rgba(0, 0, 0, 0.008) 95.2%,
    rgba(0, 0, 0, 0.002) 98.2%,
    transparent 100%
  );
  padding: 3rem 4rem 2rem;
  display: flex;
  align-items: center;
  justify-content: space-between;

  h1 {
    margin: 0;
    font-size: 1.5rem;
  }
}


.header-left {
  display: flex;
  align-items: center;

  h1 {
    margin: 0;
    font-size: 2.5rem;
  }
}

.header-right {
  --nav-fs: var(--fs-18);
  --nav-fs-lg: var(--fs-20);
  --nav-gap: 2.25rem;
  display: flex;
  gap: var(--nav-gap);
  padding: 0 2rem;
  font-size: var(--nav-fs);
  font-weight: var(--fw-medium);
  letter-spacing: 0.02em;

  a,
  RouterLink {
    position: relative;
    color: white;
    text-decoration: none;
    padding: 0.25rem 0;
    transition: color 160ms ease;

    &::after {
      content: "";
      position: absolute;
      left: 0; bottom: 0;
      width: 100%; height: 2px;
      background: currentColor;
      transform: scaleX(0);
      transform-origin: left;
      transition: transform 220ms ease;
      opacity: 0.7;
    }

    &:hover::after,
    &:focus-visible::after { transform: scaleX(1); }
    &:hover { color: #9cc9ff; }
  }
}

@media (min-width: 900px) {
  .header-right { font-size: var(--nav-fs-lg); }
}

@media (max-width: 640px) {
  .header { flex-direction: column; align-items: flex-start; padding: 2rem 1.5rem 1rem; }
  .header-right { gap: 1.25rem; font-size: var(--fs-16); padding: 1rem 0 0; flex-wrap: wrap; }
}
</style>
