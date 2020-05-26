Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"

  root to: "static#home"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :trips, only: [:index]
      resources :posts, only: [:index]
    end
  end
end
