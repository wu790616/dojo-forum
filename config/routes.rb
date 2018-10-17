Rails.application.routes.draw do
  
  devise_for :users
  root "posts#index"

  namespace :admin do
    root "posts#index"
  end

  resources :posts do
    resources :replies, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update]

end
