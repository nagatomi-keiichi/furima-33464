Rails.application.routes.draw do
  devise_for :users
  resources :items
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items do
    resources :orders, only: [:index,:create]
  end
  root "items#index"
end
