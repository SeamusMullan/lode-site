<template>
  <div class="portfolio-detailed">
    <!-- Header Section -->
    <div class="portfolio-header">
      <h1 class="portfolio-title">Our Portfolio</h1>
      <p class="portfolio-subtitle">Discover the songs we've crafted with talented artists</p>
    </div>

    <!-- Search and Filter Controls -->
    <div class="controls-section">
      <div class="search-container">
        <svg class="search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <circle cx="11" cy="11" r="8"/>
          <path d="m21 21-4.35-4.35"/>
        </svg>
        <input
          v-model="searchQuery"
          type="text"
          placeholder="Search songs, artists, or genres..."
          class="search-input"
          @input="handleSearch"
        />
        <button v-if="searchQuery" @click="clearSearch" class="clear-search">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <line x1="18" y1="6" x2="6" y2="18"/>
            <line x1="6" y1="6" x2="18" y2="18"/>
          </svg>
        </button>
      </div>

      <div class="view-controls">
        <button
          @click="viewMode = 'grid'"
          :class="['view-btn', { active: viewMode === 'grid' }]"
          aria-label="Grid view"
        >
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <rect x="3" y="3" width="7" height="7" rx="1"/>
            <rect x="14" y="3" width="7" height="7" rx="1"/>
            <rect x="14" y="14" width="7" height="7" rx="1"/>
            <rect x="3" y="14" width="7" height="7" rx="1"/>
          </svg>
        </button>
        <button
          @click="viewMode = 'list'"
          :class="['view-btn', { active: viewMode === 'list' }]"
          aria-label="List view"
        >
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <line x1="8" y1="6" x2="21" y2="6"/>
            <line x1="8" y1="12" x2="21" y2="12"/>
            <line x1="8" y1="18" x2="21" y2="18"/>
            <circle cx="4" cy="6" r="1"/>
            <circle cx="4" cy="12" r="1"/>
            <circle cx="4" cy="18" r="1"/>
          </svg>
        </button>
      </div>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="loading-container">
      <div class="loading-spinner"></div>
      <p>Loading songs...</p>
    </div>

    <!-- Results Info -->
    <div v-if="!loading && songs.length > 0" class="results-info">
      <p>
        Showing {{ filteredSongs.length }} of {{ songs.length }} songs
        <span v-if="searchQuery"> for "{{ searchQuery }}"</span>
      </p>
    </div>

    <!-- No Results -->
    <div v-if="!loading && filteredSongs.length === 0 && searchQuery" class="no-results">
      <svg class="no-results-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <circle cx="11" cy="11" r="8"/>
        <path d="m21 21-4.35-4.35"/>
      </svg>
      <h3>No songs found</h3>
      <p>Try adjusting your search terms or browse all songs</p>
      <button @click="clearSearch" class="btn-secondary">Clear Search</button>
    </div>

    <!-- Songs Grid/List -->
    <div v-if="!loading && filteredSongs.length > 0" :class="['songs-container', `view-${viewMode}`]">
      <div
        v-for="song in filteredSongs"
        :key="song.id"
        :class="['song-item', `song-item-${viewMode}`]"
      >
        <!-- Song Image -->
        <div class="song-image-container">
          <img
            :src="song.cover || song.albumArtUrl || 'https://picsum.photos/400'"
            :alt="`${song.title} by ${song.artist}`"
            class="song-image"
            loading="lazy"
          />
          <div class="song-overlay">
            <div class="platform-buttons">
              <a
                v-for="(url, platform) in song.platforms"
                :key="platform"
                :href="url"
                target="_blank"
                rel="noopener noreferrer"
                :class="['platform-btn', `platform-${platform.toLowerCase().replace(/\s+/g, '')}`]"
                :aria-label="`Listen on ${platform}`"
              >
                <span class="platform-icon">
                  <svg v-if="platform.toLowerCase() === 'spotify'" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M12 0C5.4 0 0 5.4 0 12s5.4 12 12 12 12-5.4 12-12S18.66 0 12 0zm5.521 17.34c-.24.359-.66.48-1.021.24-2.82-1.74-6.36-2.101-10.561-1.141-.418.122-.779-.179-.899-.539-.12-.421.18-.78.54-.9 4.56-1.021 8.52-.6 11.64 1.32.42.18.479.659.301 1.02zm1.44-3.3c-.301.42-.841.6-1.262.3-3.239-1.98-8.159-2.58-11.939-1.38-.479.12-1.02-.12-1.14-.6-.12-.48.12-1.021.6-1.141C9.6 9.9 15 10.561 18.72 12.84c.361.181.54.78.241 1.2zm.12-3.36C15.24 8.4 8.82 8.16 5.16 9.301c-.6.179-1.2-.181-1.38-.721-.18-.601.18-1.2.72-1.381 4.26-1.26 11.28-1.02 15.721 1.621.539.3.719 1.02.42 1.56-.299.421-1.02.599-1.559.3z"/>
                  </svg>
                  <svg v-else-if="platform.toLowerCase() === 'soundcloud'" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M3.06 11.51c-.12.07-.22.16-.31.26-.25.27-.39.62-.39 1.01v4.72c0 .8.65 1.45 1.45 1.45h5.85c.8 0 1.45-.65 1.45-1.45V9.91c0-.8-.65-1.45-1.45-1.45H3.61c-.8 0-1.45.65-1.45 1.45v1.16c0 .32.26.58.58.58h.26c.32 0 .58-.26.58-.58V9.91c0-.16.13-.29.29-.29h5.1c.16 0 .29.13.29.29v7.59c0 .16-.13.29-.29.29H3.72c-.16 0-.29-.13-.29-.29v-4.72c0-.06.01-.12.03-.17h-.4z"/>
                    <path d="M21.8 13.25c-.31-.81-.93-1.5-1.73-1.9-.8-.4-1.74-.4-2.54 0s-1.42 1.09-1.73 1.9c-.31.81-.31 1.71 0 2.52.31.81.93 1.5 1.73 1.9.4.2.84.3 1.27.3.43 0 .87-.1 1.27-.3.8-.4 1.42-1.09 1.73-1.9.31-.81.31-1.71 0-2.52zm-2.67 2.41c-.64 0-1.16-.52-1.16-1.16s.52-1.16 1.16-1.16 1.16.52 1.16 1.16-.52 1.16-1.16 1.16z"/>
                  </svg>
                  <svg v-else-if="platform.toLowerCase() === 'youtube'" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/>
                  </svg>
                  <svg v-else-if="platform.toLowerCase().includes('apple')" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M12.152 6.896c-.948 0-2.415-1.078-3.96-1.04-2.04.027-3.91 1.183-4.961 3.014-2.117 3.675-.546 9.103 1.519 12.09 1.013 1.454 2.208 3.09 3.792 3.039 1.52-.065 2.09-.987 3.935-.987 1.831 0 2.35.987 3.96.948 1.637-.026 2.676-1.48 3.676-2.948 1.156-1.688 1.636-3.325 1.662-3.415-.039-.013-3.182-1.221-3.22-4.857-.026-3.04 2.48-4.494 2.597-4.559-1.429-2.09-3.623-2.324-4.39-2.376-2-.156-3.675 1.09-4.61 1.09zM15.53 3.83c.843-1.012 1.4-2.427 1.245-3.83-1.207.052-2.662.805-3.532 1.818-.78.896-1.454 2.338-1.273 3.714 1.338.104 2.715-.688 3.559-1.701"/>
                  </svg>
                  <svg v-else-if="platform.toLowerCase() === 'bandcamp'" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M0 18.75l7.437-13.5h16.563v13.5z"/>
                  </svg>
                  <svg v-else viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <polygon points="5 3 19 12 5 21 5 3"/>
                  </svg>
                </span>
                {{ platform }}
              </a>
            </div>
          </div>
        </div>

        <!-- Song Info -->
        <div class="song-info">
          <h3 class="song-title">{{ song.title }}</h3>
          <p class="song-artist">{{ song.artist }}</p>
          
          <!-- Additional metadata if available -->
          <div v-if="song.genre || song.year || song.label || song.album" class="song-meta">
            <span v-if="song.album" class="meta-item album">
              <svg class="meta-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="12" cy="12" r="10"/>
                <circle cx="12" cy="12" r="3"/>
              </svg>
              {{ song.album }}
            </span>
            <span v-if="song.genre" class="meta-item genre">
              <svg class="meta-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M9 18V5l12-2v13"/>
                <circle cx="6" cy="18" r="3"/>
                <circle cx="18" cy="16" r="3"/>
              </svg>
              {{ song.genre }}
            </span>
            <span v-if="song.year" class="meta-item year">
              <svg class="meta-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"/>
                <line x1="16" y1="2" x2="16" y2="6"/>
                <line x1="8" y1="2" x2="8" y2="6"/>
                <line x1="3" y1="10" x2="21" y2="10"/>
              </svg>
              {{ song.year }}
            </span>
            <span v-if="song.label" class="meta-item label">
              <svg class="meta-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"/>
                <line x1="7" y1="7" x2="7.01" y2="7"/>
              </svg>
              {{ song.label }}
            </span>
          </div>

          <!-- Enhanced platform links for list view -->
          <div v-if="viewMode === 'list'" class="platform-links-list">
            <a
              v-for="(url, platform) in song.platforms"
              :key="platform"
              :href="url"
              target="_blank"
              rel="noopener noreferrer"
              :class="['platform-link', `platform-${platform.toLowerCase().replace(/\s+/g, '')}`]"
            >
              <span class="platform-link-icon">
                <svg v-if="platform.toLowerCase() === 'spotify'" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M12 0C5.4 0 0 5.4 0 12s5.4 12 12 12 12-5.4 12-12S18.66 0 12 0zm5.521 17.34c-.24.359-.66.48-1.021.24-2.82-1.74-6.36-2.101-10.561-1.141-.418.122-.779-.179-.899-.539-.12-.421.18-.78.54-.9 4.56-1.021 8.52-.6 11.64 1.32.42.18.479.659.301 1.02zm1.44-3.3c-.301.42-.841.6-1.262.3-3.239-1.98-8.159-2.58-11.939-1.38-.479.12-1.02-.12-1.14-.6-.12-.48.12-1.021.6-1.141C9.6 9.9 15 10.561 18.72 12.84c.361.181.54.78.241 1.2zm.12-3.36C15.24 8.4 8.82 8.16 5.16 9.301c-.6.179-1.2-.181-1.38-.721-.18-.601.18-1.2.72-1.381 4.26-1.26 11.28-1.02 15.721 1.621.539.3.719 1.02.42 1.56-.299.421-1.02.599-1.559.3z"/>
                </svg>
                <svg v-else-if="platform.toLowerCase() === 'soundcloud'" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M3.06 11.51c-.12.07-.22.16-.31.26-.25.27-.39.62-.39 1.01v4.72c0 .8.65 1.45 1.45 1.45h5.85c.8 0 1.45-.65 1.45-1.45V9.91c0-.8-.65-1.45-1.45-1.45H3.61c-.8 0-1.45.65-1.45 1.45v1.16c0 .32.26.58.58.58h.26c.32 0 .58-.26.58-.58V9.91c0-.16.13-.29.29-.29h5.1c.16 0 .29.13.29.29v7.59c0 .16-.13.29-.29.29H3.72c-.16 0-.29-.13-.29-.29v-4.72c0-.06.01-.12.03-.17h-.4z"/>
                </svg>
                <svg v-else-if="platform.toLowerCase() === 'youtube'" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/>
                </svg>
                <svg v-else-if="platform.toLowerCase().includes('apple')" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M12.152 6.896c-.948 0-2.415-1.078-3.96-1.04-2.04.027-3.91 1.183-4.961 3.014-2.117 3.675-.546 9.103 1.519 12.09 1.013 1.454 2.208 3.09 3.792 3.039 1.52-.065 2.09-.987 3.935-.987 1.831 0 2.35.987 3.96.948 1.637-.026 2.676-1.48 3.676-2.948 1.156-1.688 1.636-3.325 1.662-3.415-.039-.013-3.182-1.221-3.22-4.857-.026-3.04 2.48-4.494 2.597-4.559-1.429-2.09-3.623-2.324-4.39-2.376-2-.156-3.675 1.09-4.61 1.09zM15.53 3.83c.843-1.012 1.4-2.427 1.245-3.83-1.207.052-2.662.805-3.532 1.818-.78.896-1.454 2.338-1.273 3.714 1.338.104 2.715-.688 3.559-1.701"/>
                </svg>
                <svg v-else-if="platform.toLowerCase() === 'bandcamp'" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M0 18.75l7.437-13.5h16.563v13.5z"/>
                </svg>
                <svg v-else viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <polygon points="5 3 19 12 5 21 5 3"/>
                </svg>
              </span>
              {{ platform }}
            </a>
          </div>

          <!-- Additional info for list view -->
          <div v-if="viewMode === 'list'" class="song-description">
            <p v-if="song.description" class="description-text">{{ song.description }}</p>
            <div class="song-stats">
              <span v-if="Object.keys(song.platforms).length" class="stat-item">
                <svg class="stat-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"/>
                  <polyline points="15,3 21,3 21,9"/>
                  <line x1="10" y1="14" x2="21" y2="3"/>
                </svg>
                Available on {{ Object.keys(song.platforms).length }} platform{{ Object.keys(song.platforms).length !== 1 ? 's' : '' }}
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Back to Home Button -->
    <div class="back-home">
      <RouterLink to="/" class="btn-primary">← Back to Home</RouterLink>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'

// Song class to maintain consistency with Portfolio-Preview
class Song {
  constructor(id, title, artist, cover, platforms = {}, metadata = {}) {
    this.id = id
    this.title = title
    this.artist = artist
    this.cover = cover
    this.albumArtUrl = cover // Alias for consistency
    this.platforms = platforms
    // Additional metadata
    this.genre = metadata.genre
    this.year = metadata.year
    this.label = metadata.label
    this.album = metadata.album
    this.description = metadata.description
  }
}

// API configuration (same as Portfolio-Preview)
const APIKEY = import.meta.env.VITE_AUXKIT_FORMS_API_KEY
const baseUrl = "https://z4he9qd8w6.execute-api.eu-west-1.amazonaws.com/prod"
const siteID = "4irp0exae0ypozh0vdzlfn"

// Reactive state
const songs = ref([])
const loading = ref(true)
const searchQuery = ref('')
const viewMode = ref('grid') // 'grid' or 'list'

// Demo data fallback
const demoSongs = [
  new Song(1, "Midnight Dreams", "Aurora Nights", "https://picsum.photos/400/400?random=1", {
    "Spotify": "https://open.spotify.com/track/example1",
    "SoundCloud": "https://soundcloud.com/example1",
    "Apple Music": "https://music.apple.com/track/example1"
  }, { 
    genre: "Electronic", 
    year: "2023", 
    label: "Night Records", 
    album: "Nocturnal Vibes",
    description: "A mesmerizing journey through electronic soundscapes with ethereal vocals and pulsing beats."
  }),

  new Song(2, "Summer Breeze", "Coastal Vibes", "https://picsum.photos/400/400?random=2", {
    "Spotify": "https://open.spotify.com/track/example2",
    "Bandcamp": "https://example.bandcamp.com/track/example2"
  }, { 
    genre: "Indie Pop", 
    year: "2023", 
    label: "Sunny Sounds", 
    album: "Beach Sessions",
    description: "Uplifting indie pop track with warm guitar melodies and heartfelt lyrics about summer romance."
  }),

  new Song(3, "Urban Pulse", "City Lights", "https://picsum.photos/400/400?random=3", {
    "SoundCloud": "https://soundcloud.com/example3",
    "YouTube": "https://youtube.com/watch?v=example3",
    "Spotify": "https://open.spotify.com/track/example3"
  }, { 
    genre: "Hip Hop", 
    year: "2024", 
    label: "Metro Beats", 
    album: "Street Chronicles",
    description: "Hard-hitting hip hop with introspective lyrics and innovative production techniques."
  }),

  new Song(4, "Ocean Waves", "Blue Horizon", "https://picsum.photos/400/400?random=4", {
    "Spotify": "https://open.spotify.com/track/example4",
    "Apple Music": "https://music.apple.com/track/example4",
    "Bandcamp": "https://example.bandcamp.com/track/example4",
    "Tidal": "https://tidal.com/track/example4"
  }, { 
    genre: "Ambient", 
    year: "2022", 
    label: "Deep Sounds", 
    album: "Serenity",
    description: "Meditative ambient composition featuring field recordings and synthesized textures."
  }),

  new Song(5, "Electric Storm", "Neon Thunder", "https://picsum.photos/400/400?random=5", {
    "YouTube": "https://youtube.com/watch?v=example5",
    "Spotify": "https://open.spotify.com/track/example5"
  }, { 
    genre: "EDM", 
    year: "2024", 
    label: "Storm Records", 
    album: "Lightning Strikes",
    description: "High-energy EDM banger with explosive drops and electrifying synth work."
  }),

  new Song(6, "Acoustic Garden", "Gentle Folk", "https://picsum.photos/400/400?random=6", {
    "Spotify": "https://open.spotify.com/track/example6",
    "SoundCloud": "https://soundcloud.com/example6",
    "Bandcamp": "https://example.bandcamp.com/track/example6"
  }, { 
    genre: "Folk", 
    year: "2023", 
    label: "Organic Music", 
    album: "Roots & Branches",
    description: "Intimate folk ballad with fingerpicked guitar and poetic storytelling."
  }),

  new Song(7, "Jazz Nights", "The Smooth Collective", "https://picsum.photos/400/400?random=7", {
    "Spotify": "https://open.spotify.com/track/example7",
    "Apple Music": "https://music.apple.com/track/example7"
  }, { 
    genre: "Jazz", 
    year: "2023", 
    label: "Blue Note", 
    album: "After Hours",
    description: "Sophisticated jazz composition featuring smooth saxophone melodies and complex rhythms."
  }),

  new Song(8, "Rock Anthem", "Thunder Road", "https://picsum.photos/400/400?random=8", {
    "Spotify": "https://open.spotify.com/track/example8",
    "YouTube": "https://youtube.com/watch?v=example8",
    "Bandcamp": "https://example.bandcamp.com/track/example8"
  }, { 
    genre: "Rock", 
    year: "2024", 
    label: "Loud Records", 
    album: "Full Volume",
    description: "Powerful rock anthem with driving guitars, thunderous drums, and anthemic vocals."
  })
]

// Computed filtered songs
const filteredSongs = computed(() => {
  if (!searchQuery.value.trim()) {
    return songs.value
  }

  const query = searchQuery.value.toLowerCase().trim()
  return songs.value.filter(song => 
    song.title.toLowerCase().includes(query) ||
    song.artist.toLowerCase().includes(query) ||
    (song.genre && song.genre.toLowerCase().includes(query)) ||
    (song.label && song.label.toLowerCase().includes(query)) ||
    (song.album && song.album.toLowerCase().includes(query))
  )
})

// API fetch function (same as Portfolio-Preview)
const fetchSongs = async () => {
  try {
    const response = await fetch(`${baseUrl}/public/sites/${siteID}/songs`, {
      headers: {
        Authorization: `Bearer ${APIKEY}`,
      },
    })
    
    if (!response.ok) {
      throw new Error("Network response was not ok")
    }
    
    const data = await response.json()
    
    return data.map((song) => {
      const platforms = {}
      
      // Check for various platform URLs
      if (song.spotifyUrl) platforms.Spotify = song.spotifyUrl
      if (song.soundcloudUrl) platforms.SoundCloud = song.soundcloudUrl
      if (song.bandcampUrl) platforms.Bandcamp = song.bandcampUrl
      if (song.youtubeUrl) platforms.YouTube = song.youtubeUrl
      if (song.appleMusicUrl) platforms['Apple Music'] = song.appleMusicUrl
      if (song.tidalUrl) platforms.Tidal = song.tidalUrl
      if (song.deezerUrl) platforms.Deezer = song.deezerUrl
      
      // Fallback to generic URL field
      if (song.url && Object.keys(platforms).length === 0) {
        platforms.Listen = song.url
      }
      
      // Additional metadata
      const metadata = {
        genre: song.genre,
        year: song.year || song.releaseYear,
        label: song.label || song.recordLabel,
        album: song.album || song.albumName,
        description: song.description || song.bio || song.notes
      }
      
      return new Song(song.id, song.title, song.artist, song.albumArtUrl, platforms, metadata)
    })
  } catch (error) {
    console.error("Error fetching songs:", error)
    return []
  }
}

// Search handlers
const handleSearch = () => {
  // Search is handled reactively through computed property
}

const clearSearch = () => {
  searchQuery.value = ''
}

// Load songs on component mount
onMounted(async () => {
  loading.value = true
  
  try {
    const fetchedSongs = await fetchSongs()
    if (fetchedSongs.length > 0) {
      songs.value = fetchedSongs
    } else {
      // Use demo data if API fails or returns no data
      songs.value = demoSongs
    }
  } catch (error) {
    console.error('Failed to load songs:', error)
    // Fallback to demo data
    songs.value = demoSongs
  } finally {
    loading.value = false
  }
})
</script>

<style scoped>
.portfolio-detailed {
  min-height: 100vh;
  padding: 2rem;
  max-width: 1400px;
  margin: 0 auto;
}

/* Header */
.portfolio-header {
  text-align: center;
  margin-bottom: 3rem;
}

.portfolio-title {
  font-size: var(--fs-56);
  font-weight: var(--fw-bold);
  color: #fff;
  margin-bottom: 1rem;
}

.portfolio-subtitle {
  font-size: var(--fs-20);
  color: #b0b0b0;
  margin: 0;
}

/* Controls Section */
.controls-section {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 2rem;
  margin-bottom: 2rem;
  flex-wrap: wrap;
}

/* Search */
.search-container {
  position: relative;
  flex: 1;
  max-width: 500px;
}

.search-icon {
  position: absolute;
  left: 1rem;
  top: 50%;
  transform: translateY(-50%);
  width: 20px;
  height: 20px;
  color: #666;
  pointer-events: none;
}

.search-input {
  width: 100%;
  padding: 1rem 1rem 1rem 3rem;
  background: rgba(255, 255, 255, 0.1);
  border: 2px solid rgba(255, 255, 255, 0.2);
  border-radius: 50px;
  color: #fff;
  font-size: var(--fs-16);
  transition: all 0.3s ease;
}

.search-input:focus {
  outline: none;
  border-color: #ff6600;
  background: rgba(255, 255, 255, 0.15);
}

.search-input::placeholder {
  color: #888;
}

.clear-search {
  position: absolute;
  right: 1rem;
  top: 50%;
  transform: translateY(-50%);
  background: none;
  border: none;
  color: #888;
  cursor: pointer;
  padding: 0.25rem;
  border-radius: 50%;
  transition: color 0.3s ease;
}

.clear-search:hover {
  color: #fff;
}

.clear-search svg {
  width: 18px;
  height: 18px;
}

/* View Controls */
.view-controls {
  display: flex;
  gap: 0.5rem;
}

.view-btn {
  padding: 0.75rem;
  background: rgba(255, 255, 255, 0.1);
  border: 2px solid rgba(255, 255, 255, 0.2);
  border-radius: 8px;
  color: #888;
  cursor: pointer;
  transition: all 0.3s ease;
}

.view-btn:hover {
  background: rgba(255, 255, 255, 0.15);
  color: #fff;
}

.view-btn.active {
  background: linear-gradient(90deg, #ff3300 0%, #ff9900 100%);
  border-color: transparent;
  color: #fff;
}

.view-btn svg {
  width: 20px;
  height: 20px;
}

/* Loading */
.loading-container {
  text-align: center;
  padding: 4rem 0;
}

.loading-spinner {
  width: 50px;
  height: 50px;
  border: 3px solid rgba(255, 255, 255, 0.3);
  border-top: 3px solid #ff6600;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin: 0 auto 1rem;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

/* Results Info */
.results-info {
  color: #b0b0b0;
  margin-bottom: 2rem;
  font-size: var(--fs-14);
}

/* No Results */
.no-results {
  text-align: center;
  padding: 4rem 2rem;
  color: #888;
}

.no-results-icon {
  width: 64px;
  height: 64px;
  margin-bottom: 1rem;
}

.no-results h3 {
  color: #fff;
  margin-bottom: 0.5rem;
}

/* Songs Container */
.songs-container.view-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 2rem;
}

.songs-container.view-list {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

/* Song Items - Grid View */
.song-item-grid {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 16px;
  overflow: hidden;
  border: 1px solid rgba(255, 255, 255, 0.1);
  transition: all 0.3s ease;
}

.song-item-grid:hover {
  transform: translateY(-4px);
  border-color: rgba(255, 102, 0, 0.3);
  box-shadow: 0 8px 32px rgba(255, 102, 0, 0.2);
}

/* Song Items - List View */
.song-item-list {
  display: flex;
  gap: 1.5rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  padding: 1.5rem;
  border: 1px solid rgba(255, 255, 255, 0.1);
  transition: all 0.3s ease;
  align-items: flex-start;
}

.song-item-list:hover {
  background: rgba(255, 255, 255, 0.08);
  border-color: rgba(255, 102, 0, 0.3);
}

/* Song Image */
.song-image-container {
  position: relative;
  overflow: hidden;
  border-radius: 8px;
}

.song-item-grid .song-image-container {
  aspect-ratio: 1;
}

.song-item-list .song-image-container {
  width: 120px;
  height: 120px;
  flex-shrink: 0;
}

.song-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.song-image-container:hover .song-image {
  transform: scale(1.05);
}

/* Overlay */
.song-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.song-image-container:hover .song-overlay {
  opacity: 1;
}

.platform-buttons {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  align-items: center;
}

.platform-btn {
  background: linear-gradient(90deg, #ff3300 0%, #ff9900 100%);
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 20px;
  text-decoration: none;
  font-weight: bold;
  font-size: 0.85rem;
  transition: transform 0.2s ease;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  white-space: nowrap;
  min-width: 100px;
  justify-content: center;
}

.platform-btn:hover {
  transform: scale(1.05);
}

.platform-icon {
  width: 16px;
  height: 16px;
  flex-shrink: 0;
}

/* Song Info */
.song-info {
  padding: 1.5rem;
}

.song-item-list .song-info {
  padding: 0;
  flex: 1;
}

.song-title {
  font-size: var(--fs-20);
  font-weight: var(--fw-semibold);
  color: #fff;
  margin: 0 0 0.5rem 0;
}

.song-artist {
  font-size: var(--fs-16);
  color: #b0b0b0;
  margin: 0 0 1rem 0;
}

.song-meta {
  display: flex;
  flex-wrap: wrap;
  gap: 0.75rem;
  margin-bottom: 1rem;
}

.meta-item {
  background: rgba(255, 255, 255, 0.1);
  padding: 0.4rem 0.8rem;
  border-radius: 16px;
  font-size: var(--fs-12);
  color: #ccc;
  display: flex;
  align-items: center;
  gap: 0.4rem;
  font-weight: var(--fw-medium);
}

.meta-item.album {
  background: rgba(138, 43, 226, 0.2);
  color: #dda0dd;
  border: 1px solid rgba(138, 43, 226, 0.3);
}

.meta-item.genre {
  background: rgba(32, 178, 170, 0.2);
  color: #20b2aa;
  border: 1px solid rgba(32, 178, 170, 0.3);
}

.meta-item.year {
  background: rgba(255, 165, 0, 0.2);
  color: #ffa500;
  border: 1px solid rgba(255, 165, 0, 0.3);
}

.meta-item.label {
  background: rgba(255, 69, 0, 0.2);
  color: #ff4500;
  border: 1px solid rgba(255, 69, 0, 0.3);
}

.meta-icon {
  width: 14px;
  height: 14px;
  flex-shrink: 0;
}

/* Platform Links for List View */
.platform-links-list {
  display: flex;
  flex-wrap: wrap;
  gap: 0.75rem;
  margin-top: 1rem;
}

.platform-link {
  background: rgba(255, 102, 0, 0.2);
  color: #ff6600;
  padding: 0.5rem 1rem;
  border-radius: 20px;
  text-decoration: none;
  font-size: var(--fs-14);
  font-weight: var(--fw-medium);
  transition: all 0.3s ease;
  border: 1px solid rgba(255, 102, 0, 0.3);
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.platform-link:hover {
  background: rgba(255, 102, 0, 0.3);
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(255, 102, 0, 0.2);
}

.platform-link-icon {
  width: 16px;
  height: 16px;
  flex-shrink: 0;
}

/* Platform specific colors */
.platform-link.platform-spotify {
  background: rgba(30, 215, 96, 0.2);
  color: #1ed760;
  border-color: rgba(30, 215, 96, 0.3);
}

.platform-link.platform-spotify:hover {
  background: rgba(30, 215, 96, 0.3);
}

.platform-link.platform-soundcloud {
  background: rgba(255, 85, 0, 0.2);
  color: #ff5500;
  border-color: rgba(255, 85, 0, 0.3);
}

.platform-link.platform-soundcloud:hover {
  background: rgba(255, 85, 0, 0.3);
}

.platform-link.platform-youtube {
  background: rgba(255, 0, 0, 0.2);
  color: #ff0000;
  border-color: rgba(255, 0, 0, 0.3);
}

.platform-link.platform-youtube:hover {
  background: rgba(255, 0, 0, 0.3);
}

.platform-link.platform-applemusic {
  background: rgba(250, 250, 250, 0.2);
  color: #fafafa;
  border-color: rgba(250, 250, 250, 0.3);
}

.platform-link.platform-applemusic:hover {
  background: rgba(250, 250, 250, 0.3);
}

.platform-link.platform-bandcamp {
  background: rgba(99, 154, 210, 0.2);
  color: #639ad2;
  border-color: rgba(99, 154, 210, 0.3);
}

.platform-link.platform-bandcamp:hover {
  background: rgba(99, 154, 210, 0.3);
}

/* Song Description and Stats */
.song-description {
  margin-top: 1.5rem;
  padding-top: 1rem;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.description-text {
  font-size: var(--fs-14);
  line-height: var(--lh-relaxed);
  color: #b0b0b0;
  margin: 0 0 1rem 0;
  font-style: italic;
}

.song-stats {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: var(--fs-12);
  color: #888;
  font-weight: var(--fw-medium);
}

.stat-icon {
  width: 14px;
  height: 14px;
  flex-shrink: 0;
}

/* Buttons */
.btn-primary, .btn-secondary {
  padding: 0.75rem 1.5rem;
  border-radius: 25px;
  text-decoration: none;
  font-weight: var(--fw-semibold);
  font-size: var(--fs-16);
  transition: all 0.3s ease;
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  border: none;
  cursor: pointer;
}

.btn-primary {
  background: linear-gradient(90deg, #ff3300 0%, #ff9900 100%);
  color: white;
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 16px rgba(255, 51, 0, 0.3);
}

.btn-secondary {
  background: rgba(255, 255, 255, 0.1);
  color: #fff;
  border: 2px solid rgba(255, 255, 255, 0.2);
}

.btn-secondary:hover {
  background: rgba(255, 255, 255, 0.2);
}

/* Back Home */
.back-home {
  text-align: center;
  margin-top: 4rem;
  padding-top: 2rem;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

/* Responsive Design */
@media (max-width: 768px) {
  .portfolio-detailed {
    padding: 1rem;
  }

  .portfolio-title {
    font-size: var(--fs-40);
  }

  .controls-section {
    flex-direction: column;
    align-items: stretch;
    gap: 1rem;
  }

  .search-container {
    max-width: none;
  }

  .view-controls {
    justify-content: center;
  }

  .songs-container.view-grid {
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 1.5rem;
  }

  .song-item-list {
    flex-direction: column;
    text-align: center;
  }

  .song-item-list .song-image-container {
    width: 100%;
    height: 200px;
    align-self: center;
  }

  .platform-buttons {
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: center;
  }

  .platform-btn {
    font-size: 0.75rem;
    padding: 0.4rem 0.8rem;
    min-width: 80px;
  }
}

@media (max-width: 480px) {
  .songs-container.view-grid {
    grid-template-columns: 1fr;
  }

  .song-info {
    padding: 1rem;
  }

  .platform-links-list {
    justify-content: center;
  }
}
</style>
