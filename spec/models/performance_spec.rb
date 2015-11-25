require 'rails_helper'

RSpec.describe Performance do

  describe ".get_best_store" do
    let(:stores) { JSON.parse(fixture("stores.json").read) }
    let(:store) { double(:store) }

    context "when filtered by percentage" do
      it "returns the store with the highest percentage of good ratings" do
        expect(Performance.get_best_store("percentage" )).to eq store
      end
    end
  end

end