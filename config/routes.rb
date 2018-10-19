Rails.application.routes.draw do
  
  devise_for :users
  root "categories#index"

  namespace :admin do
    root "categories#index"
    resources :categories, only: [:index, :destroy, :create, :edit, :update]
    resources :users, only: [:edit, :update]
  end

  resources :posts do
    resources :replies, only: [:create, :destroy]
  end

  resources :categories, only: [:index] do
     get :feeds, :on => :collection
  end
  
  resources :users, only: [:show, :edit, :update]
end
