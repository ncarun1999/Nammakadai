require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users

  namespace :onboarding do
    get 'steps/:step', to: 'wizard#show'
    post 'steps/:step', to: 'wizard#update'
  end

  authenticate :user, ->(u) { u.super_admin? } do
    ActiveAdmin.routes(self)
    namespace :admin do
      mount Sidekiq::Web, at: '/sidekiq'
      mount Flipper::UI.app(Flipper) => '/flipper'
    end
  end

  root 'dashboard#show'
end
