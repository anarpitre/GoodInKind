Gik::Application.routes.draw do

  match '/auth/:provider/callback' => 'authentications#create'
  match 'non_profit/register' => 'non_profit#register',:as => :register
  match '/auth/failure' => 'dashboard#index'
  match 'non_profit/register' => 'non_profit#register',:as => :register
  match 'non_profit/search' => 'non_profit#search',:as => :search
  match 'non_profit/show_searched' => 'non_profit#show_searched',:as => :show_searched
  match 'non_profit/login' => 'non_profit#login',:as => :login
  match 'non_profit/attempt_login' => 'non_profit#attempt_login',:as => :attempt_login
  match 'non_profit/change_password/:id' => 'non_profit#change_password',:as => :change_password
  match "/autocomplete" => "non_profit#autocomplete", :as => "autocomplete"
  match 'non_profit/charity' => 'non_profit#index'
  devise_for :users, :controllers => {:sessions => :sessions, :registrations => :registrations} 

  resources :users do
    get 'profile'
    post 'create_profile'
  end

  resources :authentications
  resources :services do
    get :autocomplete_non_profit_name, :on => :collection
  end




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

  match ':controller(/:action(/:id(.:format)))'

  root :to => "home#index"
end
