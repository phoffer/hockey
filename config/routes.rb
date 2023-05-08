Rails.application.routes.draw do
  resources :games, only: [:index, :show] do
    get :sync, on: :member
  end
  resources :players # TODO
  resources :teams # TODO
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "games#index"
end
