Rails.application.routes.draw do
  get "customers/index"

  get "customers/zomg" => "customers#zomg"
  resources "customers"

  # get "movies/index"
  resources :movies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "rentals/check-out", to: "rentals#check_out", as: "check_out"
  post "rentals/check_in", to: "rentals#check_in", as: "check_in"
end
