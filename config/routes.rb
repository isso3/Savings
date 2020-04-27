Rails.application.routes.draw do
  root to: 'top#top'
  devise_for :users

  resources :result, only: [:show, :new, :create, :edit]
  get "/:id/beginner", to: "result#beginner"
  post "/:id/beginner", to: "result#create_beginner"
  patch "/result", to: "result#update"
end
