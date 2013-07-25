class SearchController < ApplicationController
	def prodsearch
		@my_search_results = Refinery::Products::Product.search(params[:query])
		#@my_search_results = Refinery::Products::Product.where(title: '%#{params[:query]}%')
		@query = params[:query]
		respond_to do |format|
      		format.html # prodsearch.html.erb
      		format.json { render json: @my_search_results }
    	end
	end
end
