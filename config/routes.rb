Rails.application.routes.draw do

  resources :labels
  namespace :admin do
    resources :users
  end

  # get 'sessions/new'
  root 'sessions#new'
  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
