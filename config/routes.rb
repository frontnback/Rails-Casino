Rails.application.routes.draw do
  get 'search/index'

  get 'friends/index'

  get 'friends/destroy'

  resources :friend_requests
  root 'home#index'

  get '/register' => 'users#new'
  get 'home/hit' => 'home#hit'
  get 'home/stay' => 'home#stay'
  get 'home/index' => 'home#index'
  get '/login' => 'sessions#new'
  get '/users/leaderboard' => 'users#leaderboard'
  get '/poker' => 'poker#index'
  get '/search' => 'search#index'

  post '/register' => 'users#create'
  post '/login' => 'sessions#create'
  post 'home/wager' => 'home#wager'

  delete '/logout' => 'sessions#destroy'

  mount ActionCable.server, at: '/cable'

  resources :messages
  resources :users do
    member do
      get :confirm_email
    end
  end
end
