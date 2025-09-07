<template>
  <div class="testimonials-detailed">
    <div class="testimonials-detailed__header">
      <h2 class="testimonials-detailed__title">What Artists Say</h2>
      <p class="testimonials-detailed__subtitle">
        Real feedback from artists we've worked with
      </p>
    </div>

    <div class="testimonials-detailed__slider">
      <!-- Three-slide layout: previous, current, next -->
      <div class="testimonials-detailed__slide-wrapper" :class="{ 
        'testimonials-detailed__slide-wrapper--animating': isAnimating,
        'testimonials-detailed__slide-wrapper--next': isAnimating && animationDirection === 'next',
        'testimonials-detailed__slide-wrapper--prev': isAnimating && animationDirection === 'prev'
      }">
        <!-- Previous slide (faded) -->
        <div class="testimonials-detailed__slide testimonials-detailed__slide--prev">
          <div class="testimonials-detailed__content testimonials-detailed__content--faded">
            <div class="testimonials-detailed__text">
              <div class="testimonials-detailed__content-top">
                <h3 class="testimonials-detailed__heading">
                  {{ previousTestimonial.heading }}
                </h3>
                <p class="testimonials-detailed__quote">
                  "{{ previousTestimonial.quote }}"
                </p>
              </div>
              <div class="testimonials-detailed__author">
                <span class="testimonials-detailed__name">
                  {{ previousTestimonial.artist }}
                </span>
                <span class="testimonials-detailed__role">
                  {{ previousTestimonial.role }}
                </span>
              </div>
            </div>
            <div class="testimonials-detailed__logo">
              <img
                :src="previousTestimonial.logo"
                :alt="previousTestimonial.artist"
                class="testimonials-detailed__image"
              />
            </div>
          </div>
        </div>

        <!-- Current slide (main) -->
        <div class="testimonials-detailed__slide testimonials-detailed__slide--current">
          <div class="testimonials-detailed__content">
            <div class="testimonials-detailed__text">
              <div class="testimonials-detailed__content-top">
                <h3 class="testimonials-detailed__heading">
                  {{ currentTestimonial.heading }}
                </h3>
                <p class="testimonials-detailed__quote">
                  "{{ currentTestimonial.quote }}"
                </p>
              </div>
              <div class="testimonials-detailed__author">
                <span class="testimonials-detailed__name">
                  {{ currentTestimonial.artist }}
                </span>
                <span class="testimonials-detailed__role">
                  {{ currentTestimonial.role }}
                </span>
              </div>
            </div>
            <div class="testimonials-detailed__logo">
              <img
                :src="currentTestimonial.logo"
                :alt="currentTestimonial.artist"
                class="testimonials-detailed__image"
              />
            </div>
          </div>
        </div>

        <!-- Next slide (faded) -->
        <div class="testimonials-detailed__slide testimonials-detailed__slide--next">
          <div class="testimonials-detailed__content testimonials-detailed__content--faded">
            <div class="testimonials-detailed__text">
              <div class="testimonials-detailed__content-top">
                <h3 class="testimonials-detailed__heading">
                  {{ nextTestimonial.heading }}
                </h3>
                <p class="testimonials-detailed__quote">
                  "{{ nextTestimonial.quote }}"
                </p>
              </div>
              <div class="testimonials-detailed__author">
                <span class="testimonials-detailed__name">
                  {{ nextTestimonial.artist }}
                </span>
                <span class="testimonials-detailed__role">
                  {{ nextTestimonial.role }}
                </span>
              </div>
            </div>
            <div class="testimonials-detailed__logo">
              <img
                :src="nextTestimonial.logo"
                :alt="nextTestimonial.artist"
                class="testimonials-detailed__image"
              />
            </div>
          </div>
        </div>
      </div>

      <!-- Navigation controls -->
      <div class="testimonials-detailed__controls">
        <button
          @click="previousSlide"
          class="testimonials-detailed__nav-btn testimonials-detailed__nav-btn--prev"
          :disabled="isAnimating"
        >
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
            <path d="M15 18L9 12L15 6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
          </svg>
        </button>
        
        <div class="testimonials-detailed__indicators">
          <button
            v-for="(testimonial, index) in testimonials"
            :key="index"
            @click="goToSlide(index)"
            :class="[
              'testimonials-detailed__indicator',
              { 'testimonials-detailed__indicator--active': index === currentIndex }
            ]"
            :disabled="isAnimating"
          >
            <span class="sr-only">Go to slide {{ index + 1 }}</span>
          </button>
        </div>

        <button
          @click="nextSlide"
          class="testimonials-detailed__nav-btn testimonials-detailed__nav-btn--next"
          :disabled="isAnimating"
        >
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
            <path d="M9 18L15 12L9 6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
          </svg>
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from "vue";

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

const currentIndex = ref(0);
const isAnimating = ref(false);
const animationDirection = ref('next'); // 'next' or 'prev'

const currentTestimonial = computed(() => testimonials[currentIndex.value]);

const previousTestimonial = computed(() => {
  const prevIndex = currentIndex.value === 0 ? testimonials.length - 1 : currentIndex.value - 1;
  return testimonials[prevIndex];
});

const nextTestimonial = computed(() => {
  const nextIndex = currentIndex.value === testimonials.length - 1 ? 0 : currentIndex.value + 1;
  return testimonials[nextIndex];
});

const nextSlide = () => {
  if (isAnimating.value) return;
  
  isAnimating.value = true;
  animationDirection.value = 'next';
  
  setTimeout(() => {
    currentIndex.value = currentIndex.value === testimonials.length - 1 ? 0 : currentIndex.value + 1;
    setTimeout(() => {
      isAnimating.value = false;
    }, 50);
  }, 250);
};

const previousSlide = () => {
  if (isAnimating.value) return;
  
  isAnimating.value = true;
  animationDirection.value = 'prev';
  
  setTimeout(() => {
    currentIndex.value = currentIndex.value === 0 ? testimonials.length - 1 : currentIndex.value - 1;
    setTimeout(() => {
      isAnimating.value = false;
    }, 50);
  }, 250);
};

const goToSlide = (index) => {
  if (isAnimating.value || index === currentIndex.value) return;
  
  isAnimating.value = true;
  animationDirection.value = index > currentIndex.value ? 'next' : 'prev';
  
  setTimeout(() => {
    currentIndex.value = index;
    setTimeout(() => {
      isAnimating.value = false;
    }, 50);
  }, 250);
};
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

.testimonials-detailed__slider {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
}

.testimonials-detailed__slide-wrapper {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 2rem;
  margin-bottom: 2rem;
  overflow: hidden;
  transition: transform 0.5s cubic-bezier(0.4, 0, 0.2, 1);
}

.testimonials-detailed__slide-wrapper--animating.testimonials-detailed__slide-wrapper--next {
  transform: translateX(-100px);
}

.testimonials-detailed__slide-wrapper--animating.testimonials-detailed__slide-wrapper--prev {
  transform: translateX(100px);
}

.testimonials-detailed__slide {
  display: flex;
  justify-content: center;
  transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
}

.testimonials-detailed__slide--prev,
.testimonials-detailed__slide--next {
  flex: 0 0 300px;
}

.testimonials-detailed__slide--current {
  flex: 0 0 500px;
  z-index: 2;
}

.testimonials-detailed__content {
  display: flex;
  align-items: stretch;
  gap: 2rem;
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  padding: 2.5rem;
  backdrop-filter: blur(10px);
  transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
  box-sizing: border-box;
  width: 100%;
  height: 300px;
}

.testimonials-detailed__slide-wrapper--animating .testimonials-detailed__content--faded {
  opacity: 0.2;
  transform: scale(0.8);
}

.testimonials-detailed__slide-wrapper--animating .testimonials-detailed__content:not(.testimonials-detailed__content--faded) {
  transform: scale(0.95);
}

.testimonials-detailed__content--faded {
  opacity: 0.4;
  transform: scale(0.85);
  background: rgba(255, 255, 255, 0.02);
  border-color: rgba(255, 255, 255, 0.05);
}

.testimonials-detailed__content:hover {
  transform: translateY(-4px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
}

.testimonials-detailed__content--faded:hover {
  transform: scale(0.85) translateY(-2px);
  opacity: 0.6;
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
  width: 120px;
  height: 120px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 12px;
  padding: 1rem;
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

/* Navigation Controls */
.testimonials-detailed__controls {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 2rem;
}

.testimonials-detailed__nav-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 48px;
  height: 48px;
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  color: #ffffff;
  cursor: pointer;
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
}

.testimonials-detailed__nav-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  pointer-events: none;
}

.testimonials-detailed__nav-btn:hover:not(:disabled) {
  background: rgba(255, 255, 255, 0.2);
  border-color: rgba(255, 255, 255, 0.4);
  transform: scale(1.05);
}

.testimonials-detailed__nav-btn:active {
  transform: scale(0.95);
}

.testimonials-detailed__indicators {
  display: flex;
  gap: 0.75rem;
  align-items: center;
}

.testimonials-detailed__indicator {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  border: none;
  background: rgba(255, 255, 255, 0.3);
  cursor: pointer;
  transition: all 0.3s ease;
}

.testimonials-detailed__indicator:disabled {
  cursor: not-allowed;
  pointer-events: none;
}

.testimonials-detailed__indicator:hover {
  background: rgba(255, 255, 255, 0.5);
  transform: scale(1.2);
}

.testimonials-detailed__indicator--active {
  background: #ffffff;
  transform: scale(1.3);
}

/* Screen reader only class */
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}

/* Responsive design */
@media (max-width: 1024px) {
  .testimonials-detailed__slide--prev,
  .testimonials-detailed__slide--next {
    flex: 0 0 250px;
  }

  .testimonials-detailed__slide--current {
    flex: 0 0 400px;
  }

  .testimonials-detailed__slide-wrapper {
    gap: 1.5rem;
  }
}

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

  .testimonials-detailed__slide-wrapper {
    flex-direction: column;
    gap: 1rem;
  }

  .testimonials-detailed__slide--prev,
  .testimonials-detailed__slide--next,
  .testimonials-detailed__slide--current {
    flex: 0 0 auto;
    width: 100%;
  }

  .testimonials-detailed__content {
    flex-direction: column;
    text-align: center;
    padding: 2rem;
    height: auto;
  }

  .testimonials-detailed__content--faded {
    transform: scale(0.95);
  }

  .testimonials-detailed__content--faded:hover {
    transform: scale(0.95);
  }

  .testimonials-detailed__logo {
    width: 100px;
    height: 100px;
    margin: 0 auto;
  }

  .testimonials-detailed__heading {
    font-size: 1.25rem;
  }

  .testimonials-detailed__quote {
    font-size: 0.9rem;
  }

  .testimonials-detailed__controls {
    gap: 1.5rem;
  }

  .testimonials-detailed__nav-btn {
    width: 40px;
    height: 40px;
  }
}

@media (max-width: 480px) {
  .testimonials-detailed__content {
    padding: 1.5rem;
  }

  .testimonials-detailed__heading {
    font-size: 1.1rem;
  }

  .testimonials-detailed__quote {
    font-size: 0.85rem;
  }

  .testimonials-detailed__controls {
    gap: 1rem;
  }

  .testimonials-detailed__nav-btn {
    width: 36px;
    height: 36px;
  }

  .testimonials-detailed__indicator {
    width: 10px;
    height: 10px;
  }
}
</style>
