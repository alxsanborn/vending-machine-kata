Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders
  resources :products
  resources :coins
  resources :inserted_coins
end
