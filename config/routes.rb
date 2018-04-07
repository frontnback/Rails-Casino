Rails.application.routes.draw do
  get 'search/index'

  resources :friend_requests
  root 'home#index'

  get '/register' => 'users#new'
  get 'home/hit' => 'home#hit'
  get 'home/stay' => 'home#stay'
  get 'home/index' => 'home#index'
  get '/login' => 'sessions#new'
  get '/users/leaderboard' => 'users#leaderboard'
  get '/users/online' => 'users#online'
  get '/poker' => 'poker#index'
  get '/search' => 'search#index'
  get '/friends' => 'friends#index'
  get '/friends/destroy'

  post '/register' => 'users#create'
  post '/login' => 'sessions#create'
  post 'home/wager' => 'home#wager'
  post '/friends/request' => 'friends#request'

  delete '/logout' => 'sessions#destroy'

  resources :messages
  resources :users do
    member do
      get :confirm_email
    end
  end

  mount ActionCable.server, at: '/cable'
end
