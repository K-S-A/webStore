Rails.application.routes.draw do
  devise_for :users
  root 'application#main'

  resources :products, only: [:show, :index] do
    get 'search', on: :collection
  end

  resources :users do
    post 'fetch_by_inn', on: :collection
  end

  resources :orders, only: [:index, :show, :create]
end
