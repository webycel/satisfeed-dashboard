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

	def yesterdays_experiences
		experiences.select(&:from_yesterday?)
	end

	def yesterdays_good_experiences
		good_experiences.select(&:from_yesterday?)
	end

	def yesterdays_bad_experiences
		bad_experiences.select(&:from_yesterday?)
	end

	def todays_experiences
		experiences.select(&:from_today?)
	end

	def todays_good_experiences
		good_experiences.select(&:from_today?)
	end

	def todays_bad_experiences
		bad_experiences.select(&:from_today?)
	end

	def filter_experiences(quality="anytime", range="all")
		return experiences if quality != "anytime" && range != "all"
		quality_filter = quality == "anytime" ? nil : quality
		range_filter = range == "all" ? nil : range
		return send("#{quality_filter}_experiences") if !range 
		return send("#{range_filter}s_experiences") if !quality
		return send("#{range_filter}s_#{quality_filter}_experiences")
	end

end
