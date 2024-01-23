Rails.application.routes.draw do
  resources :categories
  resources :discussions do
    resources :comments 
  end 
  resource :registration
  resource :session
end
