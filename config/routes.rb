Rails.application.routes.draw do
  root 'parkings#index'

  resources :parkings
  resources :cars
  resources :place_rents
end
