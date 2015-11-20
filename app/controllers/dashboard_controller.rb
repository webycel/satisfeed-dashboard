class DashboardController < ApplicationController

	def index

	end

	def store
		@store_id = params["store_id"]
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

		render "dashboard/index"
	end

end
