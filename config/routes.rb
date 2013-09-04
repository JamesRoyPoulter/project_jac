YourWorld::Application.routes.draw do

  devise_for :users

  resources :people
  resources :categories
  resources :checkins

  root to: 'pages#home'

  get '/checkin/past', to: 'checkins#past', as: :past_checkin

  get 'search/People', to: 'people#search'
  get 'search/Location', to: 'checkins#search'
  get 'search/Categories', to: 'categories#search'


end
