class PerformanceController < ApplicationController

	def index
		@stores = Performance.stores.body
		@filter = params["filter"] || "amount"
    @best_store = Object.const_get("#{@filter.capitalize}Performance").get_best_store
    @worst_store = Object.const_get("#{@filter.capitalize}Performance").get_worst_store
	end

end
