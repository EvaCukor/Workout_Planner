Rails.application.routes.draw do
  root to: 'users#new'
  
  post '/', to: 'users#create'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  get '/exercises', to: 'users#exercises', as: 'users_exercises'
  get '/workouts', to: 'users#workouts', as: 'users_workouts'
  
  resources :users, only: [:show]
  resources :exercises, except: [:index] do
    member do
      post 'vote'
    end
  end
  resources :workouts, except: [:index] do
    member do
      post 'vote'
    end
  end
  resources :equipment_pieces, only: [:index, :new, :create, :show]
  resources :categories, only: [:index, :new, :create, :show]
  
  get "/:username", to: 'users#homepage', as: 'user_homepage'
end
