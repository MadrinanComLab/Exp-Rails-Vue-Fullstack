![Rails+Vue Experiment Image Banner](https://user-images.githubusercontent.com/74145874/203148869-ff892906-3a71-4006-8f41-f4a93aa5a414.jpg)
# Ruby on Rails (RoR) + Vue JS Experiment
Tutorial Source: https://www.youtube.com/watch?v=TBZwkWznhZs&list=PLQIWx2J-GIASpN2yzAtdwoxILS7qld1XJ&index=2 </br>
November 14, 2022 </br>
 </br>
 
 ## Technologies used in this Project:
 <p>
 <img src="https://user-images.githubusercontent.com/74145874/203150268-0c0e6843-af70-4705-b232-d6ef740f3090.png" width="100px" height="100px" alt="Ruby on Rails" title="Ruby on Rails"/>
 <img src="https://user-images.githubusercontent.com/74145874/203150691-6cdb51ef-bbb8-45a5-9ad9-be9cd7d379ce.png" width="100px" height="100px" alt="Vue JS" title="Vue JS"/>
 <img src="https://user-images.githubusercontent.com/74145874/203151252-c9855797-b043-4385-82c7-4986cfdd222e.png" width="100px" height="100px" alt="Tailwind CSS" title="Tailwind CSS"/>
 <img src="https://user-images.githubusercontent.com/74145874/196059473-011117c1-e31d-4c5e-be6b-0a81b6d4f431.png" width="100px" height="100px" alt="PostgreSQL" title="PostgreSQL"/>
 <img src="https://user-images.githubusercontent.com/74145874/203151709-b137020a-06b0-4853-a95a-2ce77c86b918.png" width="100px" height="100px" alt="Redis" title="Redis"/>
</p>

## How to run this project:
1.) You need Ruby and Rails installed to your machine, once it was done run rails s and this is how it look like if the command succeed:
![run-rails](https://user-images.githubusercontent.com/74145874/203152796-eae44a00-a8a2-4df5-92e0-5bd4b97c7c87.png)

## Here is the following steps that how I created this project:
### SETTING UP RAILS API
----
First thing we do is setup the Rails into an API. The tutorial uses SQLite & with the current status of our machine that is not possible. Instead, we do the following: </br>
Rails Command
-------------------------------------------------|
rails new recordstore-backend --api -d=postgresql| </br>
 </br>
After the project is done generating, we add "net-smtp" to the "Gemfile". Then save this changes by running bundle install.</br></br>

The config/database.yml was modified to be able to use PostgreSQL in this experiment. Once the configuration was done, run this command:</br>
Rails Command
-------------------------------------------------|
rake db:create|</br></br>

There's a big possibility that an error will occur, but check pgAdmin and check if the expected database was created. If it wasn't there, mind the error and look for possible solution.</br>

### ADDITIONAL SETUPS BASE ON THE TUTORIAL
----
Base on the tutorial, additional libraries will be needed and was added on Gemfile. There's a comment on it so you'll see it easily. After adding it run the command bundle.
</br></br>

### GENERATING THE USER MODEL
----
Generate user model with email and password_digest. It says that password_digest is for encrypted password (?).</br>

Some modification was made in migration file for User model and after that we run rails db:migrate</br>

In app/models/user.rb, has_secure_password was added on that.</br></br>

### GENERATING SCAFFOLDS AND PREPARING THE CONTROLLERS
----
After these changes, the person in the tutorial wants to add a controller but he does scaffold instead: (Controller will come along in this command)
Rails Command
-------------------------------------------------|
rails g scaffold Artist name:string user:references|</br></br>
rails g scaffold Record title:string year:string artist:references user:references|</br></br>

***NOTE:*** We can undo the generated file for example, undoing the rails g Scaffold Artist name, you can run the following command:
Rails Command
-------------------------------------------------|
rails d Scaffold|</br>

After generating the two scaffolds, we created api/v1 in controller (I know you are familiar with this from previous experiments). Move the generated controller by scaffold the api/v1. Also cover the controller by "module", you'll see that in the code snippet</br>

***NOTE:*** Something notable you can observe in the generated controller from scaffold. You can see the return statements are fixed in a way of how API would work, return data in JSON format.</br></br>

### JWT SESSIONS SETUP
----
The documentation that the tutorial refers to:</br>
https://github.com/tuwukee/jwt_sessions </br>

First we make some changes in controller/application_controller.rb. Then we created the jwt_sessions.rb in config/initializers. And then, uncomment the necessary code snippet in cors.rb in config/initializers also.</br>

Generate a signup controller</br>
Rails Command
-------------------------------------------------|
| rails g controller signup create|</br>

After generating, go to controller/signup_controller.rb, you'll see there how to implement JWT Sessions. In the tutorial signin_controller.rb an refresh_controller.rb was manually created.</br>

### ADDING SAMPLE DATA
----
In this part, the first thing the tutorial has done is define new routes in routes.rb for Vue JS later. and then modify artists_controller.rb, records_controller.rb and home_controller.rb</br>

In the tutorial, it creates dummy data by running:</br>
Rails 'Console' Command
-------------------------------------------------|
Artist.create!(name: "AC/DC")|</br>

If you try running the command in rails console and encounter an error, check your migration file if it was similar to the repo of the tutorial.</br>
The link of the repo: https://github.com/justalever/recordstore </br>

### SETTING UP THE FRONTEND (VUE JS)
----
Command for creating the Vue JS Project:</br>
NPM Command
-------------------------------------------------|
vue init webpack recordstore-frontend|</br>

In case the command didn't accept by the CLI, run this as suggested in the terminal. After running the command below, run the command above:</br>
NPM Command
-------------------------------------------------|
npm i -g @vue/cli-init|</br>

The following question will appear just do the following:</br>
***Q:*** Project name (recordstore-frontend)</br>
***A:*** Press 'Enter'</br>
***Q:*** Project description (A Vue.js project)</br>
***A:*** A Vue.js front-end app for a Ruby on Rails API backend app. </br>
***Q:*** Author (MadrinanComLab <johncliffordmadrinan838@gmail.com>)</br>
***A:*** Press 'Enter' in my case but you can type out whatever Name and Email you want to use</br>
***Q:*** Runtime-only: about 6KB lighter min+gzip, but templates (or any Vue-specific HTML) are ONLY allowed in .vue files - render functions are required elsewhere</br>
***A:*** Press 'Enter'</br>
***Q:*** Install vue-router? (Y/n)</br>
***A:*** Y</br>
***Q:*** Use ESLint to lint your code? (Y/n) </br>
***A:*** Y</br>
***Q:*** Pick an ESLint preset (Use arrow keys)</br>
***A:*** Pick "Standard", Ex.: Standard (https://github.com/standard/standard)</br>
***Q:*** Set up unit tests (Y/n)</br>
***A:*** Y</br>
***Q:*** Pick a test runner</br>
***A:*** Karma and Mocha</br>
***Q:*** Setup e2e tests with Nightwatch? (Y/n) </br>
***A:*** n</br>
***Q:*** Should we run `npm install` for you after the project has been created? (recommended)</br>
***A:*** Yes, use NPM | NOTE: The tutorial uses Yarn so he pick yarn but since I was using NPM, I pick NPM</br></br>

After answering the question, the vue folder will be created. To run the frontend enter the following command:</br>
NPM Command
-------------------------------------------------|
cd recordstore-frontend|
npm run dev|</br>

You app will be on: http://localhost:8080/ </br>

***NOTE:*** Since the Vue app will be on port 8080, we have to modify the config/initializers/cors.rb. In there the request will be allowed from localhost:8081, but that is the port in the tutorial, mine was on 8080 so I have to change the cors.rb from 8081 to 8080

***ANOTHER NOTE:*** From this and beyond, while working on recordstore-frontend use single quote for strings because double quote for strings is against the rule of ESLint. I'm giving an emphasis to this because if you are like me that used to using double quote for strings.

***FVCKIN' NOTE:*** DO NOT USE ESLINT AT ALL, IT WILL GIVE YOU A HELL</br>

### SETTING UP THE TAILWIND CSS
----
The tutorial uses Yarn but I use NPM, so I followed the documentation of Tailwind CSS</br>
Tailwind CSS Documentation: https://tailwindcss.com/docs/guides/vite#vue </br></br>

Just follow the documentation, input.css will be instructed to be made in recordstore-frontend/src and import this in main.js</br>

***NOTE:*** In the documentation, skip the part of #1 Create your project. Follow the documentation from #2</br>

recordstore-frontend/.postcssrc.js was added "tailwindcss"</br></br>

To watch the changes of tailwind in our component, run this command to your terminal: (make sure you are on recordstore-frontend)</br>
NPM Command
-------------------------------------------------|
npx tailwindcss-cli build -i ./src/input.css -o ./dist/output.css --watch|</br>

***Breakdown of the command:***
-i means "input", your input.css can be name however you want and it was located "src" folder</br>
-o means "input", it will be generated once the tailwind was setup to your project (finished following the documentation of tailwind installation and it was located on "dist" folder and the file name is output.css)</br>

***NOTE:*** You may encounter a quite different command that looks like this:
NPM Command
-------------------------------------------------|
npx tailwindcss build -i ./src/input.css -o ./dist/output.css --watch|</br>

The problem is, it will generate a few hundred lines of code in output.css, where it should be a thousand lines. You must run the command where 'tailwindcss-cli' is present because that will generate the correct amount of lines for output.css</br></br>

***Source:*** https://stackoverflow.com/questions/70337770/tailwindcss-output-css-file-424-lines </br>

***Another note:*** (My apologies if there a lot of fvckin' note)</br>
Sometimes, tailwind utility classes may not work even it was present in output.css, but try restarting your Vue app and see if the style of your component changes. If not, look for solution on the internet.</br>

### SETTING UP VUE-AXIOS
----
To install in run:
NPM Command
-------------------------------------------------|
npm install --save axios vue-axios|</br>

Documentation for setting up Vue-axios: https://www.npmjs.com/package/vue-axios </br>

Then import vue-axios to main.js </br>

In recordstore-frontend/src backend/axios/index.js was created. </br>

### CREATING VUE COMPONENTS
----
Start on adding new route to recordstore-frontend/src/router/index.js for Signin.vue. </br>
Signup.vue and Header.vue was created.</br>

### IT's DEBUGGING TIME!
----
***NOTE:*** The final video was rubbish, read the comments on the final video and look for some helpful comments</br>
I know this is bullshit, so I'll be writing this part of Readme so you won't spent lots of time trying to debug and run it.</br>

1.) First thing I fix was recordstore-frontend/src/main.js.</br>
2.) Computer doesn't have redis but this application uses redis to store the JWT. Here is the following sources (in case you don't have redis too) that you can use to download Redis but note that I am a Windows 10 User so the source that I'll be giving might not relevant to you:</br>
Tutorial Guide:</br>
https://www.youtube.com/watch?v=6mtu_dFxm28 </br>
Where to download Redis:</br>
https://github.com/microsoftarchive/redis/releases </br>

***Note for #2:*** You don't have to follow the tutorial video until the end, the only thing you need to do is run the redis-server.exe then this app will work again.</br>

3.) You will try saving your first record, if an internal error was thrown go to records_controller.rb and find the if @record.save. Once you see it, remove ", location: @record" in "render json: @record, status: :created, location: @record"</br>

You can see the source code of the tutorial that we're following on this experiment right here:</br>
https://github.com/justalever/recordstore/blob/master/app/controllers/api/v1/records_controller.rb
