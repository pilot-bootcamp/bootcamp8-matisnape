Rails.application.routes.draw do
  root 'parkings#index'

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'register'  => 'accounts#new'
  post   '/auth/:provider/callback' => 'sessions#create'
  post   '/auth/failure' => 'sessions#failure'

  resources :parkings do
    resources :place_rents, only: [:new, :create]
  end
  resources :place_rents, only: [:index, :show]
  resources :cars
  resources :accounts, except: [:show, :index]
end
