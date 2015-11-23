class Performance < ActiveRecord::Base

	base_uri = 'https://customersatisfaction.firebaseio.com/'

	firebase = Firebase::Client.new(base_uri)

	scope :allStores, -> () do
		firebase.get("stores")
	end

	def self.getBestStore stores, filter, experience
		bestStore = Hash.new

		bestGoodCounter = 0
		bestBadCounter = 0

		stores.each do |key, store|
			goodCounter = 0
			goodPercentage = 0
			badCounter = 0
			badPercentage = 0

			store.each do |k, s|
				goodCounter += 1 if s["experience"] == "good"
				badCounter += 1 if s["experience"] == "bad"
			end

			goodPercentage = (100.to_f / (goodCounter + badCounter)) * goodCounter
			badPercentage = 100.to_f - goodPercentage

			if filter == "percentage"
				if (goodPercentage >= bestGoodCounter && experience == "good") || (badPercentage >= bestBadCounter && experience == "bad")
					bestGoodCounter = goodPercentage
					bestBadCounter = badPercentage
					bestStore = buildStoreHash(key, store, goodCounter, badCounter, bestGoodCounter)
				end
			elsif filter == "amount"
				if (goodCounter >= bestGoodCounter && experience == "good") || (badCounter >= bestBadCounter && experience == "bad")
					bestGoodCounter = goodCounter
					bestBadCounter = badCounter
					bestStore = buildStoreHash(key, store, goodCounter, badCounter, goodPercentage)
				end
			elsif filter == "difference"
				if (goodCounter - badCounter >= bestGoodCounter && experience == "good") || (goodCounter - badCounter < bestGoodCounter && experience == "bad")
					bestGoodCounter = goodCounter - badCounter
					bestStore = buildStoreHash(key, store, goodCounter, badCounter, goodPercentage)
				end
			end
		end

		bestStore
	end

	private
		def self.buildStoreHash key, experiences, good, bad, percentage
			bestStore = Hash.new
			bestStore["storeID"] = key
			bestStore["experiences"] = experiences
			bestStore["good"] = good
			bestStore["bad"] = bad
			bestStore["percentage"] = percentage
			bestStore
		end

end
