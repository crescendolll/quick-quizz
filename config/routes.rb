Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/profile', to: 'pages#profile'

  devise_scope :user do
    delete 'logout', to: 'devise/sessions#destroy', as: :logout
  end

  get '/settings', to: 'pages#settings', as: 'settings'
  get '/community', to: 'pages#community', as: 'community'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "pages#home"

  resources :quizzes, only: [ :index, :show, :new, :create, :edit, :destroy ] do
    resources :questions, only: [ :create ]
    resources :quiz_results, only: [ :new, :create ]
  end

  resources :questions, only: [ :show ] do
    resources :choices, only: [ :create ]
    resources :answers, only: [ :create ]
  end

  resources :quiz_results, only: [ :show ] do
    resources :recommendations, only: [ :new, :create, :show ]
  end
end
