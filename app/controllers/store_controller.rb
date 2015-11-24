class StoreController < ApplicationController

	def index

	end

	def store
		@store_id = params["store_id"]
		@filter_range = params["range"] || "anytime"
		@filter_experience = params["experience"]
		@store = Store.get(@store_id).body

		if @store
			@good_experiences = Store.get_by_experience(@store, "good")
			@bad_experiences = Store.get_by_experience(@store, "bad")
		end

		if @filter_experience == "good"
			@store = @good_experiences
		elsif @filter_experience == "bad"
			@store = @bad_experiences
		end

		if @filter_range == "today"
			@store = Store.filter_by_date("today", @store)
		elsif @filter_range == "yesterday"
			@store = Store.filter_by_date("yesterday", @store)
		end

		render "store/index"
	end

end
