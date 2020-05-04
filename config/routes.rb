Rails.application.routes.draw do
  devise_for :users

  get "/", to: 'top#top'
  resources :result, only: [:show, :new, :create, :edit]
  patch "/result", to: "result#update"
  patch "/:id/beginner", to: "result#create_beginner"
  get "/:id/beginner", to: "result#beginner"
  post "/:id/beginner", to: "result#create_beginner"
end
