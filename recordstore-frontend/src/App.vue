<template>
  <div id="app">
    <Header/>
    <router-view/>
  </div>
</template>

<script>
import Header from '@/components/Header.vue' /* @ REFERS TO SRC FOLDER IN recordstore-frontend */
export default {
  name: 'App',
  components: {
    Header
  }
}
</script>
