Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :products, except: :destroy
  resources :orders, only: [:show, :new, :create, :edit]
  resources :coins, only: [:show, :new, :create, :edit]
  resources :inserted_coins, except: :destroy

  root 'products#index'

end
