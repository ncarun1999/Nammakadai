require 'sidekiq/web'

Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users

  namespace :onboarding do
    get  'steps/:step',  to: 'wizard#show'
    post 'steps/:step',  to: 'wizard#update'
  end

  namespace :admin do
    authenticate :users, ->(u) { u.super_admin? } do
      mount Sidekiq::Web, at: '/sidekiq'
    end
  end

  root 'dashboard#show'
end
