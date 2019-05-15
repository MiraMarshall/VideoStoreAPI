Rails.application.routes.draw do
  get "customers/index"

  get "customers/zomg" => "customers#zomg"
  resources "customers"

  get "movies/index"
  resources :movies, only: [:index, :show, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
