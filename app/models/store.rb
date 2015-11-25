class Store

	base_uri = 'https://customersatisfaction.firebaseio.com/'

	attr_accessor :name
  attr_accessor :experiences

  ### INSTANCE METHODS
	def self.show(store_id)
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

	### CLASS METHODS
	def good_experiences
		experiences.select(&:good_experience?).count / experiences.count
	end

	def bad_experiences
		experiences.select(&:bad_experience?).count / experiences.count
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

	def firebase
		@firebase ||= Firebase::Client.new(base_uri)
	end

end
