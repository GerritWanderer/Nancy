Nancy::Application.routes.draw do
  get "settings/index", :as => :settings
	get "settings/user", :as => :user_settings
	get "settings/holiday", :as => :holiday_settings
	
	resources :day_sequences, :controller => "settings/day_sequences"
	resources :user_admin, :controller => "settings/user"
	
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
  
  root :to => "works#index"
end