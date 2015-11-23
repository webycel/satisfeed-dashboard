class Store < ActiveRecord::Base

	base_uri = 'https://customersatisfaction.firebaseio.com/'

	firebase = Firebase::Client.new(base_uri)

	scope :get, -> (store_id) do
		firebase.get("stores/" + store_id)
	end

	def self.get_by_experience experiences, rating
		experiences.select { |key, experience| experience["experience"] == rating  }
	end

	def self.filter_by_date time, experiences
		if time == "today"
			experiences.select do |key, experience|
				experience["time"].to_date.today?
			end
		elsif time == "yesterday"
			experiences.select do |key, experience|
				experience["time"].to_date.advance(:days => 1).today?
			end
		end
	end

end
