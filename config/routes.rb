Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  # Home page (landing page)
  get 'home', to: 'home#index'
  
  # Dashboard
  get 'dashboard', to: 'dashboard#index'
  
  # Allies management
  resources :allies
  
  # Point transactions
  resources :point_transactions do
    member do
      patch :claim
    end
  end

  # Tasks
  resources :tasks do
    member do
      patch :accept
      patch :complete
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
end
