Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  devise_for :users
  root 'pages#homepage'
  get 'pages/homepage'
  get 'portfolio', to: 'users#portfolio'
  get 'friends', to: 'users#friends'
  get 'search_stock', to: 'stocks#search'
end
