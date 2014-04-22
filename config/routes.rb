Rails.application.routes.draw do
  resources :deals, only: 'show'

  root to: 'home#index'
end
