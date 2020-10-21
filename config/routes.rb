Rails.application.routes.draw do
  resources :product_routes, only: %i[index show create]
  resources :criteria_definitions
  resources :products

  root to: "product_routes#index"
end
