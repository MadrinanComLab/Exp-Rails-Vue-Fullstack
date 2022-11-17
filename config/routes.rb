Rails.application.routes.draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

    namespace :api do
        namespace :v1 do
            resources :records
            resources :artists
        end
    end

    root to: "home#index"

    # THE FOLLOWING DEFINED ROUTE WASN'T NORMAL FOR A RAILS APP BUT FOR THE SAKE OF API BASE APLLICATION AND VUE, THE TUTORIAL DOES THIS.
    post "refresh", controller: :refresh, action: :create
    post "signin", controller: :signin, action: :create
    post "signup", controller: :signup, action: :create
    delete "signin", controller: :signin, action: :destroy
end
