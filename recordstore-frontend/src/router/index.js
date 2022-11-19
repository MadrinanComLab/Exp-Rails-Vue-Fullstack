import Vue from 'vue'
import Router from 'vue-router'
import Signin from '@/components/Signin.vue' /* @ REFERS TO SRC FOLDER IN recordstore-frontend */
import Signup from '@/components/Signup.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Signin',
      component: Signin
    },
    {
      path: '/signup',
      name: 'Signup',
      component: Signup
    }
  ]
})
