Nancy::Application.routes.draw do
  devise_for :users, :skip => [:registration, :sessions] do
    get '/login' => 'devise/sessions#new', :as => :new_user_session
    post '/login' => 'devise/sessions#create', :as => :user_session
    get '/registration' => 'devise/registrations#new', :as => :new_user_registration
    post '/registration' => 'devise/registrations#create', :as => :user_registration
    put '/registration' => 'devise/registrations#update'
    get '/profile' => 'devise/registrations#edit', :as => :edit_user_registration
    put '/profile' => 'devise/registrations#update', :as => :update_user_registration
    get '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  
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