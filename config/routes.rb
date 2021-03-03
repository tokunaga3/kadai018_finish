Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  root "events#index"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :events
  resources :relationships, only: [:create, :destroy]
end
