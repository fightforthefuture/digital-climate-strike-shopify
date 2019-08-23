/* eslint no-console: 0 */

import Vue from 'vue'
import App from '../app.vue'
import Vuetify from 'vuetify'

Vue.use(Vuetify)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App)
  }).$mount("#app")

  document.body.appendChild(app.$el)
})
