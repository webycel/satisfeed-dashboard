class DashboardController < ApplicationController

	def index

	end

	def store
		@store_id = params["store_id"]
		@store = Store.get(@store_id)

		render "dashboard/index"
	end

end
