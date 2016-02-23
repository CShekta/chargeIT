Rails.application.routes.draw do
  resources :users, :only => [:new, :create, :show]
  get 'signup' => 'users#new', :as => 'signup'

  resources :sessions, only: [:new, :create, :destroy]
  get 'login' => 'sessions#new', :as => 'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'
end
