Rails.application.routes.draw do
  devise_for :users

  root to: 'top#top'
  resources :result, only: [:index]
end
