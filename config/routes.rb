# encoding: utf-8
Kippribor::Application.routes.draw do
  resources :categories, :controller => 'categories'
  match '/alphabet', to: 'categories#alphabet'
  match 'set(/:id)', to: 'categories#set_session'
  match '/finish', to: 'categories#send_order'
  match '/clear', to: 'categories#delete_order'
  match '/search', to: 'search#prodsearch'
  get '/category/set_hidden_session', :to => 'categories#set_hidden_session'
  get '/deletesessionitem', to: 'categories#delete_from_session'
  get 'admin', :to => redirect('/refinery')
  #match 'refinery/products/set_session_product(/:id)', to: 'refinery/products/products#set_session_product'
=begin
  resources :products do
    member do
      post '/set_session_product', to: 'products/products#set_session_product'
    end
  end
=end
  # This line mounts Refinery's routes at the root of your application.
  # This means, any requests to the root URL of your application will go to Refinery::PagesController#home.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Refinery relies on it being the default of "refinery"
  mount Refinery::Core::Engine, :at => '/'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  #match '/categories', to: 'categories#index'
  
  
  #match '/alphabet', to: 'categories#alphabet'
  # Sample of named route:
  #  match 'products/:id/' => 'product#show', :as => :product
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
     #resources :products
     #resources :categories, :controller => 'categories'

  # Sample resource route with options:
   #  resources :categories do
    #   collection do
     #   get 'alphabet'
    #  end
    #end
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
  root :to => 'pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
