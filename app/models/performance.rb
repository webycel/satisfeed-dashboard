class Performance < ActiveRecord::Base

	base_uri = 'https://customersatisfaction.firebaseio.com/'

	firebase = Firebase::Client.new(base_uri)

	scope :all_stores, -> () { firebase.get("stores") }

	def self.get_best_store(stores, filter, experience)
		best_store = Hash.new

		best_good_counter = 0
		best_bad_counter = 0

		parsed_stores = StoresParser.parse(stores)

		stores.each do |key, store|

			good_counter = 0
			good_percentage = 0
			bad_counter = 0
			bad_percentage = 0

			store.each do |k, s|
				good_counter += 1 if s["experience"] == "good"
				bad_counter += 1 if s["experience"] == "bad"
			end

			good_percentage = (100.to_f / (good_counter + bad_counter)) * good_counter
			bad_percentage = 100.to_f - good_percentage

			if filter == "percentage"
				if (good_percentage >= best_good_counter && experience == "good") || (bad_percentage >= best_bad_counter && experience == "bad")
					best_good_counter = good_percentage
					best_bad_counter = bad_percentage
					best_store = build_store_hash(key, store, good_counter, bad_counter, best_good_counter)
				end
			elsif filter == "amount"
				if (good_counter >= best_good_counter && experience == "good") || (bad_counter >= best_bad_counter && experience == "bad")
					best_good_counter = good_counter
					best_bad_counter = bad_counter
					best_store = build_store_hash(key, store, good_counter, bad_counter, good_percentage)
				end
			elsif filter == "difference"
				if (good_counter - bad_counter >= best_good_counter && experience == "good") || (good_counter - bad_counter < best_good_counter && experience == "bad")
					best_good_counter = good_counter - bad_counter
					best_store = build_store_hash(key, store, good_counter, bad_counter, good_percentage)
				end
			end
		end

		best_store
	end

	private
		def self.build_store_hash(key, experiences, good, bad, percentage)
			best_store = Hash.new
			best_store["storeID"] = key
			best_store["experiences"] = experiences
			best_store["good"] = good
			best_store["bad"] = bad
			best_store["percentage"] = percentage.round(1)
			best_store
		end

		def create_store
			Store.new(key)
		end

end
