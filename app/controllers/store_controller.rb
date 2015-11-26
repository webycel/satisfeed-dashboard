class StoreController < ApplicationController

	def index

	end

	def search
		@store_id = params["store_id"]
		@filter_range = params["range"] || "anytime"
		@filter_experience = params["experience"]
		@store = Store.find(@store_id)

		if @filter_range == "today"
			@store = Store.filter_by_date("today", @store)
		elsif @filter_range == "yesterday"
			@store = Store.filter_by_date("yesterday", @store)
		end

		render "store/index"
	end

	def show
		@store = Store.find(@store_id)
		render :show
	end

end
