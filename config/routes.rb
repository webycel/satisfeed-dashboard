Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'dashboard#index'

  get 'store' => 'dashboard#store', as: :store
  get 'performance' => 'performance#index', as: :performance
  get 'ranking' => 'ranking#index', as: :ranking

end
