<template>
  <section class="about">
    <div class="container">
      <h2 class="about-title">About</h2>
      <p class="about-text">
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
      </p>
    </div>
  </section>
</template>

<script>
export default {
  name: 'About'
}
</script>

<style scoped>
.about {
  padding-bottom: 60px 0;
  max-width: 60%;
  margin: 0 auto;
}

.container {
  margin: 0 auto;
  padding-bottom: 0 10px;
  text-align: center;
}

.about-title {
  font-size: 3rem;
  font-weight: bold;
  text-align: center;
  margin-bottom: 40px;
  color: #fff;
  position: relative;
  display: inline-block;
}

.about-title::after {
  content: '';
  position: absolute;
  bottom: -10px;
  left: 50%;
  transform: translateX(-50%);
  width: 100%;
  height: 3px;
  background-color: #007bff;
}

.about-text {
  font-size: 1.5rem;
  line-height: 1.6;
  color: #fff;
  text-align: center;
  margin: 0 auto;
}
</style>