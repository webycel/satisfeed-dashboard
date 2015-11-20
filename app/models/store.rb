class Store < ActiveRecord::Base

	base_uri = 'https://customersatisfaction.firebaseio.com/'

	firebase = Firebase::Client.new(base_uri)

	scope :get, -> (store_id) do
		firebase.get("stores/" + store_id)
	end

	def self.get_by_experience experiences, rating
		filtered_list = Array.new
		experiences.select { |k,experience| experience["experience"] == rating  }
	end

end
