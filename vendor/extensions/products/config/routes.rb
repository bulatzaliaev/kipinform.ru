Refinery::Core::Engine.routes.append do
namespace :products do
  resources :products, :only => [:set_session_product] do
      get :set_session_product, :on => :member
    
   end
  end
  # Frontend routes
  namespace :products do
    resources :products, :path => '', :only => [:index, :show]
  #    post '/set_session_product', to: 'products#set_session_product'
 # end
end


#  match '/set_session_product(/:id)', to: 'products/products#set_session_product'




#match '/products/set_session_product(/:id)', :controller=>'products/products', :action => 'set_session_product'
#end
#resources :products do
  #collection do
  #   match '/set_session_product', to: 'products/products#set_session_product', :as => :set_session_product
  #  end
 # end
#match 'refinery/products/:id/set_session_product', to: 'products/products#set_session_product', :via => :post, :locale=>:en, :as => :set_session_product

  # Admin routes
  namespace :products, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :products, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
