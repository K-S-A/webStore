Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'application#main'

  resources :products, only: [:show, :index] do
    get 'search', on: :collection
  end

  resources :users do
    post 'fetch_by_inn', on: :collection
  end

  resources :orders, only: [:index, :show, :create] do
    resources :order_mailers, only: [:create]
  end

  resources :categories, only: [:index, :show]
end
