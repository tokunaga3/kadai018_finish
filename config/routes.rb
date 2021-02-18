Rails.application.routes.draw do
  devise_for :users
  root "events#index"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :events
  # resources :participats, only: [:update]
  resources :relationships, only: [:create, :destroy]
end
