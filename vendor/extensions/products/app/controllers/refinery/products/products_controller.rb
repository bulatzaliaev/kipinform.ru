module Refinery
  module Products
    class ProductsController < ::ApplicationController

      before_filter :find_all_products
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @product in the line below:
        present(@page)
      end

      def show
        @product = Product.find(params[:id])
       # @category_title = Category.find(@product.category_id).title
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @product in the line below:
        present(@page)
      end
            
    protected

      def find_all_products
        @products = Product.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/products").first
      end

      
    end
  end
end
