<script setup>
import 'vue3-carousel/dist/carousel.css'
import { Carousel, Slide, Navigation } from 'vue3-carousel'

const testimonials = [
  {
    id: 1,
    quote: "Korzana is a very experienced producer and has always been very easy to work with 🙂",
    name: "Lxvrich",
    role: "Artist, Songwriter"
  },
  {
    id: 2,
    quote: "Working with Korzana or Soutjay is a treat. They are both insanely talented artists with the capability to enhance any idea you throw at them. But together? LODE's capabilities are infinitely better. Expect nothing less than greatness from these two.",
    name: "Maybe blue",
    role: "Artist"
  }
]

const config = {
  itemsToShow: 1,
  wrapAround: true,
  autoplay: 5000,
  breakpoints: {
    768: {
      itemsToShow: 2,
    },
    1024: {
      itemsToShow: 3,
    }
  }
}
</script>

<template>
  <section class="testimonials-section">
    <div class="container">
      <h2 class="testimonials-title">What Artists Say</h2>
      
      <Carousel v-bind="config" class="testimonials-carousel">
        <Slide v-for="testimonial in testimonials" :key="testimonial.id">
          <div class="testimonial-card">
            <blockquote class="testimonial-quote">
              "{{ testimonial.quote }}"
            </blockquote>
            <div class="testimonial-author">
              <div class="author-info">
                <cite class="author-name">{{ testimonial.name }}</cite>
                <span class="author-role">{{ testimonial.role }}</span>
              </div>
            </div>
          </div>
        </Slide>

        <template #addons>
          <Navigation />
        </template>
      </Carousel>
    </div>
  </section>
</template>

<style scoped>
.testimonials-section {
  padding: 4rem 2rem;
}

.container {
  max-width: 80%;
  margin: 0 auto;
  position: relative;
  padding: 0 80px;
}

.testimonials-title {
  text-align: center;
  margin-bottom: 4rem;
  color: #fff;
  font-size: var(--fs-48);
}

.carousel {
  --vc-nav-background: rgba(255, 255, 255, 0.1);
  --vc-nav-border-radius: 100%;
  --vc-nav-color: #fff;
}

.testimonial-card {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 16px;
  padding: 3rem;
  margin: 0 1rem;
  height: 350px;
  display: flex;
  flex-direction: column;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.testimonial-quote {
  font-size: var(--fs-18);
  line-height: var(--lh-relaxed);
  color: rgba(255, 255, 255, 0.9);
  margin: 0 0 auto 0;
  font-style: italic;
  flex-grow: 1;
}

.testimonial-author {
  display: flex;
  align-items: center;
  margin-top: 2rem;
}

.author-info {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.author-name {
  font-weight: var(--fw-semibold);
  color: #fff;
  font-size: var(--fs-18);
  font-style: normal;
}

.author-role {
  font-size: var(--fs-16);
  color: rgba(255, 255, 255, 0.7);
}

/* Custom navigation positioning */
:deep(.carousel__prev),
:deep(.carousel__next) {
  background: rgba(255, 255, 255, 0.1);
  border: 2px solid rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  width: 64px;
  height: 64px;
  color: #fff;
  transition: all 0.3s ease;
  top: 50%;
  transform: translateY(-50%);
}

:deep(.carousel__prev) {
  left: -80px;
}

:deep(.carousel__next) {
  right: -80px;
}

:deep(.carousel__prev:hover),
:deep(.carousel__next:hover) {
  background: rgba(255, 255, 255, 0.2);
  border-color: rgba(255, 255, 255, 0.4);
  transform: translateY(-50%) scale(1.1);
}

:deep(.carousel__icon) {
  fill: currentColor;
  width: 24px;
  height: 24px;
}

@media (max-width: 768px) {
  .testimonials-section {
    padding: 3rem 1rem;
  }
  
  .container {
    padding: 0 60px;
  }
  
  .testimonial-card {
    height: 380px;
    padding: 2rem;
    margin: 0 0.5rem;
  }
  
  :deep(.carousel__prev) {
    left: -60px;
  }

  :deep(.carousel__next) {
    right: -60px;
  }
  
  :deep(.carousel__prev),
  :deep(.carousel__next) {
    width: 56px;
    height: 56px;
  }
  
  :deep(.carousel__icon) {
    width: 20px;
    height: 20px;
  }
}
</style>