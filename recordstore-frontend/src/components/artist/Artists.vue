<template>
  <div class="max-w-md m-auto py-10">
    <div class="text-red-600" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4">Add a new artist</h3>

    <form @submit.prevent="addArtist">
      <div class="mb-6">
        <input type="text" class="bg-gray-200 block p-1 w-full rounded-sm" autofocus autocomplete="off" placeholder="Type an artist name" v-model="newArtist.name">
      </div>

      <input type="submit" value="Add Artist" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green-500 hover:bg-green-700 block w-full py-4 text-white items-center justify-center">
      <hr class="border border-gray-100 my-6">

      <ul class="list-reset mt-4">
        <li class="py-4" v-for="artist in artists" :key="artist.id" :artist="artist">
          <div class="flex items-center justify-between flex-wrap">
            <p class="block flex-1 font-mono font-semibold flex items-center">
              <svg class="fill-current text-indigo w-6 h-6 mr-2" viewBox="0 0 20 20" width="20" height="20"><title>music artist</title><path d="M15.75 8l-3.74-3.75a3.99 3.99 0 0 1 6.82-3.08A4 4 0 0 1 15.75 8zm-13.9 7.3l9.2-9.19 2.83 2.83-9.2 9.2-2.82-2.84zm-1.4 2.83l2.11-2.12 1.42 1.42-2.12 2.12-1.42-1.42zM10 15l2-2v7h-2v-5z"></path></svg>
              {{ artist.name }}
            </p>

            <button class="bg-transparent text-sm hover:bg-blue-700 hover:text-white text-blue-500 border border-blue-500 no-underline font-bold py-2 px-4 mr-2 rounded" @click.prevent="editArtist(artist)">Edit</button>
            <button class="bg-transparent text-sm hover:bg-red-700 hover:text-white text-red-500 border border-red-500 no-underline font-bold py-2 px-4 mr-2 rounded" @click.prevent="removeArtist(artist)">Delete</button>
          </div>

          <div v-if="artist == editedArtist">
            <form @submit.prevent="updateArtist(artist)">
              <div class="mb-6 p-4 bg-white rounded border border-gray-100 mt-4">
                <input type="text" class="bg-gray-200 block p-1 w-full rounded-sm" v-model="artist.name">
                <input type="submit" value="Update" class="my-2 bg-transparent text-sm hover:bg-blue-700 hover:text-white text-blue-500 border border-blue-500 no-underline font-bold py-2 px-4 rounded">
              </div>
            </form>
          </div>
        </li>
      </ul>
    </form>
  </div>
</template>

<script>
export default {
  name: 'Artist',
  data () {
    return {
      artists: [],
      newArtist: [],
      error: '',
      editedArtist: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$route.replace('/')
    } else {
      this.$http.secured.get('/api/v1/artists')
        .then(response => { this.artists = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addArtist () {
      const value = this.newArtist

      if (!value) {
        return
      }

      this.$http.secured.post('/api/v1/artists', { artist: { name: this.newArtist.name }})
        .then(response => {
          this.artists.push(response.data)
          this.newArtist = ''
        })
        .catch(error => this.setError(error, 'Cannot create artist'))
    },
    removeArtist (artist) {
      this.$http.secured.delete(`/api/v1/artists/${ artist.id }`)
        .then(response => {
            this.artists.splice(this.artists.indexOf(artist), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete artist'))
    },
    editArtist () {
      this.editedArtist = artist
    },
    updateArtist (artist) {
      this.editedArtist = ''
      this.$http.secured.patch(`/api/v1/artists/${ artist.id }`, { artist: { title: artist.name }})
       .catch(error => this.setError(error, 'Cannot update artist'))
    }
  }
}
</script>