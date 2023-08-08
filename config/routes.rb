Rails.application.routes.draw do
  root "groups#index"

  resources :users do
    resources :groups
    resources :operations
  end
end
