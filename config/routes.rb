Rails.application.routes.draw do
  get 'search/index'

  root 'home#index'

  get '/register' => 'users#new'
  get 'home/hit' => 'home#hit'
  get 'home/stay' => 'home#stay'
  get 'home/index' => 'home#index'
  get '/login' => 'sessions#new'
  get '/users/leaderboard' => 'users#leaderboard'
  get '/users/online' => 'users#online'
  get '/poker' => 'poker#show'
  get '/new-game' => 'poker#create'
  get '/search' => 'search#index'
  get '/friends' => 'friends#index'
  get '/friends/destroy'
  get '/pvt-msg' => 'private_messages#index'
  get '/new-pvt-msg' => 'private_messages#new'

  post '/register' => 'users#create'
  post '/login' => 'sessions#create'
  post '/game-invite' => 'invitation#transmit'
  post 'home/wager' => 'home#wager'
  post '/friends/request' => 'friends#request'
  post '/accept-req' => 'friend_requests#accept'

  delete '/logout' => 'sessions#destroy'

  resources :friend_requests
  resources :messages
  resources :users do
    member do
      get :confirm_email
    end
  end

  mount ActionCable.server, at: '/cable'
end
