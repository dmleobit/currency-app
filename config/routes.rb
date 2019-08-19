require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :countings
  get 'sessions/create'
  get 'sessions/destroy'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  get 'sessions/login', to: 'sessions#login'
  root to: "countings#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
