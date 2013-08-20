YourWorld::Application.routes.draw do

  get 'sign_in', to: 'sessions#new', as: :sign_in
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'pages#home'

  resources :categories
  resources :checkins
  resources :users

end
