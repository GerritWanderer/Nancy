Nancy::Application.routes.draw do
  get "home/index"

  namespace "settings" do
    resources :day_sequences, :controller => "day_sequences"
    resources :user_admin, :controller => "user"
  end

  devise_for :users, :skip => [:registration], :controllers => { :sessions => "sessions" } do
      get '/login' => 'sessions#new', :as => :new_user_session
      post '/login' => 'sessions#create', :as => :user_session
      get '/registration' => 'devise/registrations#new', :as => :new_user_registration
      post '/registration' => 'devise/registrations#create', :as => :user_registration
      put '/registration' => 'devise/registrations#update'
      get '/profile' => 'devise/registrations#edit', :as => :edit_user_registration
      put '/profile' => 'devise/registrations#update', :as => :update_user_registration
      get '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    end
  
  resources :works do
    collection do
      post 'switch_customer'
    end
  end
  resources :customers do
    collection do
      get 'first'
    end
    resources :locations, :controller => "customers/locations" do
      resources :contacts, :controller => "customers/contacts"
    end
  end
  resources :projects do
    member do
      get 'switch'
      get 'report'
    end
  end
  
  root :to => "home#index"
end