Rails.application.routes.draw do
  
  devise_for :users
  root "categories#index"

  namespace :admin do
    root "categories#index"
    resources :categories, only: [:index, :destroy]
  end

  resources :posts do
    resources :replies, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update]
  resources :categories, only: [:index]

end
