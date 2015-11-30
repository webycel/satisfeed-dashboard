Rails.application.routes.draw do

  root 'stores#index'

  get 'search' => 'stores#search', as: :search
  get 'store_performance' => 'store_performance#index', as: :store_performance
  get 'ranking' => 'ranking#index', as: :ranking
  resources :stores, only: [:index, :show]
 
end
