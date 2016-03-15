Rails.application.routes.draw do

  # get '/auth/:provider/callback', to: 'sessions#create_omniauth'
  devise_for :users, controllers: { sessions: "sessions" }
  as :user do
    get 'auth/:provider/callback', to: 'sessions#create_omniauth'
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :users, only: []

  resources :user_tag_categories, only: [:create]
  resources :reported_status_updates, only: [:create]

  resources :tag_categories
  resources :tags do
    collection do
      get :search
    end
    resources :messages
  end

  root to: 'home#index'

end
