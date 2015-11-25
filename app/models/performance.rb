class Performance

	attr_accessor :parsed_stores, :stores, :firebase

	base_uri = 'https://customersatisfaction.firebaseio.com/'

	@firebase = Firebase::Client.new(base_uri)

	def self.stores
		@stores = @firebase.get("stores")
	end

	def self.get_best_store(filter)
		if filter == "percentage"
			best_percentage_store

		elsif filter == "amount"
			best_amount_store
			# raise best_percentage_store.inspect
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
		sorted_stores = {}
		parsed_stores.each{|store| sorted_stores[store] = store.good_percentage}
		sorted_stores.sort_by{|store, percentage| percentage }.last
	end

	def self.best_amount_store
		parsed_stores.map{|store| [store, store.good_experiences.count]}.max_by{|store, count| count}
	end

	def self.positive_difference_store
		parsed_stores.map do |store| 
			[store, store.positive_ratings_difference]
		end.max_by{|store, difference| difference}
	end

	def self.worst_percentage_store
		sorted_stores = {}
		parsed_stores.each{|store| sorted_stores[store] = store.bad_percentage}
		sorted_stores.sort_by{|store, percentage| percentage }.last
	end

	def self.worst_amount_store
		parsed_stores.map{|store| [store, store.bad_experiences.count]}.max_by{|store, count| count}
	end

	def self.negative_difference_store
		parsed_stores.map do |store| 
			[store, store.negative_ratings_difference]
		end.max_by{|store, difference| difference}
	end

end
