Refinery::PagesController.class_eval do
  
    before_filter :find_random_product, :only => [:home]
  
    protected
    
      def find_random_product
        @random_product = Refinery::Products::Product.random
        @random_product2 = Refinery::Products::Product.random
      end

  end