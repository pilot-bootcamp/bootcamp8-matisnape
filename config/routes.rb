Rails.application.routes.draw do
  root 'parkings#index'

  resources :parkings
    resources :place_rents, only: [:index, :show, :new, :create]
  resources :cars
end
