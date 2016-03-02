Rails.application.routes.draw do
  root 'parkings#index'

  resources :parkings do
    resources :place_rents, only: [:new, :create]
  end
  resources :place_rents, only: [:index, :show]
  resources :cars
  resource :session
end
