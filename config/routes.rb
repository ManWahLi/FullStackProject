Rails.application.routes.draw do
  get 'checkout/create'
  get 'checkout/success'
  get 'checkout/cancel'
  get 'charges/new'
  get 'charges/create'
  get "carts/index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "contacts/index"
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
  resources :carts

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
