SocialMediaLeague::Application.routes.draw do
  root 'welcome#index'
  resources :teams
  resources :users, only: [:show, :index] do
    resources :pages, only: [:show, :index]
    resources :posts, only: [:show, :index]
    resources :behaviors, only: [:show, :index]
  end

match '/login', to: 'sessions#login', as: :login, via: 'get'
match '/auth_step', to: 'sessions#auth_step', as: :auth_step, via: 'get'



end
