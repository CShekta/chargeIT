Rails.application.routes.draw do
  devise_for :users
  root to: 'maps#map'
  resources :users, :only => [:create, :show]
  get 'signup' => 'users#new', :as => 'signup'

  resources :sessions, only: [:new, :create]
  get 'login' => 'sessions#new', :as => 'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'

  get 'map' => 'maps#map', :as => 'map'
  get 'graph_test' => 'maps#graph_test'
  get 'map_test' => 'maps#map_test'
  get 'about' => 'maps#about'
  get 'get_fuel_data' => 'maps#get_fuel_data'
  get 'map_stations' => 'maps#stations'

  post 'notify' => 'twilio#notify'

  get "/.well-known/acme-challenge/#{ENV['LE_AUTH_REQUEST']}", to: 'welcome#letsencrypt'

end
