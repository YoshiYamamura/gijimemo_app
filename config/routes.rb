Rails.application.routes.draw do
  devise_for :users
  root to: 'meetings#index'
  resources :meetings do
    resources :access_permits, only: [:index, :create]
  end
  resources :transcripts, only: [:new, :create, :show, :destroy]
  resources :profiles, only: [:show, :new, :create, :edit, :update]
end
