class StoresParser

  def self.parse(data)
    return {} if data.empty?
    parse_stores(data)
  end

  private
  def self.parse_stores(data)
    data.map { |key, store_data| StoreParser.parse_store(key, store_data) }
  end

end