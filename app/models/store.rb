class Store < ActiveRecord::Base

	base_uri = 'https://customersatisfaction.firebaseio.com/'

	firebase = Firebase::Client.new(base_uri)

	scope :get, -> (store_id) do
		firebase.get("stores/" + (CGI.escape store_id))
	end

	def self.get_by_experience(experiences, rating)
		experiences.select { |_, experience| experience["experience"] == rating }
	end

	def self.filter_by_date(time, experiences)
		if time == "today"
			experiences_from_today(experiences)
		elsif time == "yesterday"
			experiences_from_yesterday(experiences)
		end
	end

	private

	def self.experiences_from_today(experiences)
		experiences.select {| _, experience| experience["time"].to_date.today? }
	end

	def self.experiences_from_yesterday(experiences)
		experiences.select do |_, experience|
			experience["time"].to_date.advance(:days => 1).today?
		end
	end

end
