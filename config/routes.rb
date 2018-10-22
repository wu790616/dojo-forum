Rails.application.routes.draw do
  
  devise_for :users
  root "categories#index"

  namespace :admin do
    root "categories#index"
    resources :categories, only: [:index, :destroy, :create, :edit, :update]
    resources :users, only: [:edit, :update]
  end

  resources :posts do
    resources :replies, only: [:create]
    
    member do
      post :collect
      post :uncollect
      get :modify
      patch :modified
    end
  end

  resources :categories, only: [:index, :show] do
     get :feeds, :on => :collection
  end
  
  resources :users, only: [:show, :edit, :update]
  resources :replies, only: [:edit, :update, :destroy]


end
