Rails.application.routes.draw do
  resources :product_tags
  resources :product_colors
  resources :tags
  resources :colors
  resources :products
  resources :brands
  resources :product_types
  resources :categories

  root to: "home#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
