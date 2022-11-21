<template>
  <div class="max-w-sm m-auto my-8">
      <div class="border p-10 border-grey-light shadow rounded-lg">
          <h3 class="text-2xl mb-6 text-gray-900">Sign Up</h3>

          <form @submit.prevent="signup">
            <div class="text-red-500 text-center" v-if="error">{{ error }}</div>

            <div class="mb-6">
              <label for="email">Email Address:</label>
              <input type="email" v-model="email" id="email" placeholder="Enter your email" class="bg-gray-200 block p-1 w-full rounded-sm">
            </div>

            <div class="mb-6">
              <label for="password">Password:</label>
              <input type="password" v-model="password" id="password" placeholder="Enter your password" class="bg-gray-200 block p-1 w-full rounded-sm">
            </div>

            <div class="mb-6">
              <label for="password_confirmation">Confirm Password:</label>
              <input type="password" v-model="password_confirmation" id="password_confirmation" placeholder="Re-enter your password" class="bg-gray-200 block p-1 w-full rounded-sm">
            </div>

            <button type="submit" class="font-sans font-bold px-1 rounded cursor-pointer no-underline bg-green-500 hover:bg-green-700 block w-full py-2 text-white items-center justify-center">
                Sign Up
            </button>

            <div class="my-4">
                <router-link to="/" class="text-blue-700 underline">Already have an account?</router-link>
            </div>
          </form>
      </div>
  </div>
</template>

<script>
export default {
  name: 'Signup',
  data () {
    return {
      email: 'john@example.com',
      password: '12345678',
      password_confirmation: '12345678',
      error: ''
    }
  },
  cretead () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    signup () {
      /* plain WAS DEFINED IN src/main.js */
      this.$http.plain.post('/signup', { email: this.email, password: this.password, password_confirmation: this.password_confirmation })
        .then(response => this.signupSuccessful(response))
        .catch(error => this.signupFailed(error))
    },
    signupSuccessful (response) {
      if (!response.data.csrf) {
        /* BACK OUT IF CSRF DOESN'T MATCH */
        this.signupFailed(response)
        return
      }

      /* localStorage WAS AVAILABLE BY DEFAULT */
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true

      /* CLEAR ERROR MESSAGES */
      this.error = ''

      /* REDIRECT */
      this.$router.replace('/records')
    },
    signupFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/records')
      }
    }
  }
}
</script>
