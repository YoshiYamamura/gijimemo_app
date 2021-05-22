Rails.application.routes.draw do
  devise_for :users
  root to: 'meetings#index'
  resources :meetings do
    resources :access_permits, only: [:index, :create]
    resources :reactions, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  resources :transcripts, only: [:new, :create, :show, :destroy]
  resources :text_detections, only: [:new, :create, :show, :destroy]
  resources :profiles, only: [:show, :new, :create, :edit, :update]
end
