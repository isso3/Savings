Rails.application.routes.draw do
  devise_for :users

  root to: 'top#top'
  resources :result, only: [:show, :new, :create, :edit]
  get "/:id/beginner", to: "result#beginner"
  post "/:id/beginner", to: "result#create_beginner"
  patch "/result", to: "result#update"
end
