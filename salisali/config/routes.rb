Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  get     'login',   to: 'sessions#new'
  post    'login',   to: 'sessions#create'
  delete  'logout',  to: 'sessions#destroy'
  resources :users

  resources :orders
  
  resources :stocks

  resources :goods_masters
  
  root 'stocks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
