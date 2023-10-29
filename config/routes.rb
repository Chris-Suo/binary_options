Rails.application.routes.draw do
  # devise_for :users

  devise_for :users, path_names: {
    sign_in: "login",
    sign_out: "logout",
    password: "secret",
    unlock: "unblock",
    sign_up: "register",
    registration: "management",
    edit: "edit/profile"
  }

  resources :users do
    get :quota, on: :member
    post :add_quota, on: :member
    post :reset_password, on: :member
    get :trials, on: :member
    post :toggle_active, on: :member
  end

  constraints format: :json do
    get "sync", to: "home#sync"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post "switch_machine/:slug", to: "machines#switch", as: "switch_machine"
  get "sync_machine/:slug", to: "machines#sync", as: "sync_machine"
  get "machine/:slug", to: "machines#show", as: "machine"
  get "machines", to: "machines#index", as: "machines"
  patch "machine/:id", to: "machines#update", as: "update_machine"
  get "show_exams/:slug", to: "machines#show_exams", as: "show_exams"
  post "machine/:slug/create_trial", to: "machines#create_trial", as: "create_trial"

  # Defines the root path route ("/")
  root "home#index"
end
