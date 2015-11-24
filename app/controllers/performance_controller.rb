class PerformanceController < ApplicationController

	def index
		@stores = Performance.all_stores().body
		@filter = params["filter"] || "amount"

		@best_store = Performance.get_best_store(@stores, @filter, "good")
		@worst_store = Performance.get_best_store(@stores, @filter, "bad")
	end

end
