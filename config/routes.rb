Rails.application.routes.draw do
  devise_for :users

  namespace :onboarding do
    get  'steps/:step',  to: 'wizard#show', as: 'step'
    post 'steps/:step',  to: 'wizard#update'
  end

  root 'dashboard#show'
end
