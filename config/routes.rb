Rails.application.routes.draw do
  root "posts#index"
  
  devise_for :users,
    controllers: { sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords" },
    path: "/",
    path_names: { sign_in: "login", sign_out: "logout", sign_up: "signup", password: "reset" }

  devise_scope :user do
    get "reset", to: "users/passwords#new", as: "reset_password"
    get "change", to: "users/passwords#edit", as: "change_password"
  end
  
  resource :follow, only: %i[ create destroy ]
  resources :posts
  
  #####

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
