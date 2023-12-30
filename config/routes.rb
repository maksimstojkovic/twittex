Rails.application.routes.draw do
  root "posts#index"
  
  devise_for :users,
    controllers: { sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords" },
    path: "/",
    path_names: { sign_in: "login", sign_out: "logout", sign_up: "signup", password: "reset" },
    skip: :passwords

  devise_scope :user do
    get "forgot-password", to: "users/passwords#new", as: "new_user_password"
    get "reset", to: "users/passwords#edit", as: "edit_user_password"
    patch "reset", to: "users/passwords#update", as: "user_password"
    put "reset", to: "users/passwords#update", as: nil
    post "reset", to: "users/passwords#create", as: nil
  end

  resources :users, only: %i[ show index ]
  
  resources :posts, except: %i[ index ]
  resource :follow, only: %i[ create destroy ]
  resource :like, only: %i[ create destroy ]
  
  #####

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
