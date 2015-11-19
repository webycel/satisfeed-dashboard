class Store < ActiveRecord::Base

	base_uri = 'https://customersatisfaction.firebaseio.com/'

	firebase = Firebase::Client.new(base_uri)

	scope :get, -> (store_id) do
		firebase.get("stores/" + store_id)
	end

end
