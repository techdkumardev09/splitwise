Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "dashboard#index"

  resources :expenses, only: :create
  resources :users, only: :index do
    post :add_participant, on: :collection
  end
  resources :friends, only: :show
end
