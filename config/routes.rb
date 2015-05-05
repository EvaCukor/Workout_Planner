Rails.application.routes.draw do
  root to: 'users#new'
  
  post '/', to: 'users#create'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  resources :exercises
  resources :equipment_pieces, only: [:index, :new, :create, :show]
  resources :categories, only: [:index, :new, :create, :show]
  
  get "/:username", to: 'users#show', as: 'user'
end
