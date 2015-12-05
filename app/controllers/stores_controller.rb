class StoresController < ApplicationController

	def index
	end

	def search
		@store = Store.find(params["store_id"])
		if @store == "error"
			redirect_to root_path, flash: {error: 'Sorry, couldn\'t find any data with this Store name.'}
		else
			redirect_to store_path(@store.name)
		end
	end

	def show
		@store = Store.find(params[:id])
		@filter_quality = params[:quality] || nil
		@filter_range = params[:range] || nil
		respond_to do |format|
	    format.html do
	    	@experiences = @store.filter_experiences(@filter_quality, @filter_range)
	    end
	    format.csv do
	    	@experiences = @store.filter_experiences
	      headers['Content-Disposition'] = "attachment; filename=\"#{@store.name.capitalize}_reviews_#{Time.now}.csv\""
	      headers['Content-Type'] ||= 'text/csv'
	    end
	  end
	end

end
