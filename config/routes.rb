Rails.application.routes.draw do
  root 'parkings#index'

  resources :parkings
  resources :cars
end
