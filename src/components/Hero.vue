<template>
  <section class="hero-single" role="banner">
    <figure class="slide">
      <img
        class="slide-img"
        :src="image.src"
        :alt="image.alt || ''"
        loading="lazy"
        decoding="async"
        draggable="false"
      />
      <figcaption v-if="image.caption" class="caption">
        <div class="caption-inner">
          <h2 v-if="typeof image.caption === 'string'">{{ image.caption }}</h2>
          <component v-else :is="image.caption" />
        </div>
      </figcaption>
    </figure>
  </section>
</template>

<script setup>
const props = defineProps({
  image: {
    type: Object,
    default: () => ({
      src: "/image.png",
      alt: "Hero image",
      caption: "Welcome to LODE*",
    }),
  },
  aspectRatio: { type: String, default: "17 / 6" }, // a bit 
});
</script>

<style scoped>
:root {
  --hs-radius: 12px;
  --hs-caption-bg: linear-gradient(
    to top,
    rgba(0, 0, 0, 0.55),
    rgba(0, 0, 0, 0)
  );
}
.hero-single {
  width: 100%;
  position: relative;
}
.slide {
  width: 100%;
  aspect-ratio: v-bind(aspectRatio);
  position: relative;
  overflow: hidden;
  border-radius: var(--hs-radius);
  margin-left: 0px;
  margin-right: 0px;
}

.slide-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
  mask-image: linear-gradient(to top, #000 0%, rgba(0,0,0,0) 100%);
  -webkit-mask-image: linear-gradient(to top, #000 0%, rgba(0,0,0,0) 100%);
  mask-size: 100% 100%;
  mask-repeat: no-repeat;
  position: relative;
  z-index: 0;
  /* Light blur removed (can cause extra posterization). Keep only mild contrast tweak. */
  filter: contrast(10.5);
}

.caption {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  padding: clamp(12px, 2.5vw, 28px);
  color: white;
  background: var(--hs-caption-bg);
  z-index: 2;
  width: fit-content;
  border-radius: 8px;
}

.caption-inner {
  max-width: min(100%, 1000px);
  margin-inline: auto;
  font-size: clamp(20px, 2.5vw, 36px);
  font-weight: 700;
  line-height: 1.2;
  text-shadow: 0 2px 12px rgba(0, 0, 0, 0.5);
}
</style>
