Rails.application.routes.draw do
  resources :tags
  resources :colors
  resources :products
  resources :brands
  resources :product_types
  resources :categories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
