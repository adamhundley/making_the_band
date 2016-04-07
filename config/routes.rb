Rails.application.routes.draw do

  root 'home#index'


  resources :artists, only: [:index,:show], param: :artist_name

  get '/auth/facebook', as: :facebook_login
  get '/auth/facebook/callback', to: 'sessions#create'
  delete "/logout", to: "sessions#destroy"
  get "/locations", to: "locations#index"
end
