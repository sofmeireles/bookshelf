Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :books do 
    post :reserve, on: :member
  end
  resources :reservations

  devise_for :users

  # Defines the root path route ("/")
  root "books#index"
end
