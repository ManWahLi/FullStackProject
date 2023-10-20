Rails.application.routes.draw do
  root to: "home#index"
  resources :abouts
  resources :tags
  resources :colors
  resources :products do
    collection do
      get "search"
    end
  end
  resources :brands
  resources :product_types
  resources :categories

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
