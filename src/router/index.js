import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import Portfolio from '../views/Portfolio.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/portfolio',
    name: 'Portfolio',
    component: Portfolio
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior(to, from, savedPosition) {
    // If the user used the back/forward buttons, restore their scroll position
    if (savedPosition) {
      return savedPosition
    }
    // For hash links (like #about), scroll to that element
    if (to.hash) {
      return new Promise((resolve) => {
        // Add a small delay to ensure the page has rendered
        setTimeout(() => {
          const element = document.querySelector(to.hash)
          if (element) {
            resolve({
              el: to.hash,
              behavior: 'smooth',
              block: 'start'
            })
          } else {
            resolve({ top: 0, left: 0 })
          }
        }, 100)
      })
    }
    // For all other navigation, always scroll to top
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve({ top: 0, left: 0 })
      }, 100)
    })
  }
})

export default router
