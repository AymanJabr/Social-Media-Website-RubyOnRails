Rails.application.routes.draw do

  root 'posts#index'

  resources :friendships, only: [:destroy]

  devise_for :users

  resources :users, only: [:index, :show] do
    resources :friendships, only: [:create, :approve, :destroy]
    get '/approve_friendships', to: 'friendships#approve'
  end

  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

end
