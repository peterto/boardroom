RubyStashboard::Application.routes.draw do
  resources :events
  resources :statuses
  resources :services
  get "services/new"
  match "/services/:id" => "services#show"
  root :to => "index#index"
end
