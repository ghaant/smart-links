Rails.application.routes.draw do
  resources :users, only: [:shoe, :new, :create]
  get '/login',       to: 'sessions#new'
  post '/login',      to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'
  resources :smartlinks, except: [:show, :edit, :update]
  get '/smartlinks/*slug', to: 'smartlinks#redirect', as: 'redirect'
end
