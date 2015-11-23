class PerformanceController < ApplicationController

	def index
		@stores = Performance.allStores().body
		@filter = params["filter"] || "amount"

		@bestStore = Performance.getBestStore(@stores, @filter, "good")
		@worstStore = Performance.getBestStore(@stores, @filter, "bad")
	end

end
