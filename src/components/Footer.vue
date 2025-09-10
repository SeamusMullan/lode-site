<template>
  <footer class="footer">
    <div class="footer-container">
      <!-- Main Footer Content -->
      <div class="footer-content">
        <!-- Left: Brand -->
        <div class="footer-left">
          <div class="footer-brand">
            <img src="/lode.png" alt="LODE* Logo" class="footer-logo" />
            <p class="footer-tagline">
              Your Creative Lodestar
            </p>
          </div>
        </div>

        <!-- Center: Contact Section -->
        <div class="footer-center">
          <div class="footer-contact">
            <h4>Ready to start a project?</h4>
            <a
              href="https://docs.google.com/forms/d/e/1FAIpQLSdou2etnK34CcXzpmr52aP44fBLkNMu16ww53bgoiXOI1UF2g/viewform"
              target="_blank"
              rel="noopener noreferrer"
              class="contact-cta"
              aria-label="Fill out Contact Form"
            >
              <svg
                class="external-link-icon"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
              >
                <path
                  d="M18 13v6a2 2 0 01-2 2H5a2 2 0 01-2-2V8a2 2 0 012-2h6"
                />
                <polyline points="15,3 21,3 21,9" />
                <line x1="10" y1="14" x2="21" y2="3" />
              </svg>
              Click to Contact
            </a>
          </div>
        </div>

        <!-- Right: Social Links -->
        <div class="footer-right">
          <div class="footer-social">
            <h4>Connect with us</h4>
            <div class="social-links">
              <a
                href="https://instagram.com"
                target="_blank"
                rel="noopener noreferrer"
                class="social-link"
              >
                LODE* Instagram
              </a>
              <a
                href="https://twitter.com"
                target="_blank"
                rel="noopener noreferrer"
                class="social-link"
              >
                something else
              </a>
              <a
                href="https://twitter.com"
                target="_blank"
                rel="noopener noreferrer"
                class="social-link"
              >
                bingus
              </a>
            </div>
          </div>
        </div>
      </div>

      <!-- Footer Bottom -->
      <div class="footer-bottom">
        <p>&copy; 2025 LODE*. All rights reserved.</p>
      </div>
    </div>
  </footer>
</template>

<script setup>
const openEmailClient = () => {
  window.location.href =
    "mailto:example@example.com?subject=Project Inquiry&body=Hi! I'd like to discuss a project with you.";
};
</script>

<style scoped>
.footer {
  background: #191919;
  color: #ffffff;
  padding: 2rem 0 2rem;
}

.footer-container {
  margin: 0 auto;
  padding: 0 2rem;
}

.footer-content {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 4rem;
  margin-bottom: 1rem;
  flex-wrap: nowrap;
}

.footer-left {
  flex: 0 1 33%;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: flex-start;
  min-width: 0;
}

.footer-center {
  flex: 0 1 34%;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: center;
  min-width: 0;
}

.footer-right {
  flex: 0 1 33%;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: flex-end;
  min-width: 0;
}

.footer-brand {
  text-align: left;
}

.footer-brand img {
  max-width: 18rem;
  height: auto;
  margin-bottom: 1rem;
}

.footer-tagline {
  font-size: var(--fs-16);
  color: #b0b0b0;
  line-height: var(--lh-relaxed);
}

.footer-contact {
  text-align: center;
  max-width: 400px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.footer-contact h4 {
  font-size: var(--fs-32);
  font-weight: var(--fw-semibold);
  margin-bottom: 1.5rem;
  margin-top: 0;
  color: #ffffff;
}

.contact-cta {
  background: linear-gradient(90deg, #ff3300 0%, #ff9900 100%);
  font-size: 1.25rem;
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
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.75rem;
  margin-bottom: 1rem;
}

.contact-cta:hover {
  transform: scale(1.07) rotate(-2deg);
  box-shadow: 0 8px 32px rgba(255, 51, 0, 0.35),
    0 2px 12px rgba(255, 153, 0, 0.25);
}

.contact-cta::after {
  content: "";
  position: absolute;
  inset: 0;
  border-radius: 32px;
  padding: 2px;
  background: linear-gradient(90deg, #ff3300, #ff9900, #ff3300);
  background-size: 200% 200%;
  z-index: -1;
  mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
  -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
  -webkit-mask-composite: xor;
  mask-composite: exclude;
  animation: cta-border-flash 2s linear infinite;
  opacity: 0.7;
}

.external-link-icon {
  width: 20px;
  height: 20px;
}

.contact-email {
  font-size: var(--fs-14);
  color: #b0b0b0;
  margin: 0;
}

.footer-social {
  text-align: right;
  display: flex;
  flex-direction: column;
  align-items: flex-end;
}

.footer-social h4 {
  font-size: var(--fs-18);
  font-weight: var(--fw-semibold);
  margin-bottom: 1rem;
  margin-top: 0;
  color: #ffffff;
}

.social-links {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  align-items: flex-end;
}

.social-link {
  color: #b0b0b0;
  font-size: var(--fs-16);
  text-decoration: none;
  transition: all 0.3s ease;
  padding: 0.25rem 0;
}

.social-link:hover {
  color: #4ecdc4;
  transform: translateX(-2px);
}

.footer-bottom {
  display: flex;
  justify-content: center;
  align-items: center;
  padding-top: 2rem;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.footer-bottom p {
  margin: 0;
  font-size: var(--fs-14);
  color: #b0b0b0;
}

/* Responsive Design */
@keyframes cta-border-flash {
  0%,
  100% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
}

@media (max-width: 768px) {
  .footer {
    padding: 3rem 0 1.5rem;
  }

  .footer-container {
    padding: 0 1rem;
  }

  .footer-content {
    flex-direction: column;
    gap: 2rem;
  }

  .footer-left,
  .footer-center,
  .footer-right {
    text-align: center;
    align-items: center;
  }

  .footer-contact {
    text-align: center;
    max-width: none;
  }

  .footer-brand {
    text-align: center;
  }

  .footer-social {
    text-align: center;
    align-items: center;
  }

  .social-links {
    align-items: center;
  }

  .footer-bottom {
    text-align: center;
  }
}

@media (max-width: 480px) {
  .contact-cta {
    padding: 0.75rem 1.5rem;
    font-size: var(--fs-14);
  }
}
</style>
