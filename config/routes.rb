Nancy::Application.routes.draw do
  resources :customers do
    resources :locations do
      resources :contacts
    end
  end
  
  resources :projects do
    member do
      get 'switch'
    end
  end
  
  resources :contacts
  resources :locations
  
  root :to => "customers#index"
end