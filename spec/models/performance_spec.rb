require 'rails_helper'

RSpec.describe Performance do

  describe ".get_best_store" do
    let(:stores) { JSON.parse(fixture("stores.json").read) }

    it "returns the store with the highest percentage of good ratings" do
      expect(Performance.get_best_store(stores, "amount", "good" )["good"]).to eq 0
      expect(Performance.get_best_store(stores, "amount", "bad" )["bad"]).to eq 0
    end
  end

end