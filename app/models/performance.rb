class Performance

	attr_accessor :parsed_stores, :stores

	def self.firebase=(instance_of_firebase)
		@firebase = instance_of_firebase		
	end

	def self.firebase
		@firebase ||= Firebase::Client.new(ENV["FIREBASE_URL"])
	end

	def self.get_best_store
		raise NotImplementedError, "this #{self.class} cannot respond to: "
	end

	def self.get_worst_store
		raise NotImplementedError, "this #{self.class} cannot respond to: "
	end

	protected
	def self.stores
		@stores = firebase.get("stores")
	end

	def self.parsed_stores
		@parsed_stores = StoresParser.parse(stores.body)
	end

end
