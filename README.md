# Ruby on Rails (RoR) + Vue JS Experiment
Tutorial Source: https://www.youtube.com/watch?v=TBZwkWznhZs&list=PLQIWx2J-GIASpN2yzAtdwoxILS7qld1XJ&index=2
November 14, 2022

==================================================================================
>>> SETTING UP RAILS API
==================================================================================
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

NOTE: Something notable you can observe in the generated controller from scaffold. You can see the return statements are fixed in a way of how API would work, return data in JSON format