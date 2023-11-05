Rails.application.routes.draw do
  resources :user_stocks, only: [:create]
  devise_for :users
  root 'pages#homepage'
  get 'pages/homepage'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
end
