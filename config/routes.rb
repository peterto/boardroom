RubyStashboard::Application.routes.draw do
  devise_for :admins

  resources :statuses

  resources :services do
    resources :events
  end

  root :to => "index#index"
  match "/:service_name" => "index#show"
  
end
