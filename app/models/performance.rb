class Performance < ActiveRecord::Base

	attr_accessor :parsed_stores

	base_uri = 'https://customersatisfaction.firebaseio.com/'

	firebase = Firebase::Client.new(base_uri)

	scope :all_stores, -> () { firebase.get("stores") }

	def self.get_best_store(filter)
		if filter == "percentage"
			best_percentage_store
		elsif filter == "amount"
			best_amount_store
		elsif filter == "difference"
			positive_difference_store("good")
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
		def parsed_stores
			@parsed_stores = StoresParser.parse(stores)
		end

		def best_percentage_store
			sorted_stores = {}
			parsed_stores.each{|store| sorted_stores[store] = store.good_percentage}
			sorted_stores.sort_by{|store, percentage| percentage }.last
		end

		def best_amount_store
			parsed_stores.map{|store| [store store.good_experiences.count]}.max_by{|store, count| count}
		end

		def positive_difference_store
			parsed_stores.map do |store| 
				store, store.positive_ratings_difference
			end.max_by{|store, difference| difference}
		end

		def worst_percentage_store
			sorted_stores = {}
			parsed_stores.each{|store| sorted_stores[store] = store.bad_percentage}
			sorted_stores.sort_by{|store, percentage| percentage }.last
		end

		def worst_amount_store
			parsed_stores.map{|store| [store, store.bad_experiences.count]}.max_by{|store, count| count}
		end

		def negative_difference_store
			parsed_stores.map do |store| 
				store, store.negative_ratings_difference
			end.max_by{|store, difference| difference}
		end

		def self.build_store_hash(key, experiences, good, bad, percentage)
			best_store = Hash.new
			best_store["storeID"] = key
			best_store["experiences"] = experiences
			best_store["good"] = good
			best_store["bad"] = bad
			best_store["percentage"] = percentage.round(1)
			best_store
		end

end
