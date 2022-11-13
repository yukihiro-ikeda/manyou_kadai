Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
end
