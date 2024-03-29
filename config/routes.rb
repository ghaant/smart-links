Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create] do
    get 'smartlinks', on: :member
  end
  get '/login',       to: 'sessions#new'
  post '/login',      to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'
  resources :smartlinks, except: [:show, :edit, :update]
  get '/smartlinks/*slug', to: 'smartlinks#redirect', as: 'redirect'
  get '/', to: redirect('/smartlinks')
end
