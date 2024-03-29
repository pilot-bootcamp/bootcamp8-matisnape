Rails.application.routes.draw do
  root 'parkings#index'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'register'  => 'accounts#new'
  get   '/auth/:provider/callback' => 'sessions#create'
  get   '/auth/facebook' => 'sessions#create', as: 'facebook_login'
  get   '/auth/failure' => 'sessions#failure'

  resources :parkings do
    resources :place_rents, only: [:new, :create]
  end
  resources :place_rents, only: [:index, :show]
  resources :cars
  resources :accounts, except: [:show, :index]
end
