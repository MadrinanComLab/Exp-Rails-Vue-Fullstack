# Ruby on Rails (RoR) + Vue JS Experiment
Tutorial Source: https://www.youtube.com/watch?v=TBZwkWznhZs&list=PLQIWx2J-GIASpN2yzAtdwoxILS7qld1XJ&index=2
November 14, 2022

===========================================================================\n
>>> SETTING UP RAILS API
===========================================================================
First thing we do is setup the Rails into an API. The tutorial uses SQLite & with the current status of our machine that is not possible. Instead, we do the following:
+---------------------------------------------------+
| rails new recordstore-backend --api -d=postgresql |
+---------------------------------------------------+

After the project is done generating, we add "net-smtp" to the "Gemfile". Then save this changes by running bundle install.

The config/database.yml was modified to be able to use PostgreSQL in this experiment. Once the configuration was done, run this command:
+---------------------------------------------------+
| rake db:create                                    |
+---------------------------------------------------+

There's a big possibility that an error will occur, but check pgAdmin and check if the expected database was created. If it wasn't there, mind the error and look for possible solution.

-------------- END OF POSTRESQL AND API CONFIGURATION --------------

==================================================================================
>>> ADDITIONAL SETUPS BASE ON THE TUTORIAL
==================================================================================
Base on the tutorial, additional libraries will be needed and was added on Gemfile. There's a comment on it so you'll see it easily. After adding it run the command bundle.

-------------- END OF ADDITIONAL SETUPS --------------

==================================================================================
>>> GENERATING THE USER MODEL
==================================================================================
Generate user model with email and password_digest. It says that password_digest is for encrypted password (?).

Some modification was made in migration file for User model and after that we run rails db:migrate

In app/models/user.rb, has_secure_password was added on that.

==================================================================================
>>> GENERATING SCAFFOLDS AND PREPARING THE CONTROLLERS
==================================================================================
After these changes, the person in the tutorial wants to add a controller but he does scaffold instead: (Controller will come along in this command)
rails g scaffold Artist name:string user:references
rails g scaffold Record title:string year:string artist:references user:references

NOTE: We can undo the generated file for example, undoing the rails g Scaffold Artist name, you can run the following command:
rails d Scaffold 

After generating the two scaffolds, we created api/v1 in controller (I know you are familiar with this from previous experiments). Move the generated controller by scaffold the api/v1. Also cover the controller by "module", you'll see that in the code snippet

NOTE: Something notable you can observe in the generated controller from scaffold. You can see the return statements are fixed in a way of how API would work, return data in JSON format.

==================================================================================
>>> JWT SESSIONS SETUP
==================================================================================
The documentation that the tutorial refers to:
https://github.com/tuwukee/jwt_sessions

First we make some changes in controller/application_controller.rb. Then we created the jwt_sessions.rb in config/initializers. And then, uncomment the necessary code snippet in cors.rb in config/initializers also.

Generate a signup controller
+---------------------------------------------------+
| rails g controller signup create                  |
+---------------------------------------------------+

After generating, go to controller/signup_controller.rb, you'll see there how to implement JWT Sessions. In the tutorial signin_controller.rb an refresh_controller.rb was manually created.

==================================================================================
>>> ADDING SAMPLE DATA
==================================================================================
In this part, the first thing the tutorial has done is define new routes in routes.rb for Vue JS later. and then modify artists_controller.rb, records_controller.rb and home_controller.rb

In the tutorial, it creates dummy data by running:
Artist.create!(name: "AC/DC")

If you try running the command in rails console and encounter an error, check your migration file if it was similar to the repo of the tutorial.
The link of the repo: https://github.com/justalever/recordstore

==================================================================================
>>> SETTING UP THE FRONTEND (VUE JS)
==================================================================================
Command for creating the Vue JS Project:
vue init webpack recordstore-frontend

In case the command didn't accept by the CLI, run this as suggested in the terminal. After running the command below, run the command above:
npm i -g @vue/cli-init

The following question will appear just do the following:
Q: Project name (recordstore-frontend)
A: Press 'Enter'
Q: Project description (A Vue.js project)
A: A Vue.js front-end app for a Ruby on Rails API backend app. 
Q: Author (MadrinanComLab <johncliffordmadrinan838@gmail.com>)
A: Press 'Enter' in my case but you can type out whatever Name and Email you want to use
Q: Runtime-only: about 6KB lighter min+gzip, but templates (or any Vue-specific HTML) are ONLY allowed in .vue files - render functions are required elsewhere
A: Press 'Enter'
Q: Install vue-router? (Y/n)
A: Y
Q: Use ESLint to lint your code? (Y/n) 
A: Y
Q: Pick an ESLint preset (Use arrow keys)
A: Pick "Standard", Ex.: Standard (https://github.com/standard/standard)
Q: Set up unit tests (Y/n)       
A: Y
Q: Pick a test runner
A: Karma and Mocha
Q: Setup e2e tests with Nightwatch? (Y/n) 
A: n
Q: Should we run `npm install` for you after the project has been created? (recommended)
A: Yes, use NPM | NOTE: The tutorial uses Yarn so he pick yarn but since I was using NPM, I pick NPM

After answering the question, the vue folder will be created. To run the frontend enter the following command:
cd recordstore-frontend
npm run dev

You app will be on: http://localhost:8080/

NOTE: Since the Vue app will be on port 8080, we have to modify the config/initializers/cors.rb. In there the request will be allowed from localhost:8081, but that is the port in the tutorial, mine was on 8080 so I have to change the cors.rb from 8081 to 8080

ANOTHER NOTE: From this and beyond, while working on recordstore-frontend use single quote for strings because double quote for strings is against the rule of ESLint. I'm giving an emphasis to this because if you are like me that used to using double quote for strings.

FVCKIN' NOTE: DO NOT USE ESLINT AT ALL, IT WILL GIVE YOU A HELL

==================================================================================
>>> SETTING UP THE TAILWIND CSS
==================================================================================
The tutorial uses Yarn but I use NPM, so I followed the documentation of Tailwind CSS
Tailwind CSS Documentation: https://tailwindcss.com/docs/guides/vite#vue

Just follow the documentation, input.css will be instructed to be made in recordstore-frontend/src and import this in main.js

NOTE: In the documentation, skip the part of #1 Create your project. Follow the documentation from #2

recordstore-frontend/.postcssrc.js was added "tailwindcss"

To watch the changes of tailwind in our component, run this command to your terminal: (make sure you are on recordstore-frontend)
npx tailwindcss-cli build -i ./src/input.css -o ./dist/output.css --watch

Breakdown of the command:
-i means "input", your input.css can be name however you want and it was located "src" folder
-o means "input", it will be generated once the tailwind was setup to your project (finished following the documentation of tailwind installation and it was located on "dist" folder and the file name is output.css)

NOTE: You may encounter a quite different command that looks like this:
npx tailwindcss build -i ./src/input.css -o ./dist/output.css --watch

The problem is, it will generate a few hundred lines of code in output.css, where it should be a thousand lines. You must run the command where 'tailwindcss-cli' is present because that will generate the correct amount of lines for output.css

Source: https://stackoverflow.com/questions/70337770/tailwindcss-output-css-file-424-lines

Another note: (My apologies if there a lot of fvckin' note)
Sometimes, tailwind utility classes may not work even it was present in output.css, but try restarting your Vue app and see if the style of your component changes. If not, look for solution on the internet.

==================================================================================
>>> SETTING UP VUE-AXIOS
==================================================================================
To install in run:
npm install --save axios vue-axios

Documentation for setting up Vue-axios: https://www.npmjs.com/package/vue-axios

Then import vue-axios to main.js

In recordstore-frontend/src backend/axios/index.js was created.

==================================================================================
>>> CREATING VUE COMPONENTS
==================================================================================
Start on adding new route to recordstore-frontend/src/router/index.js for Signin.vue. 
Signup.vue and Header.vue was created.

==================================================================================
>>> IT's DEBUGGING TIME!
==================================================================================
NOTE: The end was rubbish, read the comments on the final video and look for some helpful comments
I know this is bullshit, so I'll be writing this part of Readme so you won't spent lots of time trying to debug and run it.

1.) First thing I fix was recordstore-frontend/src/main.js.
2.) We don't have redis but this application uses redis to store the JWT. Here is the following sources that you can use to download Redis but note that I am a Windows 10 User so the source that I'll be giving might not relevant to you:
Tutorial Guide:
https://www.youtube.com/watch?v=6mtu_dFxm28
Where to download Redis:
https://github.com/microsoftarchive/redis/releases

Note for #2: You don't have to follow the tutorial video until the end, the only thing you need to do is run the redis-server.exe then this app will work again.

3.) You will try saving your first record, if an internal error was thrown go to records_controller.rb and find the if @record.save. Once you see it, remove ", location: @record" in "render json: @record, status: :created, location: @record"

You can see the source code of the tutorial that we're following on this experiment right here:
https://github.com/justalever/recordstore/blob/master/app/controllers/api/v1/records_controller.rb
