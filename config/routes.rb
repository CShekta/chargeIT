Rails.application.routes.draw do
  resources :users, :only => [:create, :show]
  get 'signup' => 'users#new', :as => 'signup'

  resources :sessions, only: [:new, :create]
  get 'login' => 'sessions#new', :as => 'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'

  get 'map' => 'maps#map', :as => 'map'
end
