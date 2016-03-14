Rails.application.routes.draw do

  devise_for :users, :controllers => {:sessions => "devise/sessions", :registrations => "registrations"}
  resources :users, :only => [:show]

  root to: 'welcome#welcome'

  get 'map' => 'maps#map', :as => 'map'
  get 'graph_test' => 'maps#graph_test'
  get 'map_test' => 'maps#map_test'
  get 'about' => 'maps#about'
  get 'get_fuel_data' => 'maps#get_fuel_data'
  get 'map_stations' => 'maps#stations'
  get 'map_location' => 'maps#location'

  post 'notify' => 'twilio#notify'

  get "/.well-known/acme-challenge/#{ENV['LE_AUTH_REQUEST']}", to: 'welcome#letsencrypt'

end
