<template>
  <div class="cta">
    <a href="/portfolio" class="cta-button">View Full Portfolio</a>
  </div>

  <div class="song-list" id="song-list-1">
    <ul>
      <li v-for="song in songs" :key="song.id">
        <img :src="song.cover" :alt="song.title" />
        <p>{{ song.title }}</p>
      </li>
    </ul>
  </div>
  <div class="spacer"></div>
  <div class="song-list" id="song-list-2">
    <ul>
      <li v-for="song in songs" :key="song.id">
        <img :src="song.cover" :alt="song.title" />
        <p class="song-title">{{ song.title }}</p>
      </li>
    </ul>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

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
const siteID = "bpj3imv48bl6ihq4fr2nn"; // TODO: replace with actual ID

// Reactive songs array
const songs = ref([
  // Default demo data
  new Song(1, "Song Title 1", "Artist 1", "https://picsum.photos/800"),
  new Song(2, "Song Title 2", "Artist 2", "https://picsum.photos/800"),
  new Song(3, "Song Title 3", "Artist 3", "https://picsum.photos/800"),
  new Song(4, "Song Title 4", "Artist 4", "https://picsum.photos/800"),
]);

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
    background-position: 200% 50%;
  }
}
@keyframes cta-border-flash {
  0% {
    background-position: 0% 50%;
  }
  100% {
    background-position: 200% 50%;
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

#song-list-1 {
  transform: translateX(-8rem);
}

#song-list-2 {
  transform: translateX(8rem);
}

.song-list ul {
  display: flex;
  flex-wrap: nowrap;
  gap: 2rem;
  justify-content: center;
  padding: 0;
  margin: 0;
  list-style: none;
  max-width: 100%;
}

.song-list li {
  flex: 0 1 480px;
  display: flex;
  flex-direction: column;
  align-items: center;
  max-width: 480px;
}

.song-list img {
  width: 480px;
  height: 480px;
  object-fit: cover;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  margin-bottom: 0.5rem;
}

.song-list p {
  text-align: center;
  font-size: 1rem;
  margin: 0;
  color: #b0b0b0;
}

.song-title {
  font-weight: bold;
  color: #fff;
}

/* Responsive: shrink images and gap on small screens */
@media (max-width: 600px) {
  .song-list ul {
    gap: 0.5rem;
  }
  .song-list li {
    max-width: 70px;
  }
  .song-list img {
    width: 480px;
    height: 480px;
  }
}
</style>
