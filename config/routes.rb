Rails.application.routes.draw do
  
  root "posts#index"

  namespace :admin do
    root "posts#index"
  end

end
