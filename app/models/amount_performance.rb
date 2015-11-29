class AmountPerformance < StorePerformance
  
  def self.get_best_store
    parsed_stores.max_by{|store| store.good_experiences.count }
  end

  def self.get_worst_store
    parsed_stores.max_by{|store| store.bad_experiences.count }
  end

end