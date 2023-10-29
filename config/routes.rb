require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  # extra routes
  get '/privacy_policy', to: 'home#privacy_policy'
  get '/terms_of_service', to: 'home#terms_of_service'

  # namespace
  namespace :onboarding do
    get 'steps/:step', to: 'wizard#show'
    post 'steps/:step', to: 'wizard#update'
  end

  # authenticate
  authenticate :user, ->(u) { u.super_admin? } do
    ActiveAdmin.routes(self)
    namespace :admin do
      mount Sidekiq::Web, at: '/sidekiq'
      mount Flipper::UI.app(Flipper) => '/flipper'
    end
  end

  # resource
  resources :products

  root 'dashboard#show'
end
