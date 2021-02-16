Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events
  root "events#index"
  # [code lang=”rails” title=”config/routes.rb”]
  #   devise_scope :user do
  # root ''
  # get 'home/show'
  #   end
  # [/code]
end
