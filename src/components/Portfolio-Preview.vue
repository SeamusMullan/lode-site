<template>
  <div class="cta">
    <a href="/portfolio" class="cta-button">View Full Portfolio</a>
  </div>

  <div class="portfolio-slider">
    <div class="portfolio-slider__track-wrapper">
      <!-- scrolling container -->
      <ul class="portfolio-slider__track">
        <li
          v-for="song in duplicatedSongs"
          :key="`${song.id}-${song.duplicateIndex || 0}`"
          class="portfolio-slider__item"
        >
          <img :src="song.cover" :alt="song.title" class="portfolio-slider__image" />
          <p class="portfolio-slider__title">{{ song.title }} - {{ song.artist }}</p>
        </li>
      </ul>

      <!-- gradient masks for smooth edges -->
      <div class="portfolio-slider__fade portfolio-slider__fade--left"></div>
      <div class="portfolio-slider__fade portfolio-slider__fade--right"></div>
    </div>
  </div>

  <div class="spacer"></div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'

class Song {
  constructor(id, title, artist, cover) {
    this.id = id;
    this.title = title;
    this.artist = artist;
    this.cover = cover;
  }
}

// we need to link to forms.auxkit.dev API to allow dynamic song fetching.

const APIKEY = import.meta.env.VITE_AUXKIT_FORMS_API_KEY;
const baseUrl = "https://z4he9qd8w6.execute-api.eu-west-1.amazonaws.com/prod";

// fetch the songs for this site from the api
const siteID = "cp3z846o6xej9jjwfb0zk"; // TODO: replace with actual ID

// Reactive songs array
const songs = ref([
  // Default demo data
  new Song(1, "Song Title 1", "Artist 1", "https://picsum.photos/800"),
  new Song(2, "Song Title 2", "Artist 2", "https://picsum.photos/800"),
  new Song(3, "Song Title 3", "Artist 3", "https://picsum.photos/800"),
  new Song(4, "Song Title 4", "Artist 4", "https://picsum.photos/800"),
]);

// Create duplicated songs for infinite scroll effect
const duplicatedSongs = computed(() => {
  const duplicated = [...songs.value, ...songs.value];
  // Add duplicate index to help with unique keys
  return duplicated.map((song, index) => ({
    ...song,
    duplicateIndex: Math.floor(index / songs.value.length)
  }));
});

const fetchSongs = async () => {
  try {
    const response = await fetch(`${baseUrl}/public/sites/${siteID}/songs`, {
      headers: {
        Authorization: `Bearer ${APIKEY}`,
      },
    });
    if (!response.ok) {
      throw new Error("Network response was not ok");
    }
    const data = await response.json();
    // API returns a direct array of songs
    return data.map(
      (song) => new Song(song.id, song.title, song.artist, song.albumArtUrl)
    );

  } catch (error) {
    console.error("Error fetching songs:", error);
    return [];
  }
};

// Fetch songs when component mounts
onMounted(async () => {
  const fetchedSongs = await fetchSongs();
  if (fetchedSongs.length > 0) {
    songs.value = fetchedSongs;
  }
  // If fetchedSongs is empty, keep the default demo data
});


</script>

<style lang="scss" scoped>
.spacer {
  height: 2rem;
  margin-top: 1rem;
  margin-bottom: 1rem;
}

.cta {
  text-align: center;
  padding: 4rem;
}

.cta-button {
  background: linear-gradient(90deg, #ff3300 0%, #ff9900 100%);
  font-size: 1.5rem;
  font-weight: 900;
  color: #fff;
  padding: 0.75rem 2.5rem;
  border: none;
  border-radius: 32px;
  cursor: pointer;
  text-decoration: none;
  box-shadow: 0 4px 24px rgba(255, 51, 0, 0.25),
    0 1.5px 8px rgba(255, 153, 0, 0.15);
  letter-spacing: 2px;
  position: relative;
  overflow: hidden;
  transition: transform 0.2s, box-shadow 0.2s;
  z-index: 0;

  &:hover {
    transform: scale(1.07) rotate(-2deg);
    box-shadow: 0 8px 32px rgba(255, 51, 0, 0.35),
      0 2px 12px rgba(255, 153, 0, 0.25);
  }
  &::after {
    content: "";
    position: absolute;
    inset: 0;
    border-radius: 32px;
    padding: 2px;
    background: linear-gradient(90deg, #ff3300, #ff9900, #ff3300);
    background-size: 200% 200%;
    z-index: -1; // behind button
    mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
    -webkit-mask: linear-gradient(#fff 0 0) content-box,
      linear-gradient(#fff 0 0);
    -webkit-mask-composite: xor;
    mask-composite: exclude;
    animation: cta-border-flash 2s linear infinite;
    opacity: 0.7;
  }
}

@keyframes cta-border-flash {
  0% {
    background-position: 0% 50%;
  }
  100% {
    background-position: 100% 50%;
  }
}

/* Portfolio Slider Styles */
.portfolio-slider {
  padding-bottom: 2rem;
  padding-top: 2rem;
}

.portfolio-slider__track-wrapper {
  position: relative;
  overflow: hidden;
  width: 100%;
}

.portfolio-slider__track {
  display: flex;
  gap: 2rem;
  animation: portfolio-scroll 25s linear infinite;
  list-style: none;
  padding: 0;
  margin: 0;
}

.portfolio-slider__item {
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 480px;
}

.portfolio-slider__image {
  width: 480px;
  height: 480px;
  object-fit: cover;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  margin-bottom: 0.5rem;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  transform: scale(0.95);
}

.portfolio-slider__image:hover {
  transform: scale(1.0);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
}

.portfolio-slider__title {
  text-align: center;
  font-size: 1.75rem;
  margin: 0;
  color: #b0b0b0;
  font-weight: bold;
}

.portfolio-slider__fade {
  position: absolute;
  top: 0;
  width: 120px;
  height: 100%;
  pointer-events: none;
  z-index: 2;
}

.portfolio-slider__fade--left {
  left: 0;
  background: linear-gradient(to right, #0f0f0f, transparent);
}

.portfolio-slider__fade--right {
  right: 0;
  background: linear-gradient(to left, #0f0f0f, transparent);
}

/* Infinite scrolling animation */
@keyframes portfolio-scroll {
  to {
    transform: translate(-50%);
  }
}

/* Responsive: shrink images and gap on small screens */
@media (max-width: 600px) {
  .portfolio-slider__track {
    gap: 1rem;
  }
  
  .portfolio-slider__item {
    width: 280px;
  }
  
  .portfolio-slider__image {
    width: 280px;
    height: 280px;
  }
  
  .portfolio-slider__title {
    font-size: 1.25rem;
  }
  
  .portfolio-slider__fade {
    width: 60px;
  }
}

@media (max-width: 768px) {
  .portfolio-slider__track {
    gap: 1.5rem;
  }
  
  .portfolio-slider__item {
    width: 320px;
  }
  
  .portfolio-slider__image {
    width: 320px;
    height: 320px;
  }
  
  .portfolio-slider__title {
    font-size: 1.5rem;
  }
}
</style>
