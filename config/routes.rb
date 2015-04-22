Rails.application.routes.draw do
  root to: 'users#new'
  post '/', to: 'users#create'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  get "/:username", to: 'users#show', as: 'user'
end
