Rails.application.routes.draw do
  resources :users, only: [:shoe, :new, :create]
  get '/login',       to: 'sessions#new'
  post '/login',      to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'
  get '/links/*slug', to: 'smartlinks#redirect'
end
