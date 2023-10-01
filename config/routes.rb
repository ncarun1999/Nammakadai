Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :onboarding do
    get  'steps/:step',  to: 'wizard#show', as: 'step'
    post 'steps/:step',  to: 'wizard#update'
  end
end
