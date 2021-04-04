Rails.application.routes.draw do
  devise_for :users
  root to: 'meetings#index'
  resources :meetings
  resources :profiles, only: [:show, :new, :create]
end
