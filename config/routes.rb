MyPodcasts::Application.routes.draw do
  root to: 'pages#index'

  get 'auth/:provider/callback', to: 'sessions#create'
end
