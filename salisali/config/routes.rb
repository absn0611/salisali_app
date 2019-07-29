Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  get     'login',   to: 'sessions#new'
  post    'login',   to: 'sessions#create'
  delete  'logout',  to: 'sessions#destroy'
  resources :users do
    resources :orders
  end
  resources :stocks
  root 'stocks#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
