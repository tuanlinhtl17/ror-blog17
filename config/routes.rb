Rails.application.routes.draw do
  root "static_pages#home"

  get "signup"      => "users#new"
  get "login"       => "sessions#new"
  post "login"      => "sessions#create"
  delete "logout"   => "sessions#destroy"
  get "newpost"     => "posts#new"
  post "newpost"    => "posts#create"

  resources :posts
  resources :users
  resources :comments,  only: [:create, :edit, :update, :destroy]
  resources :tags,      only: [:show, :create, :destroy]
end
