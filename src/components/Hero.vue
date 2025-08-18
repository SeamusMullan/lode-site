<template>
    <div class="hero">
        <h1 class="hero-title">Welcome to My Website</h1>
        <p class="hero-description">Your one-stop solution for all your needs.</p>
        <a href="/#contact" class="hero-button">Get in Touch</a>
    </div>
</template>

<script>
</script>

<style lang="scss" scoped>
@use "sass:color";

.hero {
    color: white;
    padding: 4rem;
    text-align: center;
}

.hero-title {
    font-size: 3rem;
    font-weight: bold;
    margin-bottom: 1rem;
}

.hero-description {
    font-size: 1.5rem;
    margin-bottom: 2rem;
}

.hero-button {
    padding: 1rem 2rem;
    /* darken(#007bff, 10%) -> adjust lightness by -10% */
    background-color: color.adjust(#007bff, $lightness: -10%);
    color: white;
    text-decoration: none;
    border-radius: 5px;

    &:hover {
        /* darken(#007bff, 15%) -> adjust lightness by -15% */
        background-color: color.adjust(#007bff, $lightness: -15%);
    }
}

</style>