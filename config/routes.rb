YourWorld::Application.routes.draw do

  resources :people
  resources :categories
  resources :checkins
  resources :users

  get 'sign_in', to: 'sessions#new', as: :sign_in
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'pages#home'

  get '/checkin/past', to: 'checkins#past', as: :past_checkin

  get 'search/people', to: 'people#search'
  get 'search/location', to: 'checkins#search'
  get 'search/category', to: 'categories#search'


end
