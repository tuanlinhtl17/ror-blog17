Rails.application.routes.draw do
  root "static_pages#home"

  get "signup"      => "users#new"
  get "login"       => "sessions#new"
  post "login"      => "sessions#create"
  delete "logout"   => "sessions#destroy"
  get "newpost"     => "posts#new"
  post "newpost"    => "posts#create"
  post "comments"   => "comments#create"

  resources :posts
  resources :users
  resources :comments,  only: [:create, :destroy]
  resources :tags,      only: [:create, :destroy]
end
