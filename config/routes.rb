Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :books do 
    post :reserve, on: :member
  end
  resources :reservations

  devise_for :users

  resources :company_reservations, only: [:index], path: 'company-reservations'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # Defines the root path route ("/")
  root "books#index"
end
