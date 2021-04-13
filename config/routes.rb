Rails.application.routes.draw do
  devise_for :users
  root to: 'meetings#index'
  resources :meetings do
    resources :access_permits, only: [:index, :create]
    resources :reactions, only: [:create, :destroy]
  end
  resources :transcripts, only: [:new, :create, :show, :destroy]
  resources :profiles, only: [:show, :new, :create, :edit, :update]
end
