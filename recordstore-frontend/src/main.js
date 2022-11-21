// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
// import VueAxios from 'vue-axios'
import { securedAxiosInstance, plainAxiosInstance } from './backend/axios'
import './input.css' /* ADDED TO BE ABLE TO USE TAILWIND CSS */

Vue.config.productionTip = false

/* NOTE THIS PART WAS DEBUGGED, THE PREVIOUS ONE LOOK LIKE THIS:
Vue.use(VueAxios, {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
})

BUT IT DIDN'T WORK SO THE ONE ON BELOW WORKED. THANKS TO THE PERSON WHO COMMENTED ON THE LAST VIDEO OF THE SERIES ON HOW HE FIXED IT.
 */
Vue.prototype.$http = {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
}

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  securedAxiosInstance,
  plainAxiosInstance,
  components: { App },
  template: '<App/>'
})
