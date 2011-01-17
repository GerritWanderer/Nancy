Nancy::Application.routes.draw do
  resources :works
  resources :customers do
    resources :locations do
      resources :contacts
    end
  end
  resources :projects do
    member do
      get 'switch'
      get 'report'
    end
  end
  
  root :to => "works#index"
end