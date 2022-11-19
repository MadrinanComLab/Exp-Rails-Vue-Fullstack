<template>
  <div class="max-w-sm m-auto my-8">
      <div class="border p-10 border-grey-light shadow rounded-lg">
          <h3 class="text-2xl mb-6 text-gray-900">Sign Up</h3>

          <form @submit.prevent="signup">
            <div class="text-red" v-if="error">{{ error }}</div>

            <div class="mb-6">
              <label for="email">Email Address:</label>
              <input type="email" v-model="email" id="email" placeholder="Enter your email" class="bg-gray-200 block p-1 w-full rounded-sm">
            </div>

            <div class="mb-6">
              <label for="password">Password:</label>
              <input type="password" v-model="confirm_password" id="password" placeholder="Enter your password" class="bg-gray-200 block p-1 w-full rounded-sm">
            </div>

            <div class="mb-6">
              <label for="confirm_password">Confirm Password:</label>
              <input type="password" v-model="password" id="confirm_password" placeholder="Re-enter your password" class="bg-gray-200 block p-1 w-full rounded-sm">
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
      email: '',
      password: '',
      confirm_password: '',
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
    signin () {
      /* plain WAS DEFINED IN src/main.js */
      this.$http.plain.post(
        '/signup',
        { email: this.email, password: this.password, confirm_password: this.confirm_password }
      ).then(response => this.signinSuccessful(response)).catch(error => this.signinFailed(error))
    },
    signinSuccessful (response) {
      if (!response.data.csrf) {
        /* BACK OUT IF CSRF DOESN'T MATCH */
        this.signinFailed(response)
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
    signinFailed (error) {
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
