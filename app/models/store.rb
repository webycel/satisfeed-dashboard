class Store

	@base_uri = 'https://customersatisfaction.firebaseio.com/'
	@firebase ||= Firebase::Client.new(@base_uri)

	attr_accessor :name
  attr_accessor :experiences
  attr_accessor	:stores

  ### INSTANCE METHODS
	def self.find(store_id)
		response = @firebase.get("stores/#{CGI.escape(store_id)}").body
		if !response.nil?
			@store = StoreParser.new.parse_store(store_id, @firebase.get("stores/#{CGI.escape(store_id)}").body)
		else
			@store = "error"
		end
		
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

	def self.ranked_by_percentage
		stores = StoresParser.parse(@firebase.get("stores").body)
		stores.sort_by{|store| store.good_percentage}.reverse
	end

	### CLASS METHODS
	def good_experiences
		experiences.select(&:good_experience?)
	end

	def bad_experiences
		experiences.select(&:bad_experience?)
	end

	def good_percentage
		(good_experiences.count.to_f / experiences.count).round(4) * 100
	end

	def bad_percentage
		(bad_experiences.count.to_f / experiences.count).round(4) * 100
	end

	def positive_ratings_difference
		good_experiences.count - bad_experiences.count
	end

	def negative_ratings_difference
		bad_experiences.count - good_experiences.count
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
