Nancy::Application.routes.draw do
  resources :contacts
  resources :locations
  resources :customers do
    resources :locations do
      resources :contacts
    end
  end
  
  root :to => "customers#index"
end