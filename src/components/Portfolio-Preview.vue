<template>
  <br />
  <br />
  <br />
  <div class="portfolio-slider">
    <div class="portfolio-slider__track-wrapper">
      <!-- scrolling container -->
      <ul 
        class="portfolio-slider__track"
        :style="{
          '--animation-duration': animationProps.duration,
          '--animation-distance': animationProps.distance
        }"
      >
        <li
          v-for="song in duplicatedSongs"
          :key="`${song.id}-${song.duplicateIndex || 0}`"
          class="portfolio-slider__item"
        >
          <div class="portfolio-slider__image-container">
            <img
              :src="song.cover"
              :alt="song.title"
              class="portfolio-slider__image"
            />
            <div class="portfolio-slider__overlay">
              <div 
                v-if="Object.keys(song.platforms).length > 0" 
                class="portfolio-slider__buttons"
              >
                <a 
                  v-for="(url, platform) in song.platforms"
                  :key="platform"
                  :href="url" 
                  target="_blank" 
                  class="portfolio-slider__play-button"
                >
                  ▶ {{ platform }}
                </a>
              </div>
            </div>
          </div>
          <p class="portfolio-slider__title">
            {{ song.title }} - {{ song.artist }}
          </p>
        </li>
      </ul>

      <!-- gradient masks for smooth edges -->
      <div class="portfolio-slider__fade portfolio-slider__fade--left"></div>
      <div class="portfolio-slider__fade portfolio-slider__fade--right"></div>
    </div>
  </div>

  <div class="cta">
    <button @click="navigateToPortfolio" class="cta-button">View Full Portfolio</button>
  </div>
</template>

<script setup>
import { ref, onMounted, computed, onUnmounted } from "vue";
import { useRouter } from 'vue-router'

const router = useRouter()

const navigateToPortfolio = async () => {
  // Scroll to top immediately
  document.documentElement.scrollTop = 0
  document.body.scrollTop = 0
  
  await router.push('/portfolio')
  
  // Double-check scroll position after navigation
  setTimeout(() => {
    document.documentElement.scrollTop = 0
    document.body.scrollTop = 0
    window.scrollTo(0, 0)
  }, 150)
}

class Song {
  constructor(id, title, artist, cover, platforms = {}) {
    this.id = id;
    this.title = title;
    this.artist = artist;
    this.cover = cover;
    this.platforms = platforms; // Object with platform names as keys and URLs as values
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
  new Song(1, "Demo Song 1", "Artist 1", "https://picsum.photos/800", {
    "Spotify": "https://open.spotify.com/track/example1",
    "SoundCloud": "https://soundcloud.com/example1"
  }),
  new Song(2, "Demo Song 2", "Artist 2", "https://picsum.photos/800", {
    "Spotify": "https://open.spotify.com/track/example2",
    "Bandcamp": "https://example.bandcamp.com/track/example2"
  }),
  new Song(3, "Demo Song 3", "Artist 3", "https://picsum.photos/800", {
    "SoundCloud": "https://soundcloud.com/example3",
    "YouTube": "https://youtube.com/watch?v=example3"
  }),
  new Song(4, "Demo Song 4", "Artist 4", "https://picsum.photos/800", {
    "Spotify": "https://open.spotify.com/track/example4",
    "Apple Music": "https://music.apple.com/track/example4",
    "Bandcamp": "https://example.bandcamp.com/track/example4"
  }),
  new Song(5, "Demo Song 5", "Artist 5", "https://picsum.photos/800", {
    "YouTube": "https://youtube.com/watch?v=example5"
  }),
  new Song(6, "Demo Song 6", "Artist 6", "https://picsum.photos/800", {
    "Spotify": "https://open.spotify.com/track/example6",
    "SoundCloud": "https://soundcloud.com/example6",
    "Bandcamp": "https://example.bandcamp.com/track/example6"
  }),
]);

// Track window width for responsive calculations
const windowWidth = ref(typeof window !== 'undefined' ? window.innerWidth : 1200);

const updateWindowWidth = () => {
  windowWidth.value = window.innerWidth;
};

onUnmounted(() => {
  window.removeEventListener('resize', updateWindowWidth);
});

// Create duplicated songs for infinite scroll effect
const duplicatedSongs = computed(() => {
  // Only duplicate once for seamless infinite scroll
  const duplicated = [...songs.value, ...songs.value];
  // Add duplicate index to help with unique keys
  return duplicated.map((song, index) => ({
    ...song,
    duplicateIndex: Math.floor(index / songs.value.length),
  }));
});

// Calculate dynamic animation properties
const animationProps = computed(() => {
  const songCount = songs.value.length;
  if (songCount === 0) return { duration: '20s', distance: '50%' };
  
  // Calculate item width based on screen size
  let itemWidth = 512; // Desktop: 480px + 32px gap
  
  if (windowWidth.value <= 600) {
    itemWidth = 296; // Mobile: 280px + 16px gap
  } else if (windowWidth.value <= 768) {
    itemWidth = 344; // Tablet: 320px + 24px gap
  }
  
  const totalDistance = songCount * itemWidth;
  
  // Base speed: show each song for about 4 seconds (slower)
  const timePerSong = 6; // seconds
  const duration = songCount * timePerSong;
  
  return {
    duration: `${duration}s`,
    distance: `${totalDistance}px`
  };
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
    return data.map((song) => {
      const platforms = {};
      
      // Check for various platform URLs
      if (song.spotifyUrl) platforms.Spotify = song.spotifyUrl;
      if (song.soundcloudUrl) platforms.SoundCloud = song.soundcloudUrl;
      if (song.bandcampUrl) platforms.Bandcamp = song.bandcampUrl;
      if (song.youtubeUrl) platforms.YouTube = song.youtubeUrl;
      if (song.appleMusicUrl) platforms['Apple Music'] = song.appleMusicUrl;
      if (song.tidalUrl) platforms.Tidal = song.tidalUrl;
      if (song.deezerUrl) platforms.Deezer = song.deezerUrl;
      
      // Fallback to generic URL field
      if (song.url && Object.keys(platforms).length === 0) {
        platforms.Listen = song.url;
      }
      
      return new Song(song.id, song.title, song.artist, song.albumArtUrl, platforms);
    });
  } catch (error) {
    console.error("Error fetching songs:", error);
    return [];
  }
};

// Fetch songs when component mounts
onMounted(async () => {
  // Set up resize listener
  window.addEventListener('resize', updateWindowWidth);
  
  // Fetch songs from API
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
  font-size: 2rem;
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
  list-style: none;
  padding: 0;
  margin: 0;
  --s: 0.5; /* speed factor on hover */
  animation: 
    portfolio-scroll var(--animation-duration, 20s) linear infinite,
    portfolio-scroll calc(var(--animation-duration, 20s)/var(--s)) 
    linear reverse paused;
  animation-composition: add;
}

.portfolio-slider__track:hover {
  animation-play-state: running, running;
}

.portfolio-slider__item {
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 480px;
}

.portfolio-slider__image-container {
  position: relative;
  width: 480px;
  height: 480px;
  border-radius: 8px;
  overflow: hidden;
  margin-bottom: 0.5rem;
}

.portfolio-slider__image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  transform: scale(0.95);
}

.portfolio-slider__image-container:hover .portfolio-slider__image {
  transform: scale(1);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
}

.portfolio-slider__overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.6);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.3s ease;
  border-radius: 8px;
}

.portfolio-slider__image-container:hover .portfolio-slider__overlay {
  opacity: 1;
}

.portfolio-slider__buttons {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  align-items: center;
}

.portfolio-slider__play-button {
  background: linear-gradient(90deg, #ff3300 0%, #ff9900 100%);
  color: white;
  padding: 0.75rem 1.5rem;
  border-radius: 25px;
  text-decoration: none;
  font-weight: bold;
  font-size: 1rem;
  transition: transform 0.2s ease;
  box-shadow: 0 4px 16px rgba(255, 51, 0, 0.3);
  white-space: nowrap;
  min-width: 120px;
  text-align: center;
}

.portfolio-slider__play-button:hover {
  transform: scale(1.05);
  box-shadow: 0 6px 20px rgba(255, 51, 0, 0.4);
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
  0% {
    transform: translateX(0);
  }
  100% {
    transform: translateX(calc(-1 * var(--animation-distance, 50%)));
  }
}

/* Responsive: shrink images and gap on small screens */
@media (max-width: 600px) {
  .portfolio-slider__track {
    gap: 1rem;
    --item-width: 296px; /* 280px + 16px gap */
  }

  .portfolio-slider__item {
    width: 280px;
  }

  .portfolio-slider__image-container {
    width: 280px;
    height: 280px;
  }

  .portfolio-slider__title {
    font-size: 1.25rem;
  }

  .portfolio-slider__fade {
    width: 60px;
  }

  .portfolio-slider__play-button {
    padding: 0.6rem 1.2rem;
    font-size: 0.9rem;
    min-width: 100px;
  }

  .portfolio-slider__buttons {
    gap: 0.5rem;
  }
}

@media (max-width: 768px) {
  .portfolio-slider__track {
    gap: 1.5rem;
    --item-width: 344px; /* 320px + 24px gap */
  }

  .portfolio-slider__item {
    width: 320px;
  }

  .portfolio-slider__image-container {
    width: 320px;
    height: 320px;
  }

  .portfolio-slider__title {
    font-size: 1.5rem;
  }
}
</style>
