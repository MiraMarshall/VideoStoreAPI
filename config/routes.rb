Rails.application.routes.draw do
  # get "customers/zomg" => "customers#zomg"
  resources :customers, only: [:index, :show, :create]

  resources :movies, only: [:index, :show, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
