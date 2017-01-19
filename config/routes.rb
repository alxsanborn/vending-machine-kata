Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :products, except: [:destroy, :edit, :update]
  resources :orders, only: [:show, :new, :create]
  resources :coins, only: [:show, :new, :create]
  resources :inserted_coins, except: :destroy
  resources :sessions, only: [:new, :create]

  root 'products#index'

  end
