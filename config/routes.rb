MyPodcasts::Application.routes.draw do
  root to: 'pages#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get '/:name' => 'users#show', as: :profile

  resources :users, only: [:show]
  resources :podcasts, only: [:show, :new, :create]
  resources :subscriptions, only: [:create, :update, :destroy]
end
