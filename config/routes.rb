Rails.application.routes.draw do
  root 'home#index'

  get '/register' => 'users#new'
  get 'home/hit' => 'home#hit'
  get 'home/stay' => 'home#stay'
  get 'home/index' => 'home#index'
  get '/login' => 'sessions#new'
  get '/users/leaderboard' => 'users#leaderboard'

  post '/register' => 'users#create'
  post '/login' => 'sessions#create'
  post 'home/wager' => 'home#wager'

  delete '/logout' => 'sessions#destroy'

  resources :users
end
