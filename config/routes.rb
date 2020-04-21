Rails.application.routes.draw do
  devise_for :users

  root to: 'top#top'
  resources :result, only: [:index, :new, :create]
  get "/beginner", to: "result#beginner"
  post "/beginner", to: "result#create_beginner"
end
