class StoresController < ApplicationController

	def index

	end

	def search
		@filter = params["filter"]
		@store = Store.find(params["store_id"])

		if @store == "error"
			redirect_to root_path, flash: {error: 'Sorry, couldn\'t find any data with this Store name.'}
		else
			redirect_to store_path(@store.name)
		end
		
	end

	def show
		@store = Store.find(params[:id])
		@filter_quality = params[:quality]
		@filter_range = params[:range]
		@experiences = @store.filter_experiences(@filter_quality, @filter_range)
	end

end
