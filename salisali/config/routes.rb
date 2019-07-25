Rails.application.routes.draw do
  get 'stocks/index'
  get 'sessions/new'
  get 'users/new'
  get     'login',   to: 'sessions#new'
  post    'login',   to: 'sessions#create'
  delete  'logout',  to: 'sessions#destroy'
  resources :users
  post    'stocks',   to: 'stocks#show'
  get    'stocks',   to: 'stocks#show'
  post 'orders', to: 'orders#create'

  root 'stocks#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
