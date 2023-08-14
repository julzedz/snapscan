Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root to: 'groups#index', as: :authenticated_root
      get '/users/sign_out' => 'devise/sessions#destroy'
    end

    unauthenticated do
      root 'home#index'
    end
  end

  resources :groups do
    resources :operations
  end
end
