class RankingController < ApplicationController

	def index
    @stores = Store.ranked_by_percentage
	end

end
