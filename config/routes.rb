Gik::Application.routes.draw do


  devise_for :users, :controllers => {:sessions => :sessions, :registrations => :registrations, :confirmations => :confirmations, :passwords => :passwords}

  scope '/users/:user_id' do
    resource :profile do
      get 'reviews'
      get 'services'
      post 'cancel_service'
      get 'account'
      put 'account'
    end
    resources :messages, :except => [:new, :create]
  end

  match 'offer_virtual' => 'home#offer_virtual', :as => :offer_virtual, :method => :post
  get "about_us" => 'home#about_us'
  get "faq" => "home#faq"
  get "privacy_policy" => "home#privacy_policy"
  get "contact_us" => "home#contact_us"
  get "how_it_works" => "home#how_it_works"
  get "np_terms_of_use" => "home#np_terms_of_use"
  get "user_terms_of_use" => "home#user_terms_of_use"

  match 'service/search' => 'services#search'
  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => 'home#index'
  match '/nonprofits/:id/change_password' => 'nonprofits#change_password'
  match '/messages/new' => 'messages#new', :as => :new_message
  match '/messages' => 'messages#create', :as => :create_message, :via => :post


  resources :dashboard 
  
  resources :nonprofits do
    collection do
      get :login, :logout, :reset_password, :search_nonprofit
      post :create_session, :search, :update_password
      match :forgot_password
      match :forgot_username
    end
    member do
      match :account
      post :change_password
      get :transactions
    end
  end

  resources :authentications

  resources :services do
    collection do
      get :autocomplete_nonprofit_name, :thankyou, :browse_nonprofit
      post :review, :newoffer, :send_invitation
    end
    resources :bookings, :only => [:new, :create, :destroy]
  end

  resources :requests

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

  root :to => "home#index"
end
