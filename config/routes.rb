Rails.application.routes.draw do
  resources :categories
  resources :discussions do
    resources :comments 
  end 
  resource :users, only: [:create]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
end
