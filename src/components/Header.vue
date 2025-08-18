<template>
  <div class="header">
    <div class="header-left">
      <!-- <h1>My Website</h1> -->
       <img src="../../public/lode.png" alt="Logo" style="height:5rem; width: auto;">
    </div>

    <div class="header-right">
      <a href="/#">Home</a>
      <a href="/#portfolio">About</a>
      <a href="/#testimonials">Testimonials</a>
      <a href="/#contact">Contact</a>
    </div>
  </div>
</template>

<script>
</script>

<style lang="scss" scoped>
.header {
  background: linear-gradient(
    to bottom,
    rgba(0, 0, 0, 1.000) 0%, // full black
    rgba(0, 0, 0, 0.738) 19%,
    rgba(0, 0, 0, 0.541) 34%,
    rgba(0, 0, 0, 0.382) 47%,
    rgba(0, 0, 0, 0.278) 56.5%,
    rgba(0, 0, 0, 0.194) 65%,
    rgba(0, 0, 0, 0.126) 73%,
    rgba(0, 0, 0, 0.075) 80.2%,
    rgba(0, 0, 0, 0.042) 86.1%,
    rgba(0, 0, 0, 0.021) 91%,
    rgba(0, 0, 0, 0.008) 95.2%,
    rgba(0, 0, 0, 0.002) 98.2%,
    transparent 100%
  );
  padding: 4rem;

  h1 {
    margin: 0;
    font-size: 1.5rem;
  }

  display: flex;
  align-items: center;
  justify-content: space-between;
}


.header-left {
    display: flex;
    align-items: center;
    
    h1 {
        margin: 0;
        font-size: 2.5rem;
    }
}

.header-right {
  display: flex;
  gap: 1rem;
  padding: 0rem 2rem;

  a,
  RouterLink {
    color: white;
    text-decoration: none;
    font-size: 1.8rem;

    &:hover {
      text-decoration: underline;
      cursor: pointer;
    }
  }
}

</style>
