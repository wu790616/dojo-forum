Rails.application.routes.draw do
  
  devise_for :users
  root "posts#index"

  namespace :admin do
    root "posts#index"
  end

end
