Rails.application.routes.draw do
  devise_for :users
  root to: 'meetings#index'
  resources :meetings do
    resources :access_permits, only: [:index, :create]
  end
  resources :profiles, only: [:show, :new, :create, :edit, :update]
end
