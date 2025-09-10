<template>
  <section class="about">
    <div class="container">
      <h2 class="about-title">About</h2>
      <p class="about-text">
        LODESTAR (stylized as LODE*) is a production/songwriting duo made up of Soutjay and Korzana, working alongside a team of professional topliners.
        LODE* pride themselves on versatility and a warm, polished sound that adapts to the artist.
        From custom productions to beats and toplines, our focus is on helping artists bring their ideas to life; making sure they sound their absolute best.
      </p>

      <!-- Team Section -->
      <div class="team-section">
        <h3 class="team-title">Meet the Team</h3>
        <div class="team-cards">
          <div class="team-card">
            <div class="profile-picture">
              <img src="/team/soutjay.jpg" alt="Soutjay" />
            </div>
            <h4 class="member-name">Soutjay</h4>
            <p class="member-description">
              Soutjay is a multi-instrumentalist, producer, and songwriter whose sound blends R&B inspiration, jazzy chords, and modern production. Known for his unique style, he not only crafts full productions but also writes and records toplines, bringing a complete musical perspective to every project. As part of LODE, Soutjay focuses on creating music that feels fresh, soulful, and unforgettable.
            </p>
          </div>

          <div class="team-card">
            <div class="profile-picture">
              <img src="/team/korzana.jpg" alt="Korzana" />
            </div>
            <h4 class="member-name">Korzana</h4>
            <p class="member-description">
              Coming from a house and electronic background, Korzana has built his craft on blending energy with emotion across genres. What makes him stand out is his ability to take an artist's raw idea and shape it into a finished track that feels both unique and powerful. As a part of LODE, Korzana brings years of experience, a collaborative mindset, and the drive to turn visions into songs that truly connect.
            </p>
          </div>
        </div>
      </div>
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

.team-section {
  margin-top: 60px;
}

.team-title {
  font-size: 2.5rem;
  font-weight: bold;
  text-align: center;
  margin-bottom: 40px;
  color: #fff;
}

.team-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
  max-width: 1200px;
  margin: 0 auto;
}

.team-card {
  background: rgba(255, 255, 255, 0.1);
  border-radius: 15px;
  padding: 30px;
  text-align: center;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.team-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 15px 35px rgba(0, 123, 255, 0.3);
}

.profile-picture {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  overflow: hidden;
  margin: 0 auto 20px;
  border: 3px solid #007bff;
}

.profile-picture img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.member-name {
  font-size: 1.8rem;
  font-weight: bold;
  color: #fff;
  margin-bottom: 15px;
}

.member-description {
  font-size: 1rem;
  line-height: 1.6;
  color: #e0e0e0;
  margin: 0;
}

@media (max-width: 768px) {
  .team-cards {
    grid-template-columns: 1fr;
    gap: 20px;
  }
  
  .team-card {
    padding: 20px;
  }
  
  .team-title {
    font-size: 2rem;
  }
}
</style>