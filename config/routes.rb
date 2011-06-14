Nancy::Application.routes.draw do
  scope "(:locale)", :locale => /en|de/ do
    namespace "settings" do
      resources :days, :controller => "days" do
        collection do
          get 'show_holidays'
          get 'show_user'
        end
      end
      resources :user_admin, :controller => "user"
      resources :configurations, :controller => "configurations" do
      end
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
        match ':date' => "works#index", :as => :date
      end
    end
    
    resources :customers do
      collection do
        get 'first' => 'customers#new_first_customer'
        post 'first' => 'customers#create_first_customer', :as => :create_first
      end
      resources :locations, :controller => "customers/locations" do
        resources :contacts, :controller => "customers/contacts"
      end
    end
    
    resources :projects do
      member do
        get 'switch'
        get 'report'
        match 'report/:started_at/:ended_at' => "projects#report", :as => :report_range
        get 'subscribe_user'
        post 'subscribe_user'
        delete 'unsubscribe_user'
      end
      resources :expenses, :controller => "projects/expenses"
      resources :invoices, :controller => "projects/invoices" do
        member do
          get 'switch'
        end
      end
      resources :status_messages, :controller => "projects/status_messages"
    end
    # match ':path' => 'static#show'
    resources :profiles
  end
  
  netzke
  get "home/index"
  root :to => "home#index"
end
