class Store

	attr_accessor :name
  attr_accessor :experiences
  attr_accessor	:stores

	def self.firebase=(instance_of_firebase)
		@firebase = instance_of_firebase		
	end

	def self.firebase
		@firebase ||= Firebase::Client.new(ENV["FIREBASE_URL"])
	end

  ### INSTANCE METHODS
	def self.find(store_id)
		response = firebase.get("stores/#{CGI.escape(store_id)}").body
		unless response.nil?
			@store = StoreParser.new.parse_store(store_id, @firebase.get("stores/#{CGI.escape(store_id)}").body)
		else
			@store = "error"
		end
	end

	def self.stores
		stores ||= StoresParser.parse(firebase.get("stores").body)
	end

	def self.ranked_by_percentage
		stores.sort_by{|store| store.good_percentage}.reverse
	end

	### CLASS METHODS
	def quality_reason_percentage(quality, description)
		(quality_reason_count(quality, description).to_f / total_number_of_reasons * 100).round
	end

	def good_experiences
		experiences.select(&:good_experience?)
	end

	def bad_experiences
		experiences.select(&:bad_experience?)
	end

	def good_percentage
		(good_experiences.count.to_f / experiences.count * 100).round 
	end

	def bad_percentage
		(bad_experiences.count.to_f / experiences.count * 100).round 
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

	def filter_experiences(quality=nil, range=nil)
		return experiences if !quality && !range
		return send("#{quality}_experiences") if !range
		return send("#{range}s_experiences") if !quality
		return send("#{range}s_#{quality}_experiences")
	end

	private

	def total_number_of_reasons
		experiences.inject(0){|sum, experience| sum + experience.reasons.count }
	end

	def quality_reason_count(quality, description)
		experiences_with_reasons = send("#{quality}_experiences").select{|experience| experience.reasons}
		experiences_with_reasons.inject(0){|sum, experience| sum + experience.num_of_reasons_for(description)}
	end

end
