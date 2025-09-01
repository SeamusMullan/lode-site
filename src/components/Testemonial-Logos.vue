<template>
  <div class="logo-slider">
    <p class="logo-slider__intro">
      Trusted by artists like
    </p>

    <div class="logo-slider__track-wrapper">
      <!-- scrolling container -->
      <ul class="logo-slider__track">
        <li
          v-for="(logo, index) in duplicatedLogos"
          :key="index"
          class="logo-slider__item"
        >
          <img
            :src="logo.src"
            :alt="logo.alt"
            class="logo-slider__image"
          />
        </li>
      </ul>

      <!-- gradient masks for smooth edges -->
      <div class="logo-slider__fade logo-slider__fade--left"></div>
      <div class="logo-slider__fade logo-slider__fade--right"></div>
    </div>
  </div>
</template>

<script setup>
import { computed } from "vue";

const logos = [
  { src: "/logos/hevel.png", alt: "Hevel" },
  { src: "/logos/jiselle.png", alt: "Jiselle" },
  { src: "/logos/maybe_blue.png", alt: "Maybe Blue" },
  { src: "/logos/sonny_zero.png", alt: "Sonny Zero" },
];

const duplicatedLogos = computed(() => [...logos, ...logos]);
</script>

<style scoped>
.logo-slider {
  padding-bottom: 2rem;
  padding-top: 2rem;
  text-align: center;
}

.logo-slider__intro {
  font-size: 1.25rem;
  font-weight: 500;
  color: #b0b0b0;
  margin-bottom: 1.5rem;
}

.logo-slider__track-wrapper {
  position: relative;
  overflow: hidden;
  width: 100%;
}

.logo-slider__track {
  display: flex;
  gap: 8rem;
  animation: scroll 30s linear infinite;
}

.logo-slider__item {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
}

.logo-slider__image {
  height: 60px;
  width: auto;
  object-fit: contain;
  filter: grayscale(100%) brightness(0.9);
  transition: filter 0.3s ease;
}

.logo-slider__image:hover {
  filter: grayscale(0%) brightness(1);
}

.logo-slider__fade {
  position: absolute;
  top: 0;
  width: 80px;
  height: 100%;
  pointer-events: none;
  z-index: 2;
}

.logo-slider__fade--left {
  left: 0;
  background: linear-gradient(to right, #0f0f0f, transparent);
}

.logo-slider__fade--right {
  right: 0;
  background: linear-gradient(to left, #0f0f0f, transparent);
}

/* scrolling animation */
@keyframes scroll {
  0% {
    transform: translateX(0);
  }
  100% {
    transform: translateX(-50%);
  }
}

/* responsive tweaks */
@media (max-width: 768px) {
  .logo-slider__image {
    height: 40px;
  }
  .logo-slider__track {
    gap: 1rem;
  }
}
</style>
