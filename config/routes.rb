Rails.application.routes.draw do
  root "static_pages#home"

  get "signup"      => "users#new"
  post "/"          => "sessions#create"
  delete "logout"   => "sessions#destroy"
  get "newpost"     => "posts#new"
  post "newpost"    => "posts#create"
  get "hotpost"     => "static_pages#hot"
  get "search"      => "static_pages#search"
  resources :posts
  resources :users do
    member do
      get :bookmarked
      get :following, :followers
    end
  end
  resources :comments,      only: [:create, :edit, :update, :destroy]
  resources :tags,          only: [:show, :create, :destroy]
  resources :bookmarks,     only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :likes,         only: [:create, :destroy]
end
