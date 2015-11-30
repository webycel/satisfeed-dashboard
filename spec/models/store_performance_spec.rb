require 'rails_helper'

RSpec.describe StorePerformance do

  describe ".get_best_store" do
    let(:stores) { JSON.parse(fixture("stores.json").read) }

    context "when filtered by percentage" do
      xit "returns the store with the highest percentage of good ratings" do
        expect(StorePerformance.get_best_store("percentage" )).to eq store
      end
    end
  end

end