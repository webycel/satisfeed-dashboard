class DifferencePerformance < Performance

  def self.get_best_store
    parsed_stores.max_by{ |store| store.positive_ratings_difference }
  end

  def self.get_worst_store
    parsed_stores.max_by{ |store| store.negative_ratings_difference }
  end

end
