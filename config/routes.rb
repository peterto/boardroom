RubyStashboard::Application.routes.draw do
  resources :statuses

  resources :services do
    resources :events
  end

  root :to => "index#index"
end