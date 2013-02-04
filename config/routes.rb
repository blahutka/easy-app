EasyService::Application.routes.draw do





  # LOGGED USER ROUTES
  authenticated :user do
    root :to => 'customer/dashboard#index'
  end

  #  DEVISE DEFAULT REDIRECTION USER
  match 'customer/dashboard/index' => 'customer/dashboard#index', :as => 'user_root'

  namespace :customer do
    get 'dashboard/index'
    match '/' => 'dashboard#index'
    resources :service_requests
    resources :service_orders
    resource :account
    #resource :user do
    #  put :update_password
    #end
  end


  # ADMIN ROUTES
  namespace :admin do
    match 'dashboard/show' => 'dashboard#show'
    match '/' => 'dashboard#show'

    resources :service_requests
    resources :service_providers do
      match 'search', :via => [:get, :post], :on => :collection
      resources :provision_services do
        match 'search', :via => [:get, :post], :on => :collection
      end
      resources :service_orders do
        match 'search', :via => [:get, :post], :on => :collection
      end
    end
    resources :service_orders do
      match 'search', :via => [:get, :post], :on => :collection
    end
    resources :provision_services do
      match 'search', :via => [:get, :post], :on => :collection
    end
    resources :product_categories
    resources :product_brands


    resources :users do
      get :send_new_password, :on => :member
      resource :account
    end

  end

  # PUBLIC ROUTES
  scope :module => 'public' do
    resources :service_requests
    resources :product_categories, :only => [:show]
    root :to => 'home#index'
  end

  devise_for :users



end
