YourWorld::Application.routes.draw do

  get 'sign_in', to: 'sessions#new', as: :sign_in
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'pages#home'

  resources :categories

  get '/checkin/past', to: 'checkins#past', as: :past_checkin
  get '/checkins/search/:location', to: 'checkins#search', as: :search_checkins
  
  resources :checkins

  resources :users

end
