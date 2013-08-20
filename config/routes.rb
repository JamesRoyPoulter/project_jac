YourWorld::Application.routes.draw do
  
  get 'sign_in', to: 'sessions#create', as: :sign_in
  get 'sign_out', to: 'sessions#destroy', as: :sign_out

  root to: 'pages#home'

  resources :categories
  resources :checkins
  resources :users

end
