Rails.application.routes.draw do
  devise_for :users

  root "groups#index"

  resources :users do
    resources :groups
    resources :operations
  end

  resources :groups do
    resources :operations
  end

  resources :operations
end
