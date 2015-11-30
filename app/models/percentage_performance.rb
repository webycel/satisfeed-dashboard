class PercentagePerformance < StorePerformance

  def self.get_best_store
    parsed_stores.max_by{|store| store.good_percentage }
  end

  def self.get_worst_store
    parsed_stores.max_by{|store| store.bad_percentage }
  end

end