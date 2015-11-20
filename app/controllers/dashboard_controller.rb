class DashboardController < ApplicationController

	def index

	end

	def store
		@store_id = params["store_id"]
		@store = Store.get(@store_id)

		if @store.body
			@good_experiences = Store.get_by_experience(@store.body, "good")
			@bad_experiences = Store.get_by_experience(@store.body, "bad")
		end

		render "dashboard/index"
	end

end
