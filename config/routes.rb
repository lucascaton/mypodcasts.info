MyPodcasts::Application.routes.draw do
  root to: 'pages#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :users, only: [:show]
  resources :podcasts, only: [:show, :new, :create]
  resources :subscriptions, only: [:create, :destroy]
end
