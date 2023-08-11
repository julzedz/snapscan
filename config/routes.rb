Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  root "users#index"
  resources :users, only: %i[index]

  resources :groups, only: %i[index new create show destroy update] do
    resources :operations, only: %i[index new create destroy update]
  end
end
