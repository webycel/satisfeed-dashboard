class Performance

	attr_accessor :parsed_stores, :stores, :firebase

	@firebase = Firebase::Client.new(ENV["FIREBASE_URL"])

	def self.stores
		@stores = @firebase.get("stores")
	end

	def self.get_best_store(filter)
		if filter == "percentage"
			best_percentage_store
		elsif filter == "amount"
			best_amount_store
		elsif filter == "difference"
			positive_difference_store
		end
	end

	def self.get_worst_store(filter)
		if filter == "percentage"
			worst_percentage_store
		elsif filter == "amount"
			worst_amount_store
		elsif filter == "difference"
			negative_difference_store
		end
	end

	private
	def self.parsed_stores
		@parsed_stores = StoresParser.parse(stores.body)
	end

	def self.best_percentage_store
		parsed_stores.max_by{|store| store.good_percentage }
	end

	def self.best_amount_store
		parsed_stores.max_by{|store| store.good_experiences.count }
	end

	def self.positive_difference_store
		parsed_stores.max_by{ |store| store.positive_ratings_difference }
	end

	def self.worst_percentage_store
		parsed_stores.max_by{|store| store.bad_percentage }
	end

	def self.worst_amount_store
		parsed_stores.max_by{|store| store.bad_experiences.count }
	end

	def self.negative_difference_store
		parsed_stores.max_by{ |store| store.negative_ratings_difference }
	end

end
