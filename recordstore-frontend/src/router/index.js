import Vue from 'vue'
import Router from 'vue-router'
import Signin from '@/components/Signin.vue' /* @ REFERS TO SRC FOLDER IN recordstore-frontend */
import Signup from '@/components/Signup.vue'
import Artists from '@/components/artists/Artists.vue'
import Records from '@/components/records/Records.vue'

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
    },
    {
      path: '/artists',
      name: 'Artists',
      component: Artists
    },
    {
      path: '/records',
      name: 'Records',
      component: Records
    }
  ]
})
