RubyStashboard::Application.routes.draw do
  resources :events
  resources :statuses
  resources :services

  root :to => "index#index"
end
