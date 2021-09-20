Rails.application.routes.draw do
  resources :users
  resources :pets, only: [:index, :show, :create, :destroy, :update] do
    resources :comments, only: [:index, :show, :create]
    resources :ratings, only: [:index, :show, :create]
  end

  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  post "/signup", to: "users#create"
  get "/me", to: "users#show"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
