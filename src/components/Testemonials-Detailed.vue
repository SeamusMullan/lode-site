<template>
  <div class="testimonials-detailed">
    <div class="testimonials-detailed__header">
      <h2 class="testimonials-detailed__title">What Artists Say</h2>
      <p class="testimonials-detailed__subtitle">
        Real feedback from artists we've worked with
      </p>
    </div>

    <div class="testimonials-detailed__track-wrapper">
      <!-- scrolling container -->
      <div class="testimonials-detailed__track">
        <div
          v-for="(testimonial, index) in duplicatedTestimonials"
          :key="index"
          class="testimonials-detailed__item"
        >
          <div class="testimonials-detailed__content">
            <div class="testimonials-detailed__text">
              <div class="testimonials-detailed__content-top">
                <h3 class="testimonials-detailed__heading">
                  {{ testimonial.heading }}
                </h3>
                <p class="testimonials-detailed__quote">
                  "{{ testimonial.quote }}"
                </p>
              </div>
              <div class="testimonials-detailed__author">
                <span class="testimonials-detailed__name">{{
                  testimonial.artist
                }}</span>
                <span class="testimonials-detailed__role">{{
                  testimonial.role
                }}</span>
              </div>
            </div>
            <div class="testimonials-detailed__logo">
              <img
                :src="testimonial.logo"
                :alt="testimonial.artist"
                class="testimonials-detailed__image"
              />
            </div>
          </div>
        </div>
      </div>

      <!-- gradient masks for smooth edges -->
      <div
        class="testimonials-detailed__fade testimonials-detailed__fade--left"
      ></div>
      <div
        class="testimonials-detailed__fade testimonials-detailed__fade--right"
      ></div>
    </div>
  </div>
</template>

<script setup>
import { computed } from "vue";

const testimonials = [
  {
    heading: "Incredible Mix Quality",
    quote: "Outstanding attention to detail. Every element sits perfectly in the mix.",
    artist: "Hevel",
    role: "Electronic Producer",
    logo: "/logos/hevel.png",
  },
  {
    heading: "Professional & Creative",
    quote: "Working with Lode was a game-changer. The creativity elevated my music to a new level.",
    artist: "Jiselle",
    role: "Singer-Songwriter",
    logo: "/logos/jiselle.png",
  },
  {
    heading: "Perfect Sound Design",
    quote: "Exceeded all expectations. Every detail crafted with precision and artistic vision.",
    artist: "Maybe Blue",
    role: "Indie Artist",
    logo: "/logos/maybe_blue.png",
  },
  {
    heading: "Studio Excellence",
    quote: "Seamless process. Technical expertise combined with creative insight made this incredible.",
    artist: "Sonny Zero",
    role: "Hip-Hop Artist",
    logo: "/logos/sonny_zero.png",
  },
];

const duplicatedTestimonials = computed(() => [
  ...testimonials,
  ...testimonials,
]);
</script>

<style scoped>
.testimonials-detailed {
  padding: 4rem 0;
}

.testimonials-detailed__header {
  text-align: center;
  margin-bottom: 3rem;
  padding: 0 2rem;
}

.testimonials-detailed__title {
  font-size: 2.5rem;
  font-weight: 700;
  color: #ffffff;
  margin-bottom: 1rem;
}

.testimonials-detailed__subtitle {
  font-size: 1.25rem;
  color: #b0b0b0;
  max-width: 600px;
  margin: 0 auto;
}

.testimonials-detailed__track-wrapper {
  position: relative;
  overflow: hidden;
  width: 100%;
}

.testimonials-detailed__track {
  display: flex;
  align-items: stretch;
  gap: 3rem;
  animation: scroll-testimonials 25s linear infinite;
}

.testimonials-detailed__track:hover {
  animation-play-state: paused;
}

.testimonials-detailed__item {
  flex-shrink: 0;
  width: 500px;
  display: flex;
  flex-direction: column;
}

.testimonials-detailed__content {
  transform: scale(0.95);
  display: flex;
  align-items: stretch;
  gap: 2rem;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  padding-left: 2rem;
  padding-right: 2rem;
  padding-top: 2rem;
  padding-bottom: 3rem;
  backdrop-filter: blur(10px);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  box-sizing: border-box;
  flex: 1;
}

.testimonials-detailed__content:hover {
  transform: scale(1);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
}

.testimonials-detailed__text {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.testimonials-detailed__heading {
  font-size: 1.5rem;
  font-weight: 600;
  color: #ffffff;
  margin-bottom: 1rem;
}

.testimonials-detailed__quote {
  font-size: 1rem;
  line-height: 1.6;
  color: #e0e0e0;
  margin-bottom: 0;
  font-style: italic;
  padding-bottom: 0.5rem;
}

.testimonials-detailed__author {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.testimonials-detailed__name {
  font-size: 1.1rem;
  font-weight: 600;
  color: #ffffff;
  margin-bottom: 0.25rem;
}

.testimonials-detailed__role {
  font-size: 0.9rem;
  color: #b0b0b0;
}

.testimonials-detailed__logo {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 160px;
  height: 160px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  padding: 1.5rem;
}

.testimonials-detailed__image {
  max-width: 100%;
  max-height: 100%;
  object-fit: contain;
  filter: brightness(0.9);
  transition: filter 0.3s ease;
}

.testimonials-detailed__content:hover .testimonials-detailed__image {
  filter: brightness(1);
}

.testimonials-detailed__fade {
  position: absolute;
  top: 0;
  width: 100px;
  height: 100%;
  pointer-events: none;
  z-index: 2;
}

.testimonials-detailed__fade--left {
  left: 0;
  background: linear-gradient(to right, #0f0f0f, transparent);
}

.testimonials-detailed__fade--right {
  right: 0;
  background: linear-gradient(to left, #0f0f0f, transparent);
}

/* scrolling animation */
@keyframes scroll-testimonials {
  to {
    transform: translateX(-50%);
  }
}

/* responsive design */
@media (max-width: 768px) {
  .testimonials-detailed {
    padding: 2rem 0;
  }

  .testimonials-detailed__title {
    font-size: 2rem;
  }

  .testimonials-detailed__subtitle {
    font-size: 1.1rem;
  }

  .testimonials-detailed__item {
    width: 350px;
  }

  .testimonials-detailed__content {
    flex-direction: column;
    text-align: center;
    padding: 1.5rem;
  }

  .testimonials-detailed__logo {
    width: 120px;
    height: 120px;
  }

  .testimonials-detailed__heading {
    font-size: 1.25rem;
  }

  .testimonials-detailed__quote {
    font-size: 0.9rem;
  }

  .testimonials-detailed__track {
    gap: 2rem;
  }
}

@media (max-width: 480px) {
  .testimonials-detailed__item {
    width: 280px;
  }

  .testimonials-detailed__content {
    padding: 1rem;
  }

  .testimonials-detailed__heading {
    font-size: 1.1rem;
  }

  .testimonials-detailed__quote {
    font-size: 0.85rem;
  }
}
</style>
