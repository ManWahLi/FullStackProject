Rails.application.routes.draw do
  get 'customers/index'
  get 'customers/update'
  devise_for :customers
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "contacts/index"
  get "abouts/index"
  root to: "home#index"
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
  # /checkout/create something
  scope "/checkout" do
    post "create", to: "checkout#create", as: "checkout_create"
    get "success", to: "checkout#success", as: "checkout_success"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
