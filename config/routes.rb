Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'home#index'

  # resources :players
  # resources :offers
  # resources :offers_targets

  # For the api
  namespace :api do
    namespace :v1 do
      resources :players, only: [:index, :update]
      resources :offers
      resources :offers_targets
    end
  end

end
