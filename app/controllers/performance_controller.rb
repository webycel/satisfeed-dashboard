class PerformanceController < ApplicationController

	def index
		@stores = Performance.stores.body
		@filter = params["filter"] || "amount"
		@best_store = Performance.get_best_store(@filter)
		@worst_store = Performance.get_worst_store(@filter)
	end

end
