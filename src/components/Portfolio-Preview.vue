<template>
    <div class="song-list" id="song-list-1">
        <ul>
            <li v-for="song in songs" :key="song.id">
                <img :src="song.cover" :alt="song.title" />
                <p>{{ song.title }}</p>
            </li>
        </ul>
    </div>

    <div class="song-list" id="song-list-2">
        <ul>
            <li v-for="song in songs" :key="song.id">
                <img :src="song.cover" :alt="song.title" />
                <!-- <p class="song-title">{{ song.title }}</p> -->
            </li>
        </ul>
    </div>

</template>

<script setup>
class Song {
    constructor(id, title, artist, cover) {
        this.id = id;
        this.title = title;
        this.artist = artist;
        this.cover = cover;
    }
}

const songs = [
    new Song(1, "Song Title 1", "Artist 1", "https://picsum.photos/800"),
    new Song(2, "Song Title 2", "Artist 2", "https://picsum.photos/800"),
    new Song(3, "Song Title 3", "Artist 3", "https://picsum.photos/800"),
    new Song(4, "Song Title 4", "Artist 4", "https://picsum.photos/800"),
];
</script>

<style lang="scss" scoped>

#song-list-1 {
    // offset this list a bit to the left
    transform: translateX(-8rem);
}

#song-list-2 {
    // offset this list a bit to the right
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
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
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