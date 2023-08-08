Rails.application.routes.draw do
  devise_for :users

  root "groups#index"

  resources :users do
    resources :groups
    resources :operations
  end
end
