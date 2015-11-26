class StoresController < ApplicationController

	def index

	end

	def search
		@store_id = params["store_id"]
		@filter_range = params["range"] || "anytime"
		@filter_experience = params["experience"]
		@store = Store.find(@store_id)

		if @store == "error"
			redirect_to root_path
		else
			# if @filter_range == "today"
			# 	@store = Store.filter_by_date("today", @store)
			# elsif @filter_range == "yesterday"
			# 	@store = Store.filter_by_date("yesterday", @store)
			# end
			redirect_to store_path(@store.name)
		end
		
	end

	def show
		@store = Store.find(params[:id])
		@experiences = @store.experiences
		@experiences = @store.yesterdays_experiences if params[:filter] == "yesterday"
		@experiences = @store.todays_experiences if params[:filter] == "today"
	end

end
