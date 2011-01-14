Nancy::Application.routes.draw do
  resources :projects

  resources :contacts
  resources :locations
  resources :customers do
    resources :locations do
      resources :contacts
    end
  end
  
  root :to => "customers#index"
end