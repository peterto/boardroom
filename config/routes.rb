RubyStashboard::Application.routes.draw do
  resources :statuses
  resources :services do
    resources :events
  end

  get "services/new"
  match "/services/:id" => "services#show"
  root :to => "index#index"
end
