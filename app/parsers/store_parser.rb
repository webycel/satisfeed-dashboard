class StoreParser
  def object
    @object ||= Store.new
  end

  def parse_store(name, store_data)
    object.tap do |store|
      store.name = name
      store.experiences = parse_experiences(store, store_data) 
    end
  end

  private

  def parse_experiences(store, store_data)
    results = store_data.map do |key, experience|
      Experience.new.tap do |object|
        object.id = key
        object.extra_info = experience["extraInfo"]
        object.description = experience["experience"]
        object.created_at = experience["time"]
        object.reasons = parse_reasons(experience["why"]) if experience["why"]
      end
    end
  end

  def parse_reasons(reasons)
    reasons.map do |reason| 
      Reason.new.tap do |object|
        object.description = reason
      end
    end
  end

end
